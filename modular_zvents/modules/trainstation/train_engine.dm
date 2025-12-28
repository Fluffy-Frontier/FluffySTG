/// Минимальное давление газов, проходящих через турбину
#define MINIMUM_TURBINE_PRESSURE 0.01
/// Возвращает максимальное давление, если оно ниже значения
#define PRESSURE_MAX(value) (max((value), MINIMUM_TURBINE_PRESSURE))
/// Минимальная температура для горячего пара (в Кельвинах, >373K для кипения воды)
#define MIN_STEAM_TEMPERATURE 400

// Базовый класс для частей турбины поезда
/obj/machinery/power/train_turbine
	name = "train turbine part"
	desc = "Part of a steam-fed train turbine. Consists of inlet, core, and outlet. Uses hot water vapor, outputs CO2 to atmosphere and cooled water through liquid pipe."
	icon = 'icons/obj/machines/engine/turbine.dmi'
	density = TRUE
	resistance_flags = FIRE_PROOF
	can_atmos_pass = ATMOS_PASS_DENSITY
	processing_flags = START_PROCESSING_MANUALLY

	/// Эффективность этой части (от апгрейдов)
	var/efficiency = 0.5
	/// Установленная часть (если есть апгрейды)
	var/obj/item/turbine_parts/installed_part
	/// Путь к части для установки
	var/obj/item/turbine_parts/part_path
	/// Внутренняя газовая смесь
	var/datum/gas_mixture/machine_gasmix
	/// Объем газа
	var/gas_theoretical_volume = 1000  // Базовый, переопределяется

	/// Ссылка на ядро (для всех частей)
	var/obj/machinery/power/train_turbine/core_rotor/rotor

/obj/machinery/power/train_turbine/Initialize(mapload)
	. = ..()
	machine_gasmix = new
	machine_gasmix.volume = gas_theoretical_volume

	if(mapload && part_path)
		installed_part = new part_path(src)
		efficiency = installed_part?.get_tier_value(TURBINE_MAX_EFFICIENCY) || efficiency

	air_update_turf(TRUE)
	update_appearance(UPDATE_OVERLAYS)
	register_context()

/obj/machinery/power/train_turbine/Destroy()
	air_update_turf(TRUE)
	QDEL_NULL(installed_part)
	QDEL_NULL(machine_gasmix)
	if(rotor)
		rotor.deactivate_parts()
	return ..()

/obj/machinery/power/train_turbine/proc/is_active()
	return rotor?.active || FALSE

/obj/machinery/power/train_turbine/proc/transfer_gases(datum/gas_mixture/input_mix, datum/gas_mixture/output_mix, work_amount_to_remove = 0, intake_size = 1)
	var/output_pressure = PRESSURE_MAX(output_mix.return_pressure())
	var/datum/gas_mixture/transferred_gases = input_mix.pump_gas_to(output_mix, input_mix.return_pressure() * intake_size)
	if(!transferred_gases)
		return 0

	var/work_done = QUANTIZE(transferred_gases.total_moles()) * R_IDEAL_GAS_EQUATION * transferred_gases.temperature * log((transferred_gases.volume * PRESSURE_MAX(transferred_gases.return_pressure())) / (output_mix.volume * output_pressure)) * TURBINE_WORK_CONVERSION_MULTIPLIER
	if(work_amount_to_remove)
		work_done -= work_amount_to_remove

	var/output_mix_heat_capacity = output_mix.heat_capacity()
	if(!output_mix_heat_capacity)
		return 0
	work_done = min(work_done, (output_mix_heat_capacity * output_mix.temperature - output_mix_heat_capacity * TCMB) / TURBINE_HEAT_CONVERSION_MULTIPLIER)
	output_mix.temperature = max((output_mix.temperature * output_mix_heat_capacity + work_done * TURBINE_HEAT_CONVERSION_MULTIPLIER) / output_mix_heat_capacity, TCMB)
	return work_done

// ====================================================================
// Входная часть: Inlet Compressor
// ====================================================================
/obj/machinery/power/train_turbine/inlet_compressor
	name = "train turbine inlet compressor"
	desc = "Inlet part of the train turbine. Connects to pipes for hot water vapor intake."
	icon_state = "inlet_compressor"
	base_icon_state = "inlet_compressor"
	// circuit = /obj/item/circuitboard/machine/train_turbine_inlet
	part_path = /obj/item/turbine_parts/compressor
	gas_theoretical_volume = 1000

	/// Регулятор впуска (0.01 - 1)
	var/intake_regulator = 0.5
	/// Работа компрессора на текущем тике
	var/compressor_work = 0
	/// Давление после компрессора
	var/compressor_pressure = MINIMUM_TURBINE_PRESSURE
	/// Atmos connector для труб
	var/datum/gas_machine_connector/connector

/obj/machinery/power/train_turbine/inlet_compressor/Initialize(mapload)
	. = ..()
	connector = new(loc, src, REVERSE_DIR(dir), CELL_VOLUME * 0.5)

/obj/machinery/power/train_turbine/inlet_compressor/Destroy()
	QDEL_NULL(connector)
	return ..()

/obj/machinery/power/train_turbine/inlet_compressor/proc/compress_gases()
	compressor_work = 0
	compressor_pressure = MINIMUM_TURBINE_PRESSURE

	if(!connector)
		return 0

	var/datum/gas_mixture/pipe_mix = connector.gas_connector.airs[1]
	if(!pipe_mix)
		return 0

	var/has_steam = pipe_mix.has_gas(/datum/gas/water_vapor, 1)
	var/temperature = pipe_mix.temperature
	if(!has_steam || temperature < MIN_STEAM_TEMPERATURE)
		return 0

	compressor_work = transfer_gases(pipe_mix, machine_gasmix, intake_size = intake_regulator)
	compressor_pressure = PRESSURE_MAX(machine_gasmix.return_pressure())

	return temperature

// ====================================================================
// Ядро: Core Rotor
// ====================================================================

/datum/looping_sound/turbine_loop
	mid_sounds = 'modular_zvents/sounds/turbine_loop.ogg'
	mid_length = 24 SECONDS
	volume = 60
	falloff_exponent = 3

/obj/machinery/power/train_turbine/core_rotor
	name = "train turbine core rotor"
	desc = "Core part of the train turbine. Controls RPM, temperature, and power."
	icon_state = "core_rotor"
	base_icon_state = "core_rotor"
	// circuit = /obj/item/circuitboard/machine/train_turbine_core
	part_path = /obj/item/turbine_parts/rotor
	gas_theoretical_volume = 3000

	var/active = FALSE
	var/rpm = 0
	var/max_rpm = 5000
	var/produced_energy = 0
	var/max_temperature = 1000
	var/damage = 0
	var/damage_archived = 0
	var/all_parts_connected = FALSE

	var/steam_consumption_rate = 0.1
	var/co2_production_rate = 0.15
	var/water_production_rate = 0.1

	/// Целевые обороты в % от максимума (0-1). Управляется из UI.
	var/target_rpm_percentage = 0.01

	var/datum/looping_sound/turbine_loop/soundloop
	/// Ссылки на части
	var/obj/machinery/power/train_turbine/inlet_compressor/compressor
	var/obj/machinery/power/train_turbine/turbine_outlet/turbine

	COOLDOWN_DECLARE(turbine_damage_alert)

/obj/machinery/power/train_turbine/core_rotor/Initialize(mapload)
	. = ..()
	new /obj/item/paper/guides/jobs/atmos/train_turbine(loc)

/obj/machinery/power/train_turbine/core_rotor/post_machine_initialize()
	. = ..()
	activate_parts()

/obj/machinery/power/train_turbine/core_rotor/begin_processing()
	. = ..()
	soundloop = new(src, TRUE)

/obj/machinery/power/train_turbine/core_rotor/end_processing()
	. = ..()
	QDEL_NULL(soundloop)

/obj/machinery/power/train_turbine/core_rotor/process(seconds_per_tick)
	if(!active || !all_parts_connected || !powered(ignore_use_power = TRUE))
		deactivate_parts()
		return PROCESS_KILL

	var/temperature = compressor.compress_gases()
	if(!temperature)
		rpm = 0
		produced_energy = 0
		return

	// Автоматическая регулировка впуска для достижения target RPM (простой П-регулятор)
	var/target_rpm = max_rpm * target_rpm_percentage
	var/rpm_error = target_rpm - rpm
	compressor.intake_regulator = clamp(compressor.intake_regulator + rpm_error * 0.00005, 0.01, 1)

	// Реакция: потребляем пар → CO2 + вода
	ASSERT_GAS(/datum/gas/water_vapor, compressor.machine_gasmix)
	var/steam_consumed = min(compressor.machine_gasmix.gases[/datum/gas/water_vapor][MOLES], steam_consumption_rate * compressor.intake_regulator)
	compressor.machine_gasmix.gases[/datum/gas/water_vapor][MOLES] -= steam_consumed
	compressor.machine_gasmix.garbage_collect()

	ASSERT_GAS(/datum/gas/carbon_dioxide, machine_gasmix)
	machine_gasmix.gases[/datum/gas/carbon_dioxide][MOLES] += co2_production_rate * compressor.intake_regulator

	var/work_done = steam_consumed * efficiency * 10000
	temperature += work_done / machine_gasmix.heat_capacity() * 0.1

	// Урон от перегрева
	damage_archived = damage
	var/temp_diff = temperature - max_temperature
	if(temp_diff > 0)
		damage += temp_diff * 0.01 * seconds_per_tick
		if(damage > damage_archived + 1 && COOLDOWN_FINISHED(src, turbine_damage_alert))
			COOLDOWN_START(src, turbine_damage_alert, 10 SECONDS)
			playsound(src, 'sound/machines/engine_alert/engine_alert1.ogg', 100, FALSE)
			balloon_alert_to_viewers("overheating! integrity [get_integrity()]%")

	// Охлаждение за счёт конденсации
	temperature = max(temperature - steam_consumed * 50, T20C)

	turbine.produce_water(steam_consumed * water_production_rate)

	var/rotor_work = transfer_gases(compressor.machine_gasmix, machine_gasmix, compressor.compressor_work)
	var/turbine_work = transfer_gases(machine_gasmix, turbine.machine_gasmix, abs(rotor_work))

	var/datum/gas_mixture/ejected = turbine.expel_gases()
	if(!ejected)
		rpm = 0
		produced_energy = 0
		return

	work_done = QUANTIZE(ejected.total_moles()) * R_IDEAL_GAS_EQUATION * ejected.temperature * log(compressor.compressor_pressure / PRESSURE_MAX(ejected.return_pressure()))
	work_done = max(work_done - compressor.compressor_work - turbine_work, 0)
	rpm = min(((work_done * compressor.efficiency) ** turbine.efficiency) * efficiency / TURBINE_RPM_CONVERSION, max_rpm)
	produced_energy = rpm * TURBINE_ENERGY_RECTIFICATION_MULTIPLIER * seconds_per_tick

	if(get_integrity() <= 0)
		explosion(src, devastation_range = 1, heavy_impact_range = 2, light_impact_range = 4)
		deactivate_parts()
		qdel(src)
		return PROCESS_KILL

	apply_thrust_to_train()

/obj/machinery/power/train_turbine/core_rotor/get_integrity()
	return max(round(100 - (damage / 500) * 100, 0.01), 0)

/obj/machinery/power/train_turbine/core_rotor/proc/activate_parts(mob/user, check_only = FALSE)
	if(!check_only)
		compressor = locate() in orange(1, src)
		turbine = locate() in orange(1, src)

	if(QDELETED(compressor) || QDELETED(turbine))
		balloon_alert(user, "missing parts!")
		return FALSE

	all_parts_connected = TRUE
	if(!check_only)
		compressor.rotor = src
		turbine.rotor = src
		max_rpm = (compressor.installed_part.get_tier_value(TURBINE_MAX_RPM) + turbine.installed_part.get_tier_value(TURBINE_MAX_RPM) + installed_part.get_tier_value(TURBINE_MAX_RPM)) / 3
		max_temperature = (compressor.installed_part.get_tier_value(TURBINE_MAX_TEMP) + turbine.installed_part.get_tier_value(TURBINE_MAX_TEMP) + installed_part.get_tier_value(TURBINE_MAX_TEMP)) / 3
		efficiency = (compressor.efficiency + turbine.efficiency + efficiency) / 3

	return TRUE

/obj/machinery/power/train_turbine/core_rotor/proc/deactivate_parts()
	active = FALSE
	all_parts_connected = FALSE
	rpm = 0
	produced_energy = 0
	compressor?.rotor = null
	turbine?.rotor = null
	compressor = null
	turbine = null
	end_processing()

/obj/machinery/power/train_turbine/core_rotor/proc/toggle_power(force_off = FALSE)
	if(force_off || active)
		if(!active)
			return
		active = FALSE
		end_processing()
	else
		if(!activate_parts(check_only = TRUE))
			return
		active = TRUE
		begin_processing()
	update_appearance(UPDATE_OVERLAYS)
	compressor?.update_appearance(UPDATE_OVERLAYS)
	turbine?.update_appearance(UPDATE_OVERLAYS)

/obj/machinery/power/train_turbine/core_rotor/proc/emergency_vent()
	if(!active || !turbine)
		return
	var/datum/gas_mixture/full_dump = turbine.expel_gases()  // Полный сброс
	if(full_dump)
		rpm *= 0.5  // Резкое падение оборотов
		balloon_alert_to_viewers("emergency vent activated!")

/obj/machinery/power/train_turbine/core_rotor/proc/apply_thrust_to_train()


// ====================================================================
// Выходная часть: Turbine Outlet
// ====================================================================
/obj/machinery/power/train_turbine/turbine_outlet
	name = "train turbine outlet"
	desc = "Outlet part of the train turbine. Expels CO2 to the turf and cooled water through plumbing pipe."
	icon_state = "inlet_compressor"
	base_icon_state = "inlet_compressor"
	// circuit = /obj/item/circuitboard/machine/train_turbine_outlet
	part_path = /obj/item/turbine_parts/stator
	gas_theoretical_volume = 6000

	var/turf/open/output_turf
	var/datum/component/plumbing/steam_turbine/plumbing
	var/datum/reagents/internal_reagents

/obj/machinery/power/train_turbine/turbine_outlet/Initialize(mapload)
	. = ..()
	internal_reagents = new(1000)
	internal_reagents.my_atom = src
	plumbing = AddComponent(/datum/component/plumbing/steam_turbine)
	plumbing.enable()

/obj/machinery/power/train_turbine/turbine_outlet/Destroy()
	QDEL_NULL(plumbing)
	QDEL_NULL(internal_reagents)
	return ..()

/obj/machinery/power/train_turbine/turbine_outlet/proc/expel_gases()
	if(QDELETED(output_turf))
		output_turf = get_step(loc, REVERSE_DIR(dir))
	if(isclosedturf(output_turf))
		return null

	var/datum/gas_mixture/ejected = machine_gasmix.pump_gas_to(output_turf.air, machine_gasmix.return_pressure())
	if(ejected)
		output_turf.air_update_turf(TRUE)
		output_turf.update_visuals()
	return ejected

/obj/machinery/power/train_turbine/turbine_outlet/proc/produce_water(amount)
	internal_reagents.add_reagent(/datum/reagent/water, amount)
	if(plumbing && internal_reagents.has_reagent(/datum/reagent/water, 10))
		internal_reagents.remove_reagent(/datum/reagent/water, 10)
		plumbing.reagents.add_reagent(/datum/reagent/water, 10)


/datum/component/plumbing/steam_turbine

	var/datum/reagents/water_buffer = null

/datum/component/plumbing/steam_turbine/Initialize(start, ducting_layer, turn_connects, datum/reagents/custom_receiver, extend_pipe_to_edge)
	. = ..()
	if(!istype(parent, /obj/machinery/power/train_turbine/turbine_outlet))
		return COMPONENT_INCOMPATIBLE
	water_buffer = new(500)
	water_buffer.my_atom = parent

	var/obj/machinery/power/train_turbine/turbine_outlet/turbine = parent
	demand_connects = REVERSE_DIR(turbine.dir)


// ====================================================================
// Компьютер управления
// ====================================================================
/obj/machinery/computer/train_turbine_computer
	name = "train turbine control computer"
	desc = "Computer to control the train's steam turbine. Monitor RPM, temperature, and more like a Barotrauma nuclear reactor."
	icon_screen = "train_turbine_comp"
	icon_keyboard = "tech_key"
	// circuit = /obj/item/circuitboard/computer/train_turbine_computer
	var/datum/weakref/rotor_ref
	var/mapping_id

/obj/machinery/computer/train_turbine_computer/post_machine_initialize()
	. = ..()
	if(!mapping_id)
		return
	for(var/obj/machinery/power/train_turbine/core_rotor/main as anything in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/power/train_turbine/core_rotor))
		if(main.id_tag != mapping_id)
			continue
		register_machine(main)
		break

/obj/machinery/computer/train_turbine_computer/multitool_act(mob/living/user, obj/item/multitool/multitool)
	. = ITEM_INTERACT_FAILURE
	if(!istype(multitool.buffer, /obj/machinery/power/train_turbine/core_rotor))
		to_chat(user, span_notice("Wrong machine type in [multitool] buffer..."))
		return
	if(rotor_ref)
		to_chat(user, span_notice("Changing [src] bluespace network..."))
	if(!do_after(user, 0.2 SECONDS, src))
		return

	playsound(get_turf(user), 'sound/machines/click.ogg', 10, TRUE)
	register_machine(multitool.buffer)
	to_chat(user, span_notice("You link [src] to the console in [multitool]'s buffer."))
	return ITEM_INTERACT_SUCCESS

/obj/machinery/computer/train_turbine_computer/proc/register_machine(obj/machinery/power/train_turbine/core_rotor/machine)
	rotor_ref = WEAKREF(machine)

/obj/machinery/computer/train_turbine_computer/ui_interact(mob/user, datum/tgui/ui)
	. = ..()
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "TrainTurbineComputer", name)
		ui.open()

/obj/machinery/computer/train_turbine_computer/ui_data(mob/user)
	. = list()

	var/obj/machinery/power/train_turbine/core_rotor/main_control = rotor_ref?.resolve()
	if(QDELETED(main_control) || !main_control.all_parts_connected)
		.["connected"] = FALSE
		return

	.["connected"] = TRUE
	.["active"] = main_control.active
	.["rpm"] = main_control.rpm
	.["power"] = energy_to_power(main_control.produced_energy)
	.["integrity"] = main_control.get_integrity()
	.["max_rpm"] = main_control.max_rpm
	.["max_temperature"] = main_control.max_temperature

	// Температуры по стадиям
	.["inlet_temp"] = main_control.compressor?.machine_gasmix?.temperature || T20C
	.["rotor_temp"] = main_control.machine_gasmix?.temperature || T20C
	.["outlet_temp"] = main_control.turbine?.machine_gasmix?.temperature || T20C

	// Давления по стадиям
	.["compressor_pressure"] = main_control.compressor?.compressor_pressure || MINIMUM_TURBINE_PRESSURE
	.["rotor_pressure"] = main_control.machine_gasmix?.return_pressure() || MINIMUM_TURBINE_PRESSURE
	.["outlet_pressure"] = main_control.turbine?.machine_gasmix?.return_pressure() || MINIMUM_TURBINE_PRESSURE

	.["regulator"] = main_control.compressor?.intake_regulator || 0.5
	.["target_rpm_percentage"] = main_control.target_rpm_percentage * 100
	.["steam_consumption"] = main_control.steam_consumption_rate
	.["co2_production"] = main_control.co2_production_rate
	.["water_production"] = main_control.water_production_rate

/obj/machinery/computer/train_turbine_computer/ui_act(action, list/params)
	. = ..()
	if(.)
		return

	var/obj/machinery/power/train_turbine/core_rotor/main_control = rotor_ref?.resolve()
	if(!main_control)
		return FALSE

	switch(action)
		if("toggle_power")
			if(!main_control.active)
				if(!main_control.activate_parts(usr, check_only = TRUE))
					return FALSE
			else if(main_control.rpm > 1000)
				return FALSE
			main_control.toggle_power()
			return TRUE

		if("regulate")
			var/val = params["regulate"]
			if(isnull(val))
				return FALSE
			main_control.compressor.intake_regulator = clamp(text2num(val), 0.01, 1)
			return TRUE

		if("set_target_rpm")
			var/val = params["target"]
			if(isnull(val))
				return FALSE
			main_control.target_rpm_percentage = clamp(text2num(val) / 100, 0, 1)
			return TRUE

		if("adjust_steam_rate")
			var/adjust = text2num(params["adjust"])
			if(isnull(adjust))
				return FALSE
			main_control.steam_consumption_rate = clamp(main_control.steam_consumption_rate + adjust, 0.05, 0.5)
			return TRUE

		if("emergency_vent")
			main_control.emergency_vent()
			return TRUE

// ====================================================================
// Остальные части (взаимодействие, апгрейды и т.д.) остались без изменений
// ====================================================================

/obj/item/paper/guides/jobs/atmos/train_turbine
	name = "paper- 'Quick guide on the train turbine!'"
	default_raw_text = "<B>How to operate the train turbine</B><BR>\
	- Connect pipes to the inlet for hot water vapor supply.<BR>\
	- Use the control computer to set target RPM, regulate intake, and monitor temperatures/pressures.<BR>\
	- Balance power output with temperature — overheating causes damage!<BR>\
	- Emergency vent available for rapid cooling.<BR>\
	- Outputs CO2 to atmosphere and cooled water for recirculation."

#undef PRESSURE_MAX
#undef MINIMUM_TURBINE_PRESSURE
#undef MIN_STEAM_TEMPERATURE

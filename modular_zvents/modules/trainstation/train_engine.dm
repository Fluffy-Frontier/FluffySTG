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

/obj/machinery/power/train_turbine/update_overlays()
	. = ..()
	if(panel_open)
		. += "[base_icon_state]_open"
	if(is_active())
		. += "[base_icon_state]_on"

/obj/machinery/power/train_turbine/proc/transfer_gases(datum/gas_mixture/input_mix, datum/gas_mixture/output_mix, work_amount_to_remove = 0, intake_size = 1)
	// Упрощенная версия переноса газов (как в оригинале)
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

/obj/machinery/power/train_turbine/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	if(isnull(held_item))
		return NONE

	if(panel_open && istype(held_item, part_path))
		context[SCREENTIP_CONTEXT_CTRL_LMB] = "[installed_part ? "Replace" : "Install"] part"
		return CONTEXTUAL_SCREENTIP_SET

	if(held_item.tool_behaviour == TOOL_SCREWDRIVER)
		context[SCREENTIP_CONTEXT_CTRL_LMB] = "[panel_open ? "Close" : "Open"] panel"
		return CONTEXTUAL_SCREENTIP_SET

	if(held_item.tool_behaviour == TOOL_WRENCH && panel_open)
		context[SCREENTIP_CONTEXT_CTRL_LMB] = "Rotate"
		return CONTEXTUAL_SCREENTIP_SET

	if(held_item.tool_behaviour == TOOL_CROWBAR)
		if(installed_part)
			context[SCREENTIP_CONTEXT_CTRL_RMB] = "Remove part"
		if(panel_open)
			context[SCREENTIP_CONTEXT_CTRL_LMB] = "Deconstruct"
		return CONTEXTUAL_SCREENTIP_SET

	if(held_item.tool_behaviour == TOOL_MULTITOOL)
		if(panel_open)
			context[SCREENTIP_CONTEXT_CTRL_LMB] = "Change cable layer"
		else
			context[SCREENTIP_CONTEXT_CTRL_LMB] = "Link parts"
		return CONTEXTUAL_SCREENTIP_SET

/obj/machinery/power/train_turbine/examine(mob/user)
	. = ..()
	if(installed_part)
		. += span_notice("Currently at tier [installed_part.current_tier].")
		if(installed_part.current_tier + 1 < TURBINE_PART_TIER_FOUR)
			. += span_notice("Can be upgraded by using a tier [installed_part.current_tier + 1] part.")
		. += span_notice("\The [installed_part] can be [EXAMINE_HINT("pried")] out.")
	else
		. += span_warning("Is missing a [initial(part_path.name)].")
	. += span_notice("Its maintainence panel can be [EXAMINE_HINT("screwed")] [panel_open ? "closed" : "open"].")
	if(panel_open)
		. += span_notice("It can rotated with a [EXAMINE_HINT("wrench")]")
		. += span_notice("The full machine can be [EXAMINE_HINT("pried")] apart")

/obj/machinery/power/train_turbine/screwdriver_act(mob/living/user, obj/item/tool)
	. = ITEM_INTERACT_BLOCKING
	if(is_active())
		balloon_alert(user, "turn it off!")
		return
	if(!anchored)
		balloon_alert(user, "anchor first!")
		return

	tool.play_tool_sound(src, 50)
	toggle_panel_open()
	if(panel_open)
		rotor?.deactivate_parts(user)
	else
		rotor?.activate_parts(user)
	update_appearance(UPDATE_OVERLAYS)

	return ITEM_INTERACT_SUCCESS

/obj/machinery/power/train_turbine/wrench_act(mob/living/user, obj/item/tool)
	. = ITEM_INTERACT_BLOCKING
	if(default_change_direction_wrench(user, tool))
		return ITEM_INTERACT_SUCCESS

/obj/machinery/power/train_turbine/crowbar_act(mob/living/user, obj/item/tool)
	. = ITEM_INTERACT_BLOCKING
	if(default_deconstruction_crowbar(tool))
		return ITEM_INTERACT_SUCCESS

/obj/machinery/power/train_turbine/crowbar_act_secondary(mob/living/user, obj/item/tool)
	. = ITEM_INTERACT_BLOCKING
	if(!panel_open)
		balloon_alert(user, "panel is closed!")
		return
	if(!installed_part)
		balloon_alert(user, "no part installed!")
		return
	if(is_active())
		balloon_alert(user, "[src] is on!")
		return

	user.put_in_hands(installed_part)
	return ITEM_INTERACT_SUCCESS

/obj/machinery/power/train_turbine/item_interaction(mob/living/user, obj/item/turbine_parts/object, list/modifiers)
	. = NONE
	if(!istype(object, part_path))
		return

	if(is_active())
		balloon_alert(user, "turn off the machine first!")
		return ITEM_INTERACT_BLOCKING
	if(!panel_open)
		balloon_alert(user, "open the maintenance hatch first!")
		return ITEM_INTERACT_BLOCKING

	if(!do_after(user, 2 SECONDS, src))
		return ITEM_INTERACT_BLOCKING
	if(installed_part)
		user.put_in_hands(installed_part)
		balloon_alert(user, "replaced part with the one in hand")
	else
		balloon_alert(user, "installed new part")
	user.transferItemToLoc(object, src)
	installed_part = object
	efficiency = installed_part.get_tier_value(TURBINE_MAX_EFFICIENCY)

	return ITEM_INTERACT_SUCCESS

/obj/machinery/power/train_turbine/Moved(atom/old_loc, movement_dir, forced, list/old_locs, momentum_change = TRUE)
	. = ..()
	set_panel_open(TRUE)
	update_appearance(UPDATE_OVERLAYS)
	rotor?.deactivate_parts()
	old_loc.air_update_turf(TRUE)
	air_update_turf(TRUE)


/obj/item/circuitboard/machine/train_turbine_inlet
	name = "train turbine inlet compressor"

// Входная часть: Подключается к трубе для впуска газов (только горячий водяной пар)
/obj/machinery/power/train_turbine/inlet_compressor
	name = "train turbine inlet compressor"
	desc = "Inlet part of the train turbine. Connects to pipes for hot water vapor intake."
	icon_state = "train_inlet"
	base_icon_state = "train_inlet"
	circuit = /obj/item/circuitboard/machine/train_turbine_inlet
	part_path = /obj/item/turbine_parts/compressor
	gas_theoretical_volume = 1000

	/// Регулятор впуска
	var/intake_regulator = 0.5
	/// Работа компрессора
	var/compressor_work = 0
	/// Давление компрессора
	var/compressor_pressure = MINIMUM_TURBINE_PRESSURE
	/// Atmos connector для труб
	var/obj/machinery/atmospherics/components/unary/portables_connector/connector

/obj/machinery/power/train_turbine/inlet_compressor/Initialize(mapload)
	. = ..()
	// Добавляем коннектор для труб
	connector = new /obj/machinery/atmospherics/components/unary/portables_connector(loc)
	connector.dir = REVERSE_DIR(dir)  // Вход с обратной стороны
	connector.initialize_directions = REVERSE_DIR(dir)
	connector.update_appearance()

/obj/machinery/power/train_turbine/inlet_compressor/Destroy()
	QDEL_NULL(connector)
	return ..()

/obj/machinery/power/train_turbine/inlet_compressor/proc/compress_gases()
	compressor_work = 0
	compressor_pressure = MINIMUM_TURBINE_PRESSURE

	if(!connector || !connector.connected_device)  // Если не подключена труба
		return 0

	var/datum/gas_mixture/pipe_mix = connector.airs[1]  // Газ из трубы
	if(!pipe_mix)
		return 0

	// Проверяем наличие только горячего водяного пара
	var/steam_moles = pipe_mix.gases[/datum/gas/water_vapor]?[MOLES] || 0
	var/temperature = pipe_mix.temperature
	if(steam_moles < 0.1 || temperature < MIN_STEAM_TEMPERATURE)  // Минимальные требования: достаточно пара и горячий
		return 0

	compressor_work = transfer_gases(pipe_mix, machine_gasmix, intake_size = intake_regulator)
	compressor_pressure = PRESSURE_MAX(machine_gasmix.return_pressure())

	// Возвращаем температуру входного газа
	return temperature

/obj/item/circuitboard/machine/train_turbine_core
	name = "train turbine core rotor"

// Ядро: Ротор, основной контроль
/obj/machinery/power/train_turbine/core_rotor
	name = "train turbine core rotor"
	desc = "Core part of the train turbine. Controls RPM, temperature, and power."
	icon_state = "train_core"
	base_icon_state = "train_core"
	circuit = /obj/item/circuitboard/machine/train_turbine_core
	part_path = /obj/item/turbine_parts/rotor
	gas_theoretical_volume = 3000

	var/active = FALSE
	var/rpm = 0
	var/max_rpm = 5000
	var/produced_energy = 0  // Для thrust в поезде
	var/max_temperature = 1000
	var/damage = 0
	var/damage_archived = 0
	var/all_parts_connected = FALSE
	var/steam_consumption_rate = 0.1  // Моли пара на тик
	var/co2_production_rate = 0.15     // Моли CO2 на тик (на основе потребления)
	var/water_production_rate = 0.1    // Объем воды (реагент) на тик

	/// Ссылки на части
	var/obj/machinery/power/train_turbine/inlet_compressor/compressor
	var/obj/machinery/power/train_turbine/turbine_outlet/turbine

	COOLDOWN_DECLARE(turbine_damage_alert)

/obj/machinery/power/train_turbine/core_rotor/Initialize(mapload)
	. = ..()
	new /obj/item/paper/guides/jobs/atmos/train_turbine(loc)

/obj/machinery/power/train_turbine/core_rotor/process(seconds_per_tick)
	if(!active || !all_parts_connected || !powered(ignore_use_power = TRUE))
		deactivate_parts()
		return PROCESS_KILL

	// Компрессор: Впуск из трубы (только горячий пар)
	var/temperature = compressor.compress_gases()
	if(!temperature)
		rpm = 0
		produced_energy = 0
		return

	// Симуляция реакции: Потребляем пар, производим CO2 и воду (реагент), охлаждаем
	ASSERT_GAS(/datum/gas/water_vapor, compressor.machine_gasmix)
	var/steam_consumed = min(compressor.machine_gasmix.gases[/datum/gas/water_vapor][MOLES], steam_consumption_rate * compressor.intake_regulator)
	compressor.machine_gasmix.gases[/datum/gas/water_vapor][MOLES] -= steam_consumed
	compressor.machine_gasmix.garbage_collect()

	ASSERT_GAS(/datum/gas/carbon_dioxide, machine_gasmix)
	machine_gasmix.gases[/datum/gas/carbon_dioxide][MOLES] += co2_production_rate * compressor.intake_regulator

	// Нагрев от реакции (но поскольку пар уже горячий, используем для работы)
	var/work_done = steam_consumed * efficiency * 10000  // Примерный расчет
	temperature += work_done / machine_gasmix.heat_capacity() * 0.1

	// Урон от температуры
	damage_archived = damage
	var/temp_diff = temperature - max_temperature
	if(temp_diff > 0)
		damage += temp_diff * 0.01 * seconds_per_tick
		if(damage > damage_archived + 1 && COOLDOWN_FINISHED(src, turbine_damage_alert))
			COOLDOWN_START(src, turbine_damage_alert, 10 SECONDS)
			playsound(src, 'sound/machines/engine_alert/engine_alert1.ogg', 100, FALSE)
			balloon_alert_to_viewers("overheating! integrity [get_integrity()]%")

	// Охлаждение (симулируем конденсацию)
	temperature = max(temperature - steam_consumed * 50, T20C)

	// Производим охлажденную воду как реагент и передаем в outlet
	turbine.produce_water(steam_consumed * water_production_rate)  // Передаем в outlet для вывода через жидкостную трубу

	// Перенос в ротор
	var/rotor_work = transfer_gases(compressor.machine_gasmix, machine_gasmix, compressor.compressor_work)

	// Перенос в аутлет
	var/turbine_work = transfer_gases(machine_gasmix, turbine.machine_gasmix, abs(rotor_work))

	// Выброс CO2
	var/datum/gas_mixture/ejected = turbine.expel_gases()
	if(!ejected)
		rpm = 0
		produced_energy = 0
		return

	// Расчет RPM и энергии
	work_done = QUANTIZE(ejected.total_moles()) * R_IDEAL_GAS_EQUATION * ejected.temperature * log(compressor.compressor_pressure / PRESSURE_MAX(ejected.return_pressure()))
	work_done = max(work_done - compressor.compressor_work - turbine_work, 0)
	rpm = min(((work_done * compressor.efficiency) ** turbine.efficiency) * efficiency / TURBINE_RPM_CONVERSION, max_rpm)
	produced_energy = rpm * TURBINE_ENERGY_RECTIFICATION_MULTIPLIER * seconds_per_tick

	// Если урон критический - взрыв
	if(get_integrity() <= 0)
		explosion(src, devastation_range = 1, heavy_impact_range = 2, light_impact_range = 4)
		deactivate_parts()
		qdel(src)
		return PROCESS_KILL

	apply_thrust_to_train()

/obj/machinery/power/train_turbine/core_rotor/get_integrity()
	return max(round(100 - (damage / 500) * 100, 0.01), 0)

/obj/machinery/power/train_turbine/core_rotor/proc/activate_parts(mob/user, check_only = FALSE)
	// Локализуем части
	if(!check_only)
		compressor = locate() in get_step(src, REVERSE_DIR(dir))
		turbine = locate() in get_step(src, dir)

	// Проверки на наличие и ориентацию (аналогично оригинальной турбине)
	if(QDELETED(compressor) || QDELETED(turbine))
		balloon_alert(user, "missing parts!")
		return FALSE

	// ... Добавить полные проверки как в оригинале ...

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
	if(force_off || !active)
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

/obj/machinery/power/train_turbine/core_rotor/proc/apply_thrust_to_train()

/obj/item/paper/guides/jobs/atmos/train_turbine
	name = "paper- 'Quick guide on the train turbine!'"
	default_raw_text = "<B>How to operate the train turbine</B><BR>\
	- Connect pipes to the inlet for hot water vapor supply.<BR>\
	- Monitor RPM, temperature, and integrity via the control computer.<BR>\
	- Ensure steam is hot enough; outputs CO2 to atmosphere and cooled water through liquid pipe for recirculation and reheating.<BR>\
	- Upgrades available via turbine parts."


/obj/item/circuitboard/machine/train_turbine_outlet
	name = "train turbine outlet"

// Выходная часть: Выброс CO2 на turf и вода через жидкостную трубу
/obj/machinery/power/train_turbine/turbine_outlet
	name = "train turbine outlet"
	desc = "Outlet part of the train turbine. Expels CO2 to the turf and cooled water through plumbing pipe."
	icon_state = "train_outlet"
	base_icon_state = "train_outlet"
	circuit = /obj/item/circuitboard/machine/train_turbine_outlet
	part_path = /obj/item/turbine_parts/stator
	gas_theoretical_volume = 6000

	var/turf/open/output_turf
	/// Plumbing connector для вывода жидкой воды
	var/obj/machinery/plumbing/output/liquid_connector
	/// Внутренний контейнер для реагентов (вода)
	var/datum/reagents/internal_reagents

/obj/machinery/power/train_turbine/turbine_outlet/Initialize(mapload)
	. = ..()
	internal_reagents = new(1000)  // Контейнер для реагентов
	internal_reagents.my_atom = src

	// Добавляем plumbing output для жидкостей
	liquid_connector = new /obj/machinery/plumbing/output(loc)
	liquid_connector.dir = dir  // Выход в сторону
	liquid_connector.update_appearance()

/obj/machinery/power/train_turbine/turbine_outlet/Destroy()
	QDEL_NULL(liquid_connector)
	QDEL_NULL(internal_reagents)
	return ..()

/obj/machinery/power/train_turbine/turbine_outlet/proc/expel_gases()
	if(QDELETED(output_turf))
		output_turf = get_step(loc, dir)
	if(!TURF_SHARES(output_turf))
		return null

	var/datum/gas_mixture/ejected = machine_gasmix.pump_gas_to(output_turf.air, machine_gasmix.return_pressure())
	if(ejected)
		output_turf.air_update_turf(TRUE)
		output_turf.update_visuals()
	return ejected

/obj/machinery/power/train_turbine/turbine_outlet/proc/produce_water(amount)
	// Производим охлажденную воду как реагент
	internal_reagents.add_reagent(/datum/reagent/water, amount)
	// Если подключена жидкостная труба, инжектим воду
	if(liquid_connector)
		var/datum/component/plumbing/simple_demand/comp = liquid_connector.GetComponent(/datum/component/plumbing/simple_demand)
		internal_reagents.trans_to(comp.reagents, internal_reagents.total_volume)


/datum/component/plumbing/simple_demand

#undef PRESSURE_MAX
#undef MINIMUM_TURBINE_PRESSURE
#undef MIN_STEAM_TEMPERATURE


/obj/item/circuitboard/computer/train_turbine_computer
	name = "train turbine control computer"

/obj/machinery/computer/train_turbine_computer
	name = "train turbine control computer"
	desc = "Computer to control the train's steam turbine. Monitor RPM, temperature, and more like a Barotrauma nuclear reactor."
	icon_screen = "train_turbine_comp"
	icon_keyboard = "tech_key"
	circuit = /obj/item/circuitboard/computer/train_turbine_computer
	/// Weakref к ядру ротора
	var/datum/weakref/rotor_ref
	/// ID для маппинга
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
	.["temp"] = main_control.compressor.machine_gasmix.temperature || T20C
	.["regulator"] = main_control.compressor.intake_regulator
	.["steam_consumption"] = main_control.steam_consumption_rate
	.["co2_production"] = main_control.co2_production_rate
	.["water_production"] = main_control.water_production_rate

/obj/machinery/computer/train_turbine_computer/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return

	var/obj/machinery/power/train_turbine/core_rotor/main_control = rotor_ref?.resolve()
	if(!main_control)
		return FALSE

	switch(action)
		if("toggle_power")
			if(!main_control.active)
				if(!main_control.activate_parts(ui.user, check_only = TRUE))
					return FALSE
			else if(main_control.rpm > 1000)
				return FALSE
			main_control.toggle_power()
			return TRUE

		if("regulate")
			var/intake_size = params["regulate"]
			if(isnull(intake_size))
				return FALSE
			intake_size = text2num(intake_size)
			if(isnull(intake_size))
				return FALSE
			main_control.compressor.intake_regulator = clamp(intake_size, 0.01, 1)
			return TRUE

		if("adjust_steam_rate")
			var/adjust = text2num(params["adjust"])
			main_control.steam_consumption_rate = clamp(main_control.steam_consumption_rate + adjust, 0.05, 0.5)
			return TRUE

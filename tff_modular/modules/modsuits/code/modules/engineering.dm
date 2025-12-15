/**
 * Модуль робо-рук, да-да
 *
 * Позволяет задать фиксированный набор инструментов, или брать  предмет из рук пользователя. Для того, обы создать новый тип
 * рук. Поменяйте tools, в этом поле должен быть задан список возможных инструментов.
 */


/obj/item/mod/module/robotic_arm
	name = "MOD robotic arms"
	desc = "A pair of mechanical manipulators that attach to the user's back. They can be used for their intended purpose without occupying the user's hands."
	icon = 'tff_modular/modules/modsuits/icons/mod_icons/mod_modules.dmi'
	overlay_icon_file = 'tff_modular/modules/modsuits/icons/worn_icons/mod_modules.dmi'
	icon_state = "module_toolarm"
	overlay_state_active = "robotics_arms"
	overlay_state_inactive = "robotics_arms"
	incompatible_modules = list(
		/obj/item/mod/module/robotic_arm,
	)
	complexity = 3
	module_type = MODULE_ACTIVE
	cooldown_time = 1 SECONDS

	// Список инструментов, что имеют робо-руки. Если оставить пустым, то руки/рука смогут экипировать инструмент из рук пользователя
	var/list/tools
	// Ассоциативный список предметов по именам assoc: string => item
	var/list/items_by_name
	// Время для использованимая инструмента - рукой манипулятора
	var/tool_use_time = 1 SECONDS
	// Колдаун для использования инструментов
	var/tool_use_cooldown = 1 SECONDS
	// Текущий выбранный инструмент
	var/obj/item/selected_tool = null
	// Типы предметов запрещенные до использования емага на модуле
	var/static/list/forbidden_item_types = list(
		/obj/item/gun,
		/obj/item/melee,
		/obj/item/stack,
		/obj/item/reagent_containers,
		/obj/item/scalpel/supermatter,
		/obj/item/hemostat/supermatter,
		/obj/item/nuke_core_container/supermatter,
	)
	// Максимальный вес предмета
	var/max_item_weight = WEIGHT_CLASS_NORMAL
	// Взломан ли модуль
	var/emaged = FALSE
	// Исопльзуется модуль в данный момент
	var/using_arm = FALSE
	// Может ли пользователь положить предмет в манипуляторах
	var/can_drop_item = FALSE
	// Кэшируем иконки
	VAR_PRIVATE/static/list/chached_tools_icons = list()

	COOLDOWN_DECLARE(tool_use_cd)


/obj/item/mod/module/robotic_arm/Initialize(mapload)
	. = ..()
	if(!islist(tools))
		return
	items_by_name = list()
	for(var/i = 1 to length(tools))
		var/item_path = tools[i]
		if(!ispath(item_path, /obj/item))
			stack_trace("[item_path] is not an item!")
			continue
		var/obj/item/new_tool = new item_path()
		new_tool.add_traits(list(TRAIT_NODROP), MOD_TRAIT)
		tools[i] = new_tool
		items_by_name[new_tool.name] = new_tool

/obj/item/mod/module/robotic_arm/Destroy()
	for(var/obj/item/tool as anything in tools)
		qdel(tool)
	return ..()

/obj/item/mod/module/robotic_arm/on_select(mob/activator)
	if(!active)
		pick_tool()
	. = ..()

/obj/item/mod/module/robotic_arm/activate(mob/activator)
	var/mob/user = mod.wearer
	if(active)
		if(!selected_tool)
			balloon_alert(user, "No tool selected!")
			return FALSE
		if(!COOLDOWN_FINISHED(src, tool_use_cd))
			balloon_alert(user, "Tool on cooldown!")
			return FALSE
		to_chat(user, span_notice("Select a target to use [selected_tool]."))
	return ..()

/obj/item/mod/module/robotic_arm/deactivate(mob/activator, display_message, deleting)
	. = ..()
	selected_tool = null

/obj/item/mod/module/robotic_arm/emag_act(mob/user, obj/item/card/emag/emag_card)
	. = ..()
	if(emaged)
		return
	balloon_alert(user, "Sefety protocol overrided!")
	emaged = TRUE

/obj/item/mod/module/robotic_arm/proc/pick_tool()
	if(length(tools))
		if(length(tools) > 1)
			var/list/items = list()
			for(var/obj/item/tool as anything in tools)
				if(!istype(tool))
					continue
				var/image/item_image = null

				if(chached_tools_icons[tool.type])
					item_image = chached_tools_icons[tool.type]
				else
					item_image = image(icon = tool.icon, icon_state = tool.icon_state)
					chached_tools_icons[tool.type] = item_image
				items["[tool.name]"] = item_image
				items_by_name["[tool.name]"] = tool
			var/picked = show_radial_menu(mod.wearer, mod.wearer, items, require_near = TRUE, radius = 42, display_close_button = TRUE)
			if(!picked || !items_by_name[picked])
				balloon_alert(mod.wearer, "No item selected!")
				return
			selected_tool = items_by_name[picked]
		else
			selected_tool = tools[1]
	else
		var/obj/item/held_item = mod.wearer.get_active_held_item()
		if(!held_item)
			balloon_alert(mod.wearer, "No held item!")
			return
		if(!istype(held_item))
			balloon_alert(mod.wearer, "Can't hold this item!")
			return
		if(!emaged)
			for(var/forbidden_type as anything in forbidden_item_types)
				if(istype(held_item, forbidden_type))
					balloon_alert(mod.wearer, "Can't hold this item!")
					return
		if(held_item.w_class > max_item_weight)
			balloon_alert(mod.wearer, "Item too heavy!")
			return
		equip_tool(held_item)
	playsound(src, 'sound/items/weapons/gun/general/dry_fire.ogg', 25, TRUE)

/obj/item/mod/module/robotic_arm/on_part_deactivation(deleting = FALSE)
	selected_tool = null


/obj/item/mod/module/robotic_arm/on_special_click(mob/source, atom/target)
	if(!selected_tool)
		balloon_alert(mod.wearer, "No tool selected!")
		return COMSIG_MOB_CANCEL_CLICKON
	INVOKE_ASYNC(src, PROC_REF(use_tool_on_atom), target)
	return COMSIG_MOB_CANCEL_CLICKON

/obj/item/mod/module/robotic_arm/proc/equip_tool(obj/item/tool)
	tool.add_traits(list(TRAIT_NODROP), MOD_TRAIT)
	tool.forceMove(src)
	LAZYADD(tools, tool)
	balloon_alert(mod.wearer, "Moved to robotic arm!")
	to_chat(mod.wearer, span_notice("You give [tool] to robotic arm!"))
	selected_tool = tool


/obj/item/mod/module/robotic_arm/proc/drop_tool(obj/item/tool)
	if(!can_drop_item)
		return
	if(!tool)
		tool = selected_tool ? selected_tool : tools[length(tools)]
	if(!tool)
		CRASH("drop_tool executed without any tools in manipulators!")
	tool.remove_traits(list(TRAIT_NODROP), MOD_TRAIT)
	tool.forceMove(get_turf(mod.wearer))
	LAZYREMOVE(tools, tool)
	if(tool.name in items_by_name)
		items_by_name -= tool.name
	mod.visible_message("Robotic arms on [mod] relaxed and drop [tool.name] on [get_turf(mod.wearer)]")


/obj/item/mod/module/robotic_arm/proc/use_tool_on_atom(atom/target)
	if(using_arm)
		return
	if(QDELETED(mod.wearer) || QDELETED(target))
		return

	using_arm = TRUE
	var/mob/living/user = mod.wearer

	if(tool_use_time > 0)
		if(!do_after(user, tool_use_time))
			balloon_alert(user, "Stay still!")
			using_arm = FALSE
			return

	var/is_adjacent = (get_dist(target, mod.wearer) <= 1)
	mod.visible_message("Robotics arms comes out from [mod.name] and used [selected_tool.name] on [target.name].")
	if(isitem(selected_tool))
		if(is_adjacent)
			if(selected_tool.melee_attack_chain(user, target))
				user.do_attack_animation(target)
		else
			selected_tool.ranged_interact_with_atom(target, user)

	user.changeNext_move(CLICK_CD_SLOW)
	using_arm = FALSE


/obj/item/mod/module/robotic_arm/get_configuration()
	. = ..()
	if(can_drop_item && length(tools))
		.["drop_item"] = add_ui_configuration("Drop item", "button", "scissors")
	if(length(tools) > 1)
		.["select_item"] = add_ui_configuration("Select item", "list", "Select item", assoc_to_keys(items_by_name))

/obj/item/mod/module/robotic_arm/configure_edit(key, value)
	. = ..()
	switch(key)
		if("drop_item")
			if(can_drop_item)
				drop_tool()
		if("select_item")
			selected_tool = items_by_name[value]
			balloon_alert(mod.wearer, "[value] selected!")

/obj/item/mod/module/robotic_arm/engineering
	name = "MOD engineering robotic arms"
	tools = list(
		/obj/item/screwdriver,
		/obj/item/crowbar,
		/obj/item/wrench,
		/obj/item/weldingtool/experimental/on,
		/obj/item/wirecutters,
		/obj/item/multitool
	)
	tool_use_time = 5

/obj/item/weldingtool/experimental/on
	welding = TRUE


/obj/item/mod/module/robotic_arm/workarm
	name = "MOD robotic arm"
	desc = "A mechanical manipulator that attaches to the user's back. It can pick up any object and use it. "
	overlay_state_active = "robotics_arm"
	overlay_state_inactive = "robotics_arm"
	tool_use_time = 1 SECONDS
	can_drop_item = TRUE


/obj/item/pipe_dispenser/mod
	name = "MOD rapid pipe dispenser"
	desc = "A device used to rapidly pipe things. This one build into MOD suit."
	icon = 'tff_modular/modules/modsuits/icons/mod_icons/mod_modules.dmi'
	icon_state = "module_pipe_dispanser"


/obj/item/mod/module/mod_rpd
	name = "MOD rapid pipe dispenser"
	desc = "A rapid pipe dispenser build into user's arm."
	icon = 'tff_modular/modules/modsuits/icons/mod_icons/mod_modules.dmi'
	icon_state = "module_pipe_dispanser"
	module_type = MODULE_ACTIVE
	complexity = 2
	use_energy_cost = DEFAULT_CHARGE_DRAIN * 2
	incompatible_modules = list(/obj/item/mod/module/mod_rpd)
	cooldown_time = 1 SECONDS
	required_slots = list(ITEM_SLOT_GLOVES)

	device = /obj/item/pipe_dispenser/mod


/obj/item/mod/module/electrocute_absorber
	name = "MOD electrocute absorber"
	desc = "The module is equipped with a built-in Faraday cage, which is installed in \
			the user's gloves and chest. It absorbs the energy entering the suit, allowing \
			the user to safely survive electric shocks."
	icon = 'tff_modular/modules/modsuits/icons/mod_icons/mod_modules.dmi'
	icon_state = "module_shock_protect"
	incompatible_modules = list(
		/obj/item/mod/module/electrocute_absorber,
		/obj/item/mod/module/shock_absorber,
	)
	module_type = MODULE_PASSIVE
	complexity = 3
	idle_power_cost = DEFAULT_CHARGE_DRAIN * 0.2
	use_energy_cost = POWER_CELL_USE_HIGH
	required_slots = list(ITEM_SLOT_GLOVES, ITEM_SLOT_BACK)

	// Колдаун поглащения удара станбатоном
	var/baton_protection_cooldown = 10 SECONDS
	// Колдаун поглащения удара током
	var/absorbation_cooldown = 3 SECONDS
	COOLDOWN_DECLARE(absorbation_cd)
	COOLDOWN_DECLARE(baton_protection_cd)

/obj/item/mod/module/electrocute_absorber/on_part_activation()
	. = ..()
	RegisterSignal(mod.wearer, COMSIG_LIVING_ELECTROCUTE_ACT, PROC_REF(on_wearer_electrocute), TRUE)
	RegisterSignal(mod.wearer, COMSIG_MOB_BATONED, PROC_REF(on_wearer_batoned), TRUE)
	restore_protection()

/obj/item/mod/module/electrocute_absorber/on_part_deactivation(deleting)
	. = ..()
	UnregisterSignal(mod.wearer, list(COMSIG_LIVING_ELECTROCUTE_ACT, COMSIG_MOB_BATONED))
	remove_protection()


/obj/item/mod/module/electrocute_absorber/proc/on_wearer_electrocute(datum/source, shock_damage, source, siemens_coeff, flags)
	SIGNAL_HANDLER

	if(!COOLDOWN_FINISHED(src, absorbation_cd))
		return
	COOLDOWN_START(src, absorbation_cd, absorbation_cooldown)
	drain_power(use_energy_cost)
	balloon_alert(mod.wearer, "Overcharged!")

	var/datum/effect_system/lightning_spread/sparks = new /datum/effect_system/lightning_spread
	sparks.set_up(number = 5, cardinals_only = TRUE, location = mod.wearer.loc)
	sparks.start()

	return COMPONENT_LIVING_BLOCK_SHOCK


/obj/item/mod/module/electrocute_absorber/proc/on_wearer_batoned(datum/source)
	SIGNAL_HANDLER

	if(!COOLDOWN_FINISHED(src, absorbation_cd))
		return
	COOLDOWN_START(src, baton_protection_cd, baton_protection_cooldown)
	drain_power(use_energy_cost)
	balloon_alert(mod.wearer, "Overcharged!")

	var/datum/effect_system/lightning_spread/sparks = new /datum/effect_system/lightning_spread
	sparks.set_up(number = 5, cardinals_only = TRUE, location = mod.wearer.loc)
	sparks.start()

	addtimer(CALLBACK(src, PROC_REF(remove_protection)), 1)
	addtimer(CALLBACK(src, PROC_REF(restore_protection)), baton_protection_cooldown)

/obj/item/mod/module/electrocute_absorber/proc/remove_protection()
	if(HAS_TRAIT_FROM(mod.wearer, TRAIT_BATON_RESISTANCE, REF(src)))
		REMOVE_TRAIT(mod.wearer, TRAIT_BATON_RESISTANCE, REF(src))

/obj/item/mod/module/electrocute_absorber/proc/restore_protection()
	if(!HAS_TRAIT_FROM(mod.wearer, TRAIT_BATON_RESISTANCE, REF(src)))
		ADD_TRAIT(mod.wearer, TRAIT_BATON_RESISTANCE, REF(src))



/obj/item/mod/module/cascade_evacuation
	name = "MOD supermatter evacuation module"
	desc = "This highly advanced module is installed on the user's back and consists of a two-part system. \
			The first part detects the moment when the electrons of the user's body atoms transition to another \
			energy level as a result of contact with the supermatter crystal. \
			The second part immediately locks the entire suit and evacuates the user from it using a built-in micro-bluespace catapult. \
			However, in the process, the MOD suit itself, along with all its contents, will be destroyed."
	icon = 'tff_modular/modules/modsuits/icons/mod_icons/mod_modules.dmi'
	icon_state = "module_smevac"
	incompatible_modules = list(/obj/item/mod/module/cascade_evacuation)
	module_type = MODULE_PASSIVE
	complexity = 2
	idle_power_cost = 0
	required_slots = list(ITEM_SLOT_BACK)

	var/rescue_in_process = FALSE

/obj/item/mod/module/cascade_evacuation/on_part_activation()
	. = ..()
	RegisterSignal(mod.wearer, COMSIG_SUPERMATTER_CONSUMED, PROC_REF(on_wearer_supermatter_consume))

/obj/item/mod/module/cascade_evacuation/on_part_deactivation(deleting)
	. = ..()
	UnregisterSignal(mod.wearer, COMSIG_SUPERMATTER_CONSUMED)

/obj/item/mod/module/cascade_evacuation/proc/on_wearer_supermatter_consume(datum/source)
	SIGNAL_HANDLER
	if(!rescue_in_process)
		INVOKE_ASYNC(src, PROC_REF(save_wearer_part_one))
	return COMPONENT_PREVENT_SUPERMATTER_CONSUM

/obj/item/mod/module/cascade_evacuation/proc/save_wearer_part_one()
	var/mob/living/carbon/human/engineer = mod.wearer
	if(!engineer)
		qdel(mod)

	// Процесс спасения займет некоторое время по этому позаботимся, чтобы пользователь не смог снова удариться об кристал!
	engineer.anchored = TRUE
	rescue_in_process = TRUE
	to_chat(engineer, span_userdanger("A blinding flash hits your eyes!"))
	engineer.Knockdown(60 SECONDS, ignore_canstun = TRUE)
	var/turf/hit_turf = get_turf(engineer)
	playsound(hit_turf, 'sound/misc/cracking_crystal.ogg', 45, TRUE)
	// Если пользователь сконтактировал с кристалом не на турфе? то мы немедленно перемешаем ко второй стадии спасения!
	if(!hit_turf)
		save_wearer_part_two(engineer)
		return
	var/obj/effect/crystal_mass/crystal_effect = new(hit_turf)
	sleep(2 SECONDS)
	playsound(hit_turf, 'sound/misc/cracking_crystal.ogg', 45, TRUE)
	to_chat(engineer, span_userdanger("Your skin is covered with blisters from burns!"))
	engineer.apply_damage(rand(40-70), BURN, forced = TRUE, spread_damage = TRUE, wound_bonus = 20)
	engineer.painful_scream(TRUE)
	sleep(1 SECONDS)
	playsound(hit_turf, 'sound/misc/cracking_crystal.ogg', 45, TRUE)
	save_wearer_part_two(engineer)
	qdel(crystal_effect)


/obj/item/mod/module/cascade_evacuation/proc/save_wearer_part_two(mob/living/carbon/human/engineer)
	var/turf/save_turf = get_safe_random_station_turf()
	do_teleport(engineer, save_turf, precision = 5, channel = TELEPORT_CHANNEL_BLUESPACE)
	engineer.add_mood_event("supermatter_crystal", /datum/mood_event/escape_supermatter)

	to_chat(engineer, span_notice("You managed to survive contact with supermatter crystal but lose your [mod.name]!"))
	rescue_in_process = FALSE
	qdel(mod, TRUE)


/obj/effect/crystal_mass
	name = "crystal mass"
	desc = "You see this massive crystal mass looming towards you, cracking and screeching at every seemingly random movement."
	icon = 'icons/turf/walls.dmi'
	icon_state = "crystal_cascade_1"
	layer = AREA_LAYER
	plane = ABOVE_LIGHTING_PLANE
	opacity = TRUE
	density = TRUE
	anchored = TRUE
	light_power = 1
	light_range = 5
	light_color = COLOR_VIVID_YELLOW
	move_resist = INFINITY

/obj/effect/crystal_mass/Initialize(mapload)
	. = ..()
	icon_state = "crystal_cascade_[rand(1,6)]"

/datum/mood_event/escape_supermatter
	description = "I'm somehow managed to survive contact with that crystal!"
	mood_change = -12
	timeout = 5 MINUTES

/// Школа психокинетики
/// Имеет 6 спеллов.
/// Psi lighter - создаёт миниатюрный огонёк на кончиках пальцев. Работает как зажигалка.
/// Psi blade - создаёт в руке пси-клинок. Урон увеличивается в зависимости от уровня.
/// Psi tool - создаёт в руке универсальный инструмент.
/// Tinker - чинит integrity чего бы то ни было.
/// Psyforce - даёт "клешни жизни" для вскрытия дверей
/// Telekinesis - даёт мутацию телекинеза.

// Спавнит зажигалку в руке. Очень полезно
/datum/action/cooldown/spell/conjure_item/psionic/psilighter
	name = "Psi lighter"
	desc = "Concentrates psionic energy to create a small flame in your hand."
	button_icon = 'icons/obj/cigarettes.dmi'
	button_icon_state = "match_lit"
	cooldown_time = 1.5 SECONDS
	item_type = /obj/item/psionic_fire
	mana_cost = 5
	stamina_cost = 0

// Спавнит омни инструмент в руке псионика. Аналог абдукторского
/datum/action/cooldown/spell/conjure_item/psionic/psitool
	name = "Psi tool"
	desc = "Concentrates psionic energy to create a universal tool."
	button_icon = 'icons/obj/antags/abductor.dmi'
	button_icon_state = "omnitool"
	cooldown_time = 1.5 SECONDS
	item_type = /obj/item/psionic_omnitool
	mana_cost = 30
	stamina_cost = 0

/datum/action/cooldown/spell/conjure_item/psionic/psiblade/make_item(atom/caster)
	var/obj/item/made_item = new item_type(caster.loc, cast_power)
	LAZYADD(item_refs, WEAKREF(made_item))
	var/mob/living/carbon/human/caster_pawn = owner
	caster_pawn.emote_snap()
	return made_item

// Аналог клешней жизни
/datum/action/cooldown/spell/touch/psionic/psionic_force
	name = "Psionic Force"
	desc = "Concentrates psionic energy to force a door open."
	button_icon = 'icons/mob/actions/actions_spells.dmi'
	button_icon_state = "knock"
	cooldown_time = 3 SECONDS
	mana_cost = 50
	stamina_cost = 50
	hand_path = /obj/item/melee/touch_attack/psionic_mending
	draw_message = span_notice("You ready your hand to force a door open.")
	drop_message = span_notice("You lower your hand.")
	can_cast_on_self = FALSE

/datum/action/cooldown/spell/touch/psionic/psionic_force/is_valid_target(atom/cast_on)
	return istype(cast_on, /obj/machinery/door/airlock)

/datum/action/cooldown/spell/touch/psionic/psionic_force/cast_on_hand_hit(obj/item/melee/touch_attack/hand, atom/victim, mob/living/carbon/mendicant)
	if(isatom(victim))
		if(istype(victim, /obj/machinery/door/airlock))
			var/obj/machinery/door/airlock/door_to_force = victim
			owner.visible_message(span_warning("[owner] targets their hands at [victim], like they are some kind of jedi."),
								span_notice("You psionically grab [victim], trying to force it open."))
			if(do_after(mendicant, 5 SECONDS, victim, IGNORE_SLOWDOWNS, TRUE))
				force_door_open(door_to_force, mendicant)
				drain_mana()
			return TRUE
		else
			return FALSE
	else
		return FALSE

/datum/action/cooldown/spell/touch/psionic/psionic_force/proc/force_door_open(obj/machinery/door/airlock/door_to_force, mob/living/carbon/user)
	if(door_to_force.seal)
		to_chat(user, span_warning("Remove the seal first!"))
		return
	if(door_to_force.locked)
		to_chat(user, span_warning("The airlock's bolts prevent it from being forced!"))
		return
	if(door_to_force.welded)
		to_chat(user, span_warning("It's welded, it won't budge!"))
		return
	if(door_to_force.hasPower())
		if(!door_to_force.density)
			return
		if(!door_to_force.prying_so_hard)
			playsound(src, 'sound/machines/airlock/airlock_alien_prying.ogg', 100, TRUE)
			door_to_force.prying_so_hard = TRUE
			door_to_force.open(BYPASS_DOOR_CHECKS)
			door_to_force.take_damage(25, BRUTE, 0, 0)
			if(door_to_force.density && !door_to_force.open(BYPASS_DOOR_CHECKS))
				to_chat(user, span_warning("Despite your attempts, [src] refuses to open."))
			door_to_force.prying_so_hard = FALSE
			return

// Даёт мутацию телекинеза
/datum/action/cooldown/spell/psionic/psionic_telekinesis
	name = "Telekinesis"
	desc = "Force yourself to recieve telekinesis mutation."
	cooldown_time = 60 SECONDS
	mana_cost = 80
	stamina_cost = 80

/datum/action/cooldown/spell/psionic/psionic_telekinesis/is_valid_target(atom/cast_on)
	return !issynthetic(cast_on)

/datum/action/cooldown/spell/psionic/psionic_telekinesis/cast(mob/living/cast_on)
	. = ..()
	if(!ishuman(cast_on))
		return FALSE
	var/mob/living/carbon/human/to_mutate = cast_on
	if(!to_mutate.can_mutate())
		return FALSE
	to_mutate.dna.add_mutation(/datum/mutation/telekinesis, MUTATION_SOURCE_ACTIVATED)
	drain_mana()

// Восстанавливает Integrity атома. Позволяет чинить многие нечинимые иными способами вещи
/datum/action/cooldown/spell/touch/psionic/psionic_tinker
	name = "Psionic Tinker"
	desc = "Restore somethings condition to its normal state."
	button_icon = 'icons/obj/tools.dmi'
	button_icon_state = "wrench"
	cooldown_time = 3 SECONDS
	mana_cost = 40
	stamina_cost = 50
	hand_path = /obj/item/melee/touch_attack/psionic_mending
	draw_message = span_notice("You ready your hand to tinker.")
	drop_message = span_notice("You lower your hand.")
	can_cast_on_self = FALSE

/datum/action/cooldown/spell/touch/psionic/psionic_tinker/is_valid_target(atom/cast_on)
	return cast_on.uses_integrity

/datum/action/cooldown/spell/touch/psionic/psionic_tinker/cast_on_hand_hit(obj/item/melee/touch_attack/hand, atom/victim, mob/living/carbon/mendicant)
	if(isatom(victim))
		var/atom/to_fix = victim
		if((to_fix.get_integrity() >= to_fix.max_integrity) || !to_fix.uses_integrity)
			return FALSE
		owner.visible_message(span_warning("[owner] presses his hands onto [victim]."),
							  span_notice("You grab [victim], trying to repair it."))
		if(do_after(mendicant, 6 SECONDS, victim, IGNORE_SLOWDOWNS, TRUE))
			to_fix.update_integrity(clamp(to_fix.get_integrity()+(50*cast_power), 1, to_fix.max_integrity))
			drain_mana()
		return TRUE
	else
		return FALSE

// Копирка с абдукторского
/obj/item/psionic_omnitool
	name = "psionic omnitool"
	desc = "Space Swiss Army Knife, able to shapeshift itself to fulfill psionics needs."
	icon = 'icons/obj/antags/abductor.dmi'
	lefthand_file = 'icons/mob/inhands/antag/abductor_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/antag/abductor_righthand.dmi'
	icon_state = "omnitool"
	inhand_icon_state = "silencer"
	toolspeed = 1
	tool_behaviour = TOOL_SCREWDRIVER
	color = COLOR_BRIGHT_BLUE
	usesound = 'sound/items/pshoom/pshoom.ogg'
	var/list/tool_list = list()
	item_flags = DROPDEL | ABSTRACT | HAND_ITEM

/obj/item/psionic_omnitool/Initialize(mapload)
	. = ..()
	tool_list = list(
			"Crowbar" = image(icon = 'icons/obj/tools.dmi', icon_state = "crowbar"),
			"Multitool" = image(icon = 'icons/obj/devices/tool.dmi', icon_state = "multitool"),
			"Screwdriver" = image(icon = 'icons/obj/tools.dmi', icon_state = "screwdriver_brass"),
			"Wirecutters" = image(icon = 'icons/obj/tools.dmi', icon_state = "cutters_map"),
			"Wrench" = image(icon = 'icons/obj/tools.dmi', icon_state = "wrench"),
		)
	ADD_TRAIT(src, TRAIT_EXAMINE_SKIP, INNATE_TRAIT)

/obj/item/psionic_omnitool/get_all_tool_behaviours()
	return list(
	TOOL_CROWBAR,
	TOOL_MULTITOOL,
	TOOL_SCREWDRIVER,
	TOOL_WIRECUTTER,
	TOOL_WRENCH,
	)

/obj/item/psionic_omnitool/examine()
	. = ..()
	. += " The mode is: [tool_behaviour]"

/obj/item/psionic_omnitool/attack_self(mob/user)
	if(!user)
		return

	var/tool_result = show_radial_menu(user, src, tool_list, custom_check = CALLBACK(src, PROC_REF(check_menu), user), require_near = TRUE, tooltips = TRUE)
	if(!check_menu(user))
		return
	switch(tool_result)
		if("Crowbar")
			tool_behaviour = TOOL_CROWBAR
		if("Multitool")
			tool_behaviour = TOOL_MULTITOOL
		if("Screwdriver")
			tool_behaviour = TOOL_SCREWDRIVER
		if("Wirecutters")
			tool_behaviour = TOOL_WIRECUTTER
		if("Wrench")
			tool_behaviour = TOOL_WRENCH

/obj/item/psionic_omnitool/proc/check_menu(mob/user)
	if(!istype(user))
		return FALSE
	if(user.incapacitated || !user.Adjacent(src))
		return FALSE
	return TRUE


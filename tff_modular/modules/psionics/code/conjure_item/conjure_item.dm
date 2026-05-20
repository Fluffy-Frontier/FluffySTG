// Спавнит пси-клинок в руке. Сила зависит от уровня псионика
/datum/action/cooldown/spell/conjure_item/psionic/psiblade
	name = "Psi blade"
	desc = "Concentrates psionic energy to create a sharp blade in your hand."
	button_icon = 'icons/obj/weapons/transforming_energy.dmi'
	button_icon_state = "blade"
	cooldown_time = 1.5 SECONDS
	item_type = /obj/item/melee/psionic_blade
	mana_cost = 40
	psionic_level = 2
	point_cost = 3
	category = "combat"

/datum/action/cooldown/spell/conjure_item/psionic/psiblade/make_item(atom/caster)
	var/obj/item/summoning_obj = item_type
	summoning_obj.force = 15 * cast_power
	summoning_obj.block_chance = 25 * cast_power
	return ..()

/obj/item/melee/psionic_blade
	name = "psionic blade"
	desc = "A concentrated collection of particles and energy that looks like a swords blade.."
	icon = 'icons/obj/weapons/transforming_energy.dmi'
	icon_state = "blade"
	inhand_icon_state = "blade"
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	w_class = WEIGHT_CLASS_HUGE
	force = 15
	throwforce = 10
	hitsound = 'sound/items/weapons/blade1.ogg'
	attack_verb_continuous = list("attacks", "slashes", "stabs", "slices", "tears", "lacerates", "rips", "dices", "cuts")
	attack_verb_simple = list("attack", "slash", "stab", "slice", "tear", "lacerate", "rip", "dice", "cut")
	sharpness = SHARP_EDGED
	block_chance = 25
	item_flags = DROPDEL | ABSTRACT | HAND_ITEM
	color = COLOR_BRIGHT_BLUE

/obj/item/melee/psionic_blade/New(loc, power)
	. = ..()
	ADD_TRAIT(src, TRAIT_EXAMINE_SKIP, INNATE_TRAIT)

// Спавнит омни инструмент в руке псионика. Аналог абдукторского
/datum/action/cooldown/spell/conjure_item/psionic/psitool
	name = "Psi tool"
	desc = "Concentrates psionic energy to create a universal tool."
	button_icon = 'icons/obj/antags/abductor.dmi'
	button_icon_state = "omnitool"
	cooldown_time = 60 SECONDS
	item_type = /obj/item/psionic_omnitool
	mana_cost = 20
	category = "utility"

/datum/action/cooldown/spell/conjure_item/psionic/psiblade/make_item(atom/caster)
	var/obj/item/made_item = new item_type(caster.loc, cast_power)
	LAZYADD(item_refs, WEAKREF(made_item))
	var/mob/living/carbon/human/caster_pawn = owner
	caster_pawn.emote_snap()
	return made_item

// Копирка с абдукторского
/obj/item/psionic_omnitool
	name = "psionic omnitool"
	desc = "Space Swiss Army Knife, able to shapeshift itself to fulfill psionics needs."
	icon = 'tff_modular/modules/psionics/icons/psi_items.dmi'
	lefthand_file = 'icons/mob/inhands/antag/abductor_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/antag/abductor_righthand.dmi'
	icon_state = "omnitool"
	inhand_icon_state = "silencer"
	toolspeed = 1
	tool_behaviour = TOOL_SCREWDRIVER
	color = COLOR_BRIGHT_BLUE
	usesound = 'sound/items/pshoom/pshoom.ogg'
	item_flags = DROPDEL | ABSTRACT | HAND_ITEM
	var/list/tool_list = list()

/obj/item/psionic_omnitool/Initialize(mapload)
	. = ..()
	tool_list = list(
			"Crowbar" = image(icon = 'tff_modular/modules/psionics/icons/psi_items.dmi', icon_state = "crowbar"),
			"Screwdriver" = image(icon = 'tff_modular/modules/psionics/icons/psi_items.dmi', icon_state = "screwdriver"),
			"Wirecutters" = image(icon = 'tff_modular/modules/psionics/icons/psi_items.dmi', icon_state = "cutters"),
			"Wrench" = image(icon = 'tff_modular/modules/psionics/icons/psi_items.dmi', icon_state = "wrench"),
		)
	ADD_TRAIT(src, TRAIT_EXAMINE_SKIP, INNATE_TRAIT)

/obj/item/psionic_omnitool/get_all_tool_behaviours()
	return list(
	TOOL_CROWBAR,
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

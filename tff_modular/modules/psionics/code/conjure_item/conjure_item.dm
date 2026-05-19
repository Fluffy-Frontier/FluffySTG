// Спавнит пси-клинок в руке. Сила зависит от уровня псионика
/datum/action/cooldown/spell/conjure_item/psionic/psiblade
	name = "Psi blade"
	desc = "Concentrates psionic energy to create a sharp blade in your hand."
	button_icon = 'icons/obj/weapons/transforming_energy.dmi'
	button_icon_state = "blade"
	cooldown_time = 1.5 SECONDS
	item_type = /obj/item/melee/psionic_blade
	mana_cost = 40
	stamina_cost = 0
	psionic_level = 2
	point_cost = 3

/obj/item/melee/psionic_blade
	name = "psionic blade"
	desc = "A concentrated collection of particles and energy that looks like a swords blade.."
	icon = 'icons/obj/weapons/transforming_energy.dmi'
	icon_state = "blade"
	inhand_icon_state = "blade"
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	w_class = WEIGHT_CLASS_HUGE
	force = 30
	throwforce = 10
	hitsound = 'sound/items/weapons/blade1.ogg'
	attack_verb_continuous = list("attacks", "slashes", "stabs", "slices", "tears", "lacerates", "rips", "dices", "cuts")
	attack_verb_simple = list("attack", "slash", "stab", "slice", "tear", "lacerate", "rip", "dice", "cut")
	sharpness = SHARP_EDGED
	block_chance = 0
	item_flags = DROPDEL | ABSTRACT | HAND_ITEM
	color = COLOR_BRIGHT_BLUE

/obj/item/melee/psionic_blade/New(loc, power)
	. = ..()
	ADD_TRAIT(src, TRAIT_EXAMINE_SKIP, INNATE_TRAIT)

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
	point_cost = 1

/datum/action/cooldown/spell/conjure_item/psionic/psilighter/post_created(atom/cast_on, atom/created)
	. = ..()
	var/obj/item/psionic_fire/fire = created
	fire.force *= cast_power

/obj/item/psionic_fire
	name = "small psionic fire"
	desc = "Small bluish fire, that jumps on your fingers and surprisigly doesn't burn them."
	icon = 'icons/obj/weapons/hand.dmi'
	icon_state = "greyscale"
	color = COLOR_BRIGHT_BLUE
	inhand_icon_state = "greyscale"
	light_range = 2
	light_power = 2
	light_color = LIGHT_COLOR_LIGHT_CYAN
	light_on = TRUE
	damtype = BURN
	force = 5
	attack_verb_continuous = list("burns", "singes")
	attack_verb_simple = list("burn", "singe")
	resistance_flags = FIRE_PROOF
	w_class = WEIGHT_CLASS_HUGE
	light_system = OVERLAY_LIGHT
	toolspeed = 2
	tool_behaviour = TOOL_WELDER
	item_flags = DROPDEL | ABSTRACT | HAND_ITEM
	heat = HIGH_TEMPERATURE_REQUIRED - 100

/obj/item/psionic_fire/Initialize(mapload)
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
	stamina_cost = 30
	point_cost = 1

/datum/action/cooldown/spell/conjure_item/psionic/psiblade/make_item(atom/caster)
	var/obj/item/made_item = new item_type(caster.loc, cast_power)
	LAZYADD(item_refs, WEAKREF(made_item))
	var/mob/living/carbon/human/caster_pawn = owner
	caster_pawn.emote_snap()
	return made_item

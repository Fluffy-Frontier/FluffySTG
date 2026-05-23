// Спавнит пси-клинок в руке. Сила зависит от уровня псионика
/datum/action/cooldown/spell/conjure_item/psionic/psiblade
	name = "Psionic blade"
	desc = "Concentrates psionic energy to create a sharp blade in your hand."
	button_icon = 'icons/obj/weapons/transforming_energy.dmi'
	button_icon_state = "blade"
	cooldown_time = 1.5 SECONDS
	item_type = /obj/item/melee/psionic_blade
	mana_cost = 40
	psionic_level = 2
	point_cost = 3
	category = "Tier 2"
	locked = FALSE

/obj/item/melee/psionic_blade
	name = "psionic blade"
	desc = "A concentrated collection of particles and energy that looks like a swords blade.."
	icon = 'icons/obj/weapons/transforming_energy.dmi'
	icon_state = "blade"
	inhand_icon_state = "blade"
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	w_class = WEIGHT_CLASS_HUGE
	force = 25
	armour_penetration = 30
	throwforce = 10
	hitsound = 'sound/items/weapons/blade1.ogg'
	attack_verb_continuous = list("attacks", "slashes", "stabs", "slices", "tears", "lacerates", "rips", "dices", "cuts")
	attack_verb_simple = list("attack", "slash", "stab", "slice", "tear", "lacerate", "rip", "dice", "cut")
	sharpness = SHARP_EDGED
	block_chance = 50
	item_flags = DROPDEL | ABSTRACT | HAND_ITEM
	color = COLOR_BRIGHT_BLUE

/obj/item/melee/psionic_blade/New(loc, power)
	. = ..()
	ADD_TRAIT(src, TRAIT_EXAMINE_SKIP, INNATE_TRAIT)

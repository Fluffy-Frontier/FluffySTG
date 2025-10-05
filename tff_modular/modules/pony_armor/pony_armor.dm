/mob/living/basic/pony
	var/has_armor = FALSE

/obj/item/pony_armor
	name = "Cavalryman's Pony Box"
	desc = "It's a box with a pony painted on it. You can't open it, but what if you give it to a pony?"
	icon = 'tff_modular/modules/pony_armor/icon/horse_armor.dmi'
	icon_state = "box_of_horse"
	force = 0
	throwforce = 5
	var/list/avaible_armor = list(
		"Iron Armor" = new /datum/pony_armor/iron,
		"Silver armor" = new /datum/pony_armor/silver,
		"Uranium armor" = new /datum/pony_armor/uranium,
		"Gold Armor" = new /datum/pony_armor/gold,
		"Diamond armor" = new /datum/pony_armor/diamond,
		"Bananium armor" = new /datum/pony_armor/bananium,
		"Adamantium armor" = new /datum/pony_armor/adamantium,
		"Durethead armor" = new /datum/pony_armor/durethead,
		"Dragon armor" = new /datum/pony_armor/dragon,
		"Titanium" = new /datum/pony_armor/titanium,
	)

/obj/item/pony_armor/attack(mob/living/target_mob, mob/living/user, list/modifiers, list/attack_modifiers)
	. = ..()

	if(!istype(target_mob, /mob/living/basic/pony))
		return

	var/mob/living/basic/pony/target = target_mob

	if(target.has_armor)
		return

	var/choice = tgui_input_list(user, "Pick an armor for your pony", "Pony armory", avaible_armor)
	if(!choice || QDELETED(user))
		return
	var/datum/pony_armor/choosen_armor = avaible_armor[choice]
	choosen_armor.on_armor_equip(target)
	target.has_armor = TRUE
	return

/datum/pony_armor
	var/icon/ponyicon
	var/armor_path = 'tff_modular/modules/pony_armor/icon/horse_armor.dmi'
	var/armor_name = null

/datum/pony_armor/proc/on_armor_equip(mob/living/basic/pony/who_equip)
	ponyicon = icon(icon = armor_path, icon_state = armor_name)
	who_equip.add_overlay(ponyicon)
	return

/datum/pony_armor/iron
	armor_name = "Iron_armor"

/datum/pony_armor/silver
	armor_name = "Silver_armor"

/datum/pony_armor/uranium
	armor_name = "Uranium_armor"

/datum/pony_armor/gold
	armor_name = "Gold_armor"

/datum/pony_armor/diamond
	armor_name = "Diamond_armor"

/datum/pony_armor/bananium
	armor_name = "Bananium_armor"

/datum/pony_armor/adamantium
	armor_name = "Adamantium_armor"

/datum/pony_armor/durethead
	armor_name = "Durethread_armor"

/datum/pony_armor/dragon
	armor_name = "Dragon_armor"

/datum/pony_armor/titanium
	armor_name = "Titanium"

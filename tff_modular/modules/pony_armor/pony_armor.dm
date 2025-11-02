/mob/living/basic/pony
	// Current armor we have
	var/datum/pony_armor/current_armor = null
	var/static/list/avaible_armor = list(
		"Iron Armor" = new /datum/pony_armor/iron,
		"Silver armor" = new /datum/pony_armor/silver,
		"Uranium armor" = new /datum/pony_armor/uranium,
		"Gold Armor" = new /datum/pony_armor/gold,
		"Diamond armor" = new /datum/pony_armor/diamond,
		"Bananium armor" = new /datum/pony_armor/bananium,
		"Adamantium armor" = new /datum/pony_armor/adamantium,
		"Durethead armor" = new /datum/pony_armor/durethead,
		"Dragon armor" = new /datum/pony_armor/dragon,
		"Titanium armor" = new /datum/pony_armor/titanium,
	)
	var/icon/ponyicon

/mob/living/basic/pony/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	. = ..()
	if(istype(tool, /obj/item/pony_armor))
		if(current_armor)
			if(tgui_alert(user, "There is already armor! Do you want to remove it?", "Pony Armory", list("Yes", "No")) == "Yes")
				remove_armor()
			else
				return FALSE
		var/choice = tgui_input_list(user, "Pick an armor for your pony", "Pony Armory", avaible_armor)
		if(!choice || QDELETED(user))
			return
		var/datum/pony_armor/choosen_armor = avaible_armor[choice]
		give_armor(choosen_armor)
		return TRUE

/mob/living/basic/pony/proc/give_armor(datum/pony_armor/choosen_armor)
	ponyicon = icon(icon = choosen_armor.armor_path, icon_state = choosen_armor.armor_name)
	current_armor = choosen_armor
	add_overlay(ponyicon)

/mob/living/basic/pony/proc/remove_armor()
	current_armor = null
	cut_overlay(ponyicon)

/obj/item/pony_armor
	name = "Cavalryman's Pony Box"
	desc = "It's a box with a pony painted on it. What if you give it to a pony?"
	icon = 'tff_modular/modules/pony_armor/horse_armor.dmi'
	icon_state = "box_of_horse"
	force = 0
	throwforce = 0

/datum/pony_armor
	var/armor_path = 'tff_modular/modules/pony_armor/horse_armor.dmi'
	var/armor_name = null

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
	armor_name = "Durathread_armor"

/datum/pony_armor/dragon
	armor_name = "Dragon_armor"

/datum/pony_armor/titanium
	armor_name = "Titanium_armor"

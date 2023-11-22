<<<<<<< HEAD
/datum/species/monkey
	default_mutant_bodyparts = list("tail" = "Monkey")
=======
/datum/species/monkey/get_default_mutant_bodyparts()
	return list(
		"tail" = list("Monkey", FALSE),
	)
>>>>>>> ec0245b89 (Changes default_mutant_bodyparts list to be index based (#25174))

/datum/species/monkey/prepare_human_for_preview(mob/living/carbon/human/monke)
	regenerate_organs(monke, src, visual_only = TRUE)
	monke.update_body(is_creating = TRUE)

/datum/species/monkey/get_custom_worn_icon(item_slot, obj/item/item)
	return item.worn_icon_monkey

/datum/species/monkey/set_custom_worn_icon(item_slot, obj/item/item, icon/icon)
	item.worn_icon_monkey = icon

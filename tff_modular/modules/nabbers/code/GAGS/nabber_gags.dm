#define BASE_CLOTH_X_1 1
#define BASE_CLOTH_Y_1 1

/obj/item
	var/datum/greyscale_config/greyscale_config_worn_nabber_fallback
	var/icon/worn_icon_nabber

/datum/species/nabber/get_custom_worn_icon(item_slot, obj/item/item)
	return item.worn_icon_nabber

/datum/species/nabber/set_custom_worn_icon(item_slot, obj/item/item, icon/icon)
	item.worn_icon_nabber = icon

/datum/species/nabber/get_custom_worn_config_fallback(item_slot, obj/item/item)
	return item.greyscale_config_worn_nabber_fallback

/datum/species/nabber/generate_custom_worn_icon(item_slot, obj/item/item, mob/living/carbon/human/human_owner)
	. = ..()
	if(.)
		return

	. = generate_custom_worn_icon_fallback(item_slot, item, human_owner)
	if(.)
		return

/obj/item/clothing/under
	species_clothing_color_coords = list(list(BASE_CLOTH_X_1, BASE_CLOTH_Y_1))
	greyscale_config_worn_nabber_fallback = /datum/greyscale_config/nabber

/obj/item/clothing/neck
	species_clothing_color_coords = list(list(BASE_CLOTH_X_1, BASE_CLOTH_Y_1))
	greyscale_config_worn_nabber_fallback = /datum/greyscale_config/nabber/scarf

/obj/item/clothing/neck/cloak
	species_clothing_color_coords = list(list(BASE_CLOTH_X_1, BASE_CLOTH_Y_1))
	greyscale_config_worn_nabber_fallback = /datum/greyscale_config/nabber/cloak

/obj/item/clothing/neck/tie
	species_clothing_color_coords = list(list(BASE_CLOTH_X_1, BASE_CLOTH_Y_1))
	greyscale_config_worn_nabber_fallback = /datum/greyscale_config/nabber/tie

/obj/item/clothing/gloves
	species_clothing_color_coords = list(list(BASE_CLOTH_X_1, BASE_CLOTH_Y_1))
	greyscale_config_worn_nabber_fallback = /datum/greyscale_config/nabber/gloves

/obj/item/clothing/belt
	species_clothing_color_coords = list(list(BASE_CLOTH_X_1, BASE_CLOTH_Y_1))
	greyscale_config_worn_nabber_fallback = /datum/greyscale_config/nabber/belt

/**
 * Nabber fallbacks.
 * In case what we have another species with specials Json config file. We use this for our case.
 * Check teshari fasllbacks .json config files for more datails.
 */

/datum/greyscale_config/nabber
	name = "Nabber clothing"
	icon_file = 'tff_modular/modules/nabbers/icons/nabber_fallbacks.dmi'
	json_config = 'modular_skyrat/modules/GAGS/json_configs/nabber_fallbacks/uniform.json'

/datum/greyscale_config/nabber/cloak
	name = "Nabber Poncho"
	json_config = 'modular_skyrat/modules/GAGS/json_configs/nabber_fallbacks/neck.json'

/datum/greyscale_config/nabber/tie
	name = "Nabber Tie"
	json_config = 'modular_skyrat/modules/GAGS/json_configs/nabber_fallbacks/neck.json'

/datum/greyscale_config/nabber/scarf
	name = "Nabber Scarf"
	json_config = 'modular_skyrat/modules/GAGS/json_configs/nabber_fallbacks/neck.json'

/datum/greyscale_config/nabber/gloves
	name = "Nabber Gloves"
	json_config = 'modular_skyrat/modules/GAGS/json_configs/nabber_fallbacks/gloves.json'

/datum/greyscale_config/nabber/belt
	name = "Nabber Belt"
	json_config = 'modular_skyrat/modules/GAGS/json_configs/nabber_fallbacks/belt.json'

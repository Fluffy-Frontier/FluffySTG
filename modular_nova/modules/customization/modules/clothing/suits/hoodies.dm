/*
*	The hoodies and attached sprites [WERE ORIGINALLY FROM] https://github.com/Citadel-Station-13/Citadel-Station-13-RP before GAGSification
*	Respective datums can be found in modular_nova/modules/customization/datums/greyscale/hoodies
*	These are now a subtype of toggle/jacket too, so it properly toggles and isnt the unused 'storage' type
*/

/obj/item/clothing/suit/toggle/jacket/nova/hoodie
	name = "hoodie"
	desc = "A warm hoodie. you cant help but mess with the zipper..."
	icon = 'icons/map_icons/clothing/suit/_suit.dmi'
	icon_state = "/obj/item/clothing/suit/toggle/jacket/nova/hoodie"
	post_init_icon_state = "hoodie"
	greyscale_config = /datum/greyscale_config/hoodie
	greyscale_config_worn = /datum/greyscale_config/hoodie/worn
	greyscale_colors = "#FFFFFF"
	flags_1 = IS_PLAYER_COLORABLE_1
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	gets_cropped_on_taurs = FALSE
	min_cold_protection_temperature = T0C - 20	//Not as good as the base jacket

/obj/item/clothing/suit/toggle/jacket/nova/hoodie/trim
	icon_state = "/obj/item/clothing/suit/toggle/jacket/nova/hoodie/trim"
	post_init_icon_state = "hoodie_trim"
	greyscale_config = /datum/greyscale_config/hoodie_trim
	greyscale_config_worn = /datum/greyscale_config/hoodie_trim/worn
	greyscale_colors = "#ffffff#313131"

/obj/item/clothing/suit/toggle/jacket/nova/hoodie/trim/alt
	icon_state = "/obj/item/clothing/suit/toggle/jacket/nova/hoodie/trim/alt"
	post_init_icon_state = "hoodie_trim_alt"

/*
*	PRESET GREYSCALES & BRANDED
*/

/obj/item/clothing/suit/toggle/jacket/nova/hoodie/grey
	icon_state = "/obj/item/clothing/suit/toggle/jacket/nova/hoodie/grey"
	greyscale_colors = "#a8a8a8"
	flags_1 = NONE

/obj/item/clothing/suit/toggle/jacket/nova/hoodie/black
	icon_state = "/obj/item/clothing/suit/toggle/jacket/nova/hoodie/black"
	greyscale_colors = "#313131"
	flags_1 = NONE

/obj/item/clothing/suit/toggle/jacket/nova/hoodie/red
	icon_state = "/obj/item/clothing/suit/toggle/jacket/nova/hoodie/red"
	greyscale_colors = "#D13838"
	flags_1 = NONE

/obj/item/clothing/suit/toggle/jacket/nova/hoodie/blue
	icon_state = "/obj/item/clothing/suit/toggle/jacket/nova/hoodie/blue"
	greyscale_colors = "#034A8D"
	flags_1 = NONE

/obj/item/clothing/suit/toggle/jacket/nova/hoodie/green
	icon_state = "/obj/item/clothing/suit/toggle/jacket/nova/hoodie/green"
	greyscale_colors = "#1DA103"
	flags_1 = NONE

/obj/item/clothing/suit/toggle/jacket/nova/hoodie/orange
	icon_state = "/obj/item/clothing/suit/toggle/jacket/nova/hoodie/orange"
	greyscale_colors = "#F79305"
	flags_1 = NONE

/obj/item/clothing/suit/toggle/jacket/nova/hoodie/yellow
	icon_state = "/obj/item/clothing/suit/toggle/jacket/nova/hoodie/yellow"
	greyscale_colors = "#F0D655"
	flags_1 = NONE

/obj/item/clothing/suit/toggle/jacket/nova/hoodie/branded
	name = "\improper NT hoodie"
	desc = "A warm, blue sweatshirt. It proudly bears the silver Nanotrasen insignia lettering on the back. The edges are trimmed with silver."
	icon = 'icons/map_icons/clothing/suit/_suit.dmi'
	icon_state = "/obj/item/clothing/suit/toggle/jacket/nova/hoodie/branded"
	post_init_icon_state = "hoodie_NT"
	greyscale_config = /datum/greyscale_config/hoodie_branded
	greyscale_config_worn = /datum/greyscale_config/hoodie_branded/worn
	greyscale_colors = "#02519A#ffffff"
	flags_1 = NONE

/obj/item/clothing/suit/toggle/jacket/nova/hoodie/branded/nrti
	name = "\improper NRTI hoodie"
	desc = "A warm, gray sweatshirt. It bears the letters NRT on the back, in reference to Sif's premiere New Reykjavik Technical Institute."
	icon_state = "/obj/item/clothing/suit/toggle/jacket/nova/hoodie/branded/nrti"
	post_init_icon_state = "hoodie_NRTI"
	greyscale_colors = "#747474#a83232"

/obj/item/clothing/suit/toggle/jacket/nova/hoodie/branded/mu
	name = "\improper MU hoodie"
	desc = "A warm, gray sweatshirt. It bears the letters MU on the front, a lettering to the well-known public college, Mojave University."
	icon_state = "/obj/item/clothing/suit/toggle/jacket/nova/hoodie/branded/mu"
	post_init_icon_state = "hoodie_MU"
	greyscale_colors = "#747474#ffffff"

/obj/item/clothing/suit/toggle/jacket/nova/hoodie/branded/cti
	name = "\improper CTI hoodie"
	desc = "A warm, black sweatshirt. It bears the letters CTI on the back, a lettering to the prestigious university in Tau Ceti, Ceti Technical Institute.  There is a blue supernova embroidered on the front, the emblem of CTI."
	icon_state = "/obj/item/clothing/suit/toggle/jacket/nova/hoodie/branded/cti"
	post_init_icon_state = "hoodie_CTI"
	greyscale_colors = "#313131#ffffff"

/obj/item/clothing/suit/toggle/jacket/nova/hoodie/branded/smw
	name = "\improper Space Mountain Wind hoodie"
	desc = "A warm, black sweatshirt. It has the logo for the popular softdrink Space Mountain Wind on both the front and the back."
	icon_state = "/obj/item/clothing/suit/toggle/jacket/nova/hoodie/branded/smw"
	post_init_icon_state = "hoodie_SMW"
	greyscale_colors = "#313131#ffffff"

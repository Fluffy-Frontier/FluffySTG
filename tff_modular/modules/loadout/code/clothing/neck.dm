/obj/item/clothing/suit/hooded/cloak/wakamo
	name = "halo holo-projector"
	desc =  "Prototype version of a Holo-Projector that creates projection above your head."
	icon = 'tff_modular/modules/loadout/icons/obj/clothing/neck.dmi'
	icon_state = "/obj/item/clothing/suit/hooded/cloak/wakamo"
	post_init_icon_state = "wakamo"
	worn_icon = 'tff_modular/modules/loadout/icons/mob/clothing/neck.dmi'
	hoodtype = /obj/item/clothing/head/hooded/cloakhood/wakamo
	body_parts_covered = HEAD|NECK
	slot_flags = ITEM_SLOT_NECK //it's a cloak. it's cosmetic. so why the hell not? what could possibly go wrong?
	supports_variations_flags = NONE
	resistance_flags = FIRE_PROOF
	greyscale_colors = "#AC3232"
	greyscale_config = /datum/greyscale_config/wakamo
	greyscale_config_worn = /datum/greyscale_config/wakamo/worn
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/suit/hooded/cloak/wakamo/set_greyscale(list/colors, new_config, new_worn_config, new_inhand_left, new_inhand_right)
	. = ..()
	if(!hood)
		return
	var/list/coat_colors = SSgreyscale.ParseColorString(greyscale_colors)
	var/list/new_coat_colors = coat_colors.Copy(1)
	hood.set_greyscale(new_coat_colors) //Adopt the suit's grayscale coloring for visual clarity.
	hood.update_slot_icon()

//But also keep old method in case the hood is (re-)created later
/obj/item/clothing/suit/hooded/cloak/wakamo/on_hood_created(obj/item/clothing/head/hooded/hood)
	. = ..()
	var/list/coat_colors = (SSgreyscale.ParseColorString(greyscale_colors))
	var/list/new_coat_colors = coat_colors.Copy(1)
	hood.set_greyscale(new_coat_colors) //Adopt the suit's grayscale coloring for visual clarity.

/obj/item/clothing/head/hooded/cloakhood/wakamo
	name = "halo"
	desc = "This is a projection of a Halo above the head. Looks neat. But now you feel Responsibilities weighing on your shoulders since you have grown out of it."
	icon = 'tff_modular/modules/loadout/icons/obj/clothing/head.dmi'
	icon_state = "wakamo"
	worn_icon = 'tff_modular/modules/loadout/icons/mob/clothing/head.dmi'
	flags_inv = null
	supports_variations_flags = NONE
	resistance_flags = FIRE_PROOF
	greyscale_config = /datum/greyscale_config/wakamo_halo
	greyscale_config_worn = /datum/greyscale_config/wakamo_halo/worn

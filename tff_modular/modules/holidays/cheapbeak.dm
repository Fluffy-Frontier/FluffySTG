/obj/item/clothing/mask/animal/small/raven/beak
	name = "Fake beak"
	desc = "It's very cheap and flimsy."
	icon_state = "beak"
	icon = 'tff_modular/modules/holidays/icons/beak_state.dmi'
	worn_icon = 'tff_modular/modules/holidays/icons/beak.dmi'
	clothing_flags = VOICEBOX_DISABLED

/obj/item/storage/box/survival/PopulateContents()
	new /obj/item/clothing/mask/animal/small/raven/beak(src)
	. = ..()

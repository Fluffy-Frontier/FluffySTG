/obj/structure/closet/abyss_station
	icon = 'tff_modular/modules/abyssstation/icons/closet.dmi'

/obj/structure/closet/abyss_station/abyss_emergency
	name = "abyss emergency"
	desc = "A coffin for the poor souls who fell into the Abyss."
	icon_state = "abyss"

/obj/structure/closet/abyss_station/abyss_emergency/PopulateContents()
	..()
	new /obj/item/bodybag(src)
	new /obj/item/bodybag(src)
	new /obj/item/fishing_hook/rescue(src)
	new /obj/item/storage/toolbox/fishing(src)

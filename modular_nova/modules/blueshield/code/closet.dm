/obj/item/storage/bag/garment/blueshield
	name = "blueshield's garment bag"
	desc = "A bag for storing extra clothes and shoes. This one belongs to the blueshield."

/obj/item/storage/bag/garment/blueshield/PopulateContents()
	new /obj/item/clothing/suit/hooded/wintercoat/nova/blueshield(src)
	new /obj/item/clothing/head/beret/blueshield(src)
	new /obj/item/clothing/head/beret/blueshield/navy(src)
	new /obj/item/clothing/under/rank/blueshield(src)
	new /obj/item/clothing/under/rank/blueshield/skirt(src)
	new /obj/item/clothing/under/rank/blueshield/turtleneck(src)
	new /obj/item/clothing/under/rank/blueshield/turtleneck/skirt(src)
	new /obj/item/clothing/suit/armor/vest/blueshield(src)
	new /obj/item/clothing/suit/armor/vest/blueshield/jacket(src)
	new /obj/item/clothing/neck/mantle/bsmantle(src)

/obj/structure/closet/secure_closet/blueshield
	name = "blueshield's locker"
	icon_state = "bs"
	icon = 'modular_nova/master_files/icons/obj/closet.dmi'
	req_access = list(ACCESS_CAPTAIN)

/obj/structure/closet/secure_closet/blueshield/New()
	..()
	// FLUFFY FRONTIER EDIT: ADDITION BEGIN - BLUESHIELD-REARM
	// ВАЖНО!! ДАБЫ НЕ ПЕРЕНАСЫЩАТЬ БЩ ОРУЖИЕМ, ЛЮБЫЕ НОВЫЕ ПУШКИ ПЕРЕНОСИМ В МОДУЛЬ В /obj/item/choice_beacon/blueshield/
	// Выдал БЩ дополнительные перчатки, аналогичные их стандартным, просто без эффекта рывка.
	new /obj/item/clothing/gloves/combat(src)
	// FLUFFY FRONTIER EDIT END - BLUESHIELD-REARM.
	new /obj/item/storage/briefcase/secure(src)
	new /obj/item/storage/belt/security/full(src)
	new /obj/item/grenade/flashbang(src)
	new /obj/item/assembly/flash/handheld(src)
	new /obj/item/restraints/handcuffs(src)
	new /obj/item/clothing/glasses/hud/security/sunglasses(src)
<<<<<<< HEAD
	new /obj/item/storage/medkit/tactical/blueshield(src)
	// new /obj/item/storage/toolbox/guncase/nova/xhihao_large_case/bogseo(src) FF EDIT: DELETION - BLUESHIELD-REARM
=======
	new /obj/item/storage/medkit/frontier/stocked(src)
>>>>>>> 8e6f95651b7 (Blueshield QOL with other code cleanup (#2816))
	new /obj/item/storage/bag/garment/blueshield(src)
	new /obj/item/mod/control/pre_equipped/blueshield(src)

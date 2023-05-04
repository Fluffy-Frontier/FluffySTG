/obj/structure/closet/secure_closet/security/redsec
	name = "security officer's locker"
	req_access = list(ACCESS_BRIG)
	icon = '~ff/modules/redsec/icons/obj/storage/closet.dmi'
	icon_state = "sec"

/obj/structure/closet/secure_closet/security/redsec/PopulateContents()
	..()
	new /obj/item/clothing/suit/armor/vest/alt/sec/redsec(src)
	new /obj/item/clothing/head/soft/sec(src)
	new /obj/item/clothing/head/helmet/sec(src)
	new /obj/item/radio/headset/headset_sec(src)
	new /obj/item/radio/headset/headset_sec/alt(src)
	new /obj/item/clothing/glasses/hud/security/sunglasses/redsec(src)
	new /obj/item/flashlight/seclite(src)

/obj/structure/closet/secure_closet/security/redsec/sec

/obj/structure/closet/secure_closet/security/redsec/sec/PopulateContents()
	..()
	new /obj/item/storage/belt/security/full(src)

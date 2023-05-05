/obj/structure/closet/secure_closet/redsecurity
	name = "security officer's locker"
	req_access = list(ACCESS_BRIG)
	icon = 'tff_modular/modules/redsec/icons/obj/storage/closet.dmi'
	icon_state = "sec"

/obj/structure/closet/secure_closet/redsecurity/PopulateContents()
	..()
	new /obj/item/clothing/suit/armor/vest/alt/sec/redsec(src)
	new /obj/item/clothing/head/soft/sec(src)
	new /obj/item/clothing/head/helmet/sec(src)
	new /obj/item/radio/headset/headset_sec(src)
	new /obj/item/radio/headset/headset_sec/alt(src)
	new /obj/item/clothing/glasses/hud/security/sunglasses/redsec(src)
	new /obj/item/flashlight/seclite(src)

/obj/structure/closet/secure_closet/redsecurity/sec

/obj/structure/closet/secure_closet/redsecurity/sec/PopulateContents()
	..()
	new /obj/item/storage/belt/security/redsec/full(src)

/obj/item/storage/belt/security/redsec/full/PopulateContents()
	new /obj/item/reagent_containers/spray/pepper(src)
	new /obj/item/restraints/handcuffs(src)
	new /obj/item/grenade/flashbang(src)
	new /obj/item/assembly/flash/handheld(src)
	new /obj/item/melee/baton/security/loaded(src)
	update_appearance()

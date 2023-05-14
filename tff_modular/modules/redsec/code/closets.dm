/obj/item/storage/belt/security/redsec/full/PopulateContents()
	new /obj/item/reagent_containers/spray/pepper(src)
	new /obj/item/restraints/handcuffs(src)
	new /obj/item/grenade/flashbang(src)
	new /obj/item/assembly/flash/handheld(src)
	new /obj/item/melee/baton/security/loaded(src)
	update_appearance()

/obj/structure/closet/secure_closet/security
	name = "security officer's locker"
	req_access = list(ACCESS_BRIG)
	var/sec_type = "blue"
	icon_state = "sec"

/obj/structure/closet/secure_closet/security/Initialize(mapload)
	. = ..()
	sec_type = pick("blue","red")
	if(sec_type=="blue")
		name = "blue security officer's locker"
		icon_state = "sec"
	else
		name = "red security officer's locker"
		icon = 'tff_modular/modules/redsec/icons/obj/storage/closet.dmi'
		icon_state = "sec"
	update_icon_state()
	update_icon()

/obj/structure/closet/secure_closet/security/cargo/Initialize(mapload)
	. = ..()
	name = "\proper customs agent's locker"
	icon_state = "qm"
	icon = 'icons/obj/storage/closet.dmi'
	update_icon_state()
	update_icon()

/obj/structure/closet/secure_closet/security/engine/Initialize(mapload)
	. = ..()
	name = "\proper engineering guard's locker"
	icon_state = "eng_secure"
	icon = 'icons/obj/storage/closet.dmi'
	update_icon_state()
	update_icon()

/obj/structure/closet/secure_closet/security/science/Initialize(mapload)
	. = ..()
	name = "\proper science guard's locker"
	icon_state = "science"
	icon = 'icons/obj/storage/closet.dmi'
	update_icon_state()
	update_icon()

/obj/structure/closet/secure_closet/security/med/Initialize(mapload)
	. = ..()
	name = "\proper orderly's locker"
	icon_state = "med_secure"
	icon = 'icons/obj/storage/closet.dmi'
	update_icon_state()
	update_icon()

/obj/structure/closet/secure_closet/security/PopulateContents()
	if(sec_type=="blue")
		..()
		new /obj/item/clothing/suit/armor/vest/alt/sec(src)
		new /obj/item/clothing/head/security_cap(src)
		new /obj/item/clothing/head/helmet/sec(src)
		new /obj/item/radio/headset/headset_sec(src)
		new /obj/item/radio/headset/headset_sec/alt(src)
		new /obj/item/clothing/glasses/hud/security/sunglasses(src)
		new /obj/item/flashlight/seclite(src)
	else
		..()
		new /obj/item/clothing/suit/armor/vest/alt/sec/redsec(src)
		new /obj/item/clothing/head/soft/sec(src)
		new /obj/item/clothing/head/helmet/sec(src)
		new /obj/item/radio/headset/headset_sec(src)
		new /obj/item/radio/headset/headset_sec/alt(src)
		new /obj/item/clothing/glasses/hud/security/sunglasses/redsec(src)
		new /obj/item/flashlight/seclite(src)

/obj/structure/closet/secure_closet/security/sec/PopulateContents()
	if(sec_type=="blue")
		new /obj/item/clothing/suit/armor/vest/alt/sec(src)
		new /obj/item/clothing/head/security_cap(src)
		new /obj/item/clothing/head/helmet/sec(src)
		new /obj/item/radio/headset/headset_sec(src)
		new /obj/item/radio/headset/headset_sec/alt(src)
		new /obj/item/clothing/glasses/hud/security/sunglasses(src)
		new /obj/item/flashlight/seclite(src)
		new /obj/item/storage/belt/security/full(src)
	else
		new /obj/item/clothing/suit/armor/vest/alt/sec/redsec(src)
		new /obj/item/clothing/head/soft/sec(src)
		new /obj/item/clothing/head/helmet/sec(src)
		new /obj/item/radio/headset/headset_sec(src)
		new /obj/item/radio/headset/headset_sec/alt(src)
		new /obj/item/clothing/glasses/hud/security/sunglasses/redsec(src)
		new /obj/item/flashlight/seclite(src)
		new /obj/item/storage/belt/security/redsec/full(src)

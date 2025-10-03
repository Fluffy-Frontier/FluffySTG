/obj/item/gun/ballistic/automatic/smg/vector
	name = "\improper Vector carbine"
	desc = "A police carbine based on a pre-Night of Fire SMG design. Most of the complex workings have been removed for reliability. Chambered in 9x18mm."
	icon = 'tff_modular/modules/evento_needo/icons/nanotrasen_sharplite/48x32.dmi'
	lefthand_file = 'tff_modular/modules/evento_needo/icons/nanotrasen_sharplite/lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/icons/nanotrasen_sharplite/righthand.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/icons/nanotrasen_sharplite/onmob.dmi'
	icon_state = "vector"
	inhand_icon_state = "vector"
	accepted_magazine_type = /obj/item/ammo_box/magazine/smgm9mm //you guys remember when the autorifle was chambered in 9mm
	bolt_type = BOLT_TYPE_LOCKING
	weapon_weight = WEAPON_LIGHT
	fire_sound = 'tff_modular/modules/evento_needo/sounds/smg/vector_fire.ogg'

/obj/item/gun/ballistic/automatic/smg/skm_carbine
	name = "\improper SKM-24v"
	desc = "The SKM-24v was a carbine modification of the SKM-24 during the Frontiersmen War. This, however, is just a shoddy imitation of that carbine, effectively an SKM-24 with a sawed down barrel and a folding wire stock. Can be fired with the stock folded, though accuracy suffers. Chambered in 4.6x30mm."

	icon = 'tff_modular/modules/evento_needo/icons/48x32guns.dmi'
	worn_icon = 'icons/mob/clothing/back.dmi'
	icon_state = "skm_carbine"
	inhand_icon_state = "skm_carbine"

	fire_sound = 'tff_modular/modules/evento_needo/sounds/rifle/skm_smg.ogg'

	rack_sound = 'tff_modular/modules/evento_needo/sounds/rifle/skm_cocked.ogg'
	load_sound = 'tff_modular/modules/evento_needo/sounds/rifle/skm_reload.ogg'
	load_empty_sound = 'tff_modular/modules/evento_needo/sounds/rifle/skm_reload.ogg'
	eject_sound = 'tff_modular/modules/evento_needo/sounds/rifle/skm_unload.ogg'
	eject_empty_sound = 'tff_modular/modules/evento_needo/sounds/rifle/skm_unload.ogg'

	weapon_weight = WEAPON_MEDIUM
	w_class = WEIGHT_CLASS_NORMAL
	accepted_magazine_type = /obj/item/ammo_box/magazine/skm_46_30

	recoil = 2
	recoil_unwielded = 6

	spread = 8
	spread_unwielded = 14
	wield_slowdown = SMG_SLOWDOWN

	unique_attachments = list(
		/obj/item/attachment/foldable_stock
		)

	slot_available = list(
		ATTACHMENT_SLOT_MUZZLE = 1,
		ATTACHMENT_SLOT_RAIL = 1,
		ATTACHMENT_SLOT_STOCK = 1
	)
	slot_offsets = list(
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 26,
			"y" = 20,
		),
		ATTACHMENT_SLOT_RAIL = list(
			"x" = 19,
			"y" = 18,
		),
		ATTACHMENT_SLOT_STOCK = list(
			"x" = 11,
			"y" = 20,
		)
	)

	default_attachments = list(/obj/item/attachment/foldable_stock)

/obj/item/gun/ballistic/automatic/smg/skm_carbine/inteq
	name = "\improper SKM-44v Mongrel"
	desc = "An SKM-44, further modified into a sub-machine gun by Inteq artificers with a new magazine well, collapsing stock, and shortened barrel. Faced with a surplus of SKM-44s and a shortage of other firearms, IRMG has made the most of their available materiel with conversions such as this. Chambered in 10x22mm."
	icon = 'tff_modular/modules/evento_needo/icons/inteq/48x32.dmi'
	lefthand_file = 'tff_modular/modules/evento_needo/icons/inteq/lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/icons/inteq/righthand.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/icons/inteq/onmob.dmi'
	icon_state = "skm_inteqsmg"
	inhand_icon_state = "skm_inteqsmg"

	accepted_magazine_type = /obj/item/ammo_box/magazine/smgm10mm

	fire_sound = 'tff_modular/modules/evento_needo/sounds/smg/vector_fire.ogg'

	load_sound = 'tff_modular/modules/evento_needo/sounds/smg/smg_reload.ogg'
	load_empty_sound = 'tff_modular/modules/evento_needo/sounds/smg/smg_reload.ogg'
	eject_sound = 'tff_modular/modules/evento_needo/sounds/smg/smg_unload.ogg'
	eject_empty_sound = 'tff_modular/modules/evento_needo/sounds/smg/smg_unload.ogg'

	spread = 7
	spread_unwielded = 10

	recoil = 0
	recoil_unwielded = 4
	unique_attachments = list(
		/obj/item/attachment/foldable_stock/inteq
	)
	default_attachments = list(/obj/item/attachment/foldable_stock/inteq)

/obj/item/gun/ballistic/automatic/smg/skm_carbine/saber
	name = "\improper Nanotrasen Saber SMG"
	desc = "A prototype full-auto 9x18mm submachine gun, designated 'SABR'. Has a threaded barrel for suppressors and a folding stock."
	icon = 'tff_modular/modules/evento_needo/icons/nanotrasen_sharplite/48x32.dmi'
	icon_state = "saber"
	inhand_icon_state = "gun"

	accepted_magazine_type = /obj/item/ammo_box/magazine/smgm9mm

	fire_sound = 'tff_modular/modules/evento_needo/sounds/smg/vector_fire.ogg'

	load_sound = 'tff_modular/modules/evento_needo/sounds/smg/smg_reload.ogg'
	load_empty_sound = 'tff_modular/modules/evento_needo/sounds/smg/smg_reload.ogg'
	eject_sound = 'tff_modular/modules/evento_needo/sounds/smg/smg_unload.ogg'
	eject_empty_sound = 'tff_modular/modules/evento_needo/sounds/smg/smg_unload.ogg'

	spread = 7
	spread_unwielded = 10

	recoil = 0
	recoil_unwielded = 4
	unique_attachments = list(
		/obj/item/attachment/foldable_stock
	)
	default_attachments = list(/obj/item/attachment/foldable_stock)
	bolt_type = BOLT_TYPE_LOCKING

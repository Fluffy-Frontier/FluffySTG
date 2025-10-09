/obj/item/gun/ballistic/automatic/assault/skm
	name = "\improper SKM-24"
	desc = "An obsolete model of assault rifle once used by CLIP. Legendary for its durability and low cost, surplus rifles are commonplace on the Frontier, and the design has been widely copied. Chambered in 7.62x40mm CLIP."
	icon = 'tff_modular/modules/evento_needo/icons/frontier_import/48x32.dmi'
	lefthand_file = 'tff_modular/modules/evento_needo/icons/frontier_import/lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/icons/frontier_import/righthand.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/icons/frontier_import/onmob.dmi'

	fire_sound = 'tff_modular/modules/evento_needo/sounds/rifle/skm.ogg'

	rack_sound = 'tff_modular/modules/evento_needo/sounds/rifle/skm_cocked.ogg'
	load_sound = 'tff_modular/modules/evento_needo/sounds/rifle/skm_reload.ogg'
	load_empty_sound = 'tff_modular/modules/evento_needo/sounds/rifle/skm_reload.ogg'
	eject_sound = 'tff_modular/modules/evento_needo/sounds/rifle/skm_unload.ogg'
	eject_empty_sound = 'tff_modular/modules/evento_needo/sounds/rifle/skm_unload.ogg'

	icon_state = "skm"
	inhand_icon_state = "skm"
	weapon_weight = WEAPON_MEDIUM
	slot_flags = ITEM_SLOT_BACK
	accepted_magazine_type = /obj/item/ammo_box/magazine/skm_762_40
	special_mags = TRUE

	//truly a doohickey for every occasion
	unique_attachments = list (
		/obj/item/attachment/scope,
		/obj/item/attachment/long_scope,
		/obj/item/attachment/energy_bayonet,
	)

	slot_available = list(
		ATTACHMENT_SLOT_MUZZLE = 1,
		ATTACHMENT_SLOT_RAIL = 1,
		ATTACHMENT_SLOT_SCOPE = 1
	)

	slot_offsets = list(
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 48,
			"y" = 18,
		),
		ATTACHMENT_SLOT_RAIL = list(
			"x" = 33,
			"y" = 15,
		),
		ATTACHMENT_SLOT_SCOPE = list(
			"x" = 16,
			"y" = 22,
		)
	)

	spread = 1
	fire_delay = 0.2 SECONDS

/obj/item/gun/ballistic/automatic/assault/skm/pirate
	name = "\improper Chopper"
	desc = "An SKM-24 in a state of shockingly poor repair: Several parts are missing and the 'grip' is improvised from scrap wood. It's a miracle it still works at all. Chambered in 7.62x40mm CLIP."

	icon_state = "skm_pirate"
	inhand_icon_state = "skm_pirate"

/obj/item/gun/ballistic/automatic/assault/skm/inteq
	name = "\improper SKM-44"
	desc = "An obsolete model of assault rifle once used by CLIP. Most of these were seized from Frontiersmen armories or purchased in CLIP, then modified to IRMG standards. Chambered in 7.62x40mm CLIP."

	icon = 'tff_modular/modules/evento_needo/icons/inteq/48x32.dmi'
	lefthand_file = 'tff_modular/modules/evento_needo/icons/inteq/lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/icons/inteq/righthand.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/icons/inteq/onmob.dmi'

	icon_state = "skm_inteq"
	inhand_icon_state = "skm_inteq"

/obj/item/gun/ballistic/automatic/assault/swiss_cheese
	name = "\improper Swiss Cheese"
	desc = "An ancient longarm famous for its boxy, modular design. Mass produced by the Terran Confederation in ages past, these often mutiple century old designs have survied due to their sheer ruggedness. The DMA on this unit is sadly broken, but these rifles are known for their excellent burst fire. Uses 5.56mm ammunition for Matter mode."
	icon = 'tff_modular/modules/evento_needo/icons/solararmories/48x32.dmi'
	lefthand_file = 'tff_modular/modules/evento_needo/icons/solararmories/lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/icons/solararmories/righthand.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/icons/solararmories/onmob.dmi'
	fire_sound = 'tff_modular/modules/evento_needo/sounds/rifle/swiss.ogg'
	icon_state = "swiss"
	inhand_icon_state = "swiss"
	empty_indicator = TRUE
	burst_size = 3
	burst_delay = 0.08 SECONDS
	fire_delay = 0.25 SECONDS
	spread = 8
	weapon_weight = WEAPON_MEDIUM
	gun_firenames = list(FIREMODE_SEMIAUTO = "matter semi-auto", FIREMODE_BURST = "matter burst fire", FIREMODE_FULLAUTO = "matter full auto", FIREMODE_OTHER = "hybrid")
	gun_firemodes = list(FIREMODE_SEMIAUTO, FIREMODE_FULLAUTO, FIREMODE_OTHER)

	fire_select_icon_state_prefix = "swisschesse_"

	slot_flags = ITEM_SLOT_BACK
	accepted_magazine_type = /obj/item/ammo_box/magazine/swiss
	spread = 8
	spread_unwielded = 15

/obj/item/gun/ballistic/automatic/assault/swiss_cheese/process_other(atom/target, mob/living/user, message = TRUE, flag, params = null, zone_override = "", bonus_spread = 0)
	to_chat(user, span_danger("You hear a strange sound from the DMA unit. It doesn't appear to be operational."))

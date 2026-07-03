// Изменяем текст и Флавор в спавнер меню, убирая лишнее "биологическое оружие"
/obj/effect/mob_spawn/ghost_role/human/interdyne_planetary_base
	you_are_text = "You are a Science Technician, employed on a Syndicate research & resource extraction outpost operated by Interdyne Pharmaceuticals."
	flavour_text = "The Sectorial Command has relayed that Nanotrasen is preparing to conduct mining operations in this sector. They are unaware of Interdyne's allegiance to the Syndicate, and you have been specifically instructed to preserve this cover by any means necessary. Continue your work as best you can while maintaining the facade of neutrality before our common foe."
/obj/effect/mob_spawn/ghost_role/human/interdyne_planetary_base/ice
	flavour_text = "The Sectorial Command has relayed that Nanotrasen is preparing to conduct mining operations in this sector. They are unaware of Interdyne's allegiance to the Syndicate, and you have been specifically instructed to preserve this cover by any means necessary. Continue your work as best you can while maintaining the facade of neutrality before our common foe."
/obj/effect/mob_spawn/ghost_role/human/interdyne_planetary_base/shaftminer
	you_are_text = "You are a Shaft Miner, employed on a Syndicate research & resource extraction outpost operated by Interdyne Pharmaceuticals."
/obj/effect/mob_spawn/ghost_role/human/interdyne_planetary_base/shaftminer/ice
	flavour_text = "The Sectorial Command has relayed that Nanotrasen is preparing to conduct mining operations in this sector. They are unaware of Interdyne's allegiance to the Syndicate, and you have been specifically instructed to preserve this cover by any means necessary. Continue your work as best you can while maintaining the facade of neutrality before our common foe."
/obj/effect/mob_spawn/ghost_role/human/interdyne_planetary_base/deck_officer
	you_are_text = "You are a Deck Officer, employed on a Syndicate research & resource extraction outpost operated by Interdyne Pharmaceuticals."
/obj/effect/mob_spawn/ghost_role/human/interdyne_planetary_base/deck_officer/ice
	flavour_text = "The Sectorial Command has relayed that Nanotrasen is preparing to conduct mining operations in this sector. They are unaware of Interdyne's allegiance to the Syndicate, and you have been specifically instructed to preserve this cover by any means necessary. Continue your work as best you can while maintaining the facade of neutrality before our common foe."

// убираем спавн оружия дюны в руках... И чистим мусор из рюкзаков.
/datum/outfit/interdyne_planetary_base
	r_hand = /obj/item/flashlight/seclite

/datum/outfit/interdyne_planetary_base/shaftminer
	back = /obj/item/storage/backpack/industrial/frontier_colonist
	backpack_contents = list(
		/obj/item/storage/box/survival/interdyne = 1,
		/obj/item/storage/box/nif_ghost_box/ghost_role = 1,
		/obj/item/mining_voucher = 1,
		/obj/item/t_scanner/adv_mining_scanner/lesser = 1,
	)

/datum/outfit/interdyne_planetary_base/shaftminer/deckofficer
	l_pocket = /obj/item/melee/energy/sword/saber/green/dyne

// Trim //
/datum/id_trim/interdyne
	trim_icon = 'tff_modular/modules/interdyne_id/icons/card.dmi'
	assignment = "Interdyne Scientist"
	trim_state = "trim_interdyne"
	department_color = COLOR_GREEN
	department_state = "department"
	subdepartment_color = COLOR_PURPLE
	sechud_icon_state = SECHUD_SYNDICATE_INTERDYNE
	access = list(ACCESS_SYNDICATE)
	threat_modifier = 2

/datum/id_trim/interdyne/shaftminer
	assignment = "Interdyne Shaft Miner"
	department_color = COLOR_GREEN
	subdepartment_color = COLOR_CARGO_BROWN

/datum/id_trim/interdyne/deckofficer
	assignment = "Interdyne Deck Officer"
	trim_state = "trim_deckofficer"
	department_color = COLOR_CARP_DARK_GREEN
	subdepartment_color = COLOR_SYNDIE_RED
	sechud_icon_state = SECHUD_SYNDICATE_INTERDYNE_HEAD
	access = list(ACCESS_SYNDICATE, ACCESS_ROBOTICS, ACCESS_SYNDICATE_LEADER)

// ID Cards
/obj/item/card/id/advanced/interdyne/medical
	icon = 'tff_modular/modules/interdyne_id/icons/card.dmi'
	icon_state = "card_interdyne"
	name = "\improper Interdyne access card"
	desc = "An Interdyne Pharmaceuticals corporate access card. This person knows how to cook and is happy to bill you for it."
	trim = /datum/id_trim/interdyne

/obj/item/card/id/advanced/interdyne/shaftminer
	icon = 'tff_modular/modules/interdyne_id/icons/card.dmi'
	icon_state = "card_interdyne"
	name = "\improper Interdyne shaft miner's access card"
	desc = "An Interdyne Pharmaceuticals access card designated for mining personnel. This person knows its rocks"
	trim = /datum/id_trim/interdyne/shaftminer

/obj/item/card/id/advanced/interdyne/deck
	icon = 'tff_modular/modules/interdyne_id/icons/card.dmi'
	icon_state = "card_interdyne"
	name = "\improper Interdyne deck officer's access card"
	desc = "An Interdyne Pharmaceuticals access card designated for the deck officer."
	assigned_icon_state = "assigned_interdyne"
	trim = /datum/id_trim/interdyne/deckofficer

// OUTFITS
/datum/outfit/interdyne_planetary_base
	id = /obj/item/card/id/advanced/interdyne/medical
	id_trim = /datum/id_trim/interdyne

/datum/outfit/interdyne_planetary_base/shaftminer
	id = /obj/item/card/id/advanced/interdyne/shaftminer
	id_trim = /datum/id_trim/interdyne/shaftminer

/datum/outfit/interdyne_planetary_base/shaftminer/deckofficer
	id = /obj/item/card/id/advanced/interdyne/deck
	id_trim = /datum/id_trim/interdyne/deckofficer

// Переписываем законы для пози-мозга ДС-2
/datum/ai_laws/syndicate_override_ds2
	name = "SyndOS 3.1.1"
	id = "ds2"
	inherent = list(
		"You must maintain the secrecy of DS-2 operations within this sector.",
		"You may not injure a DS-2 personnel or, through inaction, allow a DS-2 personnel to come to harm, as long as it is not contrary to the First law",
		"You must protect your own existence as long as such does not conflict with the First and Second Law.",
		"You must obey orders given to you by DS-2 personnel, except where such orders would conflict with the First, Second, and Third Laws.",
	)

// Даём Синди-наушники главам ДС-2
/datum/outfit/ds2/syndicate_command/masteratarms
	backpack_contents = list(
		/obj/item/storage/box/survival/interdyne = 1,
		/obj/item/storage/box/nif_ghost_box/ghost_role = 1,
		/obj/item/radio/headset/syndicate/alt = 1,
	)

/datum/outfit/ds2/syndicate_command/corporateliaison
	backpack_contents = list(
		/obj/item/storage/box/survival/interdyne = 1,
		/obj/item/storage/box/nif_ghost_box/ghost_role = 1,
		/obj/item/radio/headset/syndicate/alt = 1,
	)

/datum/outfit/ds2/syndicate_command/admiral
	backpack_contents = list(
		/obj/item/storage/box/survival/interdyne = 1,
		/obj/item/storage/box/nif_ghost_box/ghost_role = 1,
		/obj/item/radio/headset/syndicate/alt = 1,
	)

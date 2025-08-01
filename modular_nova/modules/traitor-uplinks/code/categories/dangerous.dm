/datum/uplink_item/dangerous/foamsmg_traitor
	name = "Toy Submachine Gun"
	desc = "A fully-loaded Donksoft bullpup submachine gun that fires riot grade darts with a 20-round magazine."
	item = /obj/item/gun/ballistic/automatic/c20r/toy/unrestricted/riot
	cost = 4
	purchasable_from = ~(UPLINK_NUKE_OPS | UPLINK_CLOWN_OPS)

/datum/uplink_item/dangerous/sindano
	name = "Sindano Submachine Gun Kit"
	desc = "A Sindano SMG, with spare lethal-and-non-lethal ammo, and three various magazines. (stendos not guaranteed) "
	item = /obj/item/storage/toolbox/guncase/nova/carwo_large_case/sindano/evil
	cost = 7
	purchasable_from = ~(UPLINK_NUKE_OPS | UPLINK_CLOWN_OPS)

/datum/uplink_item/dangerous/wespe
	name = "Geupe Pistol Kit"
	desc = "A Geupe personal defense pistol, with two lethal magazines, full-auto and dubiously legal."
	item = /obj/item/storage/toolbox/guncase/nova/pistol/opfor/wespe
	cost = 5
	purchasable_from = ~(UPLINK_NUKE_OPS | UPLINK_CLOWN_OPS)

/datum/uplink_item/dangerous/miniegunkit
	name = "Mini-egun Kit"
	desc = "A mini-egun and included recharger kit, it's better then nothing!"
	item = /obj/item/storage/toolbox/guncase/nova/pistol/opfor/egun_mini
	cost = 1 // 1 whole dolar
	purchasable_from = ~(UPLINK_NUKE_OPS | UPLINK_CLOWN_OPS)

/datum/uplink_item/dangerous/nunchaku
	name = "Syndie Fitness Nunchuks"
	desc = "Heavyweight titanium nunchucks that can be used to knock out and harm your opponent quickly and easily.\
		In close combat, it allows you to block all melee attacks and throws, punishing the offender."
	item = /obj/item/melee/baton/nunchaku
	cost = 7
	purchasable_from = ~UPLINK_SPY //spy get their own tg version
	uplink_item_flags = SYNDIE_ILLEGAL_TECH | SYNDIE_TRIPS_CONTRABAND

// TG Overrides - Raises cost of this by 2x
/datum/uplink_item/role_restricted/his_grace
	cost = 40 // forces you to murderbone, so we're taking two antags out for one if they try it

// TG Overrides - Lowers the cost of various uplink items
/datum/uplink_item/dangerous/foampistol
	cost = 3

/datum/uplink_item/dangerous/pistol
	cost = 4

/datum/uplink_item/dangerous/sword
	cost = 5

/datum/uplink_item/dangerous/guardian
	cost = 10

/datum/uplink_item/device_tools/frame
	cost = 2

/datum/uplink_item/role_restricted/meathook
	cost = 8

/datum/uplink_item/role_restricted/turretbox
	cost = 8

/datum/uplink_item/role_restricted/laser_arm
	cost = 5

/datum/uplink_item/role_restricted/chemical_gun
	cost = 8

/datum/uplink_item/role_restricted/rebarxbowsyndie
	cost = 6

/datum/uplink_item/special/autosurgeon
	cost = 2

/datum/uplink_item/suits/modsuit
	cost = 6

/datum/uplink_item/dangerous/doublesword
	cost = 28 // original cost: 13

/datum/uplink_item/dangerous/shitzu
	name = "Shitzu Magfed Shotgun"
	desc = "Everyone says a dog is a man's best friend, lets change that and make man's best friend a 12 gauge magfed shotgun! Thanks to the beloved contributions from the Gorlex Marauders."
	item = /obj/item/storage/toolbox/guncase/nova/syndicate/shitzu
	cost = 10
	surplus = 12
	limited_stock = 1
	uplink_item_flags = SYNDIE_ILLEGAL_TECH | SYNDIE_TRIPS_CONTRABAND
	population_minimum = TRAITOR_POPULATION_LOWPOP

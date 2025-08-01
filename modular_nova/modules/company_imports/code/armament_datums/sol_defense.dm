/datum/armament_entry/company_import/sol_defense
	category = SOL_DEFENSE_DEFENSE_NAME
	company_bitflag = CARGO_COMPANY_SOL_DEFENSE

// Beautiful SolFed clothing

/datum/armament_entry/company_import/sol_defense/clothing
	subcategory = "Surplus Clothing"
	cost = PAYCHECK_CREW

/datum/armament_entry/company_import/sol_defense/clothing/peacekeeper
	item_type = /obj/item/clothing/under/sol_peacekeeper

/datum/armament_entry/company_import/sol_defense/clothing/emt
	item_type = /obj/item/clothing/under/sol_emt

/datum/armament_entry/company_import/sol_defense/clothing/hecu_mask
	item_type = /obj/item/clothing/mask/gas/hecu
	cost = PAYCHECK_COMMAND

// Armor vests for protecting against bullets

/datum/armament_entry/company_import/sol_defense/armor
	subcategory = "Ballistic Armor"
	cost = PAYCHECK_CREW * 3

/datum/armament_entry/company_import/sol_defense/armor/ballistic_helmet
	item_type = /obj/item/clothing/head/helmet/sf_peacekeeper/debranded

/datum/armament_entry/company_import/sol_defense/armor/sf_ballistic_helmet
	item_type = /obj/item/clothing/head/helmet/sf_peacekeeper

/datum/armament_entry/company_import/sol_defense/armor/soft_vest
	item_type = /obj/item/clothing/suit/armor/sf_peacekeeper/debranded

/datum/armament_entry/company_import/sol_defense/armor/sf_soft_vest
	item_type = /obj/item/clothing/suit/armor/sf_peacekeeper

/datum/armament_entry/company_import/sol_defense/armor/flak_jacket
	item_type = /obj/item/clothing/suit/armor/vest/sol

/datum/armament_entry/company_import/sol_defense/armor/slim_vest
	name = "type I vest"
	item_type = /obj/item/clothing/suit/armor/vest

/datum/armament_entry/company_import/sol_defense/armor/combat_boots // boots
	name = "Combat Boots"
	cost = PAYCHECK_CREW * 4
	item_type = /obj/item/clothing/shoes/combat

/datum/armament_entry/company_import/sol_defense/armor_hardened
	subcategory = "Hardened Armor"
	cost = PAYCHECK_CREW * 3

/datum/armament_entry/company_import/sol_defense/armor_hardened/enclosed_helmet
	item_type = /obj/item/clothing/head/helmet/toggleable/sf_hardened

/datum/armament_entry/company_import/sol_defense/armor_hardened/emt_enclosed_helmet
	item_type = /obj/item/clothing/head/helmet/toggleable/sf_hardened/emt

/datum/armament_entry/company_import/sol_defense/armor_hardened/hardened_vest
	item_type = /obj/item/clothing/suit/armor/sf_hardened

/datum/armament_entry/company_import/sol_defense/armor_hardened/emt_hardened_vest
	item_type = /obj/item/clothing/suit/armor/sf_hardened/emt

/datum/armament_entry/company_import/sol_defense/armor_sacrifice
	subcategory = "Sacrifical Armor"
	cost = PAYCHECK_CREW * 3

/datum/armament_entry/company_import/sol_defense/armor_sacrifice/sacrificial_helmet
	item_type = /obj/item/clothing/head/helmet/sf_sacrificial

/datum/armament_entry/company_import/sol_defense/armor_sacrifice/face_shield
	item_type = /obj/item/sacrificial_face_shield
	cost = PAYCHECK_LOWER

/datum/armament_entry/company_import/sol_defense/armor_sacrifice/sacrificial_vest
	item_type = /obj/item/clothing/suit/armor/sf_sacrificial

/datum/armament_entry/company_import/sol_defense/case
	subcategory = "Weapon Cases"

/datum/armament_entry/company_import/sol_defense/case/trappiste
	item_type = /obj/item/storage/toolbox/guncase/nova/pistol/trappiste_small_case
	cost = PAYCHECK_COMMAND

/datum/armament_entry/company_import/sol_defense/case/carwo
	item_type = /obj/item/storage/toolbox/guncase/nova/carwo_large_case
	cost = PAYCHECK_COMMAND * 2

/datum/armament_entry/company_import/sol_defense/case/nanotrasen_pistol
	item_type = /obj/item/storage/toolbox/guncase/nova/ntcase/pistol
	cost = PAYCHECK_COMMAND

/datum/armament_entry/company_import/sol_defense/case/nanotrasen
	item_type = /obj/item/storage/toolbox/guncase/nova/ntcase
	cost = PAYCHECK_COMMAND * 2

/datum/armament_entry/company_import/sol_defense/case/solfed_pistol
	item_type = /obj/item/storage/toolbox/guncase/nova/solfed/pistol
	cost = PAYCHECK_COMMAND

/datum/armament_entry/company_import/sol_defense/case/solfed
	item_type = /obj/item/storage/toolbox/guncase/nova/solfed
	cost = PAYCHECK_COMMAND * 2

/datum/armament_entry/company_import/sol_defense/case/redcase_pistol
	item_type = /obj/item/storage/toolbox/guncase/nova/red/pistol
	cost = PAYCHECK_COMMAND

/datum/armament_entry/company_import/sol_defense/case/redcase
	item_type = /obj/item/storage/toolbox/guncase/nova/red
	cost = PAYCHECK_COMMAND * 2

/datum/armament_entry/company_import/sol_defense/case/bluecase_pistol
	item_type = /obj/item/storage/toolbox/guncase/nova/blue/pistol
	cost = PAYCHECK_COMMAND

/datum/armament_entry/company_import/sol_defense/case/bluecase
	item_type = /obj/item/storage/toolbox/guncase/nova/blue
	cost = PAYCHECK_COMMAND * 2

/datum/armament_entry/company_import/sol_defense/case/purplecase_pistol
	item_type = /obj/item/storage/toolbox/guncase/nova/purple/pistol
	cost = PAYCHECK_COMMAND

/datum/armament_entry/company_import/sol_defense/case/purplecase
	item_type = /obj/item/storage/toolbox/guncase/nova/purple
	cost = PAYCHECK_COMMAND * 2

/datum/armament_entry/company_import/sol_defense/case/orangecase_pistol
	item_type = /obj/item/storage/toolbox/guncase/nova/orange/pistol
	cost = PAYCHECK_COMMAND

/datum/armament_entry/company_import/sol_defense/case/orangecase
	item_type = /obj/item/storage/toolbox/guncase/nova/orange
	cost = PAYCHECK_COMMAND * 2

/datum/armament_entry/company_import/sol_defense/case/greencase_pistol
	item_type = /obj/item/storage/toolbox/guncase/nova/green/pistol
	cost = PAYCHECK_COMMAND

/datum/armament_entry/company_import/sol_defense/case/greencase
	item_type = /obj/item/storage/toolbox/guncase/nova/green
	cost = PAYCHECK_COMMAND * 2

/datum/armament_entry/company_import/sol_defense/sidearm
	subcategory = "Sidearms"
	cost = PAYCHECK_COMMAND * 4

/datum/armament_entry/company_import/sol_defense/sidearm/eland
	item_type = /obj/item/gun/ballistic/revolver/sol

/datum/armament_entry/company_import/sol_defense/sidearm/wespe
	item_type = /obj/item/gun/ballistic/automatic/pistol/sol

/datum/armament_entry/company_import/sol_defense/sidearm/type207
	item_type = /obj/item/gun/ballistic/automatic/pistol/type207

/* FLUFFY FRONTIER REMOVAL
/datum/armament_entry/company_import/sol_defense/sidearm/skild
	item_type = /obj/item/gun/ballistic/automatic/pistol/trappiste
	cost = PAYCHECK_COMMAND * 6
*/

/* FLUFFY FRONTIER REMOVAL
/datum/armament_entry/company_import/sol_defense/sidearm/takbok
	item_type = /obj/item/gun/ballistic/revolver/takbok
	cost = PAYCHECK_COMMAND * 6
*/

// Lethal anything that's not a pistol, requires high company interest

/datum/armament_entry/company_import/sol_defense/longarm
	subcategory = "Longarms"
	cost = PAYCHECK_COMMAND * 6
	restricted = TRUE

/datum/armament_entry/company_import/sol_defense/longarm/renoster
	item_type = /obj/item/gun/ballistic/shotgun/riot/sol

/datum/armament_entry/company_import/sol_defense/longarm/sindano
	item_type = /obj/item/gun/ballistic/automatic/sol_smg

/datum/armament_entry/company_import/sol_defense/longarm/type213
	item_type = /obj/item/gun/ballistic/automatic/type213

/datum/armament_entry/company_import/sol_defense/longarm/br38
	item_type = /obj/item/gun/ballistic/automatic/battle_rifle
	cost = PAYCHECK_COMMAND * 8

/datum/armament_entry/company_import/sol_defense/longarm/elite
	item_type = /obj/item/gun/ballistic/automatic/sol_rifle/marksman
	cost = PAYCHECK_COMMAND * 12

/datum/armament_entry/company_import/sol_defense/longarm/bogseo
	item_type = /obj/item/gun/ballistic/automatic/xhihao_smg
	cost = PAYCHECK_COMMAND * 10

/datum/armament_entry/company_import/sol_defense/longarm/jager
	item_type = /obj/item/gun/ballistic/shotgun/katyusha/jager
	cost = PAYCHECK_COMMAND * 16

/datum/armament_entry/company_import/sol_defense/longarm/infanterie
	item_type = /obj/item/gun/ballistic/automatic/sol_rifle
	cost = PAYCHECK_COMMAND * 14

/* //
datum/armament_entry/company_import/sol_defense/longarm/outomaties
	item_type = /obj/item/gun/ballistic/automatic/sol_rifle/machinegun
	cost = PAYCHECK_COMMAND * 23
*/ //Commented out due to a severe lack of balance regarding it.

/datum/armament_entry/company_import/sol_defense/longarm/kiboko
	item_type = /obj/item/gun/ballistic/automatic/sol_grenade_launcher
	cost = PAYCHECK_COMMAND * 46

/datum/armament_entry/company_import/sol_defense/magazines
	subcategory = "Magazines"
	cost = PAYCHECK_CREW

/datum/armament_entry/company_import/sol_defense/magazines/c35_mag
	item_type = /obj/item/ammo_box/magazine/c35sol_pistol/starts_empty

/datum/armament_entry/company_import/sol_defense/magazines/c35_extended
	item_type = /obj/item/ammo_box/magazine/c35sol_pistol/stendo/starts_empty

/datum/armament_entry/company_import/sol_defense/magazines/c585_mag
	item_type = /obj/item/ammo_box/magazine/c585trappiste_pistol/spawns_empty

/datum/armament_entry/company_import/sol_defense/magazines/sol_rifle_short
	item_type = /obj/item/ammo_box/magazine/c40sol_rifle/starts_empty

/datum/armament_entry/company_import/sol_defense/magazines/br38
	item_type = /obj/item/ammo_box/magazine/m38/empty

/datum/armament_entry/company_import/sol_defense/magazines/kineticballs
	item_type = /obj/item/ammo_box/magazine/kineticballs/starts_empty

/datum/armament_entry/company_import/sol_defense/magazines/kineticballsbig
	item_type = /obj/item/ammo_box/magazine/kineticballsbig/starts_empty

/datum/armament_entry/company_import/sol_defense/magazines/sol_rifle_standard
	item_type = /obj/item/ammo_box/magazine/c40sol_rifle/standard/starts_empty
	cost = PAYCHECK_COMMAND

/datum/armament_entry/company_import/sol_defense/magazines/sol_grenade_standard
	item_type = /obj/item/ammo_box/magazine/c980_grenade/starts_empty
	cost = PAYCHECK_COMMAND * 2

/datum/armament_entry/company_import/sol_defense/magazines/sol_grenade_drum
	item_type = /obj/item/ammo_box/magazine/c980_grenade/drum/starts_empty
	cost = PAYCHECK_CREW * 3
	restricted = TRUE

/datum/armament_entry/company_import/sol_defense/magazines/jager_shotgun_regular
	item_type = /obj/item/ammo_box/magazine/jager/empty
	cost = PAYCHECK_CREW
	restricted = TRUE

/datum/armament_entry/company_import/sol_defense/magazines/jager_shotgun_Large
	item_type = /obj/item/ammo_box/magazine/jager/large/empty
	cost = PAYCHECK_CREW * 3
	restricted = TRUE

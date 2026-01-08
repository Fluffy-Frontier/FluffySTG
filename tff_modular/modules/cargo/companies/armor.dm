// Соответствующий файл Nova: modular_nova/master_files/code/modules/cargo/packs/companies/armor.dm

// Переопределение для пакета HC surplus Voskhod-P space suit: добавляет проверку по лицензии оружия и помечает как контрабанду.
/datum/supply_pack/companies/armor/hc_surplus/space_suit
	access = ACCESS_WEAPONS
	contraband = TRUE

/datum/supply_pack/companies/modsuits/core/voskhod_autodoc_refill
	contraband = TRUE
	access = ACCESS_WEAPONS

/datum/supply_pack/companies/modsuits/mods/voskhod_refit_kit
	contraband = TRUE
	access = ACCESS_WEAPONS

/datum/supply_pack/companies/armor/sol_fed/hardened_vest
	access = ACCESS_WEAPONS

/datum/supply_pack/companies/armor/sol_fed/enclosed_helmet
	access = ACCESS_WEAPONS

/datum/supply_pack/companies/armor/sol_fed/emt_enclosed_helmet
	access = ACCESS_WEAPONS

/datum/supply_pack/companies/armor/sol_fed/emt_hardened_vest
	access = ACCESS_WEAPONS

/datum/supply_pack/companies/armor/sol_fed/sacrificial_vest
	access = ACCESS_WEAPONS

/datum/supply_pack/companies/armor/sol_fed/sacrificial_helmet
	access = ACCESS_WEAPONS

/datum/supply_pack/companies/armor/sol_fed/face_shield
	access = ACCESS_WEAPONS

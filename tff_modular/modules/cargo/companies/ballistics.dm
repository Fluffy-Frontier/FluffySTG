// Этот файл содержит переопределения для пакетов огнестрельного оружия из Nova modular.
// Соответствующий файл Nova: modular_nova/master_files/code/modules/cargo/packs/companies/ballistics.dm

// Переопределение для пакета Sol Fed longarm: добавляет проверку по лицензии оружия
/datum/supply_pack/companies/ballistics/sol_fed/longarm
	access = ACCESS_WEAPONS

// Переопределение для пакета Sol Fed Bogseo SMG: помечает как контрабанду.
/datum/supply_pack/companies/ballistics/sol_fed/longarm/bogseo
	contraband = TRUE

// Переопределение для пакета Sol Fed Kiboko grenade launcher: помечает как контрабанду.
/datum/supply_pack/companies/ballistics/sol_fed/longarm/kiboko
	contraband = TRUE

// Переопределение для пакета HC surplus Zashch pistol: добавляет проверку по лицензии оружия.
/datum/supply_pack/companies/ballistics/hc_surplus/zashch
	access = ACCESS_WEAPONS

// Переопределение для пакета HC surplus shotgun revolver: добавляет проверку по лицензии оружия.
/datum/supply_pack/companies/ballistics/hc_surplus/shotgun_revolver
	access = ACCESS_WEAPONS

// Переопределение для пакета HC surplus firearm: добавляет проверку по лицензии оружия.
/datum/supply_pack/companies/hc_surplus/firearm
	access = ACCESS_WEAPONS

// Переопределение для пакета HC surplus Lanca rifle: помечает как контрабанду.
/datum/supply_pack/companies/ballistics/hc_surplus/lanca
	contraband = TRUE

// Переопределение для пакета HC surplus anti-materiel rifle: помечает как контрабанду.
/datum/supply_pack/companies/ballistics/hc_surplus/anti_materiel_rifle
	contraband = TRUE

// Переопределение для пакета Sol Fed Takbok revolver: помечает как контрабанду.
/datum/supply_pack/companies/ballistics/sol_fed/sidearm/takbok
	contraband = TRUE

// Переопределение для пакета Sol Fed Skild pistol: помечает как контрабанду.
/datum/supply_pack/companies/ballistics/sol_fed/sidearm/skild
	contraband = TRUE

/datum/supply_pack/companies/ballistics/nt/c38_super_kit
	access = ACCESS_WEAPONS

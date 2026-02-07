
// Соответствующий файл Nova: modular_nova/master_files/code/modules/cargo/packs/companies/tools_weapons.dm

// Переопределение для Blacksteel ranged knife pack: помечает как контрабанду.
/datum/supply_pack/companies/tools_weapons/blacksteel/ranged/knife
	contraband = TRUE

// Переопределение для Kahraman Fock pack: добавляет инженерный доступ.
/datum/supply_pack/companies/tools_weapons/kahraman/fock
	access_view = ACCESS_ENGINEERING
	access = ACCESS_ENGINEERING

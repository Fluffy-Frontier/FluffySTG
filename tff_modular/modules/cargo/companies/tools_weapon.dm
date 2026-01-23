
// Соответствующий файл Nova: modular_nova/master_files/code/modules/cargo/packs/companies/tools_weapons.dm

// Переопределение для Blacksteel ranged knife pack: помечает как контрабанду.
/datum/supply_pack/companies/tools_weapons/blacksteel/ranged/knife
	order_flags = parent_type::order_flags | ORDER_CONTRABAND

// Переопределение для Kahraman Fock pack: добавляет инженерный доступ.
/datum/supply_pack/companies/tools_weapons/kahraman/fock
	access_view = ACCESS_ENGINEERING
	access = ACCESS_ENGINEERING

// Соответствующий файл Nova: modular_nova/master_files/code/modules/cargo/packs/companies/ammo.dm

// Переопределение для пакета Vitezstvi shrapnel grenade shells: помечает как контрабанду
/datum/supply_pack/companies/mags_and_ammo/vitezstvi/grenade_shells/shrapnel
	order_flags = ORDER_GOODY | ORDER_CONTRABAND

// Переопределение для пакета Vitezstvi phosphor grenade shells: помечает как контрабанду
/datum/supply_pack/companies/mags_and_ammo/vitezstvi/grenade_shells/phosphor
	order_flags = ORDER_GOODY | ORDER_CONTRABAND

/datum/supply_pack/companies/mags_and_ammo/vitezstvi/shot_shells/suppressor
	contains = list(/obj/item/ammo_box/advanced/s12gauge/suppressor)

// Переопределение для пакета Sol grenade drum: помечает как контрабанду
/datum/supply_pack/companies/mags_and_ammo/sol_grenade_drum
	order_flags = ORDER_GOODY | ORDER_CONTRABAND

// Переопределение для пакета HC surplus Lanca magazine: помечает как контрабанду.
/datum/supply_pack/companies/mags_and_ammo/hc_surplus/lanca
	order_flags = parent_type::order_flags | ORDER_CONTRABAND

// Переопределение для пакета HC surplus AMR magazine: помечает как контрабанду.
/datum/supply_pack/companies/mags_and_ammo/hc_surplus/amr_magazine
	order_flags = parent_type::order_flags | ORDER_CONTRABAND

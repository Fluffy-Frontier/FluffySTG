// Вшиваем в существующий спрайтшит наши спрайты, т.к. UI меха берет спрайты именно оттуда
/datum/asset/spritesheet_batched/mecha_equipment/create_spritesheets()
    . = ..()
    insert_all_icons("", 'tff_modular/modules/ALMG-90/icons/ALMG-90.dmi')

// Добавляем лазерный аналог Ultra AC 2 для мехов
/obj/item/mecha_parts/mecha_equipment/weapon/energy/amlg90
	name = "\improper AMLG-90"
	desc = "A weapon for combat exosuits. Shoots a rapid, three shot laser burst."
	icon = 'tff_modular/modules/ALMG-90/icons/ALMG-90.dmi'
	icon_state = "mecha_amlg90"
	equip_cooldown = 10
	projectile = /obj/projectile/beam/laser/rapid
	fire_sound = 'tff_modular/modules/ALMG-90/sound/gunshot_lascarbine.ogg'
	energy_drain = 120
	projectiles_per_shot = 3
	variance = 6
	randomspread = 1
	projectile_delay = 2
	harmful = TRUE

// Запихиваем все вышеперечисленное в фабрикатор мехов

/datum/design/mech_amlg90
	name = "AMLG-90"
	desc = "Allows for the construction of AMLG-90 Laser Cannon."
	id = "mech_amlg90"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/mecha_equipment/weapon/energy/amlg90
	materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT*5, /datum/material/diamond=SHEET_MATERIAL_AMOUNT, /datum/material/titanium=SHEET_MATERIAL_AMOUNT*2)
	construction_time = 10 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_EQUIPMENT + RND_SUBCATEGORY_MECHFAB_EQUIPMENT_WEAPONS,
		RND_CATEGORY_MECHFAB_PADDY + RND_SUBCATEGORY_MECHFAB_SUPPORTED_EQUIPMENT,
		RND_CATEGORY_MECHFAB_GYGAX + RND_SUBCATEGORY_MECHFAB_SUPPORTED_EQUIPMENT,
		RND_CATEGORY_MECHFAB_DURAND + RND_SUBCATEGORY_MECHFAB_SUPPORTED_EQUIPMENT,
		RND_CATEGORY_MECHFAB_PHAZON + RND_SUBCATEGORY_MECHFAB_SUPPORTED_EQUIPMENT,
		RND_CATEGORY_MECHFAB_HONK + RND_SUBCATEGORY_MECHFAB_SUPPORTED_EQUIPMENT,
		RND_CATEGORY_MECHFAB_SAVANNAH_IVANOV + RND_SUBCATEGORY_MECHFAB_SUPPORTED_EQUIPMENT
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

// Добавляем AMLG-90 в ветку с лазерным оружием РНД
/datum/techweb_node/mech_energy_guns/New()
	. = ..()
	design_ids += "mech_amlg90"

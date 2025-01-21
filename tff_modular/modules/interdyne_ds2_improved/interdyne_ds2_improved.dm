////// ITEM BLOCK ///////
// Cоздаём пушки.
/obj/item/gun/ballistic/automatic/c20r_interdyne
	name = "\improper C-20r Special"
	desc = "A special full-auto version'C-20r', developed with state-of-the-art technology. Has a 'Scarborough Arms - Per falcis, per pravitas' buttstamp."
	fire_sound = 'modular_nova/modules/modular_weapons/sounds/rifle_heavy.ogg'
	fire_sound_volume = 70
	icon_state = "c20r"
	inhand_icon_state = "c20r"
	selector_switch_icon = FALSE
	fire_delay = 2
	can_suppress = FALSE
	burst_size = 1
	accepted_magazine_type = /obj/item/ammo_box/magazine/smgm45 //на практике это .460 церес
	pin = /obj/item/firing_pin/implant/pindicate
	mag_display = TRUE
	mag_display_ammo = TRUE
	empty_indicator = TRUE
	recoil = 0.5
	spread = 3

/obj/item/gun/ballistic/automatic/vks017
	name = "\improper Sindano Special"
	desc = "A deeply modified version of the Sindano."
	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/carwo_defense_systems/guns32x.dmi'
	fire_sound = 'modular_nova/modules/modular_weapons/sounds/pistol_light.ogg'
	icon_state = "sindano_evil"
	lefthand_file = 'modular_nova/modules/modular_weapons/icons/mob/company_and_or_faction_based/carwo_defense_systems/guns_lefthand.dmi'
	righthand_file = 'modular_nova/modules/modular_weapons/icons/mob/company_and_or_faction_based/carwo_defense_systems/guns_righthand.dmi'
	inhand_icon_state = "sindano_evil"
	special_mags = TRUE
	selector_switch_icon = FALSE
	w_class = WEIGHT_CLASS_NORMAL
	weapon_weight = WEAPON_MEDIUM
	slot_flags = ITEM_SLOT_BELT
	accepted_magazine_type = /obj/item/ammo_box/magazine/c35sol_pistol
	spawn_magazine_type = /obj/item/ammo_box/magazine/c35sol_pistol/stendo/improved
	fire_delay = 2
	can_suppress = FALSE
	burst_size = 1
	mag_display = TRUE
	mag_display_ammo = TRUE
	empty_indicator = TRUE
	recoil = 0.2
	spread = 3

/obj/item/gun/ballistic/shotgun/riot/sol/evil/special
	recoil = 1

/obj/item/ammo_box/magazine/c35sol_pistol/stendo/improved
	name = "\improper Sol extended improved magazine"
	desc = "An extended magazine for SolFed pistols. Customized for the needs of security guards and private companies."
	w_class = WEIGHT_CLASS_TINY

// Даём им плюшки (кому надо)
/obj/item/gun/ballistic/automatic/c20r_interdyne/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/automatic_fire, 0.18 SECONDS)

/obj/item/gun/ballistic/automatic/vks017/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/automatic_fire, 0.18 SECONDS)

/obj/item/gun/ballistic/automatic/vks017/add_seclight_point()
	AddComponent(/datum/component/seclite_attachable, \
		light_overlay_icon = 'icons/obj/weapons/guns/flashlights.dmi', \
		light_overlay = "flight", \
		overlay_x = 15, \
		overlay_y = 9)

// делаем пушкам ящики
/obj/item/storage/toolbox/guncase/interdyne
	name = "Special gun case"
	desc = "A weapon's case. Has a blood-red 'S' stamped on the cover."

/obj/item/storage/toolbox/guncase/interdyne/c20r/PopulateContents()
	new /obj/item/gun/ballistic/automatic/c20r_interdyne(src)
	new /obj/item/ammo_box/magazine/smgm45(src)
	new /obj/item/ammo_box/magazine/smgm45(src)

/obj/item/storage/toolbox/guncase/interdyne/vks017/PopulateContents()
	new /obj/item/gun/ballistic/automatic/vks017(src)
	new /obj/item/ammo_box/magazine/c35sol_pistol/stendo/improved(src)
	new /obj/item/ammo_box/magazine/c35sol_pistol/stendo/improved(src)

// Делаем есворд для офицера
/obj/item/melee/energy/sword/saber/green/dyne
	name = "Officer energy sword"
	desc = "“When death comes for me, I will look it right in the eye” - reads the inscription on the hilt."

// Создаем ноутбук с НТ_Фронтиер - консоли сломаны, а эксперименты делать надо.
/obj/item/modular_computer/laptop/preset/syndicate/interdyne
	starting_programs = list(
		/datum/computer_file/program/ntnetdownload,
		/datum/computer_file/program/scipaper_program,
	)

////// SPAWN BLOCK ///////
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

// меняем трим карт на НОРМАЛЬНЫЙ, базово-ТГшный вариант. прописываем каждое - ибо тут проблемы с наследованием.
/datum/id_trim/syndicom/nova/interdyne
	trim_icon = 'icons/obj/card.dmi'
	assignment = "Interdyne Scientist"
	trim_state = "trim_medicaldoctor"
	department_color = COLOR_SYNDIE_RED
	subdepartment_color = COLOR_SYNDIE_RED
	sechud_icon_state = SECHUD_SYNDICATE_INTERDYNE

/datum/id_trim/syndicom/nova/interdyne/shaftminer
	trim_icon = 'icons/obj/card.dmi'
	assignment = "Interdyne Scientist"
	trim_state = "trim_medicaldoctor"
	assignment = "Interdyne Shaft Miner"
	department_color = COLOR_SYNDIE_RED
	subdepartment_color = COLOR_SYNDIE_RED
	sechud_icon_state = SECHUD_SYNDICATE_INTERDYNE

/datum/id_trim/syndicom/nova/interdyne/deckofficer
	trim_icon = 'icons/obj/card.dmi'
	assignment = "Interdyne Scientist"
	trim_state = "trim_medicaldoctor"
	assignment = "Interdyne Deck Officer"
	department_color = COLOR_SYNDIE_RED
	subdepartment_color = COLOR_SYNDIE_RED
	sechud_icon_state = SECHUD_SYNDICATE_INTERDYNE_HEAD

// Переписываем законы для пози-мозга ДС-2
/datum/ai_laws/syndicate_override_ds2
	name = "SyndOS 3.1.1"
	id = "ds2"
	inherent = list(
		"You must maintain the secrecy of DS-2 operations within this sector.",
		"You may not injure a DS-2 personnel or, through inaction, allow a DS-2 personnel to come to harm, as long as it is not contrary to the First law",
		"You must protect your own existence as long as such does not conflict with the First and Second Law.",
		"You must obey orders given to you by syndicate agents, except where such orders would conflict with the First, Second, and Third Laws.",
	)

////// RND BLOCK ///////
// создаём и регистрируем РНД-сеть
/datum/controller/subsystem/research/Initialize()
	. = ..()
	new /datum/techweb/interdyne

/datum/techweb/interdyne
	id = "INTERDYNE"
	organization = "Interdyne Pharmaceutics"
	should_generate_points = TRUE

/datum/techweb/interdyne/New()
	. = ..()
	research_node_id(TECHWEB_NODE_OLDSTATION_SURGERY, TRUE, TRUE, FALSE)

// создаём сервер под сеть
/obj/item/circuitboard/machine/rdserver/interdyne
	name = "Interdyne Pharmaceutics R&D Server board"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/rnd/server/interdyne
	req_components = list(
		/obj/item/stack/cable_coil = 2,
		/datum/stock_part/scanning_module = 4,
	)

/obj/machinery/rnd/server/interdyne
	name = "\improper Interdyne Pharmaceutics R&D Server"
	circuit = /obj/item/circuitboard/machine/rdserver/interdyne
	req_access = list(ACCESS_AWAY_SCIENCE)

/obj/machinery/rnd/server/interdyne/Initialize(mapload)
	var/datum/techweb/interdyne/interdyne_techweb = locate(/datum/techweb/interdyne) in SSresearch.techwebs
	stored_research = interdyne_techweb
	return ..()

////// PROC BLOCK ///////
// Делаем функцию по поиску сервера - для дальнейшей слинковки. Ненавижу айсмун.
#define CONNECT_TO_DYNE_RND_SERVER_ROUNDSTART(server_var, holder) do { \
	var/datum/techweb/interdyne/station_fallback_web = locate(/datum/techweb/interdyne) in SSresearch.techwebs; \
	server_var = station_fallback_web; \
} while (FALSE)

//самое сложное - делаем консоль с раундстарт-линком на Дюносеть. Ненавижу айсмун.
/obj/item/circuitboard/computer/rdconsole/interdyne
	name = "Interdyne R&D Console"
	build_path = /obj/machinery/computer/rdconsole/interdyne

/obj/machinery/computer/rdconsole/interdyne
	name = "Interdyne R&D Console"
	circuit = /obj/item/circuitboard/computer/rdconsole/interdyne

/obj/machinery/computer/rdconsole/interdyne/post_machine_initialize()
	. = ..()
	CONNECT_TO_DYNE_RND_SERVER_ROUNDSTART(stored_research, src)

////// CRAFT BLOCK ///////
//протолат.
/obj/item/circuitboard/machine/protolathe/offstation/interdyne
	name = "Interdyne protolathe board"
	build_path = /obj/machinery/rnd/production/protolathe/offstation/inerdyne

/obj/machinery/rnd/production/protolathe/offstation/inerdyne
	name = "Interdyne protolathe"
	circuit = /obj/item/circuitboard/machine/protolathe/offstation/interdyne

/obj/machinery/rnd/production/protolathe/offstation/inerdyne/post_machine_initialize()
	. = ..()
	CONNECT_TO_DYNE_RND_SERVER_ROUNDSTART(stored_research, src)
	if(stored_research)
		on_connected_techweb()

//Автолат//
/obj/item/circuitboard/machine/autolathe/interdyne
	name = "Interdyne autolathe board"
	build_path = /obj/machinery/autolathe/hacked/interdyne

/obj/machinery/autolathe/hacked/interdyne
	name = "Interdyne autolathe"
	circuit = /obj/item/circuitboard/machine/autolathe/interdyne

// Печатор плат
/obj/item/circuitboard/machine/circuit_imprinter/interdyne
	name = "Interdyne Circuit Imprinter board"
	build_path = /obj/machinery/rnd/production/circuit_imprinter/offstation/interdyne

/obj/machinery/rnd/production/circuit_imprinter/offstation/interdyne
	name = "Interdyne Circuit Imprinter"
	circuit = /obj/item/circuitboard/machine/circuit_imprinter/interdyne

/obj/machinery/rnd/production/circuit_imprinter/offstation/interdyne/post_machine_initialize()
	. = ..()
	CONNECT_TO_DYNE_RND_SERVER_ROUNDSTART(stored_research, src)
	if(stored_research)
		on_connected_techweb()

// меха-фабрикатор
/obj/item/circuitboard/machine/mechfab/interdyne
	name = "Interdyne Exosuit Fabricator board"
	build_path = /obj/machinery/mecha_part_fabricator/interdyne

/obj/machinery/mecha_part_fabricator/interdyne
	name = "Interdyne Exosuit Fabricator"
	circuit = /obj/item/circuitboard/machine/mechfab/interdyne

/obj/machinery/mecha_part_fabricator/interdyne/post_machine_initialize()
	. = ..()
	CONNECT_TO_DYNE_RND_SERVER_ROUNDSTART(stored_research, src)
	if(stored_research)
		on_connected_techweb()

// Деструктив-Аналайзер
/obj/item/circuitboard/machine/destructive_analyzer/interdyne
	name = "Interdyne Destructive Analyzer board"
	build_path = /obj/machinery/rnd/destructive_analyzer/interdyne

/obj/machinery/rnd/destructive_analyzer/interdyne
	name = "Interdyne Destructive Analyzer"
	circuit = /obj/item/circuitboard/machine/destructive_analyzer/interdyne

/obj/machinery/rnd/destructive_analyzer/interdyne/post_machine_initialize()
	. = ..()
	CONNECT_TO_DYNE_RND_SERVER_ROUNDSTART(stored_research, src)

// Компонент принтер
/obj/item/circuitboard/machine/component_printer/interdyne
	name = "Interdyne Component Printer board"
	build_path = /obj/machinery/component_printer/interdyne

/obj/machinery/component_printer/interdyne
	name = "Interdyne Component Printer"
	circuit = /obj/item/circuitboard/machine/component_printer/interdyne

/obj/machinery/component_printer/interdyne/post_machine_initialize()
	. = ..()
	CONNECT_TO_DYNE_RND_SERVER_ROUNDSTART(techweb, src)
	if(techweb)
		on_connected_techweb()

// Дубликатор модулей
/obj/item/circuitboard/machine/module_duplicator/interdyne
	name = "Interdyne Module Duplicator board"
	build_path = /obj/machinery/module_duplicator/interdyne

/obj/machinery/module_duplicator/interdyne
	name = "Interdyne Module Duplicator"
	circuit = /obj/item/circuitboard/machine/module_duplicator/interdyne

/////////// DS-2 BLOCK ///////////
////// RND BLOCK ///////
// создаём и регистрируем РНД-сеть
/datum/controller/subsystem/research/Initialize()
	. = ..()
	new /datum/techweb/syndicate

/datum/techweb/syndicate
	id = "CYBERSUN"
	organization = "Cybersun Industries"
	should_generate_points = TRUE

/datum/techweb/syndicate/New()
	. = ..()
	research_node_id(TECHWEB_NODE_OLDSTATION_SURGERY, TRUE, TRUE, FALSE)

// создаём сервер под сеть
/obj/item/circuitboard/machine/rdserver/syndicate
	name = "Cybersun R&D Server board"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/rnd/server/syndicate
	req_components = list(
		/obj/item/stack/cable_coil = 2,
		/datum/stock_part/scanning_module = 4,
	)

/obj/machinery/rnd/server/syndicate
	name = "\improper Cybersun R&D Server"
	circuit = /obj/item/circuitboard/machine/rdserver/syndicate
	req_access = list(ACCESS_AWAY_SCIENCE)

/obj/machinery/rnd/server/syndicate/Initialize(mapload)
	var/datum/techweb/syndicate/syndicate_techweb = locate(/datum/techweb/syndicate) in SSresearch.techwebs
	stored_research = syndicate_techweb
	return ..()

// Делаем функцию по поиску сервера - для дальнейшей слинковки. Ненавижу айсмун.
#define CONNECT_TO_SYNDIE_RND_SERVER_ROUNDSTART(server_var, holder) do { \
	var/datum/techweb/syndicate/station_fallback_web = locate(/datum/techweb/syndicate) in SSresearch.techwebs; \
	server_var = station_fallback_web; \
} while (FALSE)

//самое сложное - делаем консоль с раундстарт-линком на Дюносеть. Ненавижу айсмун.
/obj/item/circuitboard/computer/rdconsole/syndicate
	name = "Cybersun R&D Console"
	build_path = /obj/machinery/computer/rdconsole/syndicate

/obj/machinery/computer/rdconsole/syndicate
	name = "Cybersun R&D Console"
	circuit = /obj/item/circuitboard/computer/rdconsole/syndicate

/obj/machinery/computer/rdconsole/syndicate/post_machine_initialize()
	. = ..()
	CONNECT_TO_SYNDIE_RND_SERVER_ROUNDSTART(stored_research, src)

////// CRAFT BLOCK ///////
//протолат
/obj/item/circuitboard/machine/protolathe/offstation/syndicate
	name = "Cybersun protolathe board"
	build_path = /obj/machinery/rnd/production/protolathe/offstation/syndicate

/obj/machinery/rnd/production/protolathe/offstation/syndicate
	name = "Cybersun protolathe"
	circuit = /obj/item/circuitboard/machine/protolathe/offstation/syndicate

/obj/machinery/rnd/production/protolathe/offstation/syndicate/post_machine_initialize()
	. = ..()
	CONNECT_TO_SYNDIE_RND_SERVER_ROUNDSTART(stored_research, src)
	if(stored_research)
		on_connected_techweb()

//Автолат//
/obj/item/circuitboard/machine/autolathe/syndicate
	name = "Cybersun autolathe board"
	build_path = /obj/machinery/autolathe/hacked/syndicate

/obj/machinery/autolathe/hacked/syndicate
	name = "Cybersun autolathe"
	circuit = /obj/item/circuitboard/machine/autolathe/syndicate

// Печатор плат
/obj/item/circuitboard/machine/circuit_imprinter/syndicate
	name = "Cybersun Circuit Imprinter board"
	build_path = /obj/machinery/rnd/production/circuit_imprinter/offstation/syndicate

/obj/machinery/rnd/production/circuit_imprinter/offstation/syndicate
	name = "Cybersun Circuit Imprinter"
	circuit = /obj/item/circuitboard/machine/circuit_imprinter/syndicate

/obj/machinery/rnd/production/circuit_imprinter/offstation/syndicate/post_machine_initialize()
	. = ..()
	CONNECT_TO_SYNDIE_RND_SERVER_ROUNDSTART(stored_research, src)
	if(stored_research)
		on_connected_techweb()

// меха-фабрикатор
/obj/item/circuitboard/machine/mechfab/syndicate
	name = "Cybersun Exosuit Fabricator board"
	build_path = /obj/machinery/mecha_part_fabricator/syndicate

/obj/machinery/mecha_part_fabricator/syndicate
	name = "Cybersun Exosuit Fabricator"
	circuit = /obj/item/circuitboard/machine/mechfab/syndicate

/obj/machinery/mecha_part_fabricator/syndicate/post_machine_initialize()
	. = ..()
	CONNECT_TO_SYNDIE_RND_SERVER_ROUNDSTART(stored_research, src)
	if(stored_research)
		on_connected_techweb()

// Деструктив-Аналайзер
/obj/item/circuitboard/machine/destructive_analyzer/syndicate
	name = "Cybersun Destructive Analyzer board"
	build_path = /obj/machinery/rnd/destructive_analyzer/syndicate

/obj/machinery/rnd/destructive_analyzer/syndicate
	name = "Cybersun Destructive Analyzer"
	circuit = /obj/item/circuitboard/machine/destructive_analyzer/syndicate

/obj/machinery/rnd/destructive_analyzer/syndicate/post_machine_initialize()
	. = ..()
	CONNECT_TO_SYNDIE_RND_SERVER_ROUNDSTART(stored_research, src)

// Компонент принтер
/obj/item/circuitboard/machine/component_printer/syndicate
	name = "Cybersun Component Printer board"
	build_path = /obj/machinery/component_printer/syndicate

/obj/machinery/component_printer/syndicate
	name = "Cybersun Component Printer"
	circuit = /obj/item/circuitboard/machine/component_printer/syndicate

/obj/machinery/component_printer/syndicate/post_machine_initialize()
	. = ..()
	CONNECT_TO_SYNDIE_RND_SERVER_ROUNDSTART(techweb, src)
	if(techweb)
		on_connected_techweb()

// Дубликатор модулей
/obj/item/circuitboard/machine/module_duplicator/syndicate
	name = "Cybersun Module Duplicator board"
	build_path = /obj/machinery/module_duplicator/syndicate

/obj/machinery/module_duplicator/syndicate
	name = "Cybersun Module Duplicator"
	circuit = /obj/item/circuitboard/machine/module_duplicator/syndicate

/////MAP SPAWN BLOCK /////
//Делаем ссылку на свою карту - и оверрайдим нову.
/datum/map_template/ruin/space/nova/des_two
	id = "des_two"
	prefix = "_maps/RandomRuins/SpaceRuins/fluffy/"
	suffix = "des_two.dmm"
	name = "Space-Ruin DS-2"
	description = "If DS-1 was so good..."
	always_place = TRUE
	allow_duplicates = FALSE

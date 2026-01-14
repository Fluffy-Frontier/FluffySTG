/obj/item/storage/pouch/medical/tac_security
	name = "security emergency medkit"
	desc = "Standard-issue medical kit issued to NanoTrasen security operatives. Contains first-aid supplies meant to keep an officer alive until proper medical staff can take over. Stored in a pocket pouch for ease of access."
	w_class = WEIGHT_CLASS_BULKY
	icon = 'tff_modular/modules/security_rearm/icons/pouches.dmi'
	icon_state = "tac_security"
	storage_type = /datum/storage/pouch/medical/tac_sec

/datum/storage/pouch/medical/tac_sec
	max_specific_storage = WEIGHT_CLASS_SMALL
	max_slots = 6
	max_total_storage = 12

	var/static/list/pouch_holdables = list(
		/obj/item/healthanalyzer,
		/obj/item/dnainjector,
		/obj/item/reagent_containers/dropper,
		/obj/item/reagent_containers/applicator,
		/obj/item/reagent_containers/syringe,
		/obj/item/reagent_containers/medigel,
		/obj/item/reagent_containers/spray,
		/obj/item/reagent_containers/hypospray,
		/obj/item/storage/pill_bottle,
		/obj/item/storage/box/bandages,
		/obj/item/stack/medical,
		/obj/item/flashlight/pen,
		/obj/item/reagent_containers/blood,
		/obj/item/stack/sticky_tape,
	)
	var/static/list/pouch_unholdables = list(
		/obj/item/reagent_containers/spray/pepper,
		/obj/item/reagent_containers/cup,
		/obj/item/storage/wallet,
	)

/datum/storage/pouch/medical/tac_sec/New()
	. = ..()
	set_holdable(pouch_holdables, pouch_unholdables)

/obj/item/storage/pouch/medical/tac_security/loaded/Initialize(mapload)
	. = ..()
	var/static/items_inside = list(
		/obj/item/stack/medical/gauze/sterilized = 1,
		/obj/item/stack/medical/suture/coagulant = 1,
		/obj/item/stack/medical/suture = 1,
		/obj/item/stack/medical/mesh = 1,
		/obj/item/reagent_containers/hypospray/medipen/deforest/calopine = 1,
		/obj/item/reagent_containers/hypospray/medipen/deforest/morpital = 1,
	)
	generate_items_inside(items_inside, src)

/obj/item/storage/pouch/medical/tac_security/synth
	name = "security maintenance kit"
	desc = "Standard-issue maintenance kit issued to NanoTrasen synthetic security operatives. Stored in a pocket pouch for ease of access."
	icon_state = "tac_security_synth"
	storage_type = /datum/storage/pouch/medical/tac_sec/synth

/datum/storage/pouch/medical/tac_sec/synth
	var/static/list/synth_pouch_holdables = list(
		/obj/item/stack/cable_coil,
		/obj/item/weldingtool,
	)
/datum/storage/pouch/medical/tac_sec/synth/New()
	. = ..()
	set_holdable(pouch_holdables + synth_pouch_holdables, pouch_unholdables)

/obj/item/storage/pouch/medical/tac_security/synth/loaded/Initialize(mapload)
	. = ..()
	var/static/items_inside = list(
		/obj/item/stack/medical/gauze = 1,
		/obj/item/stack/medical/synth_repair = 1,
		/obj/item/stack/medical/wound_recovery/robofoam = 1,
		/obj/item/reagent_containers/hypospray/medipen/deforest/robot_system_cleaner = 1,
		/obj/item/reagent_containers/hypospray/medipen/deforest/coagulants = 1,
	)
	generate_items_inside(items_inside, src)

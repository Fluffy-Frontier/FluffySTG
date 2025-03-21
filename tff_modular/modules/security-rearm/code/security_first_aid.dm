/obj/item/storage/pouch/medical/tac_security
	name = "security emergency medkit"
	desc = "Standard-issue medical kit issued to NanoTrasen security operatives. Contains first-aid supplies meant to keep an officer alive until proper medical staff can take over. Stored in a pocket pouch for ease of access."
	icon = 'tff_modular/modules/security-rearm/icons/pouches.dmi'
	icon_state = "tac_security"

/obj/item/storage/pouch/medical/tac_security/Initialize(mapload)
	. = ..()
	atom_storage.max_specific_storage = WEIGHT_CLASS_SMALL
	atom_storage.max_slots = 6
	atom_storage.max_total_storage = 12
	atom_storage.set_holdable(med_pouch_holdables)

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

/obj/item/storage/pouch/medical/tac_security/synth/Initialize(mapload)
	. = ..()
	var/static/list/synth_med_pouch_holdables = med_pouch_holdables + list(
		/obj/item/stack/cable_coil,
		/obj/item/weldingtool,
	)
	atom_storage.set_holdable(synth_med_pouch_holdables)

/obj/item/storage/pouch/medical/tac_security/synth/loaded/Initialize(mapload)
	. = ..()
	var/static/items_inside = list(
		/obj/item/stack/medical/gauze = 1,
		/obj/item/reagent_containers/pill/robotic_patch/synth_repair = 2,
		/obj/item/stack/medical/wound_recovery/robofoam = 1,
		/obj/item/reagent_containers/hypospray/medipen/deforest/robot_system_cleaner = 1,
		/obj/item/reagent_containers/hypospray/medipen/deforest/coagulants = 1,
	)
	generate_items_inside(items_inside, src)

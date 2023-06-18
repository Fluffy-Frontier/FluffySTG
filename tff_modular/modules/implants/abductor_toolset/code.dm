/obj/item/organ/internal/cyberimp/arm/toolset/alien_med
	name = "Alien surgical toolset implant"
	desc = "A bluespace storage of alien surgical tools hidden behind a concealed panel on the user's arm."
	items_to_create = list(
		/obj/item/cautery/alien,
		/obj/item/circular_saw/alien,
		/obj/item/hemostat/alien,
		/obj/item/retractor/alien,
		/obj/item/scalpel/alien,
		/obj/item/surgical_drapes,
		/obj/item/surgicaldrill/alien,
		)
	extend_sound = "sound/items/pshoom.ogg"
	retract_sound = "sound/items/pshoom.ogg"

/obj/item/organ/internal/cyberimp/arm/toolset/alien_eng
	name = "Alien engineering toolset implant"
	desc = "A bluespace storage of alien engineering tools hidden behind a concealed panel on the user's arm."
	items_to_create = list(
		/obj/item/crowbar/abductor,
		/obj/item/screwdriver/abductor,
		/obj/item/weldingtool/abductor,
		/obj/item/wirecutters/abductor,
		/obj/item/wrench/abductor,
		/obj/item/multitool/abductor
	)
	extend_sound = "sound/items/pshoom.ogg"
	retract_sound = "sound/items/pshoom.ogg"


/datum/abductor_gear/alien_eng
	name = "Engineering Toolset Implant"
	description = "This is a QoL implant for agents, that puts all engineering tools in their hand."
	id = "alien_engi"
	cost = 1
	build_path = /obj/item/organ/internal/cyberimp/arm/toolset/alien_eng
	category = "Advanced Gear"

/datum/abductor_gear/alien_sur
	name = "Surgical Toolset Implant"
	description = "This is a QoL implant for scientists, that puts all surgical tools in their hand. There's no science tool inside"
	id = "alien_surgi"
	cost = 1
	build_path = /obj/item/organ/internal/cyberimp/arm/toolset/alien_med
	category = "Advanced Gear"

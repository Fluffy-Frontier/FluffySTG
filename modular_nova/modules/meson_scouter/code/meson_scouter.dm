/datum/atom_skin/meson
	abstract_type = /datum/atom_skin/meson
	new_icon_state = "meson_scouter"

/datum/atom_skin/meson/glasses
	preview_name = "Meson Glasses"
	new_icon = 'icons/obj/clothing/glasses.dmi'
	new_icon_state = "meson"
	new_worn_icon = 'icons/mob/clothing/eyes.dmi'

/datum/atom_skin/meson/scouter
	preview_name = "Meson Scouter"
	new_icon = 'modular_nova/modules/meson_scouter/icons/meson_scouter.dmi'
	new_icon_state = "meson_scouter"
	new_worn_icon = 'modular_nova/modules/meson_scouter/icons/meson-scouter_mob.dmi'

/obj/item/clothing/glasses/meson/Initialize(mapload)
	. = ..()
	if(type == /obj/item/clothing/glasses/meson || type == /obj/item/clothing/glasses/meson/prescription)
		AddComponent(/datum/component/reskinable_item, /datum/atom_skin/meson, initial_skin = "Meson Scouter", blacklisted_subtypes = subtypesof(/datum/atom_skin/meson/engine))
	species_exception = list() // FF ADDITION
	unique_reskin -= list(
		"Meson Glasses" = list(
			RESKIN_ICON = 'icons/obj/clothing/glasses.dmi',
			RESKIN_ICON_STATE = "meson",
			RESKIN_WORN_ICON = 'icons/mob/clothing/eyes.dmi',
			RESKIN_WORN_ICON_STATE = "meson"
		),
		"Meson Scouter" = list(
			RESKIN_ICON = 'modular_nova/modules/meson_scouter/icons/meson_scouter.dmi',
			RESKIN_ICON_STATE = "meson_scouter",
			RESKIN_WORN_ICON = 'modular_nova/modules/meson_scouter/icons/meson-scouter_mob.dmi',
			RESKIN_WORN_ICON_STATE = "meson_scouter"
		),
	)

/obj/item/clothing/glasses/meson/gar/Initialize(mapload)
	. = ..()
	species_exception = list() // FF ADDITION
	unique_reskin -= list(
		"Meson Glasses" = list(
			RESKIN_ICON = 'icons/obj/clothing/glasses.dmi',
			RESKIN_ICON_STATE = "meson",
			RESKIN_WORN_ICON = 'icons/mob/clothing/eyes.dmi',
			RESKIN_WORN_ICON_STATE = "meson"
		),
		"Meson Scouter" = list(
			RESKIN_ICON = 'modular_nova/modules/meson_scouter/icons/meson_scouter.dmi',
			RESKIN_ICON_STATE = "meson_scouter",
			RESKIN_WORN_ICON = 'modular_nova/modules/meson_scouter/icons/meson-scouter_mob.dmi',
			RESKIN_WORN_ICON_STATE = "meson_scouter"
		),
	)

/obj/item/clothing/glasses/meson/prescription/Initialize(mapload)
	. = ..()
	species_exception = list() // FF ADDITION
	unique_reskin -= list(
		"Meson Glasses" = list(
			RESKIN_ICON = 'icons/obj/clothing/glasses.dmi',
			RESKIN_ICON_STATE = "meson",
			RESKIN_WORN_ICON = 'icons/mob/clothing/eyes.dmi',
			RESKIN_WORN_ICON_STATE = "meson"
		),
		"Meson Scouter" = list(
			RESKIN_ICON = 'modular_nova/modules/meson_scouter/icons/meson_scouter.dmi',
			RESKIN_ICON_STATE = "meson_scouter",
			RESKIN_WORN_ICON = 'modular_nova/modules/meson_scouter/icons/meson-scouter_mob.dmi',
			RESKIN_WORN_ICON_STATE = "meson_scouter"
		),
	)

/obj/item/clothing/glasses/meson/engine
	species_exception = list(/datum/species/nabber) // FF ADDITION
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Engine Glasses" = list(
			RESKIN_ICON = 'icons/obj/clothing/glasses.dmi',
			RESKIN_ICON_STATE = "trayson-",
			RESKIN_WORN_ICON = 'icons/mob/clothing/eyes.dmi',
		),
		"Engine Scouter" = list(
			RESKIN_ICON = 'modular_nova/modules/meson_scouter/icons/meson_scouter.dmi',
			RESKIN_ICON_STATE = "trayson-",
			RESKIN_WORN_ICON = 'modular_nova/modules/meson_scouter/icons/meson-scouter_mob.dmi'
		),
	)

/obj/item/clothing/glasses/meson/engine/tray/Initialize(mapload)
	. = ..()
	species_exception = list() // FF ADDITION
	unique_reskin -= list(
		"Engine Glasses" = list(
			RESKIN_ICON = 'icons/obj/clothing/glasses.dmi',
			RESKIN_ICON_STATE = "trayson-",
			RESKIN_WORN_ICON = 'icons/mob/clothing/eyes.dmi',
		),
		"Engine Scouter" = list(
			RESKIN_ICON = 'modular_nova/modules/meson_scouter/icons/meson_scouter.dmi',
			RESKIN_ICON_STATE = "trayson-",
			RESKIN_WORN_ICON = 'modular_nova/modules/meson_scouter/icons/meson-scouter_mob.dmi'
		),
	)

/obj/item/clothing/glasses/meson/engine/shuttle/Initialize(mapload)
	. = ..()
	species_exception = list() // FF ADDITION
	unique_reskin -= list(
		"Engine Glasses" = list(
			RESKIN_ICON = 'icons/obj/clothing/glasses.dmi',
			RESKIN_ICON_STATE = "trayson-",
			RESKIN_WORN_ICON = 'icons/mob/clothing/eyes.dmi',
		),
		"Engine Scouter" = list(
			RESKIN_ICON = 'modular_nova/modules/meson_scouter/icons/meson_scouter.dmi',
			RESKIN_ICON_STATE = "trayson-",
			RESKIN_WORN_ICON = 'modular_nova/modules/meson_scouter/icons/meson-scouter_mob.dmi'
		),
	)
/obj/item/clothing/glasses/meson/night
	can_reskin = FALSE

/obj/item/clothing/glasses/meson/gar
	can_reskin = FALSE

/datum/atom_skin/meson/engine
	abstract_type = /datum/atom_skin/meson/engine

/datum/atom_skin/meson/engine/trayson
	preview_name = "Engine Glasses"
	new_icon = 'icons/obj/clothing/glasses.dmi'
	new_icon_state = "trayson-"
	new_worn_icon = 'icons/mob/clothing/eyes.dmi'

/datum/atom_skin/meson/engine/scouter
	preview_name = "Engine Scouter"
	new_icon = 'modular_nova/modules/meson_scouter/icons/meson_scouter.dmi'
	new_icon_state = "trayson-"
	new_worn_icon = 'modular_nova/modules/meson_scouter/icons/meson-scouter_mob.dmi'

/obj/item/clothing/glasses/meson/engine/Initialize(mapload)
	. = ..()
	if(type == /obj/item/clothing/glasses/meson/engine || type == /obj/item/clothing/glasses/meson/engine/prescription || type == /obj/item/clothing/glasses/meson/engine/tray)
		AddComponent(/datum/component/reskinable_item, /datum/atom_skin/meson/engine, initial_skin = "Engine Scouter")

	species_exception = list() // FF ADDITION
	unique_reskin -= list(
		"Engine Glasses" = list(
			RESKIN_ICON = 'icons/obj/clothing/glasses.dmi',
			RESKIN_ICON_STATE = "trayson-",
			RESKIN_WORN_ICON = 'icons/mob/clothing/eyes.dmi',
		),
		"Engine Scouter" = list(
			RESKIN_ICON = 'modular_nova/modules/meson_scouter/icons/meson_scouter.dmi',
			RESKIN_ICON_STATE = "trayson-",
			RESKIN_WORN_ICON = 'modular_nova/modules/meson_scouter/icons/meson-scouter_mob.dmi'
		),
	)

/obj/item/clothing/glasses/meson/engine/prescription/Initialize(mapload)
	. = ..()
	species_exception = list() // FF ADDITION
	unique_reskin -= list(
		"Engine Glasses" = list(
			RESKIN_ICON = 'icons/obj/clothing/glasses.dmi',
			RESKIN_ICON_STATE = "trayson-",
			RESKIN_WORN_ICON = 'icons/mob/clothing/eyes.dmi',
		),
		"Engine Scouter" = list(
			RESKIN_ICON = 'modular_nova/modules/meson_scouter/icons/meson_scouter.dmi',
			RESKIN_ICON_STATE = "trayson-",
			RESKIN_WORN_ICON = 'modular_nova/modules/meson_scouter/icons/meson-scouter_mob.dmi'
		),
	)

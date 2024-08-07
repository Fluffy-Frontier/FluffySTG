/obj/item/clothing/suit/toggle/labcoat/para_red
	name = "red paramedic labcoat"
	desc = "A red vest with reflective strips for First Responsers."
	icon = 'tff_modular/modules/clothing/suit/suit.dmi'
	icon_state = "labcoat_pmedred"
	worn_icon = 'tff_modular/modules/clothing/suit/suit.dmi'
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/toggle/labcoat/para_red/Initialize(mapload)
	. = ..()
	allowed += list(
		/obj/item/storage/medkit,
	)

/datum/loadout_item/suit/labcoat_parared
	name = "Red Paramedic Labcoat"
	item_path = /obj/item/clothing/suit/toggle/labcoat/para_red
	restricted_roles = list(JOB_CHIEF_MEDICAL_OFFICER, JOB_PARAMEDIC)

/obj/item/clothing/suit/toggle/jacket/sec/blue
	icon = 'tff_modular/modules/clothing/suit/suit.dmi'
	worn_icon = 'tff_modular/modules/clothing/suit/suit.dmi'
	name = "bluesec jacket"
	desc = "A comfortable jacket in security blue. Probably against uniform regulations."
	icon_state = "bluesec_jacket"
	uses_advanced_reskins = FALSE
	unique_reskin = list()

/obj/item/clothing/suit/toggle/jacket/sec/bluewinter
	icon = 'tff_modular/modules/clothing/suit/suit.dmi'
	worn_icon = 'tff_modular/modules/clothing/suit/suit.dmi'
	name = "bluesec winter jacket"
	desc = "A comfortable jacket in security blue. Probably against uniform regulations."
	icon_state = "bluesec_winter_jacket"
	uses_advanced_reskins = FALSE
	unique_reskin = list()

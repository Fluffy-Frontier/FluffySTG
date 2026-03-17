// TFF Донаторские очки (Ballistic series by ebin_halcyon)
/datum/atom_skin/delingar_glasses
	abstract_type = /datum/atom_skin/delingar_glasses
/datum/atom_skin/delingar_glasses_redsec
	preview_name = "red"
	new_icon_state = "delingar_glasses_redsec"
	new_worn_icon = "delingar_glasses_redsec"
/datum/atom_skin/delingar_glasses_bluesec
	preview_name = "blue"
	new_icon_state = "delingar_glasses_bluesec"
	new_icon_state = "delingar_glasses_bluesec"
/datum/atom_skin/delingar_glasses_blacksec
	preview_name = "black"
	new_icon_state = "delingar_glasses_blacksec"
	new_worn_icon = "delingar_glasses_blacksec"
/obj/item/clothing/glasses/hud/security/sunglasses/ballistic
	name = "ballistic security glasses"
	desc = "Made from the same cheap plastic as regular glasses. Don't expect them to help you. They have some strange orange shield logo on side."
	icon = 'tff_modular/master_files/icons/donator/obj/clothing/glasses.dmi'
	icon_state = "delingar_glasses_redsec"
	worn_icon = 'tff_modular/master_files/icons/donator/mob/clothing/glasses.dmi'
/obj/item/clothing/glasses/hud/security/sunglasses/ballistic/setup_reskins()
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/delingar_glasses)
/datum/atom_skin/delingar_glasses_meson
	abstract_type = /datum/atom_skin/delingar_glasses_meson
/datum/atom_skin/delingar_glasses_meson/default
	preview_name = "non-yellow"
	new_icon_state = "delingar_glasses_meson"
	new_worn_icon = "delingar_glasses_meson"
/datum/atom_skin/delingar_glasses_meson/yellow
	preview_name = "yellow"
	new_icon_state = "delingar_glasses_yellow"
	new_worn_icon = "delingar_glasses_yellow"
/obj/item/clothing/glasses/meson/ballistic
	name = "ballistic meson glasses"
	desc = "Made from the same cheap plastic as regular glasses. Don't expect them to help you. They have some strange orange shield logo on side."
	icon = 'tff_modular/master_files/icons/donator/obj/clothing/glasses.dmi'
	icon_state = "delingar_glasses_meson"
	worn_icon = 'tff_modular/master_files/icons/donator/mob/clothing/glasses.dmi'

/obj/item/clothing/glasses/meson/ballistic/setup_reskins()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/delingar_glasses_meson)

/obj/item/clothing/glasses/hud/health/ballistic
	name = "ballistic health-check glasses"
	desc = "Made from the same cheap plastic as regular glasses. Don't expect them to help you. They have some strange orange shield logo on side."
	icon = 'tff_modular/master_files/icons/donator/obj/clothing/glasses.dmi'
	icon_state = "delingar_glasses_medical"
	worn_icon = 'tff_modular/master_files/icons/donator/mob/clothing/glasses.dmi'

/obj/item/clothing/glasses/hud/diagnostic/ballistic
	name = "ballistic diagnostic glasses"
	desc = "Made from the same cheap plastic as regular glasses. Don't expect them to help you. They have some strange orange shield logo on side."
	icon = 'tff_modular/master_files/icons/donator/obj/clothing/glasses.dmi'
	icon_state = "delingar_glasses_diagnostic"
	worn_icon = 'tff_modular/master_files/icons/donator/mob/clothing/glasses.dmi'

/obj/item/clothing/glasses/ballistic
	name = "ballistic glasses"
	desc = "Made from the same cheap plastic as regular glasses. Don't expect them to help you. They have some strange orange shield logo on side."
	icon = 'tff_modular/master_files/icons/donator/obj/clothing/glasses.dmi'
	icon_state = "delingar_glasses_yellow"
	worn_icon = 'tff_modular/master_files/icons/donator/mob/clothing/glasses.dmi'

/obj/item/clothing/glasses/science/ballistic
	name = "ballistic science glasses"
	desc = "Made from the same cheap plastic as regular glasses. Don't expect them to help you. They have some strange orange shield logo on side."
	icon = 'tff_modular/master_files/icons/donator/obj/clothing/glasses.dmi'
	icon_state = "delingar_glasses_science"
	worn_icon = 'tff_modular/master_files/icons/donator/mob/clothing/glasses.dmi'


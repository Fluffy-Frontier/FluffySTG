// TFF Донаторские плащи и капюшоны
/datum/atom_skin/officer_cloak
	abstract_type = /datum/atom_skin/officer_cloak
/datum/atom_skin/officer_cloak/Nanotrasen
	preview_name = "NT"
	new_icon_state = "mercreaper_cloak_nt"
	new_worn_icon = "mercreaper_cloak_nt"
/datum/atom_skin/officer_cloak/syndicate
	preview_name = "Syndicate"
	new_icon_state = "mercreaper_cloak_syndie"
	new_worn_icon = "mercreaper_cloak_syndie"
	new_desc = "Officer's coat in Syndicate colors with a big S on the back. The inside of the collar has a label with 'Nova' written on it."
/obj/item/clothing/neck/cloak/officer
	name = "officer's coat"
	desc = "Officer's coat in RedSec colors with a big N on the back. The inside of the collar has a label with 'Cyrus' written on it."
	var/alternate_desc = "Officer's coat in Syndicate colors with a big S on the back. The inside of the collar has a label with 'Nova' written on it."
	icon = 'tff_modular/master_files/icons/donator/obj/clothing/cloaks.dmi'
	icon_state = "mercreaper_cloak_nt"
	worn_icon = 'tff_modular/master_files/icons/donator/mob/clothing/neck.dmi'

/obj/item/clothing/neck/cloak/officer/setup_reskins()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/officer_cloak)
/obj/item/clothing/neck/cloak/tendercloak
	name = "bayou old mantle"
	desc = "This is a very shabby (and time-worn) cape, it smells funny of silt."
	icon = 'tff_modular/master_files/icons/donator/obj/clothing/cloaks.dmi'
	icon_state = "ten_neck"
	worn_icon = 'tff_modular/master_files/icons/donator/mob/clothing/neck.dmi'

/obj/item/clothing/neck/cloak/eldercoat
	name = "hunter's cloak"
	desc = "Just part of hunter's coat."
	icon = 'tff_modular/master_files/icons/donator/obj/clothing/cloaks.dmi'
	icon_state = "eldercoat"
	worn_icon = 'tff_modular/master_files/icons/donator/mob/clothing/neck.dmi'
	resistance_flags = FIRE_PROOF

/obj/item/clothing/neck/cloak/haori
	name = "Flaming Haori"
	desc = "A white haori with a flaming pattern on the end. It seems to radiate heat and energy. It seems."
	icon = 'tff_modular/master_files/icons/donator/obj/clothing/cloaks.dmi'
	icon_state = "romontesque_haori"
	worn_icon = 'tff_modular/master_files/icons/donator/mob/clothing/neck.dmi'
	resistance_flags = FIRE_PROOF
/datum/atom_skin/voidarr_cape
	abstract_type = /datum/atom_skin/voidarr_cape
/datum/atom_skin/voidarr_cape/snow
	preview_name = "snow"
	new_icon_state = "smol42_voidarr_cape_snow"
	new_worn_icon = "smol42_voidarr_cape_snow"
/obj/item/clothing/neck/voidarr_cape
	name = "Voidarr personel cape"
	desc = "Garment fit for Voidarr workforce, darker than the void of stars, as though woven from the very shadow that falleth betwixt dusk and dawn. The cape doth glisten faintly, upon its length, there lieth a subtle sprinkling of moondust."
	icon = 'tff_modular/master_files/icons/donator/obj/clothing/cloaks.dmi'
	icon_state = "smol42_voidarr_cape"
	worn_icon = 'tff_modular/master_files/icons/donator/mob/clothing/neck.dmi'
	resistance_flags = FIRE_PROOF
/obj/item/clothing/neck/voidarr_cape/setup_reskins()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/voidarr_cape)
/datum/atom_skin/smoltrenchcoat
	abstract_type = /datum/atom_skin/smoltrenchcoat
/datum/atom_skin/smoltrenchcoat/white
	preview_name = "white"
	new_icon_state = "smol42_trenchcoat_white"
	new_worn_icon = "smol42_trenchcoat_white"
/datum/atom_skin/smoltrenchcoat/tin
	preview_name = "tin"
	new_icon_state = "smol42_trenchcoat_tin"
	new_worn_icon = "smol42_trenchcoat_tin"
/datum/atom_skin/smoltrenchcoat/blue
	preview_name = "blue"
	new_icon_state = "smol42_trenchcoat_blue"
	new_worn_icon = "smol42_trenchcoat_blue"

/obj/item/clothing/neck/smoltrenchcoat
	name = "Secure Trenchcoat"
	icon = 'tff_modular/master_files/icons/donator/obj/clothing/cloaks.dmi'
	icon_state = "smol42_trenchcoat"
	worn_icon = 'tff_modular/master_files/icons/donator/mob/clothing/neck.dmi'
	body_parts_covered = CHEST|GROIN|LEGS|ARMS

/obj/item/clothing/neck/smoltrenchcoat/setup_reskins()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/smoltrenchcoat)

/obj/item/clothing/neck/mousecloak
	name = "Winter assault cloak"
	desc = "Life is all about doing whatever you want. Waterproof with handmade details, it includes special sleeves, detachable parts and zipper pockets."
	icon = 'tff_modular/master_files/icons/donator/obj/clothing/cloaks.dmi'
	icon_state = "siamant_sectac_w"
	worn_icon = 'tff_modular/master_files/icons/donator/mob/clothing/neck.dmi'
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	resistance_flags = FIRE_PROOF

/obj/item/clothing/neck/mousecloak/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/toggle_icon, "over shoulder")


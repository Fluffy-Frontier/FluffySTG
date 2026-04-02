/datum/atom_skin/alt_caftan
	abstract_type = /datum/atom_skin/alt_caftan
/datum/atom_skin/alt_caftan/red
	preview_name = "red"
	new_icon_state = "caftan_red"
	new_worn_icon ="caftan_red"
/datum/atom_skin/alt_caftan/blue
	preview_name = "blue"
	new_icon_state = "caftan_blue"
	new_worn_icon ="caftan_blue"
/datum/atom_skin/alt_caftan/white
	preview_name = "white"
	new_icon_state = "caftan_white"
	new_worn_icon ="caftan_white"

/obj/item/clothing/suit/armor/vest/alt/caftan
	name = "security caftan"
	desc = "This is a long and quite comfortable outfit, sitting tightly on the shoulders. Looks like it's from times of troubles."
	icon = 'tff_modular/modules/streletz/icons/obj/suit.dmi'
	worn_icon = 'tff_modular/modules/streletz/icons/mob/suit.dmi'
	icon_state = "caftan_red"

/obj/item/clothing/suit/armor/vest/alt/caftan/setup_reskins()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/alt_caftan)

/datum/atom_skin/berendeyka
	abstract_type = /datum/atom_skin/berendeyka
/datum/atom_skin/berendeyka/red
	preview_name = "red"
	new_icon_state = "berendeyka_red"
	new_worn_icon ="berendeyka_red"
/datum/atom_skin/berendeyka/blue
	preview_name = "blue"
	new_icon_state = "berendeyka_blue"
	new_worn_icon ="berendeyka_blue"
/datum/atom_skin/berendeyka/white
	preview_name = "white"
	new_icon_state = "berendeyka_white"
	new_worn_icon ="berendeyka_white"

/obj/item/clothing/head/berendeyka
	name = "security beanie with band"
	desc = "Soft and armored beanie that toggles its order."
	icon = 'tff_modular/modules/streletz/icons/obj/hat.dmi'
	worn_icon = 'tff_modular/modules/streletz/icons/mob/hat.dmi'
	icon_state = "berendeyka_red"
	armor_type = /datum/armor/head_helmet
	strip_delay = 60
	//supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON
/obj/item/clothing/head/berendeyka/setup_reskins()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/berendeyka)

/obj/item/clothing/neck/cloak/officer
	name = "officer's coat"
	desc = "Officer's coat in RedSec colors with a big N on the back. The inside of the collar has a label with 'Cyrus' written on it."
	var/alternate_desc = "Officer's coat in Syndicate colors with a big S on the back. The inside of the collar has a label with 'Nova' written on it."
	icon = 'tff_modular/master_files/icons/donator/obj/clothing/cloaks.dmi'
	icon_state = "mercreaper_cloak_nt"
	worn_icon = 'tff_modular/master_files/icons/donator/mob/clothing/neck.dmi'
	unique_reskin = list(
		"Nanotrasen" = "mercreaper_cloak_nt",
		"Syndicate" = "mercreaper_cloak_syndie"
	)

/obj/item/clothing/neck/cloak/officer/reskin_obj(mob/M)
	. = ..()
	if(icon_state == "mercreaper_cloak_syndie")
		desc = alternate_desc

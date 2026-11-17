// TFF Донаторские плащи и капюшоны
/obj/item/clothing/suit/hooded/cloak/urscloak
	name = "Project: Urs-W"
	desc = "A standard version of a prototype cloak given out by Nanotrasen higher ups. It's surprisingly thick and heavy for a cloak despite having most of its tech stripped. It also comes with a bluespace trinket which calls its accompanying hat onto the user. A worn inscription on the inside of the cloak reads 'Vanguard' ...the rest is faded away."
	icon_state = "BCFiks_urscloak"
	icon = 'tff_modular/master_files/icons/donator/obj/clothing/cloaks.dmi'
	worn_icon = 'tff_modular/master_files/icons/donator/mob/clothing/neck.dmi'
	hoodtype = /obj/item/clothing/head/hooded/cloakhood/urscloak
	body_parts_covered = CHEST|GROIN|ARMS
	slot_flags = ITEM_SLOT_OCLOTHING | ITEM_SLOT_NECK //it's a cloak. it's cosmetic. so why the hell not? what could possibly go wrong?
	supports_variations_flags = NONE

/obj/item/clothing/head/hooded/cloakhood/urscloak
	name = "Vanguard special issue"
	desc = "This hat is unquestionably the best one, bluespaced to and from CentCom. It smells of Fox and 24 Volt Energy with a hint of antagonism"
	icon_state = "BCFiks_urscap"
	icon = 'tff_modular/master_files/icons/donator/obj/clothing/cloaks.dmi'
	worn_icon = 'tff_modular/master_files/icons/donator/mob/clothing/neck.dmi'
	flags_inv = null
	supports_variations_flags = NONE

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

/datum/atom_skin/smolcoat
	abstract_type = /datum/atom_skin/smolcoat

/datum/atom_skin/smolcoat/b
	preview_name = "Elegant Greatcoat"
	new_icon_state = "smol42_coat_B"

/datum/atom_skin/smolcoat/a
	preview_name = "Elegant Robe"
	new_icon_state = "smol42_coat_A"

/obj/item/clothing/neck/smolcoat
	name = "Elegant Greatcoat"
	desc = "A heavy greatcoat with tactical design, oversized pockets, sturdy buttons and a high collar."
	icon = 'tff_modular/master_files/icons/donator/obj/clothing/cloaks.dmi'
	worn_icon = 'tff_modular/master_files/icons/donator/mob/clothing/neck.dmi'
	icon_state = "smol42_coat_B"
	body_parts_covered = CHEST|ARMS
	resistance_flags = FIRE_PROOF

/obj/item/clothing/neck/smolcoat/setup_reskins()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/smolcoat)

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


/obj/item/clothing/neck/cloak/tattered_cloak
	name = "Tattered Cloak"
	desc = "A worn, battle-torn cloak. Complete with light red trimmings, tears, burns, and even some holes through out it's design, it clearly has seen better days. You can practically smell the despair, a hint of gunpowder, and a bit of a blood smell. On the surviving part, the inside is embroidered with silver thread and initals of \"R.A.\""
	icon = 'tff_modular/master_files/icons/donator/obj/clothing/cloaks.dmi'
	icon_state = "tattered_cloak"
	worn_icon = 'tff_modular/master_files/icons/donator/mob/clothing/neck.dmi'
	supports_variations_flags = NONE

/obj/item/clothing/neck/cloak/meowcloak
	name = "Nanotrasen 'Kitty' Replica Greatcoat"
	desc = "An award replica of HoS greatcoat with colourable NT logo! The label states that it was manufactured at the infamous factory that used the labor of tajaran kittens, ugh."
	icon = 'icons/map_icons/clothing/neck.dmi'
	icon_state = "/obj/item/clothing/neck/cloak/meowcloak"
	post_init_icon_state = "meowcloak"
	greyscale_config = /datum/greyscale_config/meowcloak
	greyscale_config_worn = /datum/greyscale_config/meowcloak/worn
	greyscale_colors = "#FFFFFF"
	flags_1 = IS_PLAYER_COLORABLE_1
	resistance_flags = FIRE_PROOF //Cause yes.

/datum/greyscale_config/meowcloak
	name = "Meowcloak"
	icon_file = 'tff_modular/master_files/icons/donator/obj/clothing/cloaks.dmi'
	json_config = 'modular_nova/modules/GAGS/json_configs/cloak/meowcloak.json'

/datum/greyscale_config/meowcloak/worn
	name = "Meowcloak (Worn)"
	icon_file = 'tff_modular/master_files/icons/donator/mob/clothing/neck.dmi'

/obj/item/clothing/suit/hooded/cloak/paddedsec
	name = "Vanguard cloak"
	desc = "A meticulously handcrafted cloak that is lined with subtle pockets always filled with some medicine. Oddly enough, you always feel comfortable regardless of the weather."
	icon_state = "paddedsec"
	icon = 'tff_modular/master_files/icons/donator/obj/clothing/cloaks.dmi'
	worn_icon = 'tff_modular/master_files/icons/donator/mob/clothing/neck.dmi'
	hoodtype = /obj/item/clothing/head/hooded/cloakhood/paddedsec
	body_parts_covered = CHEST|GROIN|ARMS
	slot_flags = ITEM_SLOT_OCLOTHING | ITEM_SLOT_NECK
	supports_variations_flags = NONE
	hood_up_affix = ""

/obj/item/clothing/head/hooded/cloakhood/paddedsec
	name = "Vanguard cloak hood"
	desc = "A meticulously handcrafted cloak that is lined with subtle pockets always filled with some medicine. Oddly enough, you always feel comfortable regardless of the weather."
	icon_state = "paddedsechood"
	icon = 'tff_modular/master_files/icons/donator/obj/clothing/cloaks.dmi'
	worn_icon = 'tff_modular/master_files/icons/donator/mob/clothing/neck.dmi'
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT
	supports_variations_flags = NONE

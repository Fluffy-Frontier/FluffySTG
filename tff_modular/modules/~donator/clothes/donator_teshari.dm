// TFF Донаторские одежда и спец. комплекты для тешари

/obj/item/clothing/suit/teshari
	name = "teshari base"
	desc = "HOW YOU GET THIS?"
	icon = 'tff_modular/master_files/icons/donator/mob/clothing/suit.dmi'
	worn_icon = 'tff_modular/master_files/icons/donator/mob/clothing/suit.dmi'
	worn_icon_teshari = 'tff_modular/master_files/icons/donator/mob/clothing/suit.dmi'

/obj/item/clothing/suit/teshari/mob_can_equip(mob/living/equipper, slot, disable_warning, bypass_equip_delay_self, ignore_equipped, indirect_action)
	if(!is_species(equipper, /datum/species/teshari))
		to_chat(equipper, span_warning("[src] is far too small for you!"))
		return FALSE
	return ..()

/obj/item/clothing/under/teshari
	name = "teshari base"
	desc = "HOW YOU GET THIS?"
	icon = 'tff_modular/master_files/icons/donator/mob/clothing/under.dmi'
	worn_icon = 'tff_modular/master_files/icons/donator/mob/clothing/under.dmi'
	worn_icon_teshari = 'tff_modular/master_files/icons/donator/mob/clothing/under.dmi'

/obj/item/clothing/under/teshari/mob_can_equip(mob/living/equipper, slot, disable_warning, bypass_equip_delay_self, ignore_equipped, indirect_action)
	if(!is_species(equipper, /datum/species/teshari))
		to_chat(equipper, span_warning("[src] is far too small for you!"))
		return FALSE
	return ..()

// Teshari Suits
/obj/item/clothing/suit/teshari/furcoat
	name = "tenka fabric coat"
	desc = "This is a small tenka fabric coat, with slits for wings. It's visible that it was sewn for a small creature."
	icon_state = "zanozkin_furcoat"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/teshari/labcoat
	name = "lab coat"
	desc = "This is a very long laboratory coat and it has slits for wings."
	icon_state = "zanozkin_labcoat"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/teshari/labcoat/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/toggle_icon)

/obj/item/clothing/suit/teshari/graycoat
	name = "grey coat"
	desc = "This is a grey coat, it has hidden slits for wings, the material seems expensive and from a certain angle the bottom part seems transparent."
	icon_state = "zanozkin_strangeshirt"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/teshari/jacket
	name = "black jacket FZ"
	desc = "This is a black jacket from an unknown company with hidden slits for wings."
	icon_state = "zanozkin_coldcoat"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/teshari/jacket/noblue
	icon_state = "zanozkin_coldcoat_noblue"

/obj/item/clothing/suit/teshari/russian_jacket
	name = "russian raptor coat"
	desc = "This is a fucking Russian jacket for raptors."
	icon_state = "zanozkin_coat_korea"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/teshari/aqua_cloak // тут действительно в виде suit.
	name = "short shirt FZ"
	desc = "This is a short shirt from an unknown company for small winged creatures"
	icon_state = "zanozkin_aquacloak"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/teshari/aqua_cloak/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/toggle_icon)

// Teshari Uniforms
/obj/item/clothing/under/teshari/consultant
	name = "crocs suit"
	desc = "Crocs clothes for little winged creatures!"
	icon_state = "zanozkin_consultant"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/under/teshari/consultant/female
	name = "crocs skirt"
	icon_state = "zanozkin_consultant_skirt"

/obj/item/clothing/under/teshari/nt_combineso
	name = "combeniso NT"
	desc = "This jumpsuit was custom-made for workers of the Avali race near their homeland."
	icon_state = "zanozkin_nt"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/under/teshari/meme
	name = "shirt and shorts"
	desc = "It's just a shirt and shorts, but it reminds me of something."
	icon_state = "zanozkin_meme"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/under/teshari/elite_suit
	name = "elite feathered"
	desc = "White shirt, black bow tie and beige pants. This suit doesn't look bad."
	icon_state = "zanozkin_elite"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/under/teshari/elite_suit/plus
	name = "elite feathered deluxe"
	desc = "White shirt, black bow tie, beige jacket and beige pants. This suit doesn't look bad"
	icon_state = "zanozkin_eliteplus"

/obj/item/clothing/under/teshari/waistcoat
	name = "delicate suit"
	desc = "Costume for winged pick-up artist."
	icon_state = "zanozkin_waistcoat"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/under/teshari/mechsuit
	name = "rivka"
	desc = "Personalized suit, it seems it was made to order and given as a gift"
	icon_state = "zanozkin_mechsuit"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

// Teshari Neck Items
/obj/item/clothing/neck/cloak/teshari/tenkacoat
	name = "small cloak"
	desc = "Just a small cloak... for avali?"
	icon = 'tff_modular/master_files/icons/donator/mob/clothing/neck.dmi'
	icon_state = "zanozkin_tenkacoat"
	worn_icon = 'tff_modular/master_files/icons/donator/mob/clothing/neck.dmi'
	worn_icon_teshari = 'tff_modular/master_files/icons/donator/mob/clothing/neck.dmi'
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON


#define TESHARI_ALT_PUNCH_LOW 3
#define TESHARI_ALT_PUNCH_HIGH 5
// Значительно увеличенный урон!
#define TESHARI_ALT_BURN_MODIFIER 1.5
#define TESHARI_ALT_BRUTE_MODIFIER 1.5
#define TESHARI_ALT_SPEED_MODIFIER -0.4
// Пути к файлам
#define TESHARI_ALT_HUSK_ICON 'tff_modular/modules/teshari_reborn/icons/mob/bodyparts/husk_bodyparts.dmi'

/obj/item/organ/internal/tongue/teshari/alt
	liked_foodtypes = MEAT | GORE
	disliked_foodtypes = GROSS | GRAIN

// Тешари <3, альтернативные.
/obj/item/bodypart/head/mutant/teshari/alt
	husk_type = "teshari"
	icon_husk = TESHARI_ALT_HUSK_ICON
	max_damage = 175 // -75 от нормального.
	brute_modifier = TESHARI_ALT_BRUTE_MODIFIER
	burn_modifier = TESHARI_ALT_BURN_MODIFIER
	head_flags = HEAD_EYESPRITES|HEAD_EYECOLOR|HEAD_EYEHOLES|HEAD_DEBRAIN

/obj/item/bodypart/chest/mutant/teshari/alt
	husk_type = "teshari"
	icon_husk = TESHARI_ALT_HUSK_ICON
	max_damage = 175
	brute_modifier = TESHARI_ALT_BRUTE_MODIFIER
	burn_modifier = TESHARI_ALT_BURN_MODIFIER

/obj/item/bodypart/arm/left/mutant/teshari/alt
	husk_type = "teshari"
	icon_husk = TESHARI_ALT_HUSK_ICON
	max_damage = 40
	unarmed_damage_low = TESHARI_ALT_PUNCH_LOW
	unarmed_damage_high = TESHARI_ALT_PUNCH_HIGH
	brute_modifier = TESHARI_ALT_BRUTE_MODIFIER
	burn_modifier = TESHARI_ALT_BURN_MODIFIER

/obj/item/bodypart/arm/right/mutant/teshari/alt
	husk_type = "teshari"
	icon_husk = TESHARI_ALT_HUSK_ICON
	max_damage = 40
	unarmed_damage_low = TESHARI_ALT_PUNCH_LOW
	unarmed_damage_high = TESHARI_ALT_PUNCH_HIGH
	brute_modifier = TESHARI_ALT_BRUTE_MODIFIER
	burn_modifier = TESHARI_ALT_BURN_MODIFIER

/obj/item/bodypart/leg/left/mutant/teshari/alt
	husk_type = "teshari"
	icon_husk = TESHARI_ALT_HUSK_ICON
	max_damage = 40
	digitigrade_type = /obj/item/bodypart/leg/left/digitigrade/teshari/alt
	brute_modifier = TESHARI_ALT_BRUTE_MODIFIER
	burn_modifier = TESHARI_ALT_BURN_MODIFIER
	speed_modifier = TESHARI_ALT_SPEED_MODIFIER

/obj/item/bodypart/leg/right/mutant/teshari/alt
	husk_type = "teshari"
	icon_husk = TESHARI_ALT_HUSK_ICON
	max_damage = 40
	digitigrade_type = /obj/item/bodypart/leg/right/digitigrade/teshari/alt
	brute_modifier = TESHARI_ALT_BRUTE_MODIFIER
	burn_modifier = TESHARI_ALT_BURN_MODIFIER
	speed_modifier = TESHARI_ALT_SPEED_MODIFIER

/obj/item/bodypart/leg/left/digitigrade/teshari/alt
	husk_type = "teshari"
	icon_husk = TESHARI_ALT_HUSK_ICON
	max_damage = 40
	brute_modifier = TESHARI_ALT_BRUTE_MODIFIER
	burn_modifier = TESHARI_ALT_BURN_MODIFIER
	speed_modifier = TESHARI_ALT_SPEED_MODIFIER

/obj/item/bodypart/leg/right/digitigrade/teshari/alt
	husk_type = "teshari"
	icon_husk = TESHARI_ALT_HUSK_ICON
	max_damage = 40
	brute_modifier = TESHARI_ALT_BRUTE_MODIFIER
	burn_modifier = TESHARI_ALT_BURN_MODIFIER
	speed_modifier = TESHARI_ALT_SPEED_MODIFIER

#undef TESHARI_ALT_PUNCH_LOW
#undef TESHARI_ALT_PUNCH_HIGH
#undef TESHARI_ALT_BURN_MODIFIER
#undef TESHARI_ALT_BRUTE_MODIFIER
#undef TESHARI_ALT_HUSK_ICON
#undef TESHARI_ALT_SPEED_MODIFIER

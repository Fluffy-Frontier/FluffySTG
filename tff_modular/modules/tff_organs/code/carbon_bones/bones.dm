/obj/item/organ/bone
	visual = TRUE
	throw_speed = 3
	throw_range = 5
	icon = 'tff_modular/modules/tff_organs/icons/bones/bones.dmi'
	w_class = WEIGHT_CLASS_SMALL
	healing_factor = STANDARD_ORGAN_HEALING
	decay_factor = FALSE
	organ_flags =  ORGAN_MINERAL | ORGAN_VITAL | ORGAN_PROMINENT | BIO_BONE

	maxHealth = BONE_LIMB_FUNC // - добавить в /code/_DEFINES/~ff_defines со 100 хп
	low_threshold = 30
	high_threshold = 70

    // required_wounding_types = list(WOUND_BLUNT)

	// wound_series = WOUND_SERIES_BONE_BLUNT_BASIC

	organ_traits = list(TRAIT_NO_STAGGER, BODYPART_TRAIT) //Суть в чем? В том, что кости держат куклу стабильной, является частью тела шкелетов.

    // Используем список травм для костей
    //var/list/datum/wounds/bone =list()
    // Для расчета вероятности травмы (хз нужно ли)
	var/damage_delta = 0
    // Размер кости
	var/bone_size = 1
    // Для дополнения трейтов (от подтипов тоже)
	var/variant_traits_added
    // Для для удаления трейтов (от подтипов тоже)
	var/variant_traits_removed
/obj/item/organ/bone/Initialize(mapload)
	. = ..()

//Кости мобов с условиями для иконок



//#define TRAIT_PARALYSIS_L_ARM "para-l-arm"
//#define TRAIT_PARALYSIS_R_ARM "para-r-arm"
//#define TRAIT_PARALYSIS_L_LEG "para-l-leg"
//#define TRAIT_PARALYSIS_R_LEG "para-r-leg"
//#define TRAIT_CANNOT_OPEN_PRESENTS "cannot-open-presents"
//#define TRAIT_PRESENT_VISION "present-vision"
//#define TRAIT_DISK_VERIFIER "disk-verifier"
//#define TRAIT_NOMOBSWAP "no-mob-swap"

/obj/item/organ/bone/skull
	name = "Human skull"
	desc = "To be, or not to be?"
	zone = BODY_ZONE_HEAD
	slot = ORGAN_BONE_SLOT_SKULL
	icon_state = "human_skull"


/obj/item/organ/bone/ribs
	name = "Ribs"
	desc = "Twelve ribs—right and left. Seven pairs to the chest, five—didn't reach, so that the organs would be safe."
	zone = BODY_ZONE_CHEST
	slot = ORGAN_BONE_SLOT_SKULL
	icon_state = "ribs"

/obj/item/organ/bone/spine
	name = "Spine"
	desc = ""
	zone = BODY_ZONE_CHEST
	slot = ORGAN_BONE_SLOT_SPINE
	icon_state = "spine"

/obj/item/organ/bone/hip
	name = "Hip bone"
	desc = "No bottom, top soldered!"
	zone = BODY_ZONE_PRECISE_GROIN
	slot = ORGAN_BONE_SLOT_HIP
	icon_state = "m_hip"

/obj/item/organ/bone/l_hand
	name = "Left hand bones"
	desc = "The main thing is not to accidentally mix them up."
	zone = BODY_ZONE_L_ARM
	slot = ORGAN_BONE_SLOT_L_HAND
	icon_state = "l_hand"

/obj/item/organ/bone/r_hand
	name = "Right hand bones"
	desc = "The main thing is not to accidentally mix them up."
	zone = BODY_ZONE_R_ARM
	slot = ORGAN_BONE_SLOT_R_HAND
	icon_state = "r_hand"

/obj/item/organ/bone/l_arm
	name = "Left arm bones"
	desc = "?taht hctiws tsum I od woH"
	zone = BODY_ZONE_L_ARM
	slot = ORGAN_BONE_SLOT_L_ARM
	icon_state = "l_arm"

/obj/item/organ/bone/r_arm
	name = "Right arm bones"
	desc = "How do I must switch that?"
	zone = BODY_ZONE_R_ARM
	slot = ORGAN_BONE_SLOT_R_ARM
	icon_state = "r_arm"

/obj/item/organ/bone/l_leg
	name = "Left leg bones"
	desc = "It will only let you down once in your life."
	zone = BODY_ZONE_L_LEG
	slot = ORGAN_BONE_SLOT_L_FUT
	icon_state = "l_leg"

/obj/item/organ/bone/r_leg
	name = "Right leg bones"
	desc = "It will only let you down second in your life."
	zone = BODY_ZONE_R_LEG
	slot = ORGAN_BONE_SLOT_R_FUT
	icon_state = "r_leg"

/obj/item/organ/bone/l_fut
	name = "Left fut bones"
	desc = "Did you know that your toes are functionally equal to your hand?"
	zone = BODY_ZONE_L_LEG
	slot = ORGAN_BONE_SLOT_L_LEG
	icon_state = "l_fut"

/obj/item/organ/bone/r_fut
	name = "Right fut bones"
	desc = "Did you know that your toes are functionally equal to your hand?"
	zone = BODY_ZONE_R_LEG
	slot = ORGAN_BONE_SLOT_R_LEG
	icon_state = "r_fut"


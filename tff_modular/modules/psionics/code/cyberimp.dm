#define ORGAN_SLOT_BRAIN_PSIONIC "brain_psionic"

// Не позволяет мане регенерироваться
/obj/item/organ/internal/cyberimp/brain/anti_psionic
	name = "Psionic Amplifier Model N"
	desc = "This implant will prohibit psionics from regenereting their energy."
	icon_state = "brain_implant_rebooter"
	slot = ORGAN_SLOT_BRAIN_PSIONIC

/obj/item/organ/internal/cyberimp/brain/anti_psionic/on_mob_insert(mob/living/carbon/organ_owner, special, movement_flags)
	. = ..()
	ADD_TRAIT(organ_owner, TRAIT_PSIONIC_SUPPRESSED, IMPLANT_TRAIT)

/obj/item/organ/internal/cyberimp/brain/anti_psionic/on_mob_remove(mob/living/carbon/organ_owner, special)
	. = ..()
	REMOVE_TRAIT(organ_owner, TRAIT_PSIONIC_SUPPRESSED, IMPLANT_TRAIT)

// Увеличивает реген маны в 2 раза
/obj/item/organ/internal/cyberimp/brain/pro_psionic
	name = "Psionic Amplifier Model A"
	desc = "This implant will boost psionics energy regeneration by two times."
	icon_state = "brain_implant_rebooter"
	slot = ORGAN_SLOT_BRAIN_PSIONIC

/obj/item/organ/internal/cyberimp/brain/pro_psionic/on_mob_insert(mob/living/carbon/organ_owner, special, movement_flags)
	. = ..()
	ADD_TRAIT(organ_owner, TRAIT_PSIONIC_IMPLANT, IMPLANT_TRAIT)

/obj/item/organ/internal/cyberimp/brain/pro_psionic/on_mob_remove(mob/living/carbon/organ_owner, special)
	. = ..()
	REMOVE_TRAIT(organ_owner, TRAIT_PSIONIC_IMPLANT, IMPLANT_TRAIT)

/datum/supply_pack/medical/psionic_implants
	name = "Psionic Implants"
	desc = "A crate containing two experimental psionic implants, which work ONLY on psionic users. No warranty."
	cost = CARGO_CRATE_VALUE * 5
	contains = list(/obj/item/organ/internal/cyberimp/brain/anti_psionic = 1,
					/obj/item/organ/internal/cyberimp/brain/pro_psionic = 1)
	crate_name = "Psionic implant crate"
	discountable = SUPPLY_PACK_RARE_DISCOUNTABLE

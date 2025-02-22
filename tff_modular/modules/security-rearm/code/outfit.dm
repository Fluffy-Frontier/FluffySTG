/datum/job
	var/datum/outfit/synthetic_outfit //Да, новая переменная в датум чисто ради аптечки, нет, мне не стыдно

/datum/species/synthetic/pre_equip_species_outfit(datum/job/job, mob/living/carbon/human/equipping, visuals_only)
	. = ..()
	if(job?.synthetic_outfit)
		equipping.equipOutfit(job.synthetic_outfit, visuals_only)

//Сами аутфиты
/datum/outfit/job/security
	suit_store = null
	backpack_contents = list(
		/obj/item/evidencebag = 1,
		/obj/item/choice_beacon/sec_officer = 1,
		)
	r_pocket = /obj/item/storage/pouch/medical/tac_security/loaded

/datum/outfit/job/security/synthetic
	r_pocket = /obj/item/storage/pouch/medical/tac_security/synth/loaded

/datum/job/security_officer
	synthetic_outfit = /datum/outfit/job/security/synthetic

/datum/outfit/job/hos
	r_pocket = /obj/item/storage/pouch/medical/tac_security/loaded

/datum/outfit/job/hos/synthetic
	r_pocket = /obj/item/storage/pouch/medical/tac_security/synth/loaded

/datum/outfit/job/warden
	r_pocket = /obj/item/storage/pouch/medical/tac_security/loaded

/datum/outfit/job/warden/synthetic
	r_pocket = /obj/item/storage/pouch/medical/tac_security/synth/loaded

/datum/species/synthetic
	outfit_override_registry = list(
		/datum/outfit/job/security = /datum/outfit/job/security/synthetic,
		/datum/outfit/job/warden = /datum/outfit/job/warden/synthetic,
		/datum/outfit/job/hos = /datum/outfit/job/hos/synthetic,
	)

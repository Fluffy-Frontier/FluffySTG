/datum/job
	var/datum/outfit/synthetic_outfit //Да, новая переменная в датум чисто ради аптечки, нет, мне не стыдно

/datum/species/synthetic/pre_equip_species_outfit(datum/job/job, mob/living/carbon/human/equipping, visuals_only)
	. = ..()
	if(job?.synthetic_outfit)
		equipping.equipOutfit(job.synthetic_outfit, visuals_only)

//Сами аутфиты
/datum/outfit/job/security
	suit_store = null
	l_pocket = /obj/item/storage/pouch/medical/tac_security/loaded
	backpack_contents = list(
		/obj/item/evidencebag = 1,
		/obj/item/choice_beacon/sec_officer = 1,
		/obj/item/restraints/handcuffs = 1,
		)

/datum/outfit/job/warden
	l_pocket = /obj/item/storage/pouch/medical/tac_security/loaded
	backpack_contents = list(
		/obj/item/evidencebag = 1,
		/obj/item/restraints/handcuffs = 1,
		)

/datum/outfit/job/hos
	l_pocket = /obj/item/storage/pouch/medical/tac_security/loaded
	backpack_contents = list(
		/obj/item/evidencebag = 1,
		/obj/item/melee/baton/security/loaded/hos = 1,
		/obj/item/restraints/handcuffs = 1,
		)

/datum/outfit/synthetic
	name = "Synthetic Crewmember Outfit"

/datum/outfit/synthetic/security
	name = "Synthetic Security Outfit"

	l_pocket = /obj/item/storage/pouch/medical/tac_security/synth/loaded
	uniform = /obj/item/clothing/under/rank/security/officer
	ears = /obj/item/radio/headset/headset_sec/alt

/datum/outfit/synthetic/security/warden
	name = "Synthetic Security Warden Outfit"

	uniform = /obj/item/clothing/under/rank/security/warden

/datum/outfit/synthetic/security/hos
	name = "Synthetic Security HoS Outfit"

	uniform = /obj/item/clothing/under/rank/security/head_of_security
	ears = /obj/item/radio/headset/heads/hos/alt

/datum/job/security_officer
	synthetic_outfit = /datum/outfit/synthetic/security

/datum/job/head_of_security
	synthetic_outfit = /datum/outfit/synthetic/security/hos

/datum/job/warden
	synthetic_outfit = /datum/outfit/synthetic/security/warden

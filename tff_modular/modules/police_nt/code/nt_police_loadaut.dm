/*
		NTIS ID CARD
*/

/datum/id_trim/centcom/ert/security/nt_police/New()
	. = ..()
	assignment = "NTIS Agent"
	sechud_icon_state = "hudagent"
	access = SSid_access.get_region_access_list(list(REGION_CENTCOM, REGION_ALL_STATION))

/datum/id_trim/centcom/ert/security/nt_police/swat/New()
	. = ..()
	assignment = "NTIS S.W.A.T."
	sechud_icon_state = "hudswat"

/datum/id_trim/centcom/ert/security/nt_police/trooper/New()
	. = ..()
	assignment = "NTIS Trooper"
	sechud_icon_state = "hudtrooper"

/obj/item/card/id/advanced/centcom/ert/nt_police
	registered_name = "NT Internal Security"
	trim = /datum/id_trim/centcom/ert/security/nt_police

/obj/item/card/id/advanced/centcom/ert/nt_police/swat
	trim = /datum/id_trim/centcom/ert/security/nt_police/swat

/obj/item/card/id/advanced/centcom/ert/nt_police/trooper
	trim = /datum/id_trim/centcom/ert/security/nt_police/trooper

/*
		NTIS OUTFIT
*/

/datum/outfit/nt_police
	name = "NTIS Base"
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses
	box = /obj/item/storage/box/survival/centcom
	back = /obj/item/storage/backpack/security
	ears = /obj/item/radio/headset/headset_cent/commander

/datum/outfit/nt_police/post_equip(mob/living/carbon/human/human_to_equip, visualsOnly = FALSE)
	if(visualsOnly)
		return

	var/obj/item/implant/mindshield/mindshield = new /obj/item/implant/mindshield(human_to_equip)
	mindshield.implant(human_to_equip, null, silent = TRUE)
	if(human_to_equip.mind.has_antag_datum(/datum/antagonist/ert/nt_police/agent))
		RegisterSignal(human_to_equip, COMSIG_LIVING_DEATH, GLOBAL_PROC_REF(check_dead_ntis), TRUE) //- вот тут должен быть сигнал, но... Увы.
	if(human_to_equip.mind.has_antag_datum(/datum/antagonist/ert/nt_police/swat))
		RegisterSignal(human_to_equip, COMSIG_LIVING_DEATH, GLOBAL_PROC_REF(check_dead_ntis), TRUE)
	var/obj/item/card/id/ID_to_give = human_to_equip.wear_id
	if(istype(ID_to_give))
		shuffle_inplace(ID_to_give.access)
		ID_to_give.registered_name = human_to_equip.real_name
		if(human_to_equip.age)
			ID_to_give.registered_age = human_to_equip.age
		ID_to_give.update_label()
		ID_to_give.update_icon()
		human_to_equip.sec_hud_set_ID()

/obj/item/radio/headset/headset_cent/alt/com
	command = TRUE

/datum/outfit/nt_police/agent
	name = "NTIS Agent"
	gloves = /obj/item/clothing/gloves/tackler/combat
	uniform = /obj/item/clothing/under/rank/security/officer
	suit = /obj/item/clothing/suit/armor/vest/nt_police
	head = /obj/item/clothing/head/hats/warden/police/patrol // Вот это не заменил. Не скоро менять будут.
	shoes = /obj/item/clothing/shoes/combat
	belt = /obj/item/melee/baton/security/loaded
	id = /obj/item/card/id/advanced/centcom/ert/nt_police
	backpack_contents = list(
		/obj/item/storage/box/handcuffs = 1,
		/obj/item/nt_reporter/swat_caller = 1,
		/obj/item/beamout_tool_nt = 1,
		/obj/item/melee/baton/telescopic = 1,
		/obj/item/choice_beacon/nt_police = 1,
	)
	r_pocket = /obj/item/flashlight/seclite
	l_pocket = /obj/item/restraints/handcuffs

/datum/outfit/nt_police/swat
	name = "NTIS S.W.A.T."
	id = /obj/item/card/id/advanced/centcom/ert/nt_police/swat
	gloves = /obj/item/clothing/gloves/combat
	uniform = /obj/item/clothing/under/rank/security/officer
	head = /obj/item/clothing/head/helmet/sf_sacrificial/nt_police
	mask = /obj/item/clothing/mask/gas/nt_police
	suit = /obj/item/clothing/suit/armor/vest/nt_police/swat
	belt = /obj/item/gun/energy/disabler
	shoes = /obj/item/clothing/shoes/combat
	ears = /obj/item/radio/headset/headset_cent/alt
	l_hand = /obj/item/shield/riot/tele
	backpack_contents = list(
		/obj/item/storage/box/handcuffs = 1,
		/obj/item/melee/baton/security/loaded = 1,
		/obj/item/nt_reporter/trooper_caller = 1,
		/obj/item/beamout_tool_nt = 1,
		/obj/item/choice_beacon/nt_police/swat = 1,
		/obj/item/choice_beacon/nt_police/swat_class = 1,
	)
	r_pocket = /obj/item/flashlight/seclite
	l_pocket = /obj/item/restraints/handcuffs

/datum/outfit/nt_police/trooper
	name = "NTIS Trooper"
	id = /obj/item/card/id/advanced/centcom/ert/nt_police/trooper
	uniform = /obj/item/clothing/under/nt_peacekeeper
	head = /obj/item/clothing/head/helmet/sf_sacrificial/nt_police // Это не планируют убирать. Я просто накину прочности.
	suit = /obj/item/clothing/suit/armor/sf_sacrificial/nt_police // Это не планируют убирать. Я просто накину прочности.
	mask = /obj/item/clothing/mask/gas/nt_police
	gloves = /obj/item/clothing/gloves/combat
	shoes = /obj/item/clothing/shoes/jackboots
	back = /obj/item/mod/control/pre_equipped/ntis_derevolutioner
	l_hand = /obj/item/shield/ballistic
	ears = /obj/item/radio/headset/headset_cent/alt
	backpack_contents = list(
		/obj/item/storage/box/handcuffs = 1,
		/obj/item/sacrificial_face_shield = 1,
		/obj/item/melee/baton/security/loaded = 1,
		/obj/item/choice_beacon/nt_police/trooper = 1,
		/obj/item/choice_beacon/nt_police/trooper_class = 1,
	)
	l_pocket = /obj/item/restraints/handcuffs
	r_pocket = /obj/item/flashlight/seclite

/datum/outfit/nt_police/agent/leader
	name = "NTIS Agent-L"
	ears = /obj/item/radio/headset/headset_cent/alt/com

/datum/outfit/nt_police/swat/leader
	name = "NTIS S.W.A.T.-L"
	ears = /obj/item/radio/headset/headset_cent/alt/com

/datum/outfit/nt_police/trooper/leader
	name = "NTIS Trooper-L"
	ears = /obj/item/radio/headset/headset_cent/alt/com

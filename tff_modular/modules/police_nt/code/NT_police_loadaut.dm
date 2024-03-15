/obj/item/choice_beacon/nt_police
	name = "gunset beacon"
	desc = "A single use beacon to deliver a gunset of your choice."
	company_source = "NanoTrasen(tm)"
	company_message = span_bold("Supply Pod incoming please stand by")

/obj/item/storage/box/survival/hug/black/nt_police
	name = "tactical cuddle kit"
	desc = "A lovely little box filled with gear for the brutal police!"

/*
		END round ammunition
*/

/obj/item/storage/box/survival/hug/black/nt_police/revolver/PopulateContents()
	new /obj/item/gun/ballistic/revolver/mateba(src)
	new /obj/item/ammo_box/a357(src)
	new /obj/item/ammo_box/a357(src)
	new /obj/item/ammo_box/a357(src)
	new /obj/item/storage/belt/holster(src)

/obj/item/storage/box/survival/hug/black/nt_police/smg/PopulateContents()
	new /obj/item/gun/ballistic/automatic/proto/unrestricted(src)
	new /obj/item/ammo_box/magazine/smgm9mm(src)
	new /obj/item/ammo_box/magazine/smgm9mm(src)
	new /obj/item/ammo_box/magazine/smgm9mm(src)
	new /obj/item/storage/pouch/ammo(src)

/obj/item/storage/box/survival/hug/black/nt_police/medic/PopulateContents()
	new /obj/item/gun/energy/laser/scatter/shotty(src)
	new /obj/item/storage/medkit/tactical/premium(src)
	new /obj/item/storage/belt/medical/ert(src)
	new /obj/item/reagent_containers/hypospray/combat/nanites(src)

/obj/item/storage/box/survival/hug/black/nt_police/laser/PopulateContents()
	new /obj/item/gun/energy/e_gun/nuclear(src)
	new /obj/item/gun/energy/ionrifle/carbine(src)

/*
		S.W.A.T ammunition
*/

/obj/item/storage/box/survival/hug/black/nt_swat/revolver/PopulateContents()
	new /obj/item/gun/ballistic/revolver/c38(src)
	new /obj/item/ammo_box/c38(src)
	new /obj/item/ammo_box/c38(src)
	new /obj/item/ammo_box/c38(src)
	new /obj/item/storage/belt/holster(src)

/obj/item/storage/box/survival/hug/black/nt_swat/smg/PopulateContents()
	new /obj/item/gun/ballistic/automatic/wt550(src)
	new /obj/item/ammo_box/magazine/wt550m9(src)
	new /obj/item/ammo_box/magazine/wt550m9(src)
	new /obj/item/ammo_box/magazine/wt550m9(src)
	new /obj/item/storage/pouch/ammo(src)

/obj/item/storage/box/survival/hug/black/nt_swat/medic/PopulateContents()
	new /obj/item/gun/energy/laser/scatter/shotty(src)
	new /obj/item/storage/medkit/tactical(src)
	new /obj/item/storage/belt/medical/ert(src)
	new /obj/item/reagent_containers/hypospray/combat(src)

/obj/item/storage/box/survival/hug/black/nt_swat/laser/PopulateContents()
	new /obj/item/gun/energy/e_gun(src)

/obj/item/choice_beacon/nt_police/generate_display_names()
	var/static/list/selectable_builds = list(
		"Officer" = /obj/item/storage/box/survival/hug/black/nt_police/revolver,
		"Trooper" = /obj/item/storage/box/survival/hug/black/nt_police/smg,
		"Laserguner" = /obj/item/storage/box/survival/hug/black/nt_police/laser,
		"Medic" = /obj/item/storage/box/survival/hug/black/nt_police/medic,
	)
	return selectable_builds

/obj/item/choice_beacon/nt_swat/generate_display_names()
	var/static/list/selectable_builds = list(
		"Officer" = /obj/item/storage/box/survival/hug/black/nt_swat/revolver,
		"Trooper" = /obj/item/storage/box/survival/hug/black/nt_swat/smg,
		"Laserguner" = /obj/item/storage/box/survival/hug/black/nt_swat/laser,
		"Medic" = /obj/item/storage/box/survival/hug/black/nt_swat/medic,
	)
	return selectable_builds

/datum/id_trim/centcom/ert/security/NT_police/New()
	. = ..()
	assignment = "NTIS Police"
	access = SSid_access.get_region_access_list(list(REGION_CENTCOM, REGION_ALL_STATION))

/datum/id_trim/centcom/ert/security/NT_police/swat/New()
	. = ..()
	assignment = "NTIS S.W.A.T."

/datum/id_trim/centcom/ert/security/NT_police/trooper/New()
	. = ..()
	assignment = "NTIS Trooper"

/obj/item/card/id/advanced/centcom/ert/NT_police
	registered_name = "NT Internal Security"
	trim = /datum/id_trim/centcom/ert/security/NT_police

/obj/item/card/id/advanced/centcom/ert/NT_police/swat
	trim = /datum/id_trim/centcom/ert/security/NT_police/swat

/obj/item/card/id/advanced/centcom/ert/NT_police/trooper
	trim = /datum/id_trim/centcom/ert/security/NT_police/trooper

/datum/outfit/NT_police
	name = "NT Internal Security: Base"
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses
	box = /obj/item/storage/box/survival/centcom
	back = /obj/item/storage/backpack/security
	ears = /obj/item/radio/headset/headset_cent/commander

/datum/outfit/NT_police/post_equip(mob/living/carbon/human/human_to_equip, visualsOnly = FALSE)
	if(visualsOnly)
		return

	var/obj/item/implant/mindshield/mindshield = new /obj/item/implant/mindshield(human_to_equip)//hmm lets have centcom officials become revs
	mindshield.implant(human_to_equip, null, silent = TRUE)

	var/obj/item/card/id/ID_to_give = human_to_equip.wear_id
	if(istype(ID_to_give))
		shuffle_inplace(ID_to_give.access)
		ID_to_give.registered_name = human_to_equip.real_name
		if(human_to_equip.age)
			ID_to_give.registered_age = human_to_equip.age
		ID_to_give.update_label()
		ID_to_give.update_icon()
		human_to_equip.sec_hud_set_ID()

/datum/outfit/NT_police/regular
	name = "NTIS Unit Regular"
	gloves = /obj/item/clothing/gloves/tackler/combat

	uniform = /obj/item/clothing/under/rank/security/officer
	suit = /obj/item/clothing/suit/armor/vest/marine
	head = /obj/item/clothing/head/hats/warden/police/patrol

	shoes = /obj/item/clothing/shoes/combat
	belt = /obj/item/melee/baton/security/loaded
	id = /obj/item/card/id/advanced/centcom/ert/NT_police

	backpack_contents = list(
		/obj/item/storage/box/handcuffs = 1,
		/obj/item/nt_reporter/swat_caller = 1,
		/obj/item/beamout_tool_nt = 1,
		/obj/item/melee/baton/telescopic = 1,
		/obj/item/storage/medkit/tactical = 1,
	)
	r_pocket = /obj/item/flashlight/seclite
	l_pocket = /obj/item/restraints/handcuffs
	l_hand = /obj/item/gun/energy/disabler/smg

/datum/outfit/NT_police/swat
	name = "NTIS S.W.A.T. Officer"
	id = /obj/item/card/id/advanced/centcom/ert/NT_police/swat
	gloves = /obj/item/clothing/gloves/combat

	uniform = /obj/item/clothing/under/rank/security/officer
	head = /obj/item/clothing/head/helmet/sf_sacrificial
	mask = /obj/item/clothing/mask/gas/nri_police
	suit = /obj/item/clothing/suit/armor/vest/marine/security

	belt = /obj/item/gun/energy/disabler
	shoes = /obj/item/clothing/shoes/combat

	backpack_contents = list(
		/obj/item/storage/box/handcuffs = 1,
		/obj/item/melee/baton/security/loaded = 1,
		/obj/item/nt_reporter/trooper_caller = 1,
		/obj/item/beamout_tool_nt = 1,
		/obj/item/choice_beacon/nt_swat = 1,
		/obj/item/shield/riot/tele = 1,
	)
	r_pocket = /obj/item/flashlight/seclite
	l_pocket = /obj/item/restraints/handcuffs

/datum/outfit/NT_police/trooper
	name = "NTIS Trooper"
	id = /obj/item/card/id/advanced/centcom/ert/NT_police/trooper

	uniform = /obj/item/clothing/under/sol_peacekeeper
	head = /obj/item/clothing/head/helmet/sf_sacrificial
	mask = /obj/item/clothing/mask/gas/alt
	suit = /obj/item/clothing/suit/armor/sf_sacrificial

	gloves = /obj/item/clothing/gloves/combat
	shoes = /obj/item/clothing/shoes/jackboots

	backpack_contents = list(
		/obj/item/storage/box/handcuffs = 1,
		/obj/item/sacrificial_face_shield = 1,
		/obj/item/melee/baton/security/loaded = 1,
		/obj/item/choice_beacon/nt_police = 1,
		/obj/item/shield/riot/tele = 1,
	)
	l_pocket = /obj/item/restraints/handcuffs
	r_pocket = /obj/item/flashlight/seclite

/obj/item/nt_reporter
	name = "NanoTrasen reporter"
	desc = "Use this in-hand to vote to call NanoTrasen backup. If half your team votes for it, SWAT will be dispatched."
	icon = 'modular_nova/modules/goofsec/icons/reporter.dmi'
	icon_state = "reporter_off"
	w_class = WEIGHT_CLASS_SMALL
	var/activated = FALSE
	var/type_to_check = /datum/antagonist/ert/NT_police/regular
	var/type_of_callers = "NT_police_regular"
	var/announcement_source = "NanoTrasen Internal Security"
	var/ghost_poll_msg = "example crap"
	var/amount_to_summon = 5
	var/type_to_summon = /datum/antagonist/ert/NT_police/swat
	var/summoned_type = "NTIS S.W.A.T."
	var/jobban_to_check = ROLE_DEATHSQUAD
	var/announcement_message = "Well..."
	var/sound_nt = 'tff_modular/modules/police_nt/nt_police_second.ogg'

/obj/item/nt_reporter/proc/pre_checks(mob/user)
	if(!user.mind.has_antag_datum(type_to_check))
		to_chat(user, span_warning("You don't know how to use this!"))
		return FALSE
	return TRUE

/obj/item/nt_reporter/proc/questions(mob/user)
	return TRUE

/obj/item/nt_reporter/attack_self(mob/user, modifiers)
	. = ..()
	if(!pre_checks(user))
		return
	if(!activated && !GLOB.NT_police_responder_info[type_of_callers][NT_POLICE_DECLARED])
		if(!questions(user))
			return
		activated = TRUE
		icon_state = "reporter_on"
		GLOB.NT_police_responder_info[type_of_callers][NT_POLICE_VOTES]++
		var/current_votes = GLOB.NT_police_responder_info[type_of_callers][NT_POLICE_VOTES]
		var/amount_of_responders = GLOB.NT_police_responder_info[type_of_callers][NT_POLICE_AMT]
		to_chat(user, span_warning("You have activated the device. \
		Current Votes: [current_votes]/[amount_of_responders] votes."))
		if(current_votes >= amount_of_responders * 0.5)
			GLOB.NT_police_responder_info[type_of_callers][NT_POLICE_DECLARED] = TRUE

			priority_announce(announcement_message, announcement_source, sound_nt, has_important_message = TRUE, color_override = "yellow")
			var/list/candidates = SSpolling.poll_ghost_candidates(
				ghost_poll_msg,
				check_jobban = jobban_to_check,
				pic_source = /obj/item/nt_reporter,
				role_name_text = summoned_type,
			)

			if(length(candidates))
				//Pick the (un)lucky players
				var/agents_number = min(amount_to_summon, candidates.len)
				GLOB.NT_police_responder_info[summoned_type][NT_POLICE_AMT] = agents_number

				var/list/spawnpoints = GLOB.emergencyresponseteamspawn
				var/index = 0
				while(agents_number && candidates.len)
					var/spawn_loc = spawnpoints[index + 1]
					index = (index + 1) % spawnpoints.len
					var/mob/dead/observer/chosen_candidate = pick(candidates)
					candidates -= chosen_candidate
					if(!chosen_candidate.key)
						continue

					var/mob/living/carbon/human/cop = new(spawn_loc)
					chosen_candidate.client.prefs.safe_transfer_prefs_to(cop, is_antag = TRUE)
					cop.key = chosen_candidate.key

					var/datum/antagonist/ert/NT_police/ert_antag = type_to_summon
					cop.mind.add_antag_datum(ert_antag)
					cop.mind.set_assigned_role(SSjob.GetJobType(ert_antag.ert_job_path))
					cop.grant_language(/datum/language/common, source = LANGUAGE_SPAWNER)
					//Logging and cleanup
					log_game("[key_name(cop)] has been selected as an [ert_antag.name]")
					agents_number--

/obj/item/nt_reporter/swat_caller
	name = "S.W.A.T. backup caller"
	desc = "Use this in-hand to vote to call NanoTrasen S.W.A.T. backup. If half your team votes for it, SWAT will be dispatched."
	type_to_check = /datum/antagonist/ert/NT_police/regular
	type_of_callers = "NT_police_regular"
	ghost_poll_msg = "The NTIS have requested a S.W.A.T. backup. Do you wish to become a S.W.A.T. member?"
	amount_to_summon = 5
	type_to_summon = /datum/antagonist/ert/NT_police/swat
	summoned_type = "NT_police_swat"
	sound_nt = 'tff_modular/modules/police_nt/nt_police_second.ogg'
	announcement_message = "Attention, crew.\nNTIS Police have requested S.W.A.T. backup. Please comply with all requests by special squad members."

/obj/item/nt_reporter/swat_caller/questions(mob/user)
	var/question = "Does the situation require additional S.W.A.T. backup, involve the station impeding you from doing your job, \
		or involve the station making a fraudulent NTIS call and needing an arrest made on the caller?"
	if(tgui_input_list(user, question, "S.W.A.T. Backup Caller", list("Yes", "No")) != "Yes")
		to_chat(user, "You decide not to request S.W.A.T. backup.")
		return FALSE
	message_admins("[ADMIN_LOOKUPFLW(user)] has voted to summon S.W.A.T backup.")
	return TRUE

/obj/item/nt_reporter/trooper_caller
	name = "Guard backup caller"
	desc = "Use this in-hand to vote that the station is engaging in Treason. If half your team votes for it, the Military will handle the situation."
	type_to_check = /datum/antagonist/ert/NT_police/swat
	type_of_callers = "NT_police_swat"
	ghost_poll_msg = "The station has decided to engage in treason. Do you wish to join the NanoTrasen Military?"
	amount_to_summon = 8
	type_to_summon = /datum/antagonist/ert/NT_police/trooper
	summoned_type = "NT_police_trooper"
	sound_nt = 'tff_modular/modules/police_nt/nt_police_third.ogg'
	announcement_message = "Attention, crew.\nYou are accused of corporate treason. Lay down your weapons and surrender. Follow all the orders of the NanoTrasen response team. The perpetrators of corporate betrayal will be punished at the greatest extent."

/obj/item/nt_reporter/trooper_caller/questions(mob/user)
	var/list/list_of_questions = list(
		"Treason is the crime of attacking a state authority to which one owes allegiance. The station is located within Sol Federation space, \
			and owes allegiance to the Sol Federation despite being owned by Nanotrasen. Did the station engage in this today?",
		"Did station crewmembers assault you or the SWAT team at the direction of Security and/or Command?",
		"Did station crewmembers actively prevent you and the SWAT team from accomplishing your objectives at the direction of Security and/or Command?",
		"Were you and your fellow SWAT members unable to handle the issue on your own?",
		"Are you absolutely sure you wish to declare the station as engaging in Treason? Misuse of this can and will result in \
			administrative action against your account."
	)
	for(var/question in list_of_questions)
		if(tgui_input_list(user, question, "Treason Reporter", list("Yes", "No")) != "Yes")
			to_chat(user, "You decide not to declare the station as treasonous.")
			return FALSE
	message_admins("[ADMIN_LOOKUPFLW(user)] has acknowledged the consequences of a false claim of Treason administratively, \
		and has voted that the station is engaging in Treason.")
	return TRUE

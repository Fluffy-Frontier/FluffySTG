/datum/outfit/NT_police
	name = "NT Internal Security: Base"
	back = /obj/item/storage/backpack/duffelbag/cops
	backpack_contents = list(/obj/item/solfed_reporter/swat_caller = 1)

/datum/outfit/NT_police/post_equip(mob/living/carbon/human/human_to_equip, visualsOnly = FALSE)
	if(visualsOnly)
		return

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

	back = /obj/item/storage/backpack/security
	gloves = /obj/item/clothing/gloves/tackler/combat
	uniform = /obj/item/clothing/under/rank/security/officer

	suit = /obj/item/clothing/suit/armor/vest/marine
	shoes = /obj/item/clothing/shoes/combat
	glasses = /obj/item/clothing/glasses/sunglasses
	ears = /obj/item/radio/headset/headset_cent/commander
	head = /obj/item/clothing/head/hats/warden/police/patrol

	belt = /obj/item/melee/baton/security/loaded
	r_pocket = /obj/item/flashlight/seclite
	l_pocket = /obj/item/restraints/handcuffs
	id = /obj/item/card/id/advanced/centcom/ert/security

	//id_trim = /datum/id_trim/centcom/naval/ltcr

	backpack_contents = list(
		/obj/item/storage/box/survival = 1,
		/obj/item/storage/box/handcuffs = 1,
		/obj/item/solfed_reporter/swat_caller = 1,
		/obj/item/beamout_tool = 1,
	)

	l_hand = /obj/item/gun/energy/disabler/smg

/datum/outfit/NT_police/condom_destroyer
	name = "NTIS S.W.A.T. Officer"
	back = /obj/item/storage/backpack/security

	gloves = /obj/item/clothing/gloves/combat
	uniform = /obj/item/clothing/under/rank/security/officer
	shoes = /obj/item/clothing/shoes/combat
	glasses = /obj/item/clothing/glasses/sunglasses
	ears = /obj/item/radio/headset/headset_cent/commander

	head = /obj/item/clothing/head/helmet/sf_sacrificial
	mask = /obj/item/clothing/mask/gas/nri_police

	belt = /obj/item/gun/energy/disabler

	suit = /obj/item/clothing/suit/armor/vest/marine/security

	r_pocket = /obj/item/flashlight/seclite
	l_pocket = /obj/item/restraints/handcuffs
	id = /obj/item/card/id/advanced/centcom/ert/security
	id_trim = /datum/id_trim/centcom/naval/ltcr
	l_hand = /obj/item/gun/ballistic/shotgun/riot/sol
	backpack_contents = list(
		/obj/item/storage/box/survival = 1,
		/obj/item/storage/box/handcuffs = 1,
		/obj/item/melee/baton/security/loaded = 1,
		/obj/item/storage/box/lethalshot = 2,
		/obj/item/solfed_reporter/treason_reporter = 1,
		/obj/item/beamout_tool = 1,
	)

/datum/outfit/NT_police/treason_destroyer
	name = "NTIS Military"

	uniform = /obj/item/clothing/under/sol_peacekeeper
	head = /obj/item/clothing/head/helmet/sf_sacrificial
	mask = /obj/item/clothing/mask/gas/alt
	gloves = /obj/item/clothing/gloves/combat
	suit = /obj/item/clothing/suit/armor/sf_sacrificial
	shoes = /obj/item/clothing/shoes/jackboots

	back = /obj/item/storage/backpack
	glasses = /obj/item/clothing/glasses/sunglasses
	ears = /obj/item/radio/headset/headset_sec/alt
	l_pocket = /obj/item/restraints/handcuffs
	r_pocket = /obj/item/flashlight/seclite
	id = /obj/item/card/id/advanced/solfed
	r_hand = /obj/item/gun/ballistic/automatic/sol_rifle
	backpack_contents = list(
		/obj/item/storage/box/handcuffs = 1,
		/obj/item/sacrificial_face_shield = 1,
		/obj/item/melee/baton/security/loaded = 1,
		/obj/item/ammo_box/magazine/c40sol_rifle/standard = 4,
	)
	id_trim = /datum/id_trim/solfed

/obj/item/nt_reporter
	name = "NanoTrasen reporter"
	desc = "Use this in-hand to vote to call NanoTrasen backup. If half your team votes for it, SWAT will be dispatched."
	icon = 'modular_nova/modules/goofsec/icons/reporter.dmi'
	icon_state = "reporter_off"
	w_class = WEIGHT_CLASS_SMALL
	var/activated = FALSE
	var/type_to_check = /datum/antagonist/ert/NT_police
	var/type_of_callers = "NT_police_regular"
	var/announcement_source = "NanoTrasen S.W.A.T."
	var/fine_station = FALSE
	var/ghost_poll_msg = "example crap"
	var/amount_to_summon = 5
	var/type_to_summon = /datum/antagonist/ert/NT_police/condom_destroyer
	var/summoned_type = "NT_police_swat"
	var/jobban_to_check = ROLE_DEATHSQUAD
	var/announcement_message = "Well..."

/obj/item/nt_reporter/proc/pre_checks(mob/user)
	if(GLOB.NT_police_responder_info[type_of_callers][NT_POLICE_AMT == 0])
		to_chat(user, span_warning("There are no responders. You likely spawned this in as an admin. Please don't do this."))
		return FALSE
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

			priority_announce(announcement_message, announcement_source, 'sound/effects/families_police.ogg', has_important_message = TRUE, color_override = "yellow")
			var/list/candidates = SSpolling.poll_ghost_candidates(
				ghost_poll_msg,
				jobban_to_check,
				pic_source = /obj/item/nt_reporter,
				role_name_text = summoned_type,
			)

			if(candidates.len)
				//Pick the (un)lucky players
				var/agents_number = min(amount_to_summon, candidates.len)
				GLOB.NT_police_responder_info[summoned_type][NT_POLICE_AMT] = agents_number

				var/list/spawnpoints = GLOB.emergencyresponseteamspawn
				var/index = 0
				while(agents_number && candidates.len)
					var/spawn_loc = spawnpoints[index + 1]
					//loop through spawnpoints one at a time
					index = (index + 1) % spawnpoints.len
					var/mob/dead/observer/chosen_candidate = pick(candidates)
					candidates -= chosen_candidate
					if(!chosen_candidate.key)
						continue

					//Spawn the body
					var/mob/living/carbon/human/cop = new(spawn_loc)
					chosen_candidate.client.prefs.safe_transfer_prefs_to(cop, is_antag = TRUE)
					cop.key = chosen_candidate.key

					//Give antag datum
					var/datum/antagonist/ert/NT_police/ert_antag = new type_to_summon

					cop.mind.add_antag_datum(ert_antag)
					cop.mind.set_assigned_role(SSjob.GetJobType(ert_antag.ert_job_path))
					SSjob.SendToLateJoin(cop)
					cop.grant_language(/datum/language/common, source = LANGUAGE_SPAWNER)
					//Logging and cleanup
					log_game("[key_name(cop)] has been selected as an [ert_antag.name]")
					agents_number--

/obj/item/nt_reporter/swat_caller
	name = "S.W.A.T. backup caller"
	desc = "Use this in-hand to vote to call SolFed S.W.A.T. backup. If half your team votes for it, SWAT will be dispatched."
	type_to_check = /datum/antagonist/ert/NT_police/regular
	type_of_callers = "NT_police_regular"
	announcement_source = "Sol Federation S.W.A.T."
	fine_station = TRUE
	ghost_poll_msg = "The Sol-Fed NTIS services have requested a S.W.A.T. backup. Do you wish to become a S.W.A.T. member?"
	amount_to_summon = 6
	type_to_summon = /datum/antagonist/ert/NT_police/condom_destroyer
	summoned_type = "NT_police_swat"
	announcement_message = "Hello, crewmembers. Our emergency services have requested S.W.A.T. backup, either for assistance doing their job due to crew \
		impediment, or due to a fraudulent NTIS call. We have billed the station $20,000 for this, to cover the expenses of flying a second emergency response to \
		your station. Please comply with all requests by said S.W.A.T. members."

/obj/item/nt_reporter/swat_caller/questions(mob/user)
	var/question = "Does the situation require additional S.W.A.T. backup, involve the station impeding you from doing your job, \
		or involve the station making a fraudulent NTIS call and needing an arrest made on the caller?"
	if(tgui_input_list(user, question, "S.W.A.T. Backup Caller", list("Yes", "No")) != "Yes")
		to_chat(user, "You decide not to request S.W.A.T. backup.")
		return FALSE
	message_admins("[ADMIN_LOOKUPFLW(user)] has voted to summon S.W.A.T backup.")
	return TRUE

/obj/item/nt_reporter/treason_reporter
	name = "treason reporter"
	desc = "Use this in-hand to vote that the station is engaging in Treason. If half your team votes for it, the Military will handle the situation."
	type_to_check = /datum/antagonist/ert/NT_police/condom_destroyer
	type_of_callers = "NT_police_swat"
	announcement_source = "Sol Federation National Guard"
	fine_station = FALSE
	ghost_poll_msg = "The station has decided to engage in treason. Do you wish to join the Sol Federation Military?"
	amount_to_summon = 12
	type_to_summon = /datum/antagonist/ert/NT_police/treason_destroyer
	summoned_type = "national_guard"
	announcement_message = "Crewmembers of the station. You have refused to comply with first responders and SWAT officers, and have assaulted them, \
		and they are unable to carry out the wills of the Sol Federation, despite residing within Sol Federation borders.\n\
		As such, we are charging those responsible with Treason. The penalty of which is death, or no less than twenty-five years in Superjail.\n\
		Treason is a serious crime. Our military forces are en route to your station. They will be assuming direct control of the station, and \
		will be evacuating civilians from the scene.\n\
		Non-offending citizens, prepare for evacuation. Comply with all orders given to you by Sol Federation military personnel.\n\
		To all those who are engaging in treason, lay down your weapons and surrender. Refusal to comply may be met with lethal force."

/obj/item/nt_reporter/treason_reporter/questions(mob/user)
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

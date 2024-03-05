/datum/antagonist/ert/NT_police
	name = "NTIS Unit"
	antag_hud_name = "hud_spacecop"
	suicide_cry = "FOR THE TRASEN!!"

/datum/antagonist/ert/NT_police/apply_innate_effects(mob/living/mob_override)
	..()
	var/mob/living/M = mob_override || owner.current
	if(M.hud_used)
		var/datum/hud/H = M.hud_used
		var/atom/movable/screen/wanted/giving_wanted_lvl = new /atom/movable/screen/wanted(null, H)
		H.wanted_lvl = giving_wanted_lvl
		H.infodisplay += giving_wanted_lvl
		H.mymob.client.screen += giving_wanted_lvl

/datum/antagonist/ert/NT_police/remove_innate_effects(mob/living/mob_override)
	var/mob/living/M = mob_override || owner.current
	if(M.hud_used)
		var/datum/hud/H = M.hud_used
		H.infodisplay -= H.wanted_lvl
		QDEL_NULL(H.wanted_lvl)
	..()

/datum/outfit/NT_police
	name = "NT Internal Security: Base"
	back = /obj/item/storage/backpack/duffelbag/cops
	backpack_contents = list(/obj/item/solfed_reporter/swat_caller = 1)

	id_trim = /datum/id_trim/space_police

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

/*
*	POLICE
*/

/datum/antagonist/ert/NT_police/regular
	name = "NTIS Unit"
	role = "NTIS Unit"
	outfit = /datum/outfit/NT_police/regular

/datum/antagonist/ert/NT_police/greet()
	var/missiondesc =  ""
	missiondesc += "<B><font size=5 color=red>You are NOT a Nanotrasen Employee. You work for the Sol Federation as a [role].</font></B>"
	missiondesc += "<BR>You are responding to emergency calls from the station for immediate SolFed assistance!\n"
	missiondesc += "<BR>Use the Cell Phone in your backpack to confer with fellow first responders!\n"
	missiondesc += "<BR><B>NTIS Transcript is as follows</B>:"
	missiondesc += "<BR> [GLOB.call_NTIS_msg]"
	missiondesc += "<BR><B>Your Mission</B>:"
	missiondesc += "<BR> <B>1.</B> Contact [GLOB.caller_of_NTIS] and assist them in resolving the matter."
	missiondesc += "<BR> <B>2.</B> Protect, ensure, and uphold the rights of Sol Federation citizens on board [station_name()]."
	missiondesc += "<BR> <B>3.</B> If you believe yourself to be in danger, unable to do the job assigned to you due to a dangerous situation, \
		or that the NTIS call was made in error, you can use the S.W.A.T. Backup Caller in your backpack to vote on calling a S.W.A.T. team to assist in the situation."
	missiondesc += "<BR> <B>4.</B> When you have finished with your work on the station, use the Beamout Tool in your backpack to beam out yourself \
		along with anyone you are pulling."
	to_chat(owner, missiondesc)
	var/mob/living/greeted_mob = owner.current
	greeted_mob.playsound_local(greeted_mob, 'sound/effects/families_police.ogg', 100, FALSE, pressure_affected = FALSE, use_reverb = FALSE)


/datum/outfit/NT_police/regular
	name = "NTIS Unit: regular"

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

	backpack_contents = list(
		/obj/item/storage/box/survival = 1,
		/obj/item/storage/box/handcuffs = 1,
		/obj/item/solfed_reporter/swat_caller = 1,
		/obj/item/beamout_tool = 1,
	)

	l_hand = /obj/item/gun/energy/disabler/smg


/datum/antagonist/ert/NT_police/condom_destroyer
	name = "NTIS S.W.A.T. Officer"
	role = "S.W.A.T. Officer"
	outfit = /datum/outfit/NT_police/condom_destroyer

/datum/antagonist/ert/NT_police/condom_destroyer/greet()
	var/missiondesc =  ""
	missiondesc += "<B><font size=5 color=red>You are NOT a Nanotrasen Employee. You work for the Sol Federation as a [role].</font></B>"
	missiondesc += "<BR>You are here to backup the NTIS first responders, as they have reported for your assistance..\n"
	missiondesc += "<BR><B>Your Mission</B>:"
	missiondesc += "<BR> <B>1.</B> Contact the first responders using the Cell Phone in your backpack to figure out the situation."
	missiondesc += "<BR> <B>2.</B> Arrest anyone who interferes the work of the first responders."
	missiondesc += "<BR> <B>3.</B> Use lethal force in the arrest of the suspects if they will not comply, or the station refuses to comply."
	missiondesc += "<BR> <B>4.</B> If you believe the station is engaging in treason and is firing upon first responders and S.W.A.T. members, use the \
		Treason Reporter in your backpack to call the military."
	missiondesc += "<BR> <B>5.</B> When you have finished with your work on the station, use the Beamout Tool in your backpack to beam out yourself \
		along with anyone you are pulling."
	to_chat(owner, missiondesc)
	var/mob/living/greeted_mob = owner.current
	greeted_mob.playsound_local(greeted_mob, 'sound/effects/families_police.ogg', 100, FALSE, pressure_affected = FALSE, use_reverb = FALSE)

/datum/outfit/NT_police/condom_destroyer
	name = "NTIS S.W.A.T. Officer"
	back = /obj/item/storage/backpack
	uniform = /obj/item/clothing/under/sol_peacekeeper
	shoes = /obj/item/clothing/shoes/jackboots
	glasses = /obj/item/clothing/glasses/sunglasses
	ears = /obj/item/radio/headset/headset_sec/alt
	head = /obj/item/clothing/head/helmet/sf_peacekeeper
	belt = /obj/item/gun/energy/disabler
	suit = /obj/item/clothing/suit/armor/sf_peacekeeper
	r_pocket = /obj/item/flashlight/seclite
	l_pocket = /obj/item/restraints/handcuffs
	id = /obj/item/card/id/advanced/solfed
	l_hand = /obj/item/gun/ballistic/shotgun/riot/sol
	backpack_contents = list(
		/obj/item/storage/box/survival = 1,
		/obj/item/storage/box/handcuffs = 1,
		/obj/item/melee/baton/security/loaded = 1,
		/obj/item/storage/box/lethalshot = 2,
		/obj/item/solfed_reporter/treason_reporter = 1,
		/obj/item/beamout_tool = 1,
	)

	id_trim = /datum/id_trim/solfed

/datum/antagonist/ert/NT_police/treason_destroyer
	name = "NTIS Military"
	role = "Private"
	outfit = /datum/outfit/NT_police/treason_destroyer

/datum/antagonist/ert/NT_police/treason_destroyer/greet()
	var/missiondesc =  ""
	missiondesc += "<B><font size=5 color=red>You are NOT a Nanotrasen Employee. You work for the Sol Federation as a [role].</font></B>"
	missiondesc += "<BR>You are here to assume control of [station_name()] due to the occupants engaging in Treason as reported by our SWAT team.\n"
	missiondesc += "<BR><B>Your Mission</B>:"
	missiondesc += "<BR> <B>1.</B> Contact the SWAT Team and the First Responders via your cell phone to get the situation from them."
	missiondesc += "<BR> <B>2.</B> Arrest all suspects involved in the treason attempt."
	missiondesc += "<BR> <B>3.</B> Assume control of the station for the Sol Federation, and initiate evacuation procedures to get non-offending citizens \
		away from the scene."
	missiondesc += "<BR> <B>4.</B> If you need to use lethal force, do so, but only if you must."
	to_chat(owner, missiondesc)
	var/mob/living/greeted_mob = owner.current
	greeted_mob.playsound_local(greeted_mob, 'sound/effects/families_police.ogg', 100, FALSE, pressure_affected = FALSE, use_reverb = FALSE)

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


/*
/obj/item/solfed_reporter
	name = "SolFed reporter"
	desc = "Use this in-hand to vote to call SolFed backup. If half your team votes for it, SWAT will be dispatched."
	icon = 'modular_nova/modules/goofsec/icons/reporter.dmi'
	icon_state = "reporter_off"
	w_class = WEIGHT_CLASS_SMALL
	/// Was the reporter turned on?
	var/activated = FALSE
	/// What antagonist should be required to use the reporter?
	var/type_to_check = /datum/antagonist/ert/NT_police
	/// What table should we be incrementing votes in and checking against in the solfed responders global?
	var/type_of_callers = "NTIS_responders"
	/// What source should be supplied for the announcement message?
	var/announcement_source = "Sol Federation S.W.A.T."
	/// Should the station be issued a fine when the vote completes?
	var/fine_station = TRUE
	/// What poll message should we show to the ghosts when they are asked to join the squad?
	var/ghost_poll_msg = "example crap"
	/// How many ghosts should we pick from the applicants to become members of the squad?
	var/amount_to_summon = 4
	/// What antagonist type should we give to the ghosts?
	var/type_to_summon = /datum/antagonist/ert/NT_police/condom_destroyer
	/// What table should be be incrementing amount in in the solfed responders global?
	var/summoned_type = "swat"
	/// What name and ID should be on the cell phone given to the squad members?
	var/cell_phone_number = "NTIS"
	/// What jobban should we be checking for the ghost polling?
	var/jobban_to_check = ROLE_DEATHSQUAD
	/// What announcement message should be displayed if the vote succeeds?
	var/announcement_message = "Example announcement message"

/obj/item/solfed_reporter/proc/pre_checks(mob/user)
	if(GLOB.solfed_responder_info[type_of_callers][SOLFED_AMT] == 0)
		to_chat(user, span_warning("There are no responders. You likely spawned this in as an admin. Please don't do this."))
		return FALSE
	if(!user.mind.has_antag_datum(type_to_check))
		to_chat(user, span_warning("You don't know how to use this!"))
		return FALSE
	return TRUE

/obj/item/solfed_reporter/proc/questions(mob/user)
	return TRUE

/obj/item/solfed_reporter/attack_self(mob/user, modifiers)
	. = ..()
	if(!pre_checks(user))
		return
	if(!activated && !GLOB.solfed_responder_info[type_of_callers][SOLFED_DECLARED])
		if(!questions(user))
			return
		activated = TRUE
		icon_state = "reporter_on"
		GLOB.solfed_responder_info[type_of_callers][SOLFED_VOTES]++
		var/current_votes = GLOB.solfed_responder_info[type_of_callers][SOLFED_VOTES]
		var/amount_of_responders = GLOB.solfed_responder_info[type_of_callers][SOLFED_AMT]
		to_chat(user, span_warning("You have activated the device. \
		Current Votes: [current_votes]/[amount_of_responders] votes."))
		if(current_votes >= amount_of_responders * 0.5)
			GLOB.solfed_responder_info[type_of_callers][SOLFED_DECLARED] = TRUE
			if(fine_station)
				var/datum/bank_account/station_balance = SSeconomy.get_dep_account(ACCOUNT_CAR)

			priority_announce(announcement_message, announcement_source, 'sound/effects/families_police.ogg', has_important_message = TRUE, color_override = "yellow")
			var/list/candidates = SSpolling.poll_ghost_candidates(
				ghost_poll_msg,
				jobban_to_check,
				pic_source = /obj/item/solfed_reporter,
				role_name_text = summoned_type,
			)

			if(candidates.len)
				//Pick the (un)lucky players
				var/agents_number = min(amount_to_summon, candidates.len)
				GLOB.solfed_responder_info[summoned_type][SOLFED_AMT] = agents_number

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

					var/obj/item/gangster_cellphone/phone = new() // biggest gang in the city
					phone.gang_id = cell_phone_number
					phone.name = "[cell_phone_number] branded cell phone"
					var/phone_equipped = phone.equip_to_best_slot(cop)
					if(!phone_equipped)
						to_chat(cop, "Your [phone.name] has been placed at your feet.")
						phone.forceMove(get_turf(cop))

					//Logging and cleanup
					log_game("[key_name(cop)] has been selected as an [ert_antag.name]")
					agents_number--

/obj/item/solfed_reporter/swat_caller
	name = "S.W.A.T. backup caller"
	desc = "Use this in-hand to vote to call SolFed S.W.A.T. backup. If half your team votes for it, SWAT will be dispatched."
	type_to_check = /datum/antagonist/ert/NT_police
	type_of_callers = "NTIS_responders"
	announcement_source = "Sol Federation S.W.A.T."
	fine_station = TRUE
	ghost_poll_msg = "The Sol-Fed NTIS services have requested a S.W.A.T. backup. Do you wish to become a S.W.A.T. member?"
	amount_to_summon = 6
	type_to_summon = /datum/antagonist/ert/NT_police/condom_destroyer
	summoned_type = "swat"
	announcement_message = "Hello, crewmembers. Our emergency services have requested S.W.A.T. backup, either for assistance doing their job due to crew \
		impediment, or due to a fraudulent NTIS call. We have billed the station $20,000 for this, to cover the expenses of flying a second emergency response to \
		your station. Please comply with all requests by said S.W.A.T. members."

/obj/item/solfed_reporter/swat_caller/questions(mob/user)
	var/question = "Does the situation require additional S.W.A.T. backup, involve the station impeding you from doing your job, \
		or involve the station making a fraudulent NTIS call and needing an arrest made on the caller?"
	if(tgui_input_list(user, question, "S.W.A.T. Backup Caller", list("Yes", "No")) != "Yes")
		to_chat(user, "You decide not to request S.W.A.T. backup.")
		return FALSE
	message_admins("[ADMIN_LOOKUPFLW(user)] has voted to summon S.W.A.T backup.")
	return TRUE

/obj/item/solfed_reporter/treason_reporter
	name = "treason reporter"
	desc = "Use this in-hand to vote that the station is engaging in Treason. If half your team votes for it, the Military will handle the situation."
	type_to_check = /datum/antagonist/ert/NT_police/condom_destroyer
	type_of_callers = "swat"
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

/obj/item/solfed_reporter/treason_reporter/questions(mob/user)
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

/obj/item/beamout_tool
	name = "beam-out tool" // TODO, find a way to make this into drop pods cuz that's cooler visually
	desc = "Use this to begin the lengthy beam-out  process to return to Sol Federation space. It will bring anyone you are pulling with you."
	icon = 'modular_nova/modules/goofsec/icons/reporter.dmi'
	icon_state = "beam_me_up_scotty"
	w_class = WEIGHT_CLASS_SMALL

/obj/item/beamout_tool/attack_self(mob/user, modifiers)
	. = ..()
	if(!user.mind.has_antag_datum(/datum/antagonist/ert))
		to_chat(user, span_warning("You don't understand how to use this device."))
		return
	message_admins("[ADMIN_LOOKUPFLW(user)] has begun to beam-out using their beam-out tool.")
	to_chat(user, "You have begun the beam-out process. Please wait for the beam to reach the station.")
	user.balloon_alert(user, "begun beam-out")
	if(do_after(user, 30 SECONDS))
		to_chat(user, "You have completed the beam-out process and are returning to the Sol Federation.")
		message_admins("[ADMIN_LOOKUPFLW(user)] has beamed themselves out.")
		if(isliving(user))
			var/mob/living/living_user = user
			if(living_user.pulling)
				if(ishuman(living_user.pulling))
					var/mob/living/carbon/human/beamed_human = living_user.pulling
					message_admins("[ADMIN_LOOKUPFLW(user)] has beamed out [ADMIN_LOOKUPFLW(beamed_human)] alongside them.")
				else
					message_admins("[ADMIN_LOOKUPFLW(user)] has beamed out [living_user.pulling] alongside them.")
				var/turf/pulling_turf = get_turf(living_user.pulling)
				playsound(pulling_turf, 'sound/magic/Repulse.ogg', 100, 1)
				var/datum/effect_system/spark_spread/quantum/sparks = new
				sparks.set_up(10, 1, pulling_turf)
				sparks.attach(pulling_turf)
				sparks.start()
				qdel(living_user.pulling)
			var/turf/user_turf = get_turf(living_user)
			playsound(user_turf, 'sound/magic/Repulse.ogg', 100, 1)
			var/datum/effect_system/spark_spread/quantum/sparks = new
			sparks.set_up(10, 1, user_turf)
			sparks.attach(user_turf)
			sparks.start()
			qdel(user)
	else
		user.balloon_alert(user, "beam-out cancelled")
*/


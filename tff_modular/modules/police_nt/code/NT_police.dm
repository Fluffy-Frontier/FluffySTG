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
/*
*	POLICE
*/
/datum/antagonist/ert/NT_police/regular
	name = "NTIS Unit"
	role = "Internal Security Unit"
	outfit = /datum/outfit/NT_police/regular

/datum/antagonist/ert/NT_police/greet()
	var/missiondesc =  ""
	missiondesc += "<B><font size=5 color=red>You are a Nanotrasen Employee. You work for the Nanotrasen as a [role].</font></B>"
	missiondesc += "<BR>You are responding to emergency calls from the station consultants!\n"
	missiondesc += "<BR><B>NTIS Transcript is as follows</B>:"
	missiondesc += "<BR> [GLOB.call_NTIS_msg]"
	missiondesc += "<BR><B>Your Mission</B>:"
	missiondesc += "<BR> <B>1.</B> Contact consultant [GLOB.caller_of_NTIS]. Your job is to assist the consultant or \"evacuate\" them in case of a false alarm."
	missiondesc += "<BR> <B>2.</B> Protect, ensure, and uphold the space law of station employees on board [station_name()]."
	missiondesc += "<BR> <B>3.</B> If you believe yourself to be in danger, unable to do the job assigned to you due to a dangerous situation, \
		or that the NTIS call was made in error, you can use the S.W.A.T. Backup Caller in your backpack to vote on calling a S.W.A.T. team to assist in the situation."
	missiondesc += "<BR> <B>4.</B> When you have finished (Don't forget to ask the NTC about it!) with your work on the station AND centcom, use the beamout Tool in your backpack to beam out yourself \
		along with anyone you are pulling.\n"
	missiondesc += "<B><font size=5 color=red>Also don't forget to return to centcom on the ship before using beamout tool!</font></B>"
	to_chat(owner, missiondesc)

/datum/antagonist/ert/NT_police/swat
	name = "NTIS S.W.A.T. Officer"
	role = "S.W.A.T. Officer"
	outfit = /datum/outfit/NT_police/swat

/datum/antagonist/ert/NT_police/swat/greet()
	var/missiondesc =  ""
	missiondesc += "<B><font size=5 color=red>You are a Nanotrasen Employee. You work for the Nanotrasen as a [role].</font></B>"
	missiondesc += "<BR>You are here to backup the NTIS police, as they have reported for your assistance.\n"
	missiondesc += "<BR><B>Your Mission</B>:"
	missiondesc += "<BR> <B>1.</B> Contact the NTIS police to figure out the situation."
	missiondesc += "<BR> <B>2.</B> Arrest anyone who interferes the work of the internal security."
	missiondesc += "<BR> <B>3.</B> Use lethal force in the arrest of the suspects if they will not comply, or the station refuses to comply."
	missiondesc += "<BR> <B>4.</B> If you believe the station is engaging in treason and is firing upon first responders and S.W.A.T. members, use the \
		trooper caller in your backpack to call the military."
	missiondesc += "<BR> <B>5.</B> When you have finished (Don't forget to ask the NTC about it!) with your work on the station AND centcom, use the beamout Tool in your backpack to beam out yourself \
		along with anyone you are pulling.\n"
	missiondesc += "<B><font size=5 color=red>Also don't forget to return to centcom on the ship before using beamout tool!</font></B>"
	to_chat(owner, missiondesc)

/datum/antagonist/ert/NT_police/trooper
	name = "NTIS Trooper"
	role = "NTIS Trooper"
	outfit = /datum/outfit/NT_police/trooper

/datum/antagonist/ert/NT_police/trooper/greet()
	var/missiondesc =  ""
	missiondesc += "<B><font size=5 color=red>You are a Nanotrasen Employee. You work for the Nanotrasen as a [role].</font></B>"
	missiondesc += "<BR>You are here to assume control of [station_name()] due to the occupants engaging in Treason as reported by our SWAT team.\n"
	missiondesc += "<BR><B>Your Mission</B>:"
	missiondesc += "<BR> <B>1.</B> Contact the SWAT Team and the First Responders to get the situation from them."
	missiondesc += "<BR> <B>2.</B> Arrest all suspects involved in the treason attempt."
	missiondesc += "<BR> <B>3.</B> Assume control of the station for the Corporation, and initiate evacuation procedures to get non-offending citizens \
		away from the scene."
	missiondesc += "<BR> <B>4.</B> If you need to use lethal force, do so, but only if you must."
	to_chat(owner, missiondesc)


/obj/item/beamout_tool_nt
	name = "beam-out tool"
	desc = "Use this to begin the lengthy beam-out process to return to NTIS office. It will bring anyone you are pulling with you."
	icon = 'modular_nova/modules/goofsec/icons/reporter.dmi'
	icon_state = "beam_me_up_scotty"
	w_class = WEIGHT_CLASS_SMALL

/obj/item/beamout_tool_nt/attack_self(mob/user, modifiers)
	. = ..()
	if(!user.mind.has_antag_datum(/datum/antagonist/ert))
		to_chat(user, span_warning("You don't understand how to use this device."))
		return
	message_admins("[ADMIN_LOOKUPFLW(user)] has begun to beam-out using their beam-out tool.")
	to_chat(user, "You have begun the beam-out process. Please wait for the beam to reach the station.")
	user.balloon_alert(user, "begun beam-out")
	if(do_after(user, 15 SECONDS))
		to_chat(user, "You have completed the beam-out process and are returning to the NTIS office.")
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


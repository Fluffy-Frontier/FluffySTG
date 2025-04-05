/client
	var/necro_whisper_muted = FALSE

/mob/living/carbon/human/necromorph/say(message, bubble_type, list/spans = list(), sanitize = TRUE, datum/language/language = null, ignore_spam = FALSE, forced = null, filterproof = null, message_range, datum/saymode/saymode, list/message_mods = list())
	if(!message || stat)
		return

	if (src.client)
		if(client.prefs.muted & MUTE_IC)
			to_chat(src, span_boldwarning("You cannot send IC messages (muted)."))
			return
		if (!(ignore_spam || forced) && src.client.handle_spam_prevention(message,MUTE_IC))
			return

	if(!marker)
		to_chat(src, span_warning("There is no connection between you and the Marker!"))
		return

	message = trim(copytext_char(sanitize(message), 1, MAX_MESSAGE_LEN))

	message = span_blob("[name] ([controlling?.name]): [message]")

	log_talk(message, LOG_SAY, forced_by = forced, custom_say_emote = message_mods[MODE_CUSTOM_SAY_EMOTE])

	marker.hive_mind_message(src, message)

	return TRUE

/mob/living/carbon/human/necromorph/proc/play_necro_sound(audio_type, volume, vary, extra_range)
	CRASH("play_necro_sound() wasn't overriden")

/mob/living/carbon/human/necromorph/proc/evacuate()

	if(controlling)
		controlling.abstract_move(get_turf(src))
		mind.transfer_to(controlling, TRUE)
		controlling = null

/mob/living/carbon/human/necromorph/proc/add_shield()
	dodge_shield = 5 + (maxHealth*0.15)
	if(hud_used)
		var/datum/hud/necromorph/hud = hud_used
		hud.update_shieldbar(src)
	addtimer(CALLBACK(src, PROC_REF(remove_shield)), 5 SECONDS, TIMER_OVERRIDE|TIMER_UNIQUE)

/mob/living/carbon/human/necromorph/proc/remove_shield()
	dodge_shield = 0
	if(hud_used)
		var/datum/hud/necromorph/hud = hud_used
		hud.update_shieldbar(src)

/mob/living/carbon/human/necromorph/proc/reduce_shield(amount)
	dodge_shield -= amount
	if(hud_used)
		var/datum/hud/necromorph/hud = hud_used
		hud.update_shieldbar(src)

/mob/living/carbon/human/necromorph/verb/show_tutorial()
	set name = "Show Info"
	set desc = "Display any information about current necromorph"
	set category = "Necromorph"

	to_chat(usr, tutorial_text)


ADMIN_VERB_AND_CONTEXT_MENU(spawn_necromorph, R_ADMIN, "Spawn a necromorph", "Spawn a necromorph.", ADMIN_CATEGORY_DEBUG)

	if(!length(GLOB.necromorph_markers))
		to_chat(user, span_warning("There are no markers present!"))
		return

	var/list/list_to_pick = list()
	for(var/datum/necro_class/class as anything in subtypesof(/datum/necro_class))
		if(initial(class.implemented))
			list_to_pick[initial(class.display_name)] = initial(class.necromorph_type_path)

	var/type_to_spawn = list_to_pick[tgui_input_list(usr, "Pick a necromorph to spawn", "Spawning", list_to_pick)]
	if(!type_to_spawn)
		return

	if(!length(GLOB.necromorph_markers))
		to_chat(user, span_warning("There are no markers present!"))
		return

	var/obj/structure/marker/marker = tgui_input_list(usr, "Pick a marker", "Marker", GLOB.necromorph_markers)

	if(QDELETED(marker))
		return

	var/mob/living/carbon/human/necromorph/necro = new type_to_spawn(get_turf(usr), marker)
	necro.flags_1 |= ADMIN_SPAWNED_1

	log_admin("[key_name(usr)] spawned [type_to_spawn] at [AREACOORD(usr)]")
	SSblackbox.record_feedback("tally", "necro_spawn", 1, "Spawn Necromorph") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!


ADMIN_VERB_AND_CONTEXT_MENU(brethren_message, R_ADMIN, "Brethren Message", "Send a message to the entire necromorph hive as a brethren moon.", ADMIN_CATEGORY_DEBUG, msg as text)
	user.brethren_message(msg)

/client/proc/brethren_message(msg as text)
	if(!msg) //If we have no message we don't want to continue
		return

	if(!length(GLOB.necromorph_markers))
		to_chat(src, span_warning("There are no markers!"))
		return //Make sure there is a marker to actually send this to

	var/obj/structure/marker/marker = tgui_input_list(src, "Pick a marker to send a hivemind message to.", "Brethren Message", GLOB.necromorph_markers)
	if(QDELETED(marker))
		return //On the off-chance the marker is destroyed before we send it

	msg = trim(copytext_char(sanitize(msg), 1, MAX_MESSAGE_LEN))

	msg = "<span class='blobannounce'>Brethren Moons : [msg]</span>"

	usr.log_talk(msg, LOG_OOC, tag = "Brethren Moons")
	marker.hive_mind_message(src, msg)

	return TRUE

ADMIN_VERB_AND_CONTEXT_MENU(kick_marker, R_ADMIN, "Kick marker", "Kick marker signal", ADMIN_CATEGORY_DEBUG)

	if(!length(GLOB.necromorph_markers))
		return
	var/obj/structure/marker/mark = pick(GLOB.necromorph_markers)
	if(mark.camera_mob)
		mark.camera_mob.downgrade()

ADMIN_VERB_AND_CONTEXT_MENU(spawn_corruption_structure, R_ADMIN, "Spawn corruption structure", "Spawn corruption structure", ADMIN_CATEGORY_DEBUG)

	if(!length(GLOB.necromorph_markers))
		to_chat(user, span_warning("There are no markers present!"))
		return

	var/list/list_to_pick = list()
	for(var/obj/structure/necromorph/struct as anything in subtypesof(/obj/structure/necromorph))
		list_to_pick[initial(struct.name)] = struct

	var/type_to_spawn = list_to_pick[tgui_input_list(usr, "Pick a structure to spawn", "Spawning", list_to_pick)]
	if(!type_to_spawn)
		return

	if(!length(GLOB.necromorph_markers))
		to_chat(user, span_warning("There are no markers present!"))
		return

	var/obj/structure/marker/marker = tgui_input_list(usr, "Pick a marker", "Marker", GLOB.necromorph_markers)

	if(QDELETED(marker))
		return

	var/obj/structure/necromorph/necro = new type_to_spawn(get_turf(usr), marker)
	necro.flags_1 |= ADMIN_SPAWNED_1

	log_admin("[key_name(usr)] spawned [type_to_spawn] at [AREACOORD(usr)]")
	SSblackbox.record_feedback("tally", "corruption_spawn", 1, "Spawn Corruption Structure") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

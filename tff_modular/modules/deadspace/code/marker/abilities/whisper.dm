/datum/action/cooldown/necro/psy/whisper
	name = "Whisper"
	desc = "Allows you to broadcast a subliminal message into the mind of a receptive target. Can be used on anyone visible."
	button_icon_state = "whisper"
	cost = 30

/datum/action/cooldown/necro/psy/whisper/PreActivate(mob/living/target)
	if(owner.client.prefs.muted & MUTE_SIGNAL_WHISPER)
		to_chat(owner, span_danger("You cannot send Signal Whisper messages (muted)."), confidential = TRUE)
		return
	if(!istype(target))
		return FALSE
	if(!target.client)
		to_chat(owner, span_notice("[target] is SSD or doesn't have a player."))
		return FALSE
	return ..()

/datum/action/cooldown/necro/psy/whisper/Activate(mob/living/target)
	var/mob/camera/marker_signal/signal = owner
	var/message = tgui_input_text(signal, "Write a message to send to [target.name]", "Whisper")
	if(!message)
		return TRUE
	.=..()
	log_directed_talk(owner, target, message, LOG_SAY, tag = "signal whisper")
	to_chat(target, "<span class='hypnophrase'>[message]</span>")
	signal.marker.hive_mind_message(signal, "[signal] -> [target] <span class='hypnophrase'>[message]</span>")

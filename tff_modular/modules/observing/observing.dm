GLOBAL_VAR_INIT(observing_allowed, TRUE)

ADMIN_VERB(toggle_observing, R_ADMIN, "Toggle Observing", "Toggle the Observing in lobby menu.", ADMIN_CATEGORY_SERVER)
	toggle_observing()
	log_admin("[key_name(user)] toggled Observing.")
	message_admins("[key_name_admin(user)] toggled Observing.")

/proc/toggle_observing(toggle = null)
	if(toggle != null)
		if(toggle != GLOB.observing_allowed)
			GLOB.observing_allowed = toggle
		else
			return
	else
		GLOB.observing_allowed = !GLOB.observing_allowed
	to_chat(world, "<span class='oocplain'><B>The Observing has been globally [GLOB.observing_allowed ? "enabled" : "disabled"].</B></span>")

// Трейт котоырй можно выдать заранее на следующий раунд, чтобы шустрые госты не успели нажать Observe до того, как админы выключат его
/datum/station_trait/disabled_observing
	name = "!Disable Observing"
	weight = 0

/datum/station_trait/disabled_observing/New()
	. = ..()
	toggle_observing(FALSE)

/datum/station_trait/disabled_observing/Destroy()
	. = ..()
	toggle_observing(TRUE)

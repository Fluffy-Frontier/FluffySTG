/datum/action/cooldown/spell/psionic/search
	name = "Psionic Search"
	desc = "Scan your Z-level for Nlom signatures."
	button_icon_state = "wiz_shield"
	mana_cost = 5
	cooldown_time = 10 SECONDS
	point_cost = 1
	locked = FALSE

/datum/action/cooldown/spell/psionic/search/cast(atom/cast_on)
	. = ..()
	var/list/alive_list = list()
	var/mob/living/carbon/human/searcher = cast_on
	for(var/mob/living/carbon/human/alive in world)
		var/datum/psionic/psi_datum = alive.get_psionic()
		if(!is_valid_z_level(alive.loc, searcher.loc))
			continue
		if(alive.stat == DEAD)
			continue
		if(!psi_datum)
			continue
		if(psi_datum.is_suppressed())
			continue
		alive_list += alive

	var/mob/living/carbon/who_to_find = tgui_input_list(searcher, "Who you want to find?", "Psionic Search", alive_list)
	if(!who_to_find || who_to_find.stat == DEAD || QDELETED(searcher))
		return FALSE

	var/area/place = get_area(who_to_find)
	to_chat(searcher, span_horizonblue("The one who you looking for at... [place.name]"))
	playsound(searcher, 'tff_modular/modules/psionics/sounds/power_used.ogg', 50, TRUE, SILENCED_SOUND_EXTRARANGE)

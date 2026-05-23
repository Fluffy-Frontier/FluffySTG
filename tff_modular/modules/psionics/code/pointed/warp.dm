/datum/action/cooldown/spell/pointed/psionic/warp
	name = "Psionic Warp"
	desc = "Warp through objects."
	button_icon_state = "tech_blink"
	category = "Tier 2"
	cooldown_time = 60 SECONDS
	psionic_level = 2
	point_cost = 2
	mana_cost = 30
	locked = FALSE
	cast_range = 2
	var/turf/target_turf

/datum/action/cooldown/spell/pointed/psionic/warp/is_valid_target(atom/cast_on)
	. = ..()
	var/turf/closed/wall/turf_we_check = cast_on
	if(!iswallturf(turf_we_check))
		to_chat(owner, span_horizonblue("Target must be a wall!"))
		return FALSE
	if(!turf_we_check.density)
		return FALSE
	return TRUE

/datum/action/cooldown/spell/pointed/psionic/warp/cast(atom/cast_on)
	. = ..()
	var/turf/closed/wall/density_object = cast_on
	density_object.warp()
	drain_mana()

/turf/closed/wall
	var/warped = FALSE

/turf/closed/wall/proc/warp()
	density = 0
	animate(src, alpha = 75, time = 2 SECONDS)
	warped = TRUE
	apply_wibbly_filters(src)
	RegisterSignal(src, COMSIG_ATOM_EXAMINE, PROC_REF(on_examine))

/turf/closed/wall/proc/unwarp()
	density = initial(density)
	animate(src, alpha = initial(alpha), time = 2 SECONDS)
	warped = FALSE
	remove_wibbly_filters(src)
	UnregisterSignal(src, COMSIG_ATOM_EXAMINE)

/turf/closed/wall/attack_hand(mob/user, list/modifiers)
	. = ..()
	if(warped)
		to_chat(user, span_horizonblue("The wall begins to return to its condition..."))
		unwarp()

/turf/closed/wall/proc/on_examine(datum/source, mob/user, text)
	SIGNAL_HANDLER
	text += span_horizonblue("There's something wrong with this wall. It looks like it's... An illusion?")

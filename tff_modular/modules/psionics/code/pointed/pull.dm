/datum/action/cooldown/spell/pointed/psionic/pull
	name = "Psionic Pull"
	desc = "Pulls the target straight towards the user. Even if the item is big, it's cant harm you on impact. Note that you can catch items you pull to yourself if you toggle throw mode before pulling an item."
	button_icon_state = "tech_passwall"
	category = "Tier 2"
	cooldown_time = 20 SECONDS
	psionic_level = 2
	point_cost = 1
	mana_cost = 30
	locked = FALSE
	cast_range = 5

/datum/action/cooldown/spell/pointed/psionic/pull/is_valid_target(atom/cast_on)
	if(cast_on == owner)
		return FALSE
	if(isobj(cast_on) || (isliving(cast_on) && cast_power >= 2))
		var/atom/movable/AM = cast_on
		if(AM.anchored)
			return FALSE
		return TRUE
	return FALSE

/datum/action/cooldown/spell/pointed/psionic/pull/cast(atom/cast_on)
	. = ..()
	var/atom/movable/AM = cast_on
	var/mob/living/carbon/human/user = owner
	if(isobj(cast_on))
		var/obj/object = cast_on
		if(object.anchored)
			to_chat(user, span_warning("That object cant be moved!"))
			return
	user.visible_message(span_warning("[user] extends [user.p_their()] hand at [cast_on] and pulls!"), span_warning("You mimic pulling at [cast_on]!"))
	if(ismob(cast_on))
		to_chat(cast_on, span_warning("A psychic force pulls you!"))
	AM.safe_throw_at(user, 10, 1, user, gentle = TRUE)
	playsound(user, 'tff_modular/modules/psionics/sounds/power_evoke.ogg', 40)
	drain_mana()

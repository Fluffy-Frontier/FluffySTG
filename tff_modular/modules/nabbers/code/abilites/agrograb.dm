#define MARTIALART_NABBER "scythes grab"

/datum/martial_art/nabber_grab
	name = "scythes grab"
	id = MARTIALART_NABBER

/datum/martial_art/nabber_grab/grab_act(mob/living/attacker, mob/living/defender)
	if(attacker == defender)
		return MARTIAL_ATTACK_INVALID

	var/old_grab_state = attacker.grab_state
	defender.grabbedby(attacker, TRUE)
	if(old_grab_state == GRAB_PASSIVE)
		defender.drop_all_held_items()
		attacker.setGrabState(GRAB_AGGRESSIVE) //Instant aggressive grab if on grab intent
		log_combat(attacker, defender, "grabbed", addition="aggressively")
		defender.visible_message(
			span_warning("[attacker] grabs [defender] in his scythes!"),
			span_userdanger("You're grabbed in scythes by [attacker]!"),
			span_hear("You hear sounds of aggressive fondling!"),
			COMBAT_MESSAGE_RANGE,
			attacker,
		)
		to_chat(attacker, span_danger("You grab [defender] in your scythes!"))
	return MARTIAL_ATTACK_SUCCESS

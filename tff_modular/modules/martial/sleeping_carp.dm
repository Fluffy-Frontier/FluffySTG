/datum/martial_art/the_sleeping_carp/can_deflect(mob/living/carp_user)
	if(!carp_user.throw_mode)
		return FALSE
	return is_capable(carp_user);

/datum/martial_art/the_sleeping_carp/proc/is_capable(mob/living/carp_user)
	if(!can_use(carp_user))
		return FALSE
	if(INCAPACITATED_IGNORING(carp_user, INCAPABLE_GRAB)) //NO STUN
		return FALSE
	if(!(carp_user.mobility_flags & MOBILITY_USE)) //NO UNABLE TO USE
		return FALSE
	var/datum/dna/dna = carp_user.has_dna()
	if(dna?.check_mutation(/datum/mutation/human/hulk)) //NO HULK
		return FALSE
	if(!isturf(carp_user.loc)) //NO MOTHERFLIPPIN MECHS!
		return FALSE
	return TRUE

/datum/martial_art/the_sleeping_carp/disarm_act(mob/living/attacker, mob/living/defender)
	if(!is_capable(attacker) || !attacker.combat_mode) //allows for deniability
		return MARTIAL_ATTACK_INVALID
	if(defender.check_block(attacker, 0, attacker.name, UNARMED_ATTACK))
		return MARTIAL_ATTACK_FAIL

	add_to_streak("D", defender)
	if(check_streak(attacker, defender))
		return MARTIAL_ATTACK_SUCCESS

	attacker.do_attack_animation(defender, ATTACK_EFFECT_PUNCH)
	playsound(defender, 'sound/items/weapons/punch1.ogg', 25, TRUE, -1)
	defender.apply_damage(20, STAMINA)
	log_combat(attacker, defender, "disarmed (Sleeping Carp)")
	return MARTIAL_ATTACK_INVALID // normal disarm

/datum/martial_art/the_sleeping_carp/grab_act(mob/living/attacker, mob/living/defender)
	if(!is_capable(attacker) || !attacker.combat_mode) //allows for deniability
		return MARTIAL_ATTACK_INVALID

	if(defender.check_block(attacker, 0, "[attacker]'s grab", UNARMED_ATTACK))
		return MARTIAL_ATTACK_FAIL

	add_to_streak("G", defender)
	if(check_streak(attacker, defender))
		return MARTIAL_ATTACK_SUCCESS

	var/grab_log_description = "grabbed"
	attacker.do_attack_animation(defender, ATTACK_EFFECT_PUNCH)
	playsound(defender, 'sound/items/weapons/punch1.ogg', 25, TRUE, -1)
	if(defender.stat != DEAD && !defender.IsUnconscious() && defender.getStaminaLoss() >= 80) //We put our target to sleep.
		defender.visible_message(
			span_danger("[attacker] carefully pinch a nerve in [defender]'s neck, knocking them out cold!"),
			span_userdanger("[attacker] pinches something in your neck, and you fall unconscious!"),
		)
		grab_log_description = "grabbed and nerve pinched"
		defender.Unconscious(10 SECONDS)
	defender.apply_damage(20, STAMINA)
	log_combat(attacker, defender, "[grab_log_description] (Sleeping Carp)")
	return MARTIAL_ATTACK_INVALID // normal grab

/mob/living/proc/sleeping_carp_help_tff()
	set name = "Recall Teachings"
	set desc = "Remember the martial techniques of the Sleeping Carp clan."
	set category = "Sleeping Carp"

	to_chat(usr, "<b><i>You retreat inward and recall the teachings of the Sleeping Carp...</i></b>\n\
	[span_notice("Gnashing Teeth")]: Punch Punch. Deal additional damage every second (consecutive) punch! Very good chance to wound!\n\
	[span_notice("Crashing Wave Kick")]: Punch Shove. Launch your opponent away from you with incredible force!\n\
	[span_notice("Keelhaul")]: Shove Shove. Nonlethally kick an opponent to the floor, knocking them down, discombobulating them and dealing substantial stamina damage. If they're already prone, disarm them as well.\n\
	[span_notice("Grabs and Shoves")]: While in combat mode, your typical grab and shove do decent stamina damage. If you grab someone who has substantial amounts of stamina damage, you knock them out!\n\
	<span class='notice'>While in throw mode (and not stunned, not a hulk, and not in a mech), you can reflect all projectiles that come your way, sending them back at the people who fired them! \n\
	Also, you are more resilient against suffering wounds in combat, and your limbs cannot be dismembered. This grants you extra staying power during extended combat, especially against slashing and other bleeding weapons. \n\
	You are not invincible, however- while you may not suffer debilitating wounds often, you must still watch your health and should have appropriate medical supplies for use during downtime. \n\
	In addition, your training has imbued you with a loathing of guns, and you can no longer use them.</span>")

/obj/item/book/granter/martial/carp
	greet = "<span class='sciradio'>You have learned the ancient martial art of the Sleeping Carp! Your hand-to-hand combat has become much more effective, and you are now able to deflect any projectiles \
		directed toward you while in Throw Mode. Your body has also hardened itself, granting extra protection against lasting wounds that would otherwise mount during extended combat. \
		However, you are also unable to use any ranged weaponry. You can learn more about your newfound art by using the Recall Teachings verb in the Sleeping Carp tab.</span>"

/datum/uplink_item/stealthy_weapons/martialarts
	cost = 17

/datum/martial_art/the_sleeping_carp
	help_verb = /mob/living/proc/sleeping_carp_help_tff

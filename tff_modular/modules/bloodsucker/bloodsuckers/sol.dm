///Legacy name - now refers to the time between free levels for vampires.
#define TIME_BLOODSUCKER_NIGHT 600

SUBSYSTEM_DEF(sol)
	name = "Sol"
	can_fire = FALSE
	wait = 20 // ticks, not seconds (so this runs every second, actually)
	flags = SS_NO_INIT | SS_BACKGROUND | SS_TICKER | SS_KEEP_TIMING

	///The time between the next cycle.
	var/time_til_cycle = TIME_BLOODSUCKER_NIGHT
	///If Bloodsucker levels for the night has been given out yet.
	var/issued_XP = FALSE

/datum/controller/subsystem/sol/Recover()
	can_fire = SSsol.can_fire
	time_til_cycle = SSsol.time_til_cycle
	issued_XP = SSsol.issued_XP

/datum/controller/subsystem/sol/fire(resumed = FALSE)
	time_til_cycle--

	if (time_til_cycle > 0 && time_til_cycle <= 15)
		if (!issued_XP)
			issued_XP = TRUE
			SEND_SIGNAL(src, COMSIG_SOL_RANKUP_BLOODSUCKERS)

	if (time_til_cycle < 1)
		issued_XP = FALSE
		time_til_cycle = TIME_BLOODSUCKER_NIGHT

#undef TIME_BLOODSUCKER_NIGHT

/**
 *	# Assigning Sol
 *
 *	Sol is a legacy name, now simply referring to the system used to give all vampires free levels at the same time.
 */

/// Start Sol, called when someone is assigned Bloodsucker
/datum/antagonist/bloodsucker/proc/check_start_sunlight()
	var/list/existing_suckers = get_antag_minds(/datum/antagonist/bloodsucker) - owner
	if(!length(existing_suckers))
		message_admins("New Sol has been created due to Bloodsucker assignment.")
		SSsol.can_fire = TRUE

/// End Sol, if you're the last Bloodsucker
/datum/antagonist/bloodsucker/proc/check_cancel_sunlight()
	var/list/existing_suckers = get_antag_minds(/datum/antagonist/bloodsucker) - owner
	if(!length(existing_suckers))
		message_admins("Sol has been deleted due to the lack of Bloodsuckers")
		SSsol.can_fire = FALSE

///Ranks the Bloodsucker up, called by Sol.
/datum/antagonist/bloodsucker/proc/sol_rank_up(atom/source)
	SIGNAL_HANDLER

	if(sol_levels_remaining > 0)
		sol_levels_remaining--
		INVOKE_ASYNC(src, PROC_REF(RankUp))

/**
 * # Torpor
 *
 * Torpor is what deals with the Bloodsucker falling asleep, their healing, the effects, ect.
 * This is basically what Sol is meant to do to them, but they can also trigger it manually if they wish to heal, as Burn is only healed through Torpor.
 * You cannot manually exit Torpor, it is instead entered/exited by:
 *
 * Torpor is triggered by:
 * - Being in a Coffin while Sol is on, dealt with by Sol
 * - Entering a Coffin with more than 10 combined Brute/Burn damage, dealt with by /datum/antagonist/bloodsucker/on_enter_coffin() [procs.dm]
 * - Death, dealt with by /HandleDeath()
 * Torpor is ended by:
 * - Having less than maxHealth * 0.8 damage while OUTSIDE of your Coffin while it isnt Sol.
 * - Having less than 10 Damage Combined while INSIDE of your Coffin while it isnt Sol.
 * - Sol being over, dealt with by /datum/controller/subsystem/processing/sunlight/process() [sol_subsystem.dm]
*/
/datum/antagonist/bloodsucker/proc/check_begin_torpor(SkipChecks = FALSE)
	var/mob/living/carbon/user = owner.current
	if(QDELETED(user))
		return
	/// Are we entering Torpor via Sol/Death? Then entering it isnt optional!
	if(SkipChecks)
		torpor_begin()
		return
	if(user.has_status_effect(/datum/status_effect/frenzy))
		to_chat(user, span_userdanger("You are restless! Collect enough blood to end your frenzy."))
		return
	var/total_brute = user.get_brute_loss_nonProsthetic()
	var/total_burn = user.get_fire_loss_nonProsthetic()
	var/total_damage = total_brute + total_burn
	/// Checks - Not daylight & Has more than 10 Brute/Burn & not already in Torpor
	if((total_damage >= 10 || length(user.get_missing_limbs()) > 0) && !is_in_torpor())
		torpor_begin()

/datum/antagonist/bloodsucker/proc/check_end_torpor()
	var/mob/living/carbon/user = owner.current
	if(QDELETED(user))
		return
	var/total_brute = user.get_brute_loss_nonProsthetic()
	var/total_burn = user.get_fire_loss_nonProsthetic()
	var/total_damage = total_brute + total_burn
	if(total_burn >= 199)
		return FALSE

	// You are in a Coffin, so instead we'll check TOTAL damage, here.
	if(istype(user.loc, /obj/structure/closet/crate/coffin))
		if(total_damage <= 10 && length(user.get_missing_limbs()) == 0)
			torpor_end()
	else
		if(total_brute <= 10)
			torpor_end()
	if(COOLDOWN_FINISHED(src, bloodsucker_torpor_max_time))
		torpor_end() // YOUR TAKING TOO LONG

/datum/antagonist/bloodsucker/proc/is_in_torpor()
	if(QDELETED(owner.current))
		return FALSE
	return HAS_TRAIT_FROM(owner.current, TRAIT_NODEATH, TORPOR_TRAIT)

/datum/antagonist/bloodsucker/proc/torpor_begin()
	var/mob/living/current = owner.current
	if(QDELETED(current))
		return
	to_chat(current, span_notice("You enter the horrible slumber of deathless Torpor. You will heal until you are renewed."))
	// Force them to go to sleep
	REMOVE_TRAIT(current, TRAIT_SLEEPIMMUNE, BLOODSUCKER_TRAIT)
	// Without this, you'll just keep dying while you recover.
	current.add_traits(torpor_traits, TORPOR_TRAIT)
	current.set_timed_status_effect(0 SECONDS, /datum/status_effect/jitter, only_if_higher = TRUE)
	//monkestation edit
	// Failsafe to prevent players taking too long in torpor
	COOLDOWN_START(src, bloodsucker_torpor_max_time, BLOODSUCKER_TORPOR_MAX_TIME)
	//monkestation end
	// Disable ALL Powers
	DisableAllPowers()

/datum/antagonist/bloodsucker/proc/torpor_end()
	var/mob/living/current = owner.current
	if(QDELETED(current))
		return

	if(!COOLDOWN_FINISHED(src, bloodsucker_torpor_max_time))
		COOLDOWN_RESET(src, bloodsucker_torpor_max_time)

	current.grab_ghost()
	to_chat(current, span_warning("You have recovered from Torpor."))
	current.remove_traits(torpor_traits, TORPOR_TRAIT)
	if(!HAS_TRAIT(current, TRAIT_MASQUERADE))
		ADD_TRAIT(current, TRAIT_SLEEPIMMUNE, BLOODSUCKER_TRAIT)
	heal_vampire_organs()
	current.update_stat()
	SEND_SIGNAL(src, COMSIG_BLOODSUCKER_EXIT_TORPOR)

/// TGMC_XENOS (old nova sector xenos)

/datum/action/cooldown/alien/tgmc/generic_evolve
	name = "Evolve"
	desc = "Allows us to evolve to a higher caste of our type, if there is not one already."
	button_icon_state = "evolution"
	/// What type this ability will turn the owner into upon completion
	var/type_to_evolve_into

/datum/action/cooldown/alien/tgmc/generic_evolve/Grant(mob/grant_to)
	. = ..()
	if(!isalien(owner))
		return
	var/mob/living/carbon/alien/target_alien = owner
	plasma_cost = target_alien.get_max_plasma() //This ability should always require that a xeno be at their max plasma capacity to use

/datum/action/cooldown/alien/tgmc/generic_evolve/Activate()
	var/mob/living/carbon/alien/adult/tgmc/evolver = owner

	if(!istype(evolver))
		to_chat(owner, span_warning("You aren't an alien, you can't evolve!"))
		return FALSE

	type_to_evolve_into = evolver.next_evolution
	if(!type_to_evolve_into)
		to_chat(evolver, span_bolddanger("Something is wrong... We can't evolve into anything? (This is broken report it on GitHub)"))
		CRASH("Couldn't find an evolution for [owner] ([owner.type]).")

	if(!isturf(evolver.loc))
		return FALSE

	if(get_alien_type(type_to_evolve_into))
		evolver.balloon_alert(evolver, "too many of our evolution already")
		return FALSE

	var/obj/item/organ/alien/hivenode/node = evolver.get_organ_by_type(/obj/item/organ/alien/hivenode)
	if(!node)
		to_chat(evolver, span_bolddanger("We can't sense our node's connection to the hive... We can't evolve!"))
		return FALSE

	if(node.recent_queen_death)
		to_chat(evolver, span_bolddanger("The death of our queen... We can't seem to gather the mental energy required to evolve..."))
		return FALSE

	if(evolver.has_evolved_recently)
		evolver.balloon_alert(evolver, "can evolve in 1.5 minutes") //Make that 1.5 variable later, but it keeps fucking up for me :(
		return FALSE

	var/new_beno = new type_to_evolve_into(evolver.loc)
	evolver.alien_evolve(new_beno)
	return TRUE


/mob/living/carbon/alien/adult/tgmc/alien_evolve(mob/living/carbon/alien/adult/tgmc/new_xeno, is_it_a_larva)
	visible_message(
		span_alertalien("[src] begins to twist and contort!"),
		span_noticealien("You begin to evolve!"),
	)

	new_xeno.setDir(dir)
	new_xeno.identifier = identifier
	new_xeno.name = new_xeno.real_name
	new_xeno.set_name()

	if(!islarva(new_xeno))
		new_xeno.has_just_evolved()
	if(mind)
		mind.name = new_xeno.real_name
		mind.transfer_to(new_xeno)
	drop_all_held_items()
	qdel(src)

/// Called when a larva or xeno evolves, adds a configurable timer on evolving again to the xeno
/mob/living/carbon/alien/adult/tgmc/proc/has_just_evolved()
	if(has_evolved_recently)
		return
	has_evolved_recently = TRUE
	addtimer(CALLBACK(src, PROC_REF(can_evolve_once_again)), evolution_cooldown_time)

/// Allows xenos to evolve again if they are currently unable to
/mob/living/carbon/alien/adult/tgmc/proc/can_evolve_once_again()
	if(!has_evolved_recently)
		return
	has_evolved_recently = FALSE

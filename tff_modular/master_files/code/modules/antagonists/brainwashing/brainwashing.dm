
// TFF ADDITION START
/// Removes objectives from someone's brainwash.
/proc/unbrainwash(mob/living/victim, list/directives)
	var/datum/antagonist/brainwashed/brainwash = victim?.mind?.has_antag_datum(/datum/antagonist/brainwashed)
	if(!brainwash)
		return FALSE
	if(directives)
		if(!isnull(directives) && !islist(directives))
			directives = list(directives)
		var/list/removed_objectives = list()
		var/list/objective_texts = list()
		for(var/datum/objective/directive as anything in directives)
			if(istype(directive, /datum/weakref))
				var/datum/weakref/directive_weakref = directive
				directive = directive_weakref.resolve()
			if(!istype(directive))
				continue
			brainwash.objectives -= directive
			removed_objectives += directive
			objective_texts += "\"[directive.explanation_text]\""
		log_admin("[key_name(victim)] had the following brainwashing objective[length(removed_objectives) > 1 ? "s" : ""] removed: [english_list(objective_texts)].")
		if(LAZYLEN(brainwash.objectives))
			to_chat(victim, span_userdanger("[length(removed_objectives) > 1 ? "Some" : "One"] of your Directives fade away! You only have to obey the remaining Directives now.</b></span></big>"))
			victim.mind.announce_objectives()
		else
			victim.mind.remove_antag_datum(/datum/antagonist/brainwashed)
		QDEL_LIST(removed_objectives)
	else
		var/list/objective_texts = list()
		for(var/datum/objective/directive as anything in brainwash.objectives)
			objective_texts += "\"[directive.explanation_text]\""
		log_admin("[key_name(victim)] had all of their brainwashing objectives removed: [english_list(objective_texts)].")
		QDEL_LIST(brainwash.objectives)
		victim.mind.remove_antag_datum(/datum/antagonist/brainwashed)

// TFF ADDITION END

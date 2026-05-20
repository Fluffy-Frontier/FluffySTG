// Даёт мутацию телекинеза
/datum/action/cooldown/spell/psionic/psionic_telekinesis
	name = "Telekinesis"
	desc = "Force yourself to recieve telekinesis mutation."
	cooldown_time = 20 SECONDS
	mana_cost = 80

/datum/action/cooldown/spell/psionic/psionic_telekinesis/is_valid_target(atom/cast_on)
	return !issynthetic(cast_on)

/datum/action/cooldown/spell/psionic/psionic_telekinesis/cast(mob/living/cast_on)
	. = ..()
	if(!ishuman(cast_on))
		return FALSE
	var/mob/living/carbon/human/to_mutate = cast_on
	if(!to_mutate.can_mutate())
		return FALSE
	to_mutate.dna.add_mutation(/datum/mutation/telekinesis/psionic, MUTATION_SOURCE_ACTIVATED)
	drain_mana()

/datum/mutation/telekinesis/psionic
	no_effect = TRUE

// Создаёт ЕМП в месте удара руки
/datum/action/cooldown/spell/psionic/emp
	name = "Psionic EMP"
	desc = "Cause a small, but powerful EMP."
	button_icon_state = "overload"
	cooldown_time = 15 SECONDS
	mana_cost = 30
	psionic_level = 2

/datum/action/cooldown/spell/psionic/emp/cast(atom/cast_on)
	. = ..()
	empulse(cast_on.loc, 3, 3)
	drain_mana()

/datum/action/cooldown/spell/psionic/focus
	name = "Psionic Focus"
	desc = "Creates a useful reagents inside of you, removing stun."
	button_icon_state = "blink"
	cooldown_time = 50 SECONDS
	mana_cost = 20
	point_cost = 1
	psionic_level = 2

/datum/action/cooldown/spell/psionic/focus/cast(atom/cast_on)
	. = ..()
	var/mob/living/carbon/human/human_living = cast_on
	if(do_after(human_living, 1 SECONDS))
		to_chat(human_living, span_warning("A calm rush envelops your mind.."))
		human_living.reagents.add_reagent_list(list(/datum/reagent/medicine/ephedrine = 5, /datum/reagent/medicine/synaptizine = 5, /datum/reagent/medicine/epinephrine = 5))
		human_living.SetStun(0)
		human_living.SetParalyzed(0)
		human_living.SetSleeping(0)
		human_living.SetAllImmobility(0)
		drain_mana()

/datum/action/cooldown/spell/psionic/charge
	name = "Psionic Charge"
	button_icon_state = "audible_deception"
	cooldown_time = 60 SECONDS
	mana_cost = 10
	point_cost = 1
	psionic_level = 1

/datum/action/cooldown/spell/psionic/charge/is_valid_target(atom/cast_on)
	return isliving(cast_on)

/datum/action/cooldown/spell/psionic/charge/cast(mob/living/cast_on)
	. = ..()

	// Charge people we're pulling first and foremost
	if(isliving(cast_on.pulling) && cast_power >= 2)
		var/mob/living/pulled_living = cast_on.pulling
		var/pulled_has_spells = FALSE

		for(var/datum/action/cooldown/spell/spell in pulled_living.actions)
			spell.reset_spell_cooldown()
			pulled_has_spells = TRUE

		if(pulled_has_spells)
			to_chat(pulled_living, span_notice("You feel psi flowing through you. It feels good!"))
			to_chat(cast_on, span_notice("[pulled_living] suddenly feels very warm!"))
			return

		to_chat(pulled_living, span_notice("You feel very strange for a moment, but then it passes."))

	// Then charge their main hand item, then charge their offhand item
	var/obj/item/to_charge = cast_on.get_active_held_item() || cast_on.get_inactive_held_item()
	if(!to_charge)
		to_chat(cast_on, span_notice("You feel magical power surging through your hands, but the feeling rapidly fades."))
		return

	var/charge_return = SEND_SIGNAL(to_charge, COMSIG_ITEM_MAGICALLY_CHARGED, src, cast_on)

	if(QDELETED(to_charge))
		to_chat(cast_on, span_warning("[src] seems to react adversely with [to_charge]!"))
		return

	if(charge_return & COMPONENT_ITEM_BURNT_OUT)
		to_chat(cast_on, span_warning("[to_charge] seems to react negatively to [src], becoming uncomfortably warm!"))

	else if(charge_return & COMPONENT_ITEM_CHARGED)
		to_chat(cast_on, span_notice("[to_charge] suddenly feels very warm!"))

	else
		to_chat(cast_on, span_notice("[to_charge] doesn't seem to be react to [src]."))

	drain_mana()

/datum/action/cooldown/spell/pointed/psionic/bubble
	name = "Psionic Bubble"
	desc = "Create a protective bubble around you or target that removes your need to breathe or wear space protection!"
	button_icon_state = "shield"
	point_cost = 1
	cooldown_time = 30 SECONDS
	mana_cost = 10

/datum/action/cooldown/spell/pointed/psionic/bubble/cast(atom/cast_on)
	. = ..()
	var/mob/living/living_living = cast_on
	living_living.set_timed_status_effect(15 SECONDS * cast_power, /datum/status_effect/psi_bubble)

/datum/status_effect/psi_bubble
	id = "psi_bubble"
	alert_type = /atom/movable/screen/alert/psi_bubble
	var/icon/bubbleicon

/datum/status_effect/psi_bubble/on_apply()
	. = ..()
	bubbleicon = icon(icon = 'icons/effects/effects.dmi', icon_state = "shield2")
	owner.add_overlay(bubbleicon)
	owner.add_traits(list(TRAIT_OXYIMMUNE, TRAIT_RESISTLOWPRESSURE, TRAIT_RESISTCOLD))

/datum/status_effect/psi_bubble/on_remove()
	. = ..()
	owner.cut_overlay(bubbleicon)

/atom/movable/screen/alert/psi_bubble
	icon = 'icons/effects/effects.dmi'
	icon_state = "shield2"
	name = "Air Bubble"
	desc = "There is a protective bubble around you that removes your need to breathe or wear space protection!"

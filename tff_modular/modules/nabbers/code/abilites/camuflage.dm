#define ICON_STATE_CAMOUFLAGE_ON "camuflage_off"
#define ICON_STATE_CAMOUFLAGE_OFF "camuflage_on"

/datum/action/cooldown/optical_camouflage
	name = "Toggle camouflage"
	desc = "Blend it with your surroundings and become transparent."
	cooldown_time = 10 SECONDS

	button_icon = 'tff_modular/modules/nabbers/icons/actions.dmi'
	var/active = FALSE
	var/camouflage_alpha = 35

/datum/action/cooldown/optical_camouflage/Trigger(trigger_flags, atom/target)
	. = ..()
	if(!owner)
		return

	if(active)
		remove_camouflage()
		return

	if(owner.has_status_effect(/datum/status_effect/nabber_combat))
		owner.balloon_alert("Can't now!")
		return

	RegisterSignals(owner, list(COMSIG_MOB_ITEM_ATTACK, COMSIG_ATOM_ATTACKBY, COMSIG_ATOM_ATTACK_HAND, COMSIG_ATOM_HITBY, COMSIG_ATOM_HULK_ATTACK, COMSIG_ATOM_ATTACK_PAW, COMSIG_CARBON_CUFF_ATTEMPTED, COMSIG_ATOM_BULLET_ACT, COMSIG_HUMAN_MELEE_UNARMED_ATTACK, COMSIG_LIVING_MOB_BUMP, COMSIG_HUMAN_BURNING), PROC_REF(remove_camouflage))
	enter_camouflage()

/datum/action/cooldown/optical_camouflage/Grant(mob/granted_to)
	. = ..()
	button_icon_state = ICON_STATE_CAMOUFLAGE_OFF

/datum/action/cooldown/optical_camouflage/Destroy()
	. = ..()
	if(!owner)
		return
	remove_camouflage()

/datum/action/cooldown/optical_camouflage/proc/enter_camouflage()
	owner.visible_message(span_notice("[owner] starts shifting colors and becomes transparent."), span_notice("You blend it with your surroundings."), span_hear("You hear a low hiss."))

	animate(owner, alpha = camouflage_alpha, time = cooldown_time)

	button_icon_state = ICON_STATE_CAMOUFLAGE_ON
	owner.update_action_buttons()

/datum/action/cooldown/optical_camouflage/proc/remove_camouflage()
	owner.visible_message(span_notice("[owner] stops blending in with surroundings."), span_notice("You become visible again."), span_hear("You hear a low hiss."))
	animate(owner, alpha = 255, time = 1.5 SECONDS)

	UnregisterSignal(owner, list(COMSIG_HUMAN_MELEE_UNARMED_ATTACK, COMSIG_MOB_ITEM_ATTACK, COMSIG_ATOM_ATTACKBY, COMSIG_ATOM_ATTACK_HAND, COMSIG_ATOM_BULLET_ACT, COMSIG_ATOM_HITBY, COMSIG_ATOM_HULK_ATTACK, COMSIG_ATOM_ATTACK_PAW, COMSIG_CARBON_CUFF_ATTEMPTED, COMSIG_LIVING_MOB_BUMP, COMSIG_HUMAN_BURNING))

	button_icon_state = ICON_STATE_CAMOUFLAGE_OFF
	owner.update_action_buttons()

#undef ICON_STATE_CAMOUFLAGE_ON
#undef ICON_STATE_CAMOUFLAGE_OFF

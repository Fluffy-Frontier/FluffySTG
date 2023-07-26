#define LOCATION_CYCLE_COOLDOWN 3 SECONDS
#define ECHOLOCATION_BASE_COOLDWN_TIME 10 SECONDS
#define ECHOLOCATION_RANGE 9

/datum/action/cooldown/teshari/echolocation
	name = "Toggle echolocation"

	cooldown_time = ECHOLOCATION_BASE_COOLDWN_TIME
	var/active = FALSE
	var/cycle_cooldown = ECHOLOCATION_BASE_COOLDWN_TIME

/datum/action/cooldown/teshari/echolocation/New(Target, original)
	. = ..()
	button_icon_state = "agility_mode_above"

/datum/action/cooldown/teshari/echolocation/Activate(atom/target)
	if(!owner)
		return FALSE
	var/mob/living/carbon/human/tesh
	if(!(tesh.can_hear()))
		tesh.balloon_alert(tesh, "Can't hear!")
		return FALSE
	if(active)
		tesh.visible_message(span_notice(""), span_notice(""))
		tesh.balloon_alert(tesh, "Stop echolocation!")
		STOP_PROCESSING(SSprocessing, src)
		StartCooldown()
		return TRUE

	tesh.visible_message(span_notice(""), span_notice(""))
	tesh.balloon_alert(tesh, "Start echolocation!")
	START_PROCESSING(SSprocessing, src)
	active = TRUE

	return FALSE

/datum/action/cooldown/teshari/echolocation/process()
	. = ..()
	for(var/mob/living/creature in range(ECHOLOCATION_RANGE, owner))
		if(creature == owner || creature.stat == DEAD)
			continue
		new /obj/effect/temp_visual/sonar_ping(owner.loc, owner, creature)

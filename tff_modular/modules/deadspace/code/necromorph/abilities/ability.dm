#define PLAY_SHAKING_ANIMATION(object, rotation, offset, shake_dir, initial_x, initial_y, initial_transform)\
	##shake_dir = pick(-1, 1);\
	animate(transform=turn(##object.transform, ##rotation*##shake_dir), pixel_x=##offset * shake_dir, pixel_y = (##offset * pick(-1, 1)) + ##offset*##shake_dir, time=1);\
	animate(transform=##initial_transform, pixel_x=##initial_x, pixel_y=##initial_y, time=2, easing=ELASTIC_EASING);

/datum/action/cooldown/necro
	background_icon_state = "bg_demon"

/datum/action/cooldown/necro/New(Target, original, cooldown)
	. = ..()
	if(!isnull(cooldown))
		cooldown_time = cooldown

/datum/action/cooldown/necro/Grant(mob/granted_to)
	.=..()
	if(!owner)
		return

/datum/action/cooldown/necro/PreActivate(atom/target)
	var/mob/living/carbon/human/necromorph/charger = owner
	if(charger.stat == DEAD)
		return FALSE
	return ..()

/datum/action/cooldown/necro/proc/TriggerOnKeybindSignal(mob/source)
	SIGNAL_HANDLER
	Trigger()
	return COMSIG_KB_ACTIVATED

/*
	Active abilties that can be activated but can't be deactivated
*/

/datum/action/cooldown/necro/active
	var/duration_time = 2 SECONDS
	var/active = FALSE

/datum/action/cooldown/necro/active/New(Target, cooldown, duration)
	if(!isnull(duration))
		duration_time = duration
	return ..()

/datum/action/cooldown/necro/active/Destroy()
	CooldownEnd()
	STOP_PROCESSING(SSfastprocess, src)
	return ..()

/datum/action/cooldown/necro/active/Activate(atom/target)
	active = TRUE
	StartCooldown(duration_time)

/datum/action/cooldown/necro/active/process(delta_time)
	.=..()
	if((next_use_time - world.time) <= 0)
		CooldownEnd()

/datum/action/cooldown/necro/active/proc/CooldownEnd()
	if(active)
		active = FALSE
		StartCooldown()
		return TRUE

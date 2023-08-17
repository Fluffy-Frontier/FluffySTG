/datum/action/cooldown/void_ability/toggle_light
	name = "Переключить затемнение"
	desc = "Включить/выключить затемнение окружения."

	button_icon = 'icons/hud/guardian.dmi'
	button_icon_state = "lightning"

/datum/action/cooldown/void_ability/toggle_light/Activate(atom/target)
	if(!istype(owner, /mob/living/basic/void_creture))
		return
	var/mob/living/basic/void_creture/toggle_target = owner
	toggle_target.force_lighthing_blink = !toggle_target.force_lighthing_blink
	toggle_target.balloon_alert(toggle_target, "Ligght blink toggled!")


/datum/action/cooldown/void_ability/toggle_nightvision
	name = "Переключить ночное зрение"
	desc = "Переключить режим ночного зрения.."

	button_icon = 'icons/hud/guardian.dmi'
	button_icon_state = "gaseous"

/datum/action/cooldown/void_ability/toggle_nightvision/Activate(atom/target)
	if(!istype(owner, /mob/living/basic/void_creture))
		return
	var/mob/living/basic/void_creture/toggle_target = owner

	if(toggle_target.lighting_cutoff == LIGHTING_CUTOFF_HIGH)
		toggle_target.lighting_cutoff = LIGHTING_CUTOFF_FULLBRIGHT
	else if(toggle_target.lighting_cutoff == LIGHTING_CUTOFF_FULLBRIGHT)
		toggle_target.lighting_cutoff = LIGHTING_CUTOFF_VISIBLE
	else if(toggle_target.lighting_cutoff == LIGHTING_CUTOFF_VISIBLE)
		toggle_target.lighting_cutoff = LIGHTING_CUTOFF_MEDIUM
	else if(toggle_target.lighting_cutoff == LIGHTING_CUTOFF_MEDIUM)
		toggle_target.lighting_cutoff = LIGHTING_CUTOFF_HIGH

	toggle_target.balloon_alert(toggle_target, "Nightvision set to [toggle_target.lighting_cutoff]%!")
	toggle_target.update_sight()

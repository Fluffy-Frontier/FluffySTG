/datum/action/cooldown/void_ability/toggle_light
	name = "Переключить затемнение"
	desc = "Включить/выключить затемнение окружения."

	button_icon = 'icons/hud/guardian.dmi'
	button_icon_state = "lightning"

/datum/action/cooldown/void_ability/toggle_light/Activate(atom/target)
	if(!istype(owner, /mob/living/simple_animal/hostile/void_creture))
		return
	var/mob/living/simple_animal/hostile/void_creture/toggle_target = owner
	toggle_target.force_lighthing_blink = !toggle_target.force_lighthing_blink
	toggle_target.balloon_alert(toggle_target, "Ligght blink toggled!")

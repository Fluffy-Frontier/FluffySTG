//О да - это чертов скример!
/datum/action/cooldown/void_ability/scream
	name = "Крик"
	desc = "Вызывает чудовищный крик и ужас во всех, рядом с тобой."
	cooldown_time = 60 SECONDS

	button_icon_state = "standard"
	button_icon = 'icons/hud/guardian.dmi'
	var/screamsound = sound('tff_modular/modules/void/sounds/horror.ogg', FALSE)

/datum/action/cooldown/void_ability/scream/Activate(atom/target)
	if(!owner)
		return FALSE
	var/mob/living/void_mob = owner
	//Сперва захватим ближайших к нам игроков.
	for(var/mob/living/carbon/human/scream_target in view(owner))
		//Если у цели - нет клинка, пропускаем её.
		if(!scream_target.client)
			continue
		if(isdead(scream_target))
			continue
		//Переводим нашу цель в состояния страха и накладываем эффект на экран!
		scream_target.set_horror_state(HUMAN_HORROR_STATE_FEAR, 30 SECONDS)
		scream_target.add_screeen_temporary_effect(/atom/movable/screen/fullscreen/void_brightless/highter, 30 SECONDS, TRUE)
		scream_target.playsound_local(get_turf(scream_target), screamsound, 90, 0, channel = CHANNEL_BOSS_MUSIC, use_reverb = FALSE)
		shake_camera(scream_target, 1 SECONDS, 5)
		to_chat(scream_target, span_narsie("RUN!")) //Лучше бы тебе бежать сынок!
		scream_target.Stun(1 SECONDS)
		scream_target.apply_status_effect(/datum/status_effect/regenerative_core)

	void_mob.apply_status_effect(/datum/status_effect/void_run)
	StartCooldown()

/datum/status_effect/void_run
	id = "Void run"
	duration = 20 SECONDS
	status_type = STATUS_EFFECT_REPLACE

/datum/status_effect/void_run/on_apply()
	. = ..()
	owner.add_movespeed_modifier(/datum/movespeed_modifier/void_run)
	to_chat(owner, span_notice("You can move faster for a while"))

/datum/status_effect/void_run/on_remove()
	. = ..()
	owner.remove_movespeed_modifier(/datum/movespeed_modifier/void_run)
	to_chat(owner, span_notice("You move with normal speed."))

/datum/movespeed_modifier/void_run
	id = "Void run"
	blacklisted_movetypes = FLYING
	multiplicative_slowdown = -3

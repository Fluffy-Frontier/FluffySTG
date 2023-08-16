#define VOID_LIGHT_BLINK_COOLDOWN 3 SECONDS
#define VOID_ANOMALY_NEUTRALIZER_STUN_COOLDOWN 60 SECONDS

/mob/living/simple_animal/hostile/void_creture
	name = "\improper Unknown"
	desc = "JUST RUN!"
	gender = NEUTER
	maxHealth = 10000
	health = 10000
	//Лечимся от любого брута, можем получать только бурн тип урона.
	damage_coeff = list(BRUTE = -1, BURN = 0.5, TOX = 0, CLONE = 0, STAMINA = 0, OXY = 0)
	combat_mode = TRUE
	speed = 4
	movement_type = GROUND
	attack_verb_continuous = "blusts"
	attack_verb_simple = "corrupt"
	attack_sound = 'sound/magic/demon_attack1.ogg'
	attack_vis_effect = ATTACK_EFFECT_SMASH
	icon = 'tff_modular/modules/void/icons/void_mob.dmi'
	icon_state = "void_creature"
	icon_living = "void_creature"
	icon_dead = "void_creature"
	obj_damage = 60
	can_buckle_to = FALSE
	melee_damage_upper = 70
	melee_damage_lower = 80
	mob_size = MOB_SIZE_HUGE
	armour_penetration = 100
	pixel_x = -8
	base_pixel_x = -8
	maptext_height = 48
	maptext_width = 48
	mouse_opacity = MOUSE_OPACITY_ICON
	death_message = "Oh.. siriosly? You kill that.. soo you need just know.. teshari the best.. ye-a... how did you do it?"
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_plas" = 0, "max_plas" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = -INFINITY
	maxbodytemp = INFINITY
	pressure_resistance = INFINITY

	//Должны ли мы тушить источники света вокруг нас!
	var/force_lighthing_blink = TRUE
	//Должны ли мы вызывать страх у всех, кто будет нас окружать!
	var/force_horror = TRUE
	//Должны ли мы оставлять лужу пустота за собой.
	var/void_steps = TRUE
	var/steps_with_no_void = 0 //Шаги, что были сделаны без эффекта пустоты.

	COOLDOWN_DECLARE(light_blink)

/mob/living/simple_animal/hostile/void_creture/Life(seconds_per_tick, times_fired)
	. = ..()
	if(isdead(src))
		return

	if(force_lighthing_blink)
		if(!COOLDOWN_FINISHED(src, light_blink))
			return

		//В начале ищем окрудающие источники света и зставляем их тухнут/моргать.
		for(var/atom/AO in range(9, src))
			if(isturf(AO) || istype(AO, /obj/effect))
				continue
			if(!AO.light_on)
				continue

			if(istype(AO, /obj/machinery/light))
				var/obj/machinery/light/l = AO
				if(l.status == LIGHT_BROKEN)
					continue
				l.break_light_tube()

			else if(istype(AO, /obj/item/flashlight))
				var/obj/item/flashlight/f = AO
				if(f.on)
					f.make_flick()

			else if(istype(AO,	/mob/living/carbon))
				var/mob/living/carbon/c = AO
				for(var/atom/thing in c.contents)
					if(istype(thing, /obj/item/flashlight))
						var/obj/item/flashlight/f = thing
						f.make_flick()
						continue
					thing.set_light_on(FALSE)

			else if(isobj(AO))
			//Выключаем источник света... удачи с этим.
				AO.set_light_on(FALSE)
				AO.update_light()
		COOLDOWN_START(src, light_blink, VOID_LIGHT_BLINK_COOLDOWN)

	if(force_horror)
		for(var/mob/living/carbon/human/h in view(src))
			if(isdead(h) || !h.client || !h.horror_effect_on || h.IsUnconscious())
				continue
			if(h.horror_state > HUMAN_HORROR_STATE_NORMAL)
				continue
			h.set_horror_state(HUMAN_HORROR_STATE_PANIC, time = 5 SECONDS)
			h.add_screeen_temporary_effect(/atom/movable/screen/fullscreen/void_brightless)

/mob/living/simple_animal/hostile/void_creture/AttackingTarget(atom/attacked_target)
	if(!combat_mode)
		if(istype(attacked_target, /turf/closed/wall))
			var/turf/closed/wall/w = attacked_target
			w.visible_message(span_black("[src.name], Beggin corrupt [w.name] with void!"))
			playsound(w, 'sound/machines/airlock_alien_prying.ogg', 100, TRUE)

			balloon_alert(src, "Beging crushing!")
			if(!do_after(src, 10 SECONDS, w))
				balloon_alert(src, "Stand still!")
				return

			balloon_alert(src, "Succesfull!")
			w.atom_destruction()
		else if(istype(attacked_target, /obj/machinery/door/airlock))
			var/obj/machinery/door/airlock/a = attacked_target
			playsound(a, 'sound/machines/airlock_alien_prying.ogg', 100, TRUE)

			if(a.locked)
				do_sparks(3, TRUE, a)
				a.visible_message(span_black("[src.name], beggin corrupt [a.name] bolts with void!"))
				balloon_alert(src, "Beging crawling bolt!")
				if(!do_after(src, 5 SECONDS, a))
					balloon_alert(src, "Stand still!")
					return
				do_sparks(3, TRUE, a)
				a.unlock()

			a.visible_message(span_black("[src.name], beggin force open [a.name]"))
			balloon_alert(src, "Beging opening!")
			do_sparks(3, TRUE, a)
			if(!do_after(src, 5 SECONDS, a))
				balloon_alert(src, "Stand still!")
				return

			a.open()
			do_sparks(3, TRUE, a)
			balloon_alert(src, "Succesfull!")
			return
	if(ismob(attacked_target))
		var/mob/t =	attacked_target
		to_chat(t, span_black("Void.. corrupt you..."))
	. = ..()

//Наносим урон тем, кто нас ударит... Пустота делает больно!
/mob/living/simple_animal/hostile/void_creture/attack_hand(mob/living/carbon/human/user, list/modifiers)
	. = ..()
	to_chat(user, span_black("Void.. corrupt you..."))
	user.apply_damage(25, BRUTE)

/mob/living/simple_animal/hostile/void_creture/Move(atom/newloc, dir, step_x, step_y)
	. = ..()
	if(void_steps && steps_with_no_void >= 2)
		steps_with_no_void = 0
		addtimer(CALLBACK(src, PROC_REF(make_void_step)), 5)
	steps_with_no_void++

/mob/living/simple_animal/hostile/void_creture/proc/make_void_step()
	new /obj/effect/temp_visual/void_step(loc, src)

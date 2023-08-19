#define VOID_LIGHT_BLINK_COOLDOWN 3 SECONDS

/mob/living/basic/void_creture
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
	attack_sound = 'tff_modular/modules/void/sounds/stab.ogg'
	attack_vis_effect = ATTACK_EFFECT_SLASH
	icon = 'tff_modular/modules/void/icons/void_mob.dmi'
	icon_state = "void_creature"
	icon_living = "void_creature"
	icon_dead = "void_creature"
	obj_damage = 15
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
	death_message = "Oh... seriously? You just killed it... so you need to know... TEHSHARI ARE THE BEST... yeah... so, how the hell did you do that!?"
	unsuitable_atmos_damage = 0
	basic_mob_flags = IMMUNE_TO_FISTS
	minimum_survivable_temperature = -INFINITY
	maximum_survivable_temperature = INFINITY
	pressure_resistance = INFINITY
	lighting_cutoff = LIGHTING_CUTOFF_HIGH
	zone_selected = BODY_ZONE_CHEST

	//Должны ли мы тушить источники света вокруг нас!
	var/force_lighthing_blink = TRUE
	//Должны ли мы вызывать страх у всех, кто будет нас окружать!
	var/force_horror = TRUE
	//Должны ли мы оставлять лужу пустота за собой.
	var/void_steps = TRUE
	var/steps_with_no_void = 0 //Шаги, что были сделаны без эффекта пустоты.

	//Наши абилки
	var/datum/action/cooldown/void_ability/scream/void_scream
	var/datum/action/cooldown/void_ability/toggle_light/light_blinking
	var/datum/action/cooldown/void_ability/toggle_nightvision/darknes_vision
	var/datum/action/cooldown/void_ability/void_teleport/teleport

	COOLDOWN_DECLARE(light_blink)

/mob/living/basic/void_creture/Initialize(mapload, true_spawn = FALSE)
	. = ..()
	if(!true_spawn)
		force_lighthing_blink = FALSE
		force_horror = FALSE
		void_steps = FALSE

	void_scream = new()
	light_blinking = new()
	darknes_vision = new()
	teleport = new()

	teleport.Grant(src)
	darknes_vision.Grant(src)
	void_scream.Grant(src)
	light_blinking.Grant(src)

	COOLDOWN_START(src, light_blink, VOID_LIGHT_BLINK_COOLDOWN)

/mob/living/basic/void_creture/void_creture/Destroy()
	. = ..()
	void_scream.Destroy()
	light_blinking.Destroy()
	darknes_vision.Destroy()
	teleport.Destroy()

	if(GLOB.void_creature == src)
		GLOB.void_creature = null

/mob/living/basic/void_creture/Life(seconds_per_tick, times_fired)
	. = ..()
	if(isdead(src))
		return

	if(force_lighthing_blink && COOLDOWN_FINISHED(src, light_blink))
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

			else if(istype(AO, /obj/item/modular_computer))
				var/obj/item/modular_computer/c = AO
				c.make_flick()

			//Самая сложная часть.. Вызывает эффекты у карбонов и их контента.
			else if(istype(AO,	/mob/living/carbon))
				var/mob/living/carbon/C = AO
				//Вызываем эффект моргания у фонарика МОДа.
				if(istype(C.back, /obj/item/mod/control))
					var/obj/item/mod/control/mc = C.back
					if(mc.active)
						for(var/m in mc.modules)
							if(istype(m, /obj/item/mod/module/flashlight))
								var/obj/item/mod/module/flashlight/mf = m
								mf.make_flick()

				for(var/atom/thing in C.contents)
					//Вызываем эффект моргания у ручного фонарика, если он есть.
					if(istype(thing, /obj/item/flashlight))
						var/obj/item/flashlight/f = thing
						f.make_flick()
						continue
					//Вызываем эффект моргания у любых модульных устройств.
					if(istype(thing, /obj/item/modular_computer))
						var/obj/item/modular_computer/mc = thing
						mc.make_flick()
						continue
					thing.set_light_on(FALSE)

			else if(isobj(AO))
			//Выключаем источник света... удачи с этим.
				AO.set_light_on(FALSE)
				AO.update_light()
		COOLDOWN_START(src, light_blink, VOID_LIGHT_BLINK_COOLDOWN)

	if(force_horror)
		for(var/mob/living/carbon/human/h in view(src))
			if(isdead(h) || !h.client || h.IsUnconscious())
				continue
			if(h.horror_state > HUMAN_HORROR_STATE_NORMAL)
				continue
			h.set_horror_state(HUMAN_HORROR_STATE_PANIC, time = 5 SECONDS)
			h.add_screeen_temporary_effect(/atom/movable/screen/fullscreen/void_brightless)
			h.light_out()

/mob/living/basic/void_creture/melee_attack(atom/target, list/modifiers)
	if(!combat_mode)
		if(istype(target, /obj/machinery/door/airlock))
			var/obj/machinery/door/airlock/a = target
			playsound(a, 'sound/machines/airlock_alien_prying.ogg', 100, TRUE)

			if(a.locked)
				do_sparks(3, TRUE, a)
				a.visible_message(span_userdanger("[src.name], starts melting through [a.name], slowly dissolving it in void!"))
				balloon_alert(src, "Opening an airlock!")
				if(!do_after(src, 5 SECONDS, a))
					balloon_alert(src, "Stand still!")
					return FALSE
				do_sparks(3, TRUE, a)
				a.unlock()

			a.visible_message(span_userdanger("[src.name], starts forcibly opening [a.name]!"))
			balloon_alert(src, "Opening an airlock!")
			do_sparks(3, TRUE, a)
			if(!do_after(src, 5 SECONDS, a))
				balloon_alert(src, "Stand still!")
				return FALSE

			a.open(BYPASS_DOOR_CHECKS)
			do_sparks(3, TRUE, a)
			balloon_alert(src, "Successful!")
			return FALSE

	if(istype(target, /turf/closed/wall))
		var/turf/closed/wall/w = target
		w.visible_message(span_userdanger("[src.name] starts melting through the [w.name] dissolving it in void!"))
		playsound(w, 'sound/machines/airlock_alien_prying.ogg', 100, TRUE)

		balloon_alert(src, "Destroying wall!")
		if(!do_after(src, 10 SECONDS, w))
			balloon_alert(src, "Stand still!")
			return FALSE

		balloon_alert(src, "Successful!")
		playsound(w, 'tff_modular/modules/void/sounds/stab.ogg', 100, TRUE)
		w.atom_destruction()
		new /obj/effect/temp_visual/voidout(get_turf(w))
		return FALSE

	if(ishuman(target))
		var/mob/living/carbon/human/H = target
		var/obj/item/bodypart/chest/C = H.get_bodypart(BODY_ZONE_CHEST)
		var/datum/wound/inner_void/infected/void_infection
		if(!(H.all_wounds & void_infection))
			void_infection = new()
			void_infection.apply_wound(C)
			to_chat(H, span_black("Void corrupts you."))

	return ..(target, modifiers)

//Наносим урон тем, кто нас ударит... Пустота делает больно!
/mob/living/basic/void_creture/attack_hand(mob/living/carbon/human/user, list/modifiers)
	. = ..()
	to_chat(user, span_black("Void corrupts you."))
	user.apply_damage(25, BRUTE)

/mob/living/basic/void_creture/say(message, bubble_type, list/spans, sanitize, datum/language/language, ignore_spam, forced, filterproof, message_range, datum/saymode/saymode)
	return FALSE

/mob/living/basic/void_creture/gib()
	return FALSE

/mob/living/basic/void_creture/Move(atom/newloc, dir, step_x, step_y)
	. = ..()
	if(void_steps && steps_with_no_void >= 2)
		steps_with_no_void = 0
		addtimer(CALLBACK(src, PROC_REF(make_void_step)), 5)
	steps_with_no_void++

/mob/living/basic/void_creture/proc/make_void_step()
	new /obj/effect/temp_visual/void_step(loc, src)

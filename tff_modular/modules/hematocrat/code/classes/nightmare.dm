// Класс Кошмара. Накладывает негативные эффекты. Планируется как дебаффер

// Зрение ужаса. Дает термальное зрение, ночное зрение, Глаза при активации становятся красными, что можно обнаружить при экзамайне.
/datum/action/cooldown/hematocrat/beast_vision
	name = "The Feelings Of The Terror"
	desc = "Gives you thermal and night vision, also you can hear throught walls, but at the same time, your eyes start to glow strangely and anyone can see it."
	button_icon = 'icons/mob/actions/actions_cult.dmi'
	button_icon_state = "horror"
	background_icon = 'icons/mob/actions/backgrounds.dmi'
	background_icon_state = "bg_fugu"
	overlay_icon = 'icons/mob/actions/backgrounds.dmi'
	overlay_icon_state = "bg_fugu_border"
	cooldown_time = 60 SECONDS
	click_to_activate = FALSE
	var/static/list/vision_traits = list(
		TRAIT_TRUE_NIGHT_VISION,
		TRAIT_HEAR_THROUGH_DARKNESS,
		TRAIT_BLOODSHOT_EYES,
		TRAIT_UNNATURAL_RED_GLOWY_EYES,
		TRAIT_XRAY_HEARING,
		TRAIT_THERMAL_VISION,
	)

/datum/action/cooldown/hematocrat/beast_vision/Remove(mob/living/remove_from)
	if(HAS_TRAIT(remove_from, TRAIT_BLOODSHOT_EYES))
		remove_from.remove_traits(vision_traits, ACTION_TRAIT)
		remove_from.update_sight()
	return ..()

/datum/action/cooldown/hematocrat/beast_vision/Activate(atom/target)

	if(HAS_TRAIT(owner, TRAIT_BLOODSHOT_EYES))
		owner.balloon_alert(owner, "Beast vision removed")
		owner.remove_traits(vision_traits, ACTION_TRAIT)

	else
		owner.balloon_alert(owner, "Beast vision activated")
		owner.add_traits(vision_traits, ACTION_TRAIT)

	owner.update_sight()
	return TRUE

// Уклонение. Дает уклонение от мили атак (50% шанс) и от дальних (35% шанс), но игрок теряет возможность нормально стрелять.
/datum/action/cooldown/hematocrat/dodging
	name = "Dodging"
	desc = "Allow you to dodge attacks with a some chance, but you lose the ability to aim properly with ranged weapon!"
	cooldown_time = 5 SECONDS
	button_icon = 'icons/mob/actions/actions_spells.dmi'
	button_icon_state = "lace"
	var/active = FALSE
	var/min_spread_bonus = 15
	var/max_spread_bonus = 40

/datum/action/cooldown/hematocrat/dodging/Remove(mob/removed_from)
	. = ..()
	var/mob/living/carbon/dodger = removed_from
	if(active)
		UnregisterSignal(dodger, list(COMSIG_ATOM_PRE_BULLET_ACT, COMSIG_ATOM_ATTACKBY, COMSIG_MOB_FIRED_GUN))
		dodger.remove_filter("dodger")

/datum/action/cooldown/hematocrat/dodging/Activate(atom/target)
	. = ..()
	var/mob/living/carbon/dodger = owner
	if(active)
		UnregisterSignal(dodger, list(COMSIG_ATOM_PRE_BULLET_ACT, COMSIG_ATOM_ATTACKBY, COMSIG_MOB_FIRED_GUN))
		dodger.remove_filter("dodger")
		active = FALSE
		return FALSE

	active = TRUE
	RegisterSignal(dodger, COMSIG_ATOM_PRE_BULLET_ACT, PROC_REF(on_bullet))
	RegisterSignal(dodger, COMSIG_ATOM_ATTACKBY, PROC_REF(on_melee))
	RegisterSignal(dodger, COMSIG_MOB_FIRED_GUN, PROC_REF(on_fire))
	dodger.add_filter("dodger", 2, list("type" = "blur", "size" = 1.5))

/datum/action/cooldown/hematocrat/dodging/proc/on_melee(mob/living/dodger, obj/item/attack_weapon, mob/attacker, list/modifiers)
	SIGNAL_HANDLER
	if(attacker == owner)
		return

	if(prob(50))
		playsound(dodger, 'sound/effects/parry.ogg', 75, TRUE)
		to_chat(dodger, span_warning("[dodger] has parried [attacker]'s attack!"))
		return COMPONENT_NO_AFTERATTACK

/datum/action/cooldown/hematocrat/dodging/proc/on_fire(mob/user, obj/item/gun/gun_fired, target, params, zone_override, list/bonus_spread_values)
	SIGNAL_HANDLER
	bonus_spread_values[MIN_BONUS_SPREAD_INDEX] += min_spread_bonus
	bonus_spread_values[MAX_BONUS_SPREAD_INDEX] += max_spread_bonus

/datum/action/cooldown/hematocrat/dodging/proc/on_bullet(/obj/proj, def_zone, piercing_hit, blocked)
	SIGNAL_HANDLER
	var/mob/living/carbon/dodger = owner
	if(prob(35))
		playsound(dodger, SFX_BULLET_MISS, 75, TRUE)
		return COMPONENT_BULLET_PIERCED

// Если у игроков в радиусе уровень настроения ниже нейтрального, удаляет им все временные муды и лечится, получая мудбафф.
/datum/action/cooldown/hematocrat/absorb_emotions
	name = "Absorb Emotions"
	desc = "Absorbs the negative emotions of people within a 4x4 radius and heals by it."
	cooldown_time = 30 SECONDS
	button_icon = 'tff_modular/modules/hematocrat/icons/hematocraticons.dmi'
	button_icon_state = "absorb"

/datum/action/cooldown/hematocrat/absorb_emotions/Activate(atom/target)
	. = ..()
	var/heal_amount = 0
	var/mob/living/carbon/absorber = owner
	for (var/mob/living/carbon/candidate in view(2, absorber))
		if(HAS_TRAIT(candidate, TRAIT_HEMATOCRAT))
			continue
		heal_amount += 5
		if(candidate.mob_mood.mood_level < MOOD_LEVEL_NEUTRAL)
			candidate.mob_mood.remove_temp_moods()
			candidate.mob_mood.set_sanity(SANITY_NEUTRAL)
			candidate.add_mood_event("absorbed emotions", /datum/mood_event/absorbed_emotions)
			to_chat(candidate, span_danger("You feel empty..."))
			to_chat(absorber, span_warning("You have absorbed [candidate] emotions!"))
			absorber.Beam(candidate, icon = 'tff_modular/modules/hematocrat/icons/smol_effects.dmi', icon_state = "terror", time = 3 SECONDS)

	if(heal_amount >= 5)
		absorber.adjustBruteLoss(-heal_amount)
		absorber.adjustFireLoss(-heal_amount)
		absorber.adjustToxLoss(-heal_amount)
		absorber.adjustOxyLoss(-heal_amount)
		absorber.add_mood_event("Fed up with emotions", /datum/mood_event/fed_up_with_emotions)

	heal_amount = 0

// Накладывает на игроков в радиусе яд, который заставляет их экран плавно темнеть, накладывает муддебафф, убирает временные муды.
/datum/action/cooldown/hematocrat/terror
	name = "Terror"
	desc = "Fill everyone in a 4x4 radius with poison, which spoils their mood and leads to panic, disrupting their eyesight."
	cooldown_time = 120 SECONDS
	var/list/to_terror = list()
	button_icon = 'tff_modular/modules/hematocrat/icons/smol_effects.dmi'
	button_icon_state = "terror"

/datum/action/cooldown/hematocrat/terror/Activate(atom/target)
	. = ..()
	var/mob/living/carbon/terror = owner
	for (var/mob/living/carbon/candidate in view(2, terror))
		if(HAS_TRAIT(candidate, TRAIT_HEMATOCRAT))
			continue
		to_terror[candidate] =  TRUE

	for (var/mob/living/carbon/candidate as anything in to_terror)
		if(candidate.mob_mood.mood_level >= MOOD_LEVEL_NEUTRAL)
			candidate.mob_mood.remove_temp_moods()
			candidate.mob_mood.set_sanity(SANITY_CRAZY)
			candidate.reagents.add_reagent(/datum/reagent/drug/hallucinogen, 10)

	new /obj/effect/temp_visual/terror_hit(terror.loc)

/datum/mood_event/absorbed_emotions
	description = "I feel empty... And I like it"
	mood_change = 10
	timeout = 1 MINUTES

/datum/mood_event/filled_emotions
	description = "What is happening?!"
	mood_change = -15

/datum/mood_event/fed_up_with_emotions
	description = "I Fed up with emotions."
	mood_change = 15
	timeout = 3 MINUTES

/datum/reagent/drug/hallucinogen
	name = "Hallucinogen"
	description = "A strong hallucinogenic drug."
	color = "#e70000"
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	taste_description = "something awful"
	ph = 11
	overdose_threshold = 30
	chemical_flags = REAGENT_IGNORE_STASIS

/datum/reagent/drug/hallucinogen/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	. = ..()
	if(SPT_PROB(5, seconds_per_tick))
		var/terror_message = pick("You feel terrible.","You feel anxiety.","You saw someone.","Someone is nearby.","Your heart beats quickly.","Do you know what a nightmare really is?","You're alone. Now you're alone.","WHAT HAPPENED TO YOU?")
		to_chat(affected_mob, span_bad("[terror_message]"))

/datum/reagent/drug/hallucinogen/on_mob_metabolize(mob/living/carbon/affected_mob)
	. = ..()

	affected_mob.add_mood_event("terrored", /datum/mood_event/filled_emotions)

	if(!affected_mob.hud_used)
		return

	var/atom/movable/plane_master_controller/game_plane_master_controller = affected_mob.hud_used.plane_master_controllers[PLANE_MASTERS_GAME]

	// фильтры для затемнения
	var/list/col_filter_identity = list(1,0,0,0, 0,1,0,0, 0,0,1,0, 0,0,0,1, 0,0,0,0)
	var/list/col_filter_darken = list(0.3,0,0,0, 0,0.3,0,0, 0,0,0.3,0, 0,0,0,1, -0.2,-0.2,-0.2,0)
	var/list/col_filter_black = list(0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,1, -0.5,-0.5,-0.5,0)
	var/list/col_filter_partial = list(0.6,0,0,0, 0,0.6,0,0, 0,0,0.6,0, 0,0,0,1, -0.1,-0.1,-0.1,0)

	game_plane_master_controller.add_filter("terror", 10, color_matrix_filter(col_filter_identity, FILTER_COLOR_HSL))

	// циклично затемняет и осветляет экран
	for(var/filter in game_plane_master_controller.get_filters("terror"))
		animate(filter, color = col_filter_identity, time = 2 SECONDS, loop = -1, flags = ANIMATION_PARALLEL)
		animate(color = col_filter_partial, time = 3 SECONDS)
		animate(color = col_filter_darken, time = 4 SECONDS)
		animate(color = col_filter_black, time = 2 SECONDS)
		animate(color = col_filter_darken, time = 2 SECONDS)
		animate(color = col_filter_partial, time = 3 SECONDS)
		animate(color = col_filter_identity, time = 4 SECONDS)

/datum/reagent/drug/hallucinogen/on_mob_end_metabolize(mob/living/carbon/affected_mob)
	. = ..()
	affected_mob.clear_mood_event("terrored")
	if(!affected_mob.hud_used)
		return

	var/atom/movable/plane_master_controller/game_plane_master_controller = affected_mob.hud_used.plane_master_controllers[PLANE_MASTERS_GAME]
	game_plane_master_controller.remove_filter("terror")

/obj/effect/temp_visual/terror_hit
	name = "\improper Terror"
	icon = 'tff_modular/modules/hematocrat/icons/96x160.dmi'
	icon_state = "terror"
	layer = ABOVE_ALL_MOB_LAYER
	plane = ABOVE_GAME_PLANE
	pixel_y = -32
	pixel_x = -32
	duration = 10

#define LEAP_SHOCKWAVE_DAMAGE 45
#define LEAP_CONE_DAMAGE 55

/*--------------------------------
	Leap
--------------------------------*/
/datum/action/cooldown/mob_cooldown/lava_swoop/high_leap
	name = "High Leap"
	desc = "Leaps to a target location, dealing damage around the landing point, and knockdown in a frontal cone"
	background_icon_state = "bg_demon"
	button_icon = null
	button_icon_state = ""
	cooldown_time = 6 SECONDS
	var/sound_file = list('tff_modular/modules/deadspace/sound/effects/impacts/hard_impact_1.ogg',
	'tff_modular/modules/deadspace/sound/effects/impacts/hard_impact_2.ogg',
	'tff_modular/modules/deadspace/sound/effects/impacts/low_impact_1.ogg',
	'tff_modular/modules/deadspace/sound/effects/impacts/low_impact_2.ogg')


/datum/action/cooldown/mob_cooldown/lava_swoop/high_leap/attack_sequence(atom/target)
	swoop_attack(target)

/datum/action/cooldown/mob_cooldown/lava_swoop/high_leap/Activate(atom/target_atom)

	if (get_turf(target_atom) == get_turf(src))
		return
	var/mob/living/carbon/human/necromorph/tripod = owner
	tripod.play_necro_sound(SOUND_SHOUT, VOLUME_MID, 1, 2)
	return ..()

/datum/action/cooldown/mob_cooldown/lava_swoop/high_leap/swoop_attack(atom/target, lava_arena = FALSE)
	if(swooping || !target)
		return
	var/mob/living/carbon/human/necromorph/tripod = owner
	// stop swooped target movement
	swooping = TRUE
	owner.add_traits(list(TRAIT_GODMODE, TRAIT_UNDENSE), SWOOPING_TRAIT)
	owner.visible_message(span_boldwarning("[owner] swoops up high!"))
	var/negative
	var/initial_x = owner.x
	if(target.x < initial_x) //if the target's x is lower than ours, swoop to the left
		negative = TRUE
	else if(target.x > initial_x)
		negative = FALSE
	else if(target.x == initial_x) //if their x is the same, pick a direction
		negative = prob(50)
	negative = !negative //invert it for the swoop down later

	var/oldtransform = owner.transform
	owner.alpha = 255
	animate(owner, alpha = 204, transform = matrix()*0.9, time = 3, easing = BOUNCE_EASING)
	for(var/i in 1 to 3)
		sleep(0.1 SECONDS)
		if(QDELETED(owner) || owner.stat == DEAD) //we got hit and died, rip us
			if(owner.stat == DEAD)
				swooping = FALSE
				animate(owner, alpha = 255, transform = oldtransform, time = 0, flags = ANIMATION_END_NOW) //reset immediately
			return
	animate(owner, alpha = 100, transform = matrix()*0.7, time = 7)
	SEND_SIGNAL(owner, COMSIG_SWOOP_INVULNERABILITY_STARTED)
	owner.mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	SLEEP_CHECK_DEATH(7, owner)

	var/turf/target_turf = get_turf(target)
	while(!QDELETED(target) && owner.loc != target_turf && owner.z == target_turf.z)
		owner.forceMove(get_step(owner, get_dir(owner, target_turf)))
		SLEEP_CHECK_DEATH(0.5, owner)
		target_turf = get_turf(target)

	var/descentTime = 10

	//ensure swoop direction continuity.
	if(negative)
		if(ISINRANGE(owner.x, initial_x + 1, initial_x + 5))
			negative = FALSE
	else
		if(ISINRANGE(owner.x, initial_x - 5, initial_x - 1))
			negative = TRUE
	new /obj/effect/temp_visual/dragon_swoop(owner.loc)
	animate(owner, alpha = 255, transform = oldtransform, descentTime)
	SLEEP_CHECK_DEATH(descentTime, owner)
	owner.mouse_opacity = initial(owner.mouse_opacity)
	for(var/mob/living/victim in range(1, owner) - owner)
		if(!QDELETED(victim)) // Some mobs are deleted on death
			if (victim == tripod)
				continue
			if(isnecromorph(victim))
				continue
			shake_camera(victim,8,2)
			victim.Knockdown(1 SECONDS)
			victim.attack_necromorph(owner, dealt_damage = LEAP_SHOCKWAVE_DAMAGE)
	for(var/obj/vehicle/sealed/mecha/mech in orange(1, owner))
		mech.take_damage(75, BRUTE, MELEE, 1)
	owner.remove_traits(list(TRAIT_GODMODE, TRAIT_UNDENSE), SWOOPING_TRAIT)
	SLEEP_CHECK_DEATH(1, owner)
	swooping = FALSE

	//We play a sound!
	var/sound = pick(sound_file)
	playsound(owner, sound, VOLUME_MID, TRUE)

	new /obj/effect/temp_visual/expanding_circle/tripod(tripod.loc, 0.65 SECONDS, 1.5)
	spawn(1.5)
	new /obj/effect/temp_visual/expanding_circle/tripod(tripod.loc, 0.65 SECONDS, 1.5)
	spawn(3)
	new /obj/effect/temp_visual/expanding_circle/tripod(tripod.loc, 0.75 SECONDS, 1.5)
	var/turf/target_turfs = get_line(get_turf(tripod), get_ranged_target_turf(get_turf(tripod), tripod.dir, 4))
	for (var/turf/T as anything in target_turfs)
		for (var/mob/living/L in T)
			if (L == tripod)
				continue

			if(isnecromorph(L))
				continue

			L.Stun(2 SECONDS)
			L.attack_necromorph(owner, dealt_damage = LEAP_CONE_DAMAGE)
			shake_camera(L,10,3)

/obj/effect/temp_visual/expanding_circle/tripod
	color = "#EE0000"

#undef LEAP_SHOCKWAVE_DAMAGE
#undef LEAP_CONE_DAMAGE

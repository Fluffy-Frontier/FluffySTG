/mob/living/simple_animal/hostile/abnormality/yang
	name = "Yang"
	desc = "A floating white fish that seems to help everyone near it."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/64x64.dmi'
	icon_state = "yang"
	icon_living = "yang"
	var/icon_breach = "yang_breach"
	icon_dead = "yang_slain"
	maxHealth = 800	//It is helpful and therefore weak.
	health = 800
	move_to_delay = 7
	pixel_x = -16
	base_pixel_x = -16
	pixel_y = -8
	base_pixel_y = -8
	stat_attack = HARD_CRIT

	//work stuff
	can_breach = TRUE
	fear_level = WAW_LEVEL

	ego_list = list(
		/datum/ego_datum/weapon/assonance,
		/datum/ego_datum/armor/assonance,
	)
	gift_type = /datum/ego_gifts/assonance
	grouped_abnos = list(
		/mob/living/simple_animal/hostile/abnormality/yin = 5, // TAKE THE FISH. DO IT NOW.
	)

	//Melee
	damage_coeff = list(BURN = 1, BRAIN = 0.2, BRUTE = 1.7, TOX = 2)
	melee_damage_lower = 30
	melee_damage_upper = 30
	melee_damage_type = BRUTE
	faction = list("neutral")	//Doesn't attack until attacked.

	//Ranged. Simple AI to help it work
	ranged = 1
	retreat_distance = 2
	minimum_distance = 5
	projectiletype = /obj/projectile/beam/yang
	projectilesound = 'sound/items/weapons/sear.ogg'

	observation_prompt = "The Angel's Pendant was one half of a greater whole, but now they've been cleaved in half, forever wanting to reunite. <br>\
		The pendant laid upon the podium before you, even being in the same room as it seemed to fortify your body and soul."


	var/explosion_damage = 150
	var/explosion_timer = 7 SECONDS
	var/explosion_range = 15
	var/exploding = FALSE

	//slowly heals sanity over time
	var/heal_cooldown
	var/heal_cooldown_time = 3 SECONDS
	var/heal_amount = 5
	update_qliphoth = 0

/mob/living/simple_animal/hostile/abnormality/yang/Initialize(mapload)
	. = ..()
	addtimer(CALLBACK(src, PROC_REF(healing_check)), heal_cooldown_time)

/mob/living/simple_animal/hostile/abnormality/yang/Move()
	if(exploding || SSlobotomy_events.yang_downed)
		return
	return ..()

/mob/living/simple_animal/hostile/abnormality/yang/proc/healing_check()
	if((heal_cooldown < world.time) && !(HAS_TRAIT(src, TRAIT_GODMODE)))
		HealPulse()
	addtimer(CALLBACK(src, PROC_REF(healing_check)), heal_cooldown_time)

/mob/living/simple_animal/hostile/abnormality/yang/try_working(mob/living/carbon/human/user)
	neutral_chance = YinCheck() ? 50 : 35
	return ..()

/mob/living/simple_animal/hostile/abnormality/yang/proc/YinCheck()
	for(var/datum/abnormality/AD in SSlobotomy_corp.all_abnormality_datums)
		if(AD.abno_path == /mob/living/simple_animal/hostile/abnormality/yin)
			return TRUE
	return FALSE

/mob/living/simple_animal/hostile/abnormality/yang/bullet_act(obj/projectile/P, def_zone, piercing_hit = FALSE)
	apply_damage(P.damage, P.damage_type)
	P.on_hit(src, 0, piercing_hit)
	if(!P.firer)
		return BULLET_ACT_HIT
	Reflect(P.firer, P.damage)
	return ..()

/mob/living/simple_animal/hostile/abnormality/yang/attacked_by(obj/item/I, mob/living/user)
	. = ..()
	Reflect(user, I.force)
	return

/mob/living/simple_animal/hostile/abnormality/yang/attack_hand(mob/living/carbon/human/M)
	. = ..()
	Reflect(M, 2)
	return

/mob/living/simple_animal/hostile/abnormality/yang/attack_animal(mob/living/simple_animal/M)
	. = ..()
	Reflect(M, M.melee_damage_upper)
	return

/mob/living/simple_animal/hostile/abnormality/yang/proc/Reflect(mob/living/attacker, damage)
	if(ishuman(attacker))
		var/mob/living/carbon/human/H = attacker
		var/justice_mod = 1 + (H.get_clothing_class_level(CLOTHING_ARMORED))
		damage *= justice_mod
	attacker.apply_damage(damage, BRUTE)
	return

/mob/living/simple_animal/hostile/abnormality/yang/death()
	//Make sure we didn't get cheesed, and blow up.
	if(health > 0)
		return
	if(YinCheck() && SSlobotomy_events.yin_downed)
		SSlobotomy_events.yang_downed = TRUE
		return ..()
	if(SSlobotomy_events.yin_downed) // This is always true unless Yin exists and modifies it.
		icon_state = "yang_blow"
		exploding = TRUE
		SSlobotomy_events.yang_downed = TRUE
		addtimer(CALLBACK(src, PROC_REF(explode)), explosion_timer)
		return
	if(SSlobotomy_events.yang_downed)
		return
	INVOKE_ASYNC(src, PROC_REF(BeDead))

/mob/living/simple_animal/hostile/abnormality/yang/proc/BeDead()
	icon_state = icon_dead
	playsound(src, 'sound/effects/magic.ogg', 60)
	SSlobotomy_events.yang_downed = TRUE
	ChangeResistances(list(BURN = 0, BRAIN = 0, BRUTE = 0, TOX = 0))
	for(var/i = 1 to 12)
		SLEEP_CHECK_DEATH(5 SECONDS, src)
		if(SSlobotomy_events.yin_downed)
			death()
			return
	adjustBruteLoss(-maxHealth, forced = TRUE)
	ChangeResistances(list(BURN = 1, BRAIN = 0.2, BRUTE = 1.7, TOX = 2))
	SSlobotomy_events.yang_downed = FALSE
	icon_state = icon_breach

/mob/living/simple_animal/hostile/abnormality/yang/proc/explode()
	exploding = TRUE
	new /obj/effect/temp_visual/explosion/fast(get_turf(src))
	var/turf/orgin = get_turf(src)
	var/list/all_turfs = RANGE_TURFS(explosion_range, orgin)
	alpha = 0

	for(var/i = 0 to explosion_range)
		for(var/turf/T in all_turfs)
			if(T.density)
				continue
			if(get_dist(src, T) > i)
				continue
			new /obj/effect/temp_visual/dir_setting/speedbike_trail(T)
			HurtInTurf(T, list(), explosion_damage, BRUTE, hurt_mechs = TRUE)
			all_turfs -= T
		SLEEP_CHECK_DEATH(1, src)

	QDEL_NULL(src)


/mob/living/simple_animal/hostile/abnormality/yang/proc/HealPulse()
	heal_cooldown = world.time + heal_cooldown_time

	for(var/mob/living/carbon/human/H in view(15, src))
		if(H.stat == DEAD)
			continue
		H.adjustSanityLoss(-heal_amount) // It's healing
		new /obj/effect/temp_visual/emp/pulse(get_turf(H))


/obj/projectile/beam/yang
	name = "yang beam"
	icon_state = "omnilaser"
	hitscan = TRUE
	damage = 70
	damage_type = BRUTE
	muzzle_type = /obj/effect/projectile/muzzle/laser/white
	tracer_type = /obj/effect/projectile/tracer/laser/white
	impact_type = /obj/effect/projectile/impact/laser/white

/obj/effect/projectile/muzzle/laser/white
	name = "white flash"
	icon_state = "muzzle_white"

/obj/effect/projectile/tracer/laser/white
	name = "white beam"
	icon_state = "beam_white"

/obj/effect/projectile/impact/laser/white
	name = "white impact"
	icon_state = "impact_white"


/mob/living/simple_animal/hostile/abnormality/yang/FailureEffect(mob/living/carbon/human/user)
	qliphoth_change(-1)
	for(var/datum/abnormality/AD in SSlobotomy_corp.all_abnormality_datums)
		if(AD.abno_path != /mob/living/simple_animal/hostile/abnormality/yin)
			continue
		AD.current.qliphoth_change(-1)
		break
	return

/mob/living/simple_animal/hostile/abnormality/yang/BreachEffect(mob/living/carbon/human/user, breach_type)
	. = ..()
	icon_state = icon_breach
	SSlobotomy_events.yang_downed = FALSE

/mob/living/simple_animal/hostile/abnormality/yang/PostWorkEffect(mob/living/carbon/human/user)
	if(prob(negative_chance))
		qliphoth_change(-2)
	return

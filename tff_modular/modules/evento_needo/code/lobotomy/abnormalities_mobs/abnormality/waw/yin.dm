/mob/living/simple_animal/hostile/abnormality/yin
	name = "Yin"
	desc = "A floating black fish that seems to hurt everyone near it."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/64x64.dmi'
	icon_state = "yin"
	icon_living = "yin"
	var/icon_breach = "yin_breach"
	icon_dead = "yin_slain"
	maxHealth = 1600
	health = 1600
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
		/datum/ego_datum/weapon/discord,
		/datum/ego_datum/armor/discord,
	)
	gift_type = /datum/ego_gifts/discord
	grouped_abnos = list(
		/mob/living/simple_animal/hostile/abnormality/yang = 5, // TAKE THE FISH. DO IT
	)

	observation_prompt = "The Devil's Pendant was one half of a greater whole, but now they've been cleaved in half, forever wanting to reunite. <br>\
		The pendant laid upon the podium before you, even being in the same room as it seemed to suck the life out of you and erodes your very essence."


	faction = list("neutral", "hostile") // Not fought by anything, typically. But...
	var/faction_override = list("hostile") // The effects hit non-hostiles.

	//Melee
	damage_coeff = list(BURN = 0.5, BRAIN = 1.5, BRUTE = 0, TOX = 1)
	melee_damage_lower = 60 // Doesn't actually swing individually
	melee_damage_upper = 60
	melee_damage_type = BRUTE

	//Ranged
	COOLDOWN_DECLARE(beam)
	var/beam_cooldown = 10 SECONDS
	var/beam_distance = 20

	COOLDOWN_DECLARE(pulse)
	var/pulse_cooldown = 5 SECONDS
	var/pulse_damage = 40
	var/pulse_distance = 4

	var/busy = FALSE

	var/list/hit_people = list()
	var/list/spawned_effects = list()
	var/list/prohibitted_flips = list(
		/mob/living/simple_animal/hostile/abnormality/nihil,
		/mob/living/simple_animal/hostile/abnormality/white_night,
		/mob/living/simple_animal/hostile/megafauna/apocalypse_bird,
		/mob/living/simple_animal/hostile/megafauna/arbiter,
		/mob/living/simple_animal/hostile/abnormality/yang,
		/mob/living/simple_animal/hostile/abnormality/yin,
	)
	var/dragon_spawned = FALSE
	update_qliphoth = 0

/mob/living/simple_animal/hostile/abnormality/yin/Login()
	. = ..()
	to_chat(src, "<h1>You are Yin, A Tank Role Abnormality.</h1><br>\
		<b>|Ruination|: When you click on a tile which is not right next to you, you will fire a laser towards that tile. \
		The laser deal BLACK damage, and has a 10 second cooldown.<br>\
		<br>\
		|Decay|: Each time you take damage, if your pulse is off cooldown. You will send out a pulse around you, which deals BLACK damage to all humans. \
		The Pulse has a cooldown of 8 seconds.</b>")

/mob/living/simple_animal/hostile/abnormality/yin/Life()
	if(!..())
		return FALSE
	if(dragon_spawned)
		return FALSE
	if(SSlobotomy_events.yin_downed)
		return FALSE
	var/mob/living/simple_animal/hostile/abnormality/yang/yang
	for(var/mob/living/L in view(2, src))
		if(istype(L, /mob/living/simple_animal/hostile/abnormality/yang))
			yang = L
			SSlobotomy_events.YY_middle = null
			SSlobotomy_events.YY_breached = list()
	if(!yang)
		return
	if(SSlobotomy_events.yang_downed)
		return
	if(HAS_TRAIT(yang, TRAIT_GODMODE))
		return
	SpawnDragon(yang)

/mob/living/simple_animal/hostile/abnormality/yin/Move()
	if(busy || SSlobotomy_events.yin_downed)
		return FALSE
	return ..()

/mob/living/simple_animal/hostile/abnormality/yin/Moved(atom/old_loc, movement_dir, forced, list/old_locs, momentum_change)
	if(!COOLDOWN_FINISHED(src, pulse) || SSlobotomy_events.yin_downed)
		return ..()
	var/turfs_to_check = view(2, src)
	for(var/mob/living/L in turfs_to_check)
		if(L == src)
			continue
		if(HAS_TRAIT(L, TRAIT_GODMODE))
			continue
		if(faction_check(L.faction, faction_override))
			continue
		if(L.stat >= DEAD)
			continue
		COOLDOWN_START(src, pulse, pulse_cooldown)
		INVOKE_ASYNC(src, PROC_REF(Pulse))
		return ..()
	for(var/obj/vehicle/sealed/mecha/M in turfs_to_check)
		if(!M.occupants || length(M.occupants) == 0)
			continue
		COOLDOWN_START(src, pulse, pulse_cooldown)
		INVOKE_ASYNC(src, PROC_REF(Pulse))
		return ..()
	return ..()

/mob/living/simple_animal/hostile/abnormality/yin/death(gibbed)
	if(SSlobotomy_events.yang_downed)
		SSlobotomy_events.yin_downed = TRUE
		return ..()
	if(SSlobotomy_events.yin_downed)
		return FALSE
	INVOKE_ASYNC(src, PROC_REF(BeDead))

/mob/living/simple_animal/hostile/abnormality/yin/proc/BeDead()
	icon_state = icon_dead
	playsound(src, 'sound/effects/magic.ogg', 60)
	SSlobotomy_events.yin_downed = TRUE
	ChangeResistances(list(BRUTE = 0, BRUTE = 0, BRUTE = 0))
	for(var/i = 1 to 12)
		SLEEP_CHECK_DEATH(5 SECONDS, src)
		if(SSlobotomy_events.yang_downed)
			death()
			return
	adjustBruteLoss(-maxHealth, forced = TRUE)
	ChangeResistances(list(BRUTE = 0.5, BRUTE = 1.5, BRUTE = 1))
	SSlobotomy_events.yin_downed = FALSE
	icon_state = icon_breach

/mob/living/simple_animal/hostile/abnormality/yin/Destroy()
	for(var/atom/AT in spawned_effects)
		qdel(AT)
	return ..()

/mob/living/simple_animal/hostile/abnormality/yin/try_working(mob/living/carbon/human/user)
	neutral_chance = YangCheck() ? 50 : 35
	return ..()

/mob/living/simple_animal/hostile/abnormality/yin/PostWorkEffect(mob/living/carbon/human/user)
	for(var/datum/abnormality/AD in SSlobotomy_corp.all_abnormality_datums)
		if(AD.abno_path != /mob/living/simple_animal/hostile/abnormality/yang)
			continue
		qliphoth_change(-1)
		break

/mob/living/simple_animal/hostile/abnormality/yin/BreachEffect(mob/living/carbon/human/user, breach_type)
	. = ..()
	icon_state = icon_breach
	SSlobotomy_events.yin_downed = FALSE

/mob/living/simple_animal/hostile/abnormality/yin/proc/PulseOrLaser(user)
	if(prob(50))
		FireLaser(user)
	else
		if(COOLDOWN_FINISHED(src, pulse) || SSlobotomy_events.yin_downed)
			COOLDOWN_START(src, pulse, pulse_cooldown)
			INVOKE_ASYNC(src, PROC_REF(Pulse))

/mob/living/simple_animal/hostile/abnormality/yin/attacked_by(obj/item/I, mob/living/user)
	. = ..()
	PulseOrLaser(user)

/mob/living/simple_animal/hostile/abnormality/yin/attack_hand(mob/living/carbon/human/M)
	. = ..()
	PulseOrLaser(M)

/mob/living/simple_animal/hostile/abnormality/yin/attack_animal(mob/living/simple_animal/M)
	. = ..()
	PulseOrLaser(M)

/mob/living/simple_animal/hostile/abnormality/yin/OpenFire()
	FireLaser(target)

/mob/living/simple_animal/hostile/abnormality/yin/bullet_act(obj/projectile/P, def_zone, piercing_hit = FALSE)
	apply_damage(P.damage, P.damage_type)
	P.on_hit(src, 0, piercing_hit)
	. = BULLET_ACT_HIT
	if(!P.firer)
		return .
	if(!isliving(P.firer) && !ismecha(P.firer))
		return .
	PulseOrLaser(P.firer)
	return ..()

/mob/living/simple_animal/hostile/abnormality/yin/AttackingTarget(atom/attacked_target)
	return FALSE

/mob/living/simple_animal/hostile/abnormality/yin/proc/Pulse()
	var/list/hit_turfs = list()
	var/list/hit = list()
	for(var/i = 1 to pulse_distance)
		var/list/to_hit = range(i, src) - hit_turfs
		hit_turfs |= to_hit
		for(var/turf/open/OT in to_hit)
			hit = HurtInTurf(OT, hit, pulse_damage, BRUTE, null, TRUE, faction_override, TRUE)
			new /obj/effect/temp_visual/small_smoke/yin_smoke/short(OT)
		sleep(3)

/mob/living/simple_animal/hostile/abnormality/yin/proc/FireLaser(mob/target)
	if(busy || !COOLDOWN_FINISHED(src, beam) || SSlobotomy_events.yin_downed)
		return FALSE
	busy = TRUE
	face_atom(target)
	var/turf/target_turf = get_ranged_target_turf_direct(src, target, beam_distance)
	var/list/to_hit = get_line(src, target_turf)
	var/datum/beam/beam = Beam(get_turf(src),"volt_ray")
	for(var/turf/open/OT in to_hit)
		if(!istype(OT) || OT.density)
			break
		beam.target = OT
		beam.redrawing()
		sleep(1)
		new /obj/effect/temp_visual/revenant/cracks/yin(OT)
	for(var/obj/effect/FX in spawned_effects)
		qdel(FX)
	qdel(beam)
	COOLDOWN_START(src, beam, beam_cooldown)
	busy = FALSE
	return TRUE

/mob/living/simple_animal/hostile/abnormality/yin/proc/SpawnDragon(mob/living/simple_animal/hostile/abnormality/yang/Y)
	if(!istype(Y))
		return
	REMOVE_TRAIT(Y, TRAIT_GODMODE, ADMIN_TRAIT)
	Y.forceMove(src)
	REMOVE_TRAIT(src, TRAIT_GODMODE, ADMIN_TRAIT)
	animate(src, 8, alpha = 0)
	new /obj/effect/temp_visual/guardian/phase
	dragon_spawned = TRUE
	var/start_dir = pick(NORTH, EAST, SOUTH, WEST)
	var/turf/start_turf
	var/turf/mid_turf = get_turf(src)
	var/angle
	switch(start_dir)
		if(NORTH)
			start_turf = locate(1, 255, src.z)
		if(EAST)
			start_turf = locate(255, 255, src.z)
		if(SOUTH)
			start_turf = locate(255, 1, src.z)
		if(WEST)
			start_turf = locate(1, 1, src.z)
	angle = get_angle(start_turf, mid_turf)
	angle += rand(-10, 10)
	var/turf/end_turf = get_turf_in_angle(angle, start_turf, 300)
	var/list/path = get_line(start_turf, end_turf)
	SEND_SOUND(world, (sound("tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/yin/dragon_spawn.ogg")))
	for(var/i = 0 to 7)
		var/obj/effect/yinyang_dragon/DP
		var/turf/T = path[15-(i*2)]
		var/list/temp_path = get_line(T, end_turf)
		switch(i)
			if(0)
				DP = new /obj/effect/yinyang_dragon/dragon_head(T)
				DP.layer += 0.1
				notify_ghosts("The Dragon has arrived!", source = DP, header="Something Interesting!")
			if(7)
				DP = new /obj/effect/yinyang_dragon/dragon_tail(T)
				DP.layer += 0.1
				src.forceMove(DP)
			else
				DP = new(T)
		var/matrix/M = matrix(DP.transform)
		M.Turn(angle-90)
		DP.transform = M
		MoveDragon(DP, temp_path)

/mob/living/simple_animal/hostile/abnormality/yin/proc/MoveDragon(obj/effect/yinyang_dragon/DP, list/path = list())
	set waitfor = FALSE
	if(path.len <= 0)
		qdel(DP)
		return
	for(var/turf/T in path)
		DP.forceMove(T)
		DragonFlip(DP)
		sleep(1)
	qdel(DP)

/mob/living/simple_animal/hostile/abnormality/yin/proc/DragonFlip(obj/effect/yinyang_dragon/DP)
	for(var/mob/living/L in range(2, DP))
		if(L in hit_people)
			continue
		if(L.type in prohibitted_flips)
			continue
		var/damage = L.health
		L.adjustBruteLoss(-L.maxHealth+40)
		L.adjustBruteLoss(damage+40)
		if(ishuman(L))
			var/mob/living/carbon/human/H = L
			damage = H.sanityhealth
			H.adjustSanityLoss(-H.maxSanity)
			H.adjustSanityLoss(damage)
		hit_people += L
		to_chat(L, span_userdanger("All that is shall become all that isn't."))

/mob/living/simple_animal/hostile/abnormality/yin/proc/YangCheck()
	for(var/datum/abnormality/AD in SSlobotomy_corp.all_abnormality_datums)
		if(AD.abno_path == /mob/living/simple_animal/hostile/abnormality/yang)
			return TRUE
	return FALSE

/obj/effect/yinyang_dragon
	name = "Avatar of Harmony"
	desc = "All that isn't shall become all that is."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/64x64.dmi'
	icon_state = "dragon_body"

/obj/effect/yinyang_dragon/Initialize(mapload)
	. = ..()
	src.transform *= 1.5

/obj/effect/yinyang_dragon/Destroy(force)
	. = ..()
	for(var/atom/at in src)
		qdel(at)

/obj/effect/yinyang_dragon/dragon_head
	icon_state = "dragon_head"

/obj/effect/yinyang_dragon/dragon_tail
	icon_state = "dragon_tail"

/obj/effect/temp_visual/small_smoke/yin_smoke
	color = COLOR_PURPLE
	duration = 10

/obj/effect/temp_visual/small_smoke/yin_smoke/short
	duration = 5

/obj/effect/temp_visual/small_smoke/yin_smoke/long
	duration = 20

/obj/effect/temp_visual/revenant/cracks/yin
	icon_state = "yincracks"
	duration = 9
	var/damage = 60
	faction = list("hostile")

/obj/effect/temp_visual/revenant/cracks/yin/Destroy()
	for(var/turf/T in range(1, src))
		for(var/mob/living/L in T)
			if(faction_check(L.faction, src.faction))
				continue
			L.apply_damage(damage, BRUTE)
		for(var/obj/vehicle/sealed/mecha/V in T)
			V.take_damage(damage, BRUTE)
		new /obj/effect/temp_visual/small_smoke/yin_smoke/long(T)
	return ..()

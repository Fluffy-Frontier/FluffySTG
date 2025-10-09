/mob/living/simple_animal/hostile/humanoid/blood
	faction = list("hostile")

/mob/living/simple_animal/hostile/humanoid/blood/fiend
	name = "bloodfiend"
	desc = "A humanoid wearing a bloody dress and a bird mask."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/blood_fiends_32x32.dmi'
	icon_state = "test_meifiend"
	icon_living = "test_meifiend"
	icon_dead = "test_meifiend_dead"
	damage_coeff = list(BRUTE = 1, BURN = 1.2, BRAIN = 0.8, BRUTE = 0.6, TOX = 1.3)
	melee_damage_lower = 8
	melee_damage_upper = 10
	melee_damage_type = BURN
	attack_sound = 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/nosferatu/attack.ogg'
	attack_verb_continuous = "slices"
	attack_verb_simple = "slice"
	maxHealth = 1000
	health = 1000
	ranged = TRUE

	var/leap_sound = 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/nosferatu/attack_special.ogg'
	var/blood_feast = 450
	var/max_blood_feast = 500
	var/can_act = TRUE
	var/leap_damage = 50
	var/slash_damage = 25
	var/drain_cooldown = 0
	var/drain_cooldown_time = 50
	var/bleed_stacks = 2
	var/leap_bleed_stacks = 5
	var/drop_outfit = TRUE

/mob/living/simple_animal/hostile/humanoid/blood/fiend/proc/AdjustBloodFeast(amount)
	if(stat != DEAD)
		adjustBruteLoss(-amount/4)
		blood_feast += amount
		if (blood_feast > max_blood_feast)
			blood_feast = max_blood_feast
	else
		return

/mob/living/simple_animal/hostile/humanoid/blood/fiend/death(gibbed)
	if(drop_outfit)
		if(prob(20))
			new /obj/item/clothing/suit/armor/ego_gear/city/masquerade_cloak (get_turf(src))
	. = ..()

/mob/living/simple_animal/hostile/humanoid/blood/fiend/proc/Drain()
	var/turf/T = get_turf(src)
	if(!T)
		return
	if (health != maxHealth || blood_feast != max_blood_feast)
		for(var/obj/effect/decal/cleanable/blood/B in view(T, 2)) //will clean up any blood, but only heals from human blood
			if (health != maxHealth || blood_feast != max_blood_feast)
				playsound(T, 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/nosferatu/bloodcollect.ogg', 25, 3)
				if(B.bloodiness == 100) //Bonus for "pristine" bloodpools, also to prevent footprint spam
					AdjustBloodFeast(30)
				else
					AdjustBloodFeast(max((B.bloodiness**2)/800,1))
				qdel(B)

/mob/living/simple_animal/hostile/humanoid/blood/fiend/proc/Dash(target_turf)
	target_turf = get_turf(target)
	var/list/hit_mob = list()
	shake_up_animation()
	if(do_after(src, 0.5 SECONDS, target = src))
		var/turf/wallcheck = get_turf(src)
		var/enemy_direction = get_dir(src, target_turf)
		for(var/i = 0 to 4)
			if(get_turf(src) != wallcheck || stat == DEAD)
				break
			wallcheck = get_step(src, enemy_direction)
			if(!ClearSky(wallcheck))
				break
			sleep(0.25)//without this the attack happens instantly
			forceMove(wallcheck)
			playsound(wallcheck, 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/doomsdaycalendar/Lor_Slash_Generic.ogg', 20, 0, 4)
			for(var/turf/T in orange(get_turf(src), 1))
				if(isclosedturf(T))
					continue
				var/obj/effect/temp_visual/slice/blood = new(T)
				blood.color = "#b52e19"
				hit_mob = HurtInTurf(T, hit_mob, slash_damage, BURN, null, TRUE, FALSE, TRUE, hurt_structure = TRUE)

/obj/effect/temp_visual/warning3x3/bloodfiend
	duration = 1.5 SECONDS

/mob/living/simple_animal/hostile/humanoid/blood/fiend/proc/Leap(mob/living/target)
	if(!isliving(target) && !ismecha(target) || !can_act)
		return
	blood_feast = 0
	can_act = FALSE
	SLEEP_CHECK_DEATH(0.25 SECONDS, src)
	animate(src, alpha = 1,pixel_x = 16, pixel_z = 0, time = 0.1 SECONDS)
	src.pixel_x = 16
	playsound(src, 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/ichthys/jump.ogg', 50, FALSE, 4)
	var/turf/target_turf = get_turf(target)
	var/obj/effect/temp_visual/warning3x3/W = new(target_turf)
	W.color = "#fa3217ac"
	SLEEP_CHECK_DEATH(1.5 SECONDS, src)
	if(target_turf)
		forceMove(target_turf) //look out, someone is rushing you!
	playsound(src, leap_sound, 50, FALSE, 4)
	animate(src, alpha = 255,pixel_x = -16, pixel_z = 0, time = 0.1 SECONDS)
	src.pixel_x = 0
	SLEEP_CHECK_DEATH(0.1 SECONDS, src)
	for(var/turf/T in view(1, src))
		var/obj/effect/temp_visual/small_smoke/halfsecond/FX =  new(T)
		FX.color = "#b52e19"
		for(var/mob/living/L in T)
			if(faction_check_atom(L))
				continue
			L.blood_volume -= L.blood_volume / leap_bleed_stacks
			L.apply_damage(leap_damage, BURN)
		for(var/obj/vehicle/sealed/mecha/V in T)
			V.take_damage(leap_damage, BURN)
	SLEEP_CHECK_DEATH(0.5 SECONDS, src)
	say("No... I NEED MORE!!!")
	SLEEP_CHECK_DEATH(1.5 SECONDS, src)
	Dash(target_turf)
	Dash(target_turf)
	can_act = TRUE

/mob/living/simple_animal/hostile/humanoid/blood/fiend/ClearSky(turf/T)
	. = ..()
	if(.)
		if(locate(/obj/structure/table) in T.contents)
			return FALSE
		if(locate(/obj/structure/railing) in T.contents)
			return FALSE

/mob/living/simple_animal/hostile/humanoid/blood/fiend/Life()
	. = ..()
	if(drain_cooldown > world.time)
		return FALSE
	if(stat == DEAD)
		return FALSE
	drain_cooldown = world.time + drain_cooldown_time
	Drain()

/mob/living/simple_animal/hostile/humanoid/blood/fiend/AttackingTarget()
	if(!can_act)
		return
	if(blood_feast == max_blood_feast && !client)
		Leap(target)
		return
	. = ..()
	if (istype(target, /mob/living))
		var/mob/living/L = target
		L.blood_volume -= L.blood_volume / bleed_stacks

/mob/living/simple_animal/hostile/humanoid/blood/fiend/OpenFire()
	if(!can_act)
		return FALSE
	if(max_blood_feast == blood_feast)
		Leap(target)
		return

/mob/living/simple_animal/hostile/humanoid/blood/fiend/Move()
	if(!can_act)
		return FALSE
	if(stat != DEAD)
		Drain()
	..()

/mob/living/simple_animal/hostile/humanoid/blood/fiend/boss
	name = "royal bloodfiend"
	desc = "A humanoid wearing a bloody suit and a bird mask. They appear to hold themselves in high regard."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/blood_fiends_32x32.dmi'
	icon_state = "b_boss"
	icon_living = "b_boss"
	icon_dead = "b_boss_dead"
	var/normal_state = "b_boss"
	var/hardblood_state = "b_boss_hardblood"
	var/exhausted_state = "b_boss_exhausted"
	damage_coeff = list(BRUTE = 1, BURN = 1, BRAIN = 0.6, BRUTE = 0.4, TOX = 1.5)
	melee_damage_lower = 7
	melee_damage_upper = 8
	melee_damage_type = BURN
	attack_sound = 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/nosferatu/attack.ogg'
	attack_verb_continuous = "slices"
	attack_verb_simple = "slice"
	maxHealth = 2300
	health = 2300
	ranged = TRUE
	slash_damage = 50
	blood_feast = 700
	max_blood_feast = 750
	var/cutter_bleed_stacks = 15
	var/readyToSpawn75 = TRUE
	var/timeToSpawn75
	var/readyToSpawn25 = TRUE
	var/timeToSpawn25
	var/cooldownToSpawn = 30 SECONDS
	var/cutter_hit = FALSE
	var/stun_duration = 3 SECONDS
	var/mob/living/blood_target
	var/summon_cost = 25
	var/slashing = FALSE

/mob/living/simple_animal/hostile/humanoid/blood/fiend/boss/AdjustBloodFeast(amount)
	. = ..()
	if (slashing)
		return

	if (blood_feast > max_blood_feast * 0.5)
		icon_state = hardblood_state
		melee_damage_lower = 10
		melee_damage_upper = 12
		melee_damage_type = BRUTE
	else
		icon_state = normal_state
		melee_damage_lower = 7
		melee_damage_upper = 8
		melee_damage_type = BURN

/mob/living/simple_animal/hostile/humanoid/blood/fiend/boss/Leap(mob/living/target)
	if(!isliving(target) && !ismecha(target) || !can_act)
		return
	slashing = TRUE
	cutter_hit = FALSE
	say("Hardblood Arts 5...")
	ChangeResistances(list(BURN = 0.3, BRAIN = 0.3, BRUTE = 0.3, TOX = 0.3))
	blood_target = target
	blood_target.faction += "hostile"
	can_act = FALSE
	var/list/dirs_to_land = shuffle(list(NORTH, SOUTH, EAST, WEST, NORTHEAST, NORTHWEST, SOUTHEAST, SOUTHWEST))
	var/list/dir_overlays = list()
	for (var/i in 1 to 3)
		var/dir_to_land = dirs_to_land[i]
		var/x
		var/y
		if (dir_to_land == NORTH)
			x = 0
			y = 32
		else if (dir_to_land == SOUTH)
			x = 0
			y = -32
		else if (dir_to_land == EAST)
			x = 32
			y = 0
		else if (dir_to_land == SOUTH)
			x = -32
			y = 0
		else if (dir_to_land == NORTHEAST)
			x = 32
			y = 32
		else if (dir_to_land == NORTHWEST)
			x = 32
			y = -32
		else if (dir_to_land == SOUTHEAST)
			x = 32
			y = -32
		else
			x = -32
			y = -32
		var/image/O = image(icon='tff_modular/modules/evento_needo/icons/Teguicons/cult_effects.dmi',icon_state="bloodsparkles", pixel_x = x, pixel_y = y)
		blood_target.add_overlay(O)
		dir_overlays.Add(O)
		playsound(blood_target, 'tff_modular/modules/evento_needo/sounds/Tegusounds/claw/eviscerate1.ogg', 100, 1)
		if (stat != DEAD)
			sleep(1 SECONDS)
		else
			break
	say("Blood Snare!!!")
	for (var/i in 1 to 3)
		blood_target.cut_overlay(dir_overlays[i])
		if (stat == DEAD)
			blood_target.faction -= "hostile"
			continue
		animate(src, alpha = 1,pixel_x = 16, pixel_z = 0, time = 0.1 SECONDS)
		src.pixel_x = 16
		playsound(src, 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/ichthys/jump.ogg', 50, FALSE, 4)
		var/turf/target_turf = get_step(get_turf(blood_target), dirs_to_land[i])
		if(target_turf)
			forceMove(target_turf) //look out, someone is rushing you!
		playsound(src, leap_sound, 50, FALSE, 4)
		animate(src, alpha = 255,pixel_x = -16, pixel_z = 0, time = 0.1 SECONDS)
		src.pixel_x = 0
		if (i == 2)
			say("Just...")
		if (i == 3)
			say("ROT AWAY!!!")
		Dash(blood_target)
		sleep(0.25 SECONDS)
	blood_target.faction -= "hostile"
	if (!cutter_hit)
		var/mutable_appearance/colored_overlay = mutable_appearance(icon, "small_stagger", layer + 0.1)
		add_overlay(colored_overlay)
		manual_emote("kneels on the floor...")
		icon_state = exhausted_state
		ChangeResistances(list(BURN = 2, BRAIN = 1.2, BRUTE = 1, TOX = 3))
		sleep(stun_duration)
		manual_emote("rises back up...")
		cut_overlays()
	blood_feast = 0
	icon_state = normal_state
	ChangeResistances(list(BURN = 1, BRAIN = 0.6, BRUTE = 0.4, TOX = 1.5))
	slashing = FALSE
	can_act = TRUE

/mob/living/simple_animal/hostile/humanoid/blood/fiend/boss/Dash(target_turf)
	target_turf = get_turf(blood_target)

	shake_up_animation()
	var/dx = src.x - blood_target.x
	var/dy = src.y - blood_target.y
	var/turf/safe_turf = locate(blood_target.x - dx, blood_target.y - dy, blood_target.z)
	if (safe_turf.density)
		safe_turf = locate(blood_target.x, blood_target.y, blood_target.z)
	var/list/warning_overlays = list()
	var/list/warning_turfs = list()
	for(var/turf/T in view(target_turf, 2))
		if (T == safe_turf)
			var/image/S = image(icon='icons/effects/eldritch.dmi',icon_state="cloud_swirl")
			T.add_overlay(S)
			warning_overlays.Add(S)
			warning_turfs.Add(T)
			continue;
		var/image/O = image(icon='icons/effects/eldritch.dmi',icon_state="blood_cloud_swirl")
		T.add_overlay(O)
		warning_overlays.Add(O)
		warning_turfs.Add(T)


	sleep(15)
	for (var/i in 1 to warning_turfs.len)
		var/turf/T = warning_turfs[i]
		T.cut_overlay(warning_overlays[i])

	if (stat == DEAD)
		return
	playsound(blood_target, 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/doomsdaycalendar/Lor_Slash_Generic.ogg', 20, 0, 4)
	var/list/hit_list = list()
	for(var/turf/T in range(target_turf, 2))
		if (T == safe_turf)
			continue;
		var/obj/effect/temp_visual/slice/blood = new(T)
		blood.color = "#b52e19"
		hit_list = HurtInTurf(T, hit_list, slash_damage, BURN, null, TRUE, TRUE, TRUE, hurt_structure = TRUE)
	for (var/hit in hit_list)
		if (istype(hit, /mob/living))
			var/mob/living/L = hit
			cutter_hit = TRUE
			L.blood_volume -= L.blood_volume / cutter_bleed_stacks

/mob/living/simple_animal/hostile/humanoid/blood/fiend/boss/adjustHealth(amount, updating_health = TRUE, forced = FALSE)
	if (health/maxHealth > 0.75)
		readyToSpawn75 = TRUE
	if (health/maxHealth > 0.25)
		readyToSpawn25 = TRUE
	. = ..()
	if(!slashing)
		if (health/maxHealth < 0.75 && readyToSpawn75 && world.time > timeToSpawn75)
			// spawn
			spawnbags()
			readyToSpawn75 = FALSE
			timeToSpawn75 = world.time + cooldownToSpawn
			can_act = FALSE
			ChangeResistances(list(BURN = 0.3, BRAIN = 0.3, BRUTE = 0.3, TOX = 0.3))
			addtimer(CALLBACK(src, PROC_REF(revert_act)), 20)
		if (health/maxHealth < 0.25 && readyToSpawn25 && world.time > timeToSpawn25)
			// spawn
			spawnbags()
			readyToSpawn25 = FALSE
			timeToSpawn25 = world.time + cooldownToSpawn
			can_act = FALSE
			ChangeResistances(list(BURN = 0.3, BRAIN = 0.3, BRUTE = 0.3, TOX = 0.3))
			addtimer(CALLBACK(src, PROC_REF(revert_act)), 20)

/mob/living/simple_animal/hostile/humanoid/blood/fiend/boss/proc/revert_act()
	ChangeResistances(list(BURN = 1, BRAIN = 0.6, BRUTE = 0.4, TOX = 1.5))
	can_act = TRUE

/mob/living/simple_animal/hostile/humanoid/blood/fiend/boss/proc/spawnbags()
	say("Rise... Bloodbags...")
	var/list/turfs = shuffle(orange(1, src))
	for(var/i in 1 to 2)
		blood_feast -= summon_cost
		new /obj/effect/sweeperspawn/bagspawn(turfs[i])

/obj/effect/sweeperspawn/bagspawn

/obj/effect/sweeperspawn/bagspawn/spawnscout()
	new /mob/living/simple_animal/hostile/humanoid/blood/bag(get_turf(src))
	qdel(src)

/mob/living/simple_animal/hostile/humanoid/blood/bag
	name = "bloodbag"
	desc = "A blood bag created by some bloodfiends."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/blood_fiends_32x32.dmi'
	icon_state = "bloodbag"
	icon_living = "bloodbag"
	icon_dead = "bloodbag_dead"
	damage_coeff = list(BRUTE = 1, BURN = 1.4, BRAIN = 1, BRUTE = 0.8, TOX = 1.5)
	melee_damage_lower = 2
	melee_damage_upper = 3
	rapid_melee = 3
	melee_damage_type = BURN
	attack_sound = 'tff_modular/modules/evento_needo/sounds/Tegusounds/ordeals/brown/flea_attack.ogg'
	attack_verb_continuous = "slashes"
	attack_verb_simple = "slash"
	move_to_delay = 2.5
	maxHealth = 500
	health = 500
	var/self_damage = 10
	var/blood_drop_cooldown = 0
	var/blood_drop_cooldown_time = 2 SECONDS
	var/bleed_stacks = 1
	var/explosion_damage = 10
	var/explosion_bleed = 5
	var/drop_meat = TRUE


/mob/living/simple_animal/hostile/humanoid/blood/bag/AttackingTarget(atom/attacked_target)
	. = ..()
	if (istype(target, /mob/living))
		var/mob/living/L = target
		L.blood_volume -= L.blood_volume / bleed_stacks
	adjustFireLoss(self_damage)

/mob/living/simple_animal/hostile/humanoid/blood/bag/adjustHealth(amount, updating_health = TRUE, forced = FALSE)
	. = ..()
	if(blood_drop_cooldown > world.time)
		return FALSE
	blood_drop_cooldown = world.time + blood_drop_cooldown_time
	var/turf/origin = get_turf(src)
	var/list/all_turfs = RANGE_TURFS(1, origin)
	for(var/turf/T in shuffle(all_turfs))
		if (T.is_blocked_turf(exclude_mobs = TRUE))
			continue;
		var/obj/effect/decal/cleanable/blood/B = locate() in T
		if(!B)
			B = new /obj/effect/decal/cleanable/blood(T)
			B.bloodiness = 100
			break;

/mob/living/simple_animal/hostile/humanoid/blood/bag/death(gibbed)
	walk_to(src, 0)
	animate(src, transform = matrix()*1.8, color = "#FF0000", time = 15)
	addtimer(CALLBACK(src, PROC_REF(DeathExplosion)), 15)
	if(drop_meat)
		if(prob(10))
			new /obj/item/clothing/suit/armor/ego_gear/city/masquerade_cloak/masquerade_coat (get_turf(src))
	QDEL_IN(src, 15)
	..()

/mob/living/simple_animal/hostile/humanoid/blood/bag/proc/DeathExplosion()
	playsound(loc, 'tff_modular/modules/evento_needo/sounds/Tegusounds/ordeals/crimson/dusk_dead.ogg', 60, TRUE)
	for(var/mob/living/L in view(1, src))
		L.apply_damage(explosion_damage, BURN)
		L.blood_volume -= L.blood_volume / explosion_bleed
	var/turf/origin = get_turf(src)
	var/list/all_turfs = RANGE_TURFS(1, origin)
	for(var/turf/T in shuffle(all_turfs))
		if (T.is_blocked_turf(exclude_mobs = TRUE))
			continue;
		var/obj/effect/decal/cleanable/blood/B = locate() in T
		if(!B)
			B = new /obj/effect/decal/cleanable/blood(T)
			B.bloodiness = 100

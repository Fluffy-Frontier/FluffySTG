// Coded by endermage
/mob/living/simple_animal/hostile/abnormality/shock_centipede
	name = "Shock Centipede"
	desc = "An enormous blue centipede with electricity sparking around it."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/96x64.dmi'
	icon_state = "shock_centipede"
	icon_living = "shock_centipede"
	maxHealth = 1700
	health = 1700
	rapid_melee = 3
	ranged = TRUE
	attack_verb_continuous = "bites"
	attack_verb_simple = "bite"
	attack_sound = 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/laetitia/spider_attack.ogg'
	stat_attack = HARD_CRIT
	melee_damage_lower = 3
	melee_damage_upper = 4
	damage_coeff = list(BURN = 1, BRAIN = 0.8, BRUTE = 1, TOX = 0.5, BRUTE = 2)
	speak_emote = list("screeches")
	speech_span = SPAN_ROBOT
	vision_range = 14
	pixel_x = -32
	base_pixel_x = -32
	aggro_vision_range = 20
	can_breach = TRUE
	fear_level = HE_LEVEL
	ego_list = list(
		/datum/ego_datum/weapon/aedd,
		/datum/ego_datum/armor/aedd
		)
	gift_type = /datum/ego_gifts/aedd
	observation_prompt = "\"This centipede is capable of discharging a high voltage.\" <br>\
		That's what the sign attached to the tank says. <br>\
		Is this an aquarium, or a laboratory? <br>\
		The segments of the creature spark each time they move, suggesting faulty connections. <br>\
		There are two buttons at the tank. <br>\
		One is shaped like a thunderbolt, while the other looks like a waterdrop."


// Work vars
	var/bonus_pe = 6
	var/repression_override = 50

// Charge vars
	var/charge = 0
	var/charge_health = 0
	var/max_charge = 20
	var/self_charge_threshold = 350
	var/accumulated_charge = 0 // A record-keeping variable for effects

// Shield vars
	var/shield = 0
	var/currentShieldTimer = 0
	var/coil_cooldown = 0
	var/coil_cooldown_time = 100
	var/coil_max_shield = 500
	var/coil_start_charge = 12
	var/can_act = TRUE
	var/immortal = FALSE

// Attack vars
	var/coil_discharge_aoe_damage = 35
	var/coil_discharge_aoe_damagetype = BRUTE
	var/coil_discharge_aoe_stun_duration = 50
	var/coil_discharge_aoe_missed_charge_loss = 3
	var/coil_shield_broken_charge_loss = 6
	var/coil_shield_broken_selfstun_duration = 40

	var/immortal_damagetype = BRUTE
	var/immortal_melee_damage_upper = 6
	var/immortal_melee_damage_lower = 5
	var/immortal_countdown_duration = 30

	var/tail_attack_cooldown = 0
	var/tail_attack_cooldown_time = 80
	var/tailattack_damage = 20
	var/tailattack_damagetype = BRUTE
	var/tailattack_windup = 15
	var/tailattack_charge_per_target = 3
	var/tailattack_range = 5



/* Work effects */
/mob/living/simple_animal/hostile/abnormality/shock_centipede/try_working(mob/living/carbon/human/user)
	. = ..()
	if(!.)
		return
	//Temp too high, random damage type time.
	if(user.get_clothing_class_level(CLOTHING_ARMORED) >= 3 || datum_reference?.qliphoth_meter == 1)
		user.apply_damage(tailattack_damage)

/mob/living/simple_animal/hostile/abnormality/shock_centipede/proc/CheckQliphoth(mob/living/carbon/human/user, work_type, pe, work_time, canceled)
	if(datum_reference?.qliphoth_meter == 3 && user.get_major_clothing_class() == CLOTHING_ARMORED)
		qliphoth_change(-1)
		return FALSE
	else
		if(datum_reference?.qliphoth_meter == 1 && user.get_major_clothing_class() != CLOTHING_ARMORED)
			qliphoth_change(-1)
			return FALSE
	return TRUE

/* Success Effect */
/mob/living/simple_animal/hostile/abnormality/shock_centipede/SuccessEffect(mob/living/carbon/human/user, work_type, pe)
	if (!CheckQliphoth(user, work_type, pe))
		return
	if(datum_reference?.qliphoth_meter == 2)
		qliphoth_change(1)
	if(datum_reference?.qliphoth_meter == 1 && user.get_major_clothing_class() == CLOTHING_ARMORED)
		qliphoth_change(2)
		to_chat(user, "<span class='nicegreen'>[bonus_pe] extra PE Boxes have been generated!</span>")

/* Neutral Effect */
/mob/living/simple_animal/hostile/abnormality/shock_centipede/NeutralEffect(mob/living/carbon/human/user, work_type, pe)
	if (!CheckQliphoth(user, work_type, pe))
		return
	if(datum_reference?.qliphoth_meter == 2)
		if(prob(50))
			qliphoth_change(-1)
		else
			qliphoth_change(1)
	else
		if(datum_reference?.qliphoth_meter == 1 && user.get_major_clothing_class() == CLOTHING_ARMORED)
			qliphoth_change(1)

/* Failure Effect */
/mob/living/simple_animal/hostile/abnormality/shock_centipede/FailureEffect(mob/living/carbon/human/user, work_type, pe)
	if (!CheckQliphoth(user, work_type, pe))
		return
	qliphoth_change(-1)

/* Charge Mechanic Handling */
/mob/living/simple_animal/hostile/abnormality/shock_centipede/proc/AdjustCharge(amount)
	if(charge >= max_charge && amount > 0)
		return
	if(amount > 0)
		accumulated_charge += amount
	while(accumulated_charge >= 1)
		new /obj/effect/temp_visual/healing/charge(get_turf(src))
		accumulated_charge = clamp(accumulated_charge - 1,0,20)
	charge = clamp(charge + amount, 0, max_charge)

/mob/living/simple_animal/hostile/abnormality/shock_centipede/proc/SelfCharge(amount) // Gain charge through damage taken
	var/added_charge
	charge_health += amount
	added_charge = (charge_health / self_charge_threshold)
	if(immortal) // Since charge = health* in the immortal phase, the self charge is reversed when immortal
		added_charge *= -1
	AdjustCharge(added_charge)
	charge_health %= self_charge_threshold


/mob/living/simple_animal/hostile/abnormality/shock_centipede/proc/ChargeCountDown()
	if (charge > 1)
		AdjustCharge(-1)
		addtimer(CALLBACK(src, PROC_REF(ChargeCountDown)), immortal_countdown_duration)
	else
		adjustHealth(health)

/* Breach Effects*/
/mob/living/simple_animal/hostile/abnormality/shock_centipede/adjustHealth(amount, updating_health = TRUE, forced = FALSE)
	if (amount >= 0 && shield > 0) // actual damage
		amount = UpdateShield(amount)
	if (amount >= 0)
		SelfCharge(amount)

	if (immortal && amount >= 0)
		if (charge == 0)
			amount = health
		else
			return FALSE
	. = ..()

/mob/living/simple_animal/hostile/abnormality/shock_centipede/proc/UpdateShield(amount)
	var/remainder = amount - shield
	shield -= amount
	if (remainder >= 0)
		shield = 0
		if (currentShieldTimer  != 0) //stop coil timer
			// stop coiling animation
			deltimer(currentShieldTimer)
			currentShieldTimer = 0
		manual_emote("crumbles to the ground...")
		// stun
		icon_state = "shock_centipede"
		can_act = FALSE
		addtimer(CALLBACK(src, PROC_REF(StunEnd)), coil_shield_broken_selfstun_duration)
		AdjustCharge(-coil_shield_broken_charge_loss)
		return remainder
	else
		var/obj/effect/temp_visual/shock_shield/AT = new /obj/effect/temp_visual/shock_shield(loc, src)
		var/random_x = rand(-16, 16)
		AT.pixel_x += random_x

		var/random_y = rand(5, 32)
		AT.pixel_y += random_y
		return 0

/mob/living/simple_animal/hostile/abnormality/shock_centipede/AttackingTarget(atom/attacked_target)
	if (shield > 0 || !can_act)  // dont attack if coiled or stunned
		return FALSE
	if(!client)
		TryCoil()
		if(tail_attack_cooldown < world.time)
			var/turf/target_turf = get_turf(attacked_target)
			for(var/i = 1 to tailattack_range - 2)
				target_turf = get_step(target_turf, get_dir(get_turf(src), target_turf))
			TailAttack(target_turf)
			return FALSE
	. = ..()
	if (!immortal)
		AdjustCharge(1)
	TryCoil()

/mob/living/simple_animal/hostile/abnormality/shock_centipede/OpenFire()
	if(!can_act || shield > 0)
		return

	if(tail_attack_cooldown < world.time)
		TailAttack(target)

/mob/living/simple_animal/hostile/abnormality/shock_centipede/proc/TryCoil()
	if (charge >= coil_start_charge && world.time > coil_cooldown && !immortal)
		coil_cooldown = world.time + (coil_cooldown_time * 2)
		shield = coil_max_shield
		// icon_state end chage
		icon_state = "shock_centipede_coil"
		currentShieldTimer = addtimer(CALLBACK(src, PROC_REF(CoilEnd)), coil_cooldown_time, TIMER_STOPPABLE)
		manual_emote("starts coiling up...")

/mob/living/simple_animal/hostile/abnormality/shock_centipede/proc/CoilEnd()
	currentShieldTimer = 0
	if (shield > 0)
		manual_emote("electricity escapes from its body...")
		//start AoE
		CoilDischargeAoe()
		coil_cooldown = world.time + coil_cooldown_time


/mob/living/simple_animal/hostile/abnormality/shock_centipede/proc/StunEnd()
	// icon_state
	can_act = TRUE
	coil_cooldown = world.time + coil_cooldown_time

// dont move when coiled or stunned
/mob/living/simple_animal/hostile/abnormality/shock_centipede/Move()
	if (shield > 0 || !can_act)
		return FALSE
	return ..()

/mob/living/simple_animal/hostile/abnormality/shock_centipede/proc/CoilDischargeAoe()
	if(stat == DEAD)
		return
	icon_state = "shock_centipede"
	for(var/turf/T in view(4, src))
		new /obj/effect/temp_visual/blubbering_smash(get_turf(T))
	var/count = 0
	for(var/mob/living/L in view(4, src))
		if(faction_check_atom(L))
			continue
		L.apply_damage(coil_discharge_aoe_damage, coil_discharge_aoe_damagetype, null, L.run_armor_check(null, coil_discharge_aoe_damagetype), spread_damage = TRUE)
		L.Stun(coil_discharge_aoe_stun_duration)
		count ++
	playsound(get_turf(src), 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/kqe/hitsound2.ogg', 100, 0, 8)
	shield = 0
	if (count == 0)
		AdjustCharge(-coil_discharge_aoe_missed_charge_loss)

/mob/living/simple_animal/hostile/abnormality/shock_centipede/Life()
	TryCoil()
	..()

/mob/living/simple_animal/hostile/abnormality/shock_centipede/death()
	if(health > 0)
		return
	if (!immortal)
		manual_emote("rises back up...")
		immortal = TRUE
		icon_state = "shock_centipede_broken"
		melee_damage_type = immortal_damagetype
		melee_damage_upper = immortal_melee_damage_upper
		melee_damage_lower = immortal_melee_damage_lower
		adjustHealth(maxHealth * -1)
		set_varspeed(speed - 1)
		update_simplemob_varspeed()
		ChangeResistances(list(BURN = 1.2, BRAIN = 1.5, BRUTE = 1.2, TOX = 2.2))
		addtimer(CALLBACK(src, PROC_REF(ChargeCountDown)), immortal_countdown_duration)
		return FALSE
	else
		animate(src, alpha = 0, time = 10 SECONDS)
		QDEL_IN(src, 10 SECONDS)
		icon_state = "shock_centipede"
		return ..()

/mob/living/simple_animal/hostile/abnormality/shock_centipede/proc/TailAttack(target)
	manual_emote("pulls it's tail back...")
	tail_attack_cooldown = world.time + tail_attack_cooldown_time
	can_act = FALSE
	face_atom(target)
	//icon_state windup
	var/turf/target_turf = get_turf(target)
	// warning animation
	var/broken = FALSE
	var/distance = tailattack_range

	for(var/turf/T in get_line(get_turf(src), target_turf))
		if (distance < 0)
			break
		distance--
		if(T.density)
			if(broken)
				break
			broken = TRUE
		for(var/turf/TF in range(1, T))
			if(TF.density)
				continue
			TF.add_overlay(icon('tff_modular/modules/evento_needo/icons/Teguicons/effects.dmi', "galaxy_aura"))
			addtimer(CALLBACK(TF, TYPE_PROC_REF(/atom, cut_overlay), \
								icon('tff_modular/modules/evento_needo/icons/Teguicons/effects.dmi', "galaxy_aura")), tailattack_windup)

	playsound(get_turf(src), 'tff_modular/modules/evento_needo/sounds/Tegusounds/weapons/fixer/generic/energy3.ogg', 75, FALSE, 3)
	SLEEP_CHECK_DEATH(tailattack_windup, src)
	distance = tailattack_range
	broken = FALSE
	var/been_hit = list()
	for(var/turf/T in get_line(get_turf(src), target_turf))
		if (distance < 0)
			break
		distance--
		if(T.density)
			if(broken)
				break
			broken = TRUE
		for(var/turf/TF in range(1, T)) // AAAAAAAAAAAAAAAAAAAAAAA
			if(TF.density)
				continue
			new /obj/effect/temp_visual/smash_effect(TF)
			been_hit = HurtInTurf(TF, been_hit, tailattack_damage, tailattack_damagetype, null, null, TRUE, FALSE, TRUE, TRUE)
	AdjustCharge(length(been_hit) * tailattack_charge_per_target)
	playsound(get_turf(src), 'tff_modular/modules/evento_needo/sounds/Tegusounds/weapons/fixer/generic/energyfinisher1.ogg', 75, 1)
	can_act = TRUE

// Object effect
/obj/effect/temp_visual/shock_shield
	name = "shock_sheild"
	desc = "A shimmering forcefield protecting the shock centipede."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/effects.dmi'
	icon_state = "shield"
	layer = FLY_LAYER
	light_range = 2
	duration = 8

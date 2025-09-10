#define STATUS_EFFECT_HEX /datum/status_effect/hex
#define STATUS_EFFECT_NAILS /datum/status_effect/nails
/mob/living/simple_animal/hostile/abnormality/hurting_teddy
	name = "Hurting Teddy Bear"
	desc = "A large worn out teddy bear that has been impaled with nails. Its faded grey fur is coated in grime."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/64x64.dmi'
	icon_living = "hurting_teddy"
	icon_state = "hurting_teddy"
	icon_dead = "hurting_core"
	del_on_death = FALSE
	pixel_x = -16
	base_pixel_x = -16
	maxHealth = 1500 //it's a teddy bear that's been abused all its life, it should have some HP. It also has two pieces of rank bump equipment.
	health = 1500
	rapid_melee = 1
	melee_queue_distance = 3
	move_to_delay = 5 // it's tanky for a TETH. It should be slow.
	damage_coeff = list(BURN = 0.8, BRAIN = 1.5, BRUTE = 0.8, TOX = 2)
	can_breach = TRUE
	melee_damage_lower = 12
	melee_damage_upper = 18
	melee_damage_type = BRUTE
	stat_attack = HARD_CRIT
	attack_sound = 'tff_modular/modules/evento_needo/sounds/Tegusounds/weapons/ego/mace1.ogg'
	attack_verb_continuous = "smashes"
	attack_verb_simple = "smash"
	friendly_verb_continuous = "squeezes"
	friendly_verb_simple = "squeeze"
	can_breach = TRUE
	fear_level = TETH_LEVEL
	 //only one person can work on it with these rates so they're higher than normal. everyone else will only get low/common rates.
	ego_list = list(
		/datum/ego_datum/weapon/hexnail,
		/datum/ego_datum/armor/hexnail
	)
//gift_type = /datum/ego_gifts/hex_nail

	grouped_abnos = list(
		/mob/living/simple_animal/hostile/abnormality/happyteddybear = 1.5,
	)
	var/bearfriended //the one who can work on it safely
	var/mob/living/carbon/human/hug_victim = null
	var/release_threshold = 100 //Total raw damage needed to break a player out of a grab (from any source)
	var/release_damage = 0
	var/hug_progress = 0
	var/hug_damage = 8
	var/crush_damage = 3
	var/can_act = TRUE

//Work Mechanics

/mob/living/simple_animal/hostile/abnormality/hurting_teddy/try_working(mob/living/carbon/human/user)
	if(next_action_time > world.time)
		return
	if (user == bearfriended) //small reward to the bearfriend. it's a TETH, after all.
		to_chat(user, span_nicegreen("Hurting Teddy Bear offers you an embrace!"))
		user.adjustBruteLoss(-15)
		user.adjustSanityLoss(-15)
	return ..()

/mob/living/simple_animal/hostile/abnormality/hurting_teddy/PostWorkEffect(mob/living/carbon/human/user)
	. = ..()
	if (bearfriended == null)
		bearfriended = user
		to_chat(user, span_nicegreen("Hurting Teddy Bear becomes your friend!"))

	if (user != bearfriended) //get punished.
		to_chat(user, span_warning("You feel something sharp being jabbed into you!"))
		user.apply_status_effect(STATUS_EFFECT_NAILS)

	if(user.get_major_clothing_class() == CLOTHING_ARMORED && user == bearfriended) //you can use this to swap the bearfriend if you're fine losing the counter on a bad or a neutral
		bearfriended = null
		to_chat(user, span_warning("Hurting Teddy Bear isn't your friend anymore! You feel bad for betraying it..."))
		user.apply_status_effect(STATUS_EFFECT_HEX)
	return ..()

/mob/living/simple_animal/hostile/abnormality/hurting_teddy/NeutralEffect(mob/living/carbon/human/user, work_type, pe)
	. = ..()
	if(prob(70)) // Non-friend Agents + lucky Repression works by bearfriends will have a high chance of lowering the counter.
		qliphoth_change(-1)
	return

/mob/living/simple_animal/hostile/abnormality/hurting_teddy/FailureEffect(mob/living/carbon/human/user)
	qliphoth_change(-1)

//breach mechanics
/mob/living/simple_animal/hostile/abnormality/hurting_teddy/BreachEffect(mob/living/carbon/human/user, breach_type)
	. = ..()
	bearfriended = null //like staining rose, it's cleanup. Lets another chump work on it if you don't feel like repressing.
	GiveTarget(user)

/mob/living/simple_animal/hostile/abnormality/hurting_teddy/death(gibbed)
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/abno_cores/teth.dmi'
	density = FALSE
	animate(src, alpha = 0, time = 10 SECONDS)
	QDEL_IN(src, 10 SECONDS)
	..()

/mob/living/simple_animal/hostile/abnormality/hurting_teddy/AttackingTarget(atom/attacked_target)
	if(!can_act)
		return
	. = ..()
	if(ishuman(attacked_target))
		if(hug_progress > 4)
			HugAttack(attacked_target)
			hug_progress = 0
			return
		hug_progress += 1

/mob/living/simple_animal/hostile/abnormality/hurting_teddy/Move()
	if(!can_act)
		return FALSE
	return ..()

//mostly renamed and slightly tweaked Brown Noon noon code.

/mob/living/simple_animal/hostile/abnormality/hurting_teddy/proc/HugAttack(mob/living/carbon/human/victim)
	if(!istype(victim))
		return
	hug_victim = victim
	Strangle()
	can_act = FALSE

/mob/living/simple_animal/hostile/abnormality/hurting_teddy/proc/Strangle()
	set waitfor = FALSE
	release_damage = 0
	hug_victim.Immobilize(10)
	if(hug_victim.sanity_lost)
		hug_victim.Stun(10)
	hug_victim.forceMove(get_turf(src))
	SLEEP_CHECK_DEATH(5, src)
	to_chat(hug_victim, span_userdanger("[src] has grabbed you! Attack [src] to break free!"))
	StrangleHit(1)

/mob/living/simple_animal/hostile/abnormality/hurting_teddy/proc/StrangleHit(count)
	if(!hug_victim)
		ReleaseHug()
		return
	if(hug_victim.health < 0)
		ReleaseHug()
		return
	do_attack_animation(get_step(src, dir), no_effect = TRUE)
	hug_victim.apply_damage(hug_damage, BRUTE)
	new /obj/effect/temp_visual/smash1(get_turf(src))
	hug_victim.apply_damage(crush_damage, BRUTE)
	hug_victim.Immobilize(10)
	playsound(get_turf(src), 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/sweethome/smash.ogg', 50, 1)
	switch(count)
		if(0 to 3)
			playsound(get_turf(src), 'sound/effects/wounds/crack1.ogg', 200, 0, 7)
			to_chat(hug_victim, span_userdanger("You are being crushed!"))
		if(4)  //apply more damage
			playsound(get_turf(src), 'sound/effects/wounds/crackandbleed.ogg', 200, 0, 7)
			to_chat(hug_victim, span_userdanger("It hurts so much!"))
			hug_victim.apply_damage(crush_damage, BRUTE)
		else      //Apply ramping damage
			playsound(get_turf(src), 'sound/effects/wounds/crackandbleed.ogg', 200, 0, 7)
			hug_victim.apply_damage((crush_damage * (3 - count)), BRUTE)
	count += 1
	if(hug_victim.sanity_lost)
		hug_victim.Stun(10)
	SLEEP_CHECK_DEATH(10, src)
	StrangleHit(count)

/mob/living/simple_animal/hostile/abnormality/hurting_teddy/proc/ReleaseHug()
	if(hug_victim)
		hug_victim = null
		can_act = TRUE

/mob/living/simple_animal/hostile/abnormality/hurting_teddy/apply_damage(damage, damagetype, def_zone, blocked, forced, spread_damage, wound_bonus, bare_wound_bonus, sharpness, attack_direction, attacking_item, exposed_wound_bonus)
	. = ..()
	if(hug_victim)
		release_damage = clamp (release_damage + damage, 0, release_threshold)
	if(release_damage >= release_threshold)
		ReleaseHug()

//**   STATUS EFFECTS  **//
//HEXED
//Betray the abno, get hexed.
/datum/status_effect/hex
	id = "Hex"
	status_type = STATUS_EFFECT_UNIQUE
	duration = 3 MINUTES
	alert_type = /atom/movable/screen/alert/status_effect/hex

/atom/movable/screen/alert/status_effect/hex
	name = "Hex"
	desc = "You take more RED and BLACK damage"
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/status_sprites.dmi'
	icon_state = "schismatic" //placeholder. Yell at spriters if you want this fixed.

/datum/status_effect/hex/on_apply()
	. = ..()
	if(!ishuman(owner))
		return
	var/mob/living/carbon/human/status_holder = owner
	status_holder.physiology.burn_mod /= 0.8
	status_holder.physiology.brute_mod /= 0.8

/datum/status_effect/hex/on_remove()
	. = ..()
	if(!ishuman(owner))
		return
	var/mob/living/carbon/human/status_holder = owner
	to_chat(status_holder, span_nicegreen("You feel the hex being lifted."))
	status_holder.physiology.burn_mod *= 0.8
	status_holder.physiology.brute_mod *= 0.8


//Nails
//Clingy abno punishment.
/datum/status_effect/nails
	id = "Nails"
	status_type = STATUS_EFFECT_UNIQUE
	duration = 2 MINUTES
	alert_type = /atom/movable/screen/alert/status_effect/nails

/atom/movable/screen/alert/status_effect/nails
	name = "Nails"
	desc = "The nails stuck inside you bear a heavy curse. You gain bleed whenever you receive damage."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/status_sprites.dmi'
	icon_state = "sacrifice" //placeholder. Yell at spriters if you want this fixed.

/datum/status_effect/nails/on_apply()
	. = ..()
	if(!ishuman(owner))
		return
	var/mob/living/carbon/human/status_holder = owner
	to_chat(status_holder, span_userdanger("A cursed nail is stuck inside you!"))
	RegisterSignal(owner, COMSIG_MOB_APPLY_DAMAGE, PROC_REF(DealBleed))

/datum/status_effect/nails/on_remove()
	. = ..()
	if(!ishuman(owner))
		return
	var/mob/living/carbon/human/status_holder = owner
	to_chat(status_holder, span_nicegreen("The nail loosens! You're able to pull it out now!"))
	UnregisterSignal(owner, COMSIG_MOB_APPLY_DAMAGE)

/datum/status_effect/nails/proc/DealBleed(mob/living/carbon/human/owner, damage, damagetype, def_zone)
	SIGNAL_HANDLER
	var/mob/living/carbon/human/H = owner
	if(!istype(H))
		return
	if(damage <= 1)
		return
	H.blood_volume -= H.blood_volume * 0.1

#undef STATUS_EFFECT_HEX
#undef STATUS_EFFECT_NAILS



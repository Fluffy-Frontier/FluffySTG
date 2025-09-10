/mob/living/simple_animal/hostile/abnormality/voiddream
	name = "Void Dream"
	desc = "A very fluffy floating sheep.."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/tegumobs.dmi'
	icon_state = "void_dream"
	icon_living = "void_dream"
	del_on_death = TRUE
	maxHealth = 600
	health = 600
	rapid_melee = 2
	move_to_delay = 6
	damage_coeff = list(BURN = 1.5, BRAIN = 0.8, BRUTE = 1.2, TOX = 2)

	attack_verb_continuous = "nuzzles"
	attack_verb_simple = "nuzzles"
	faction = list("neutral", "hostile")
	can_breach = TRUE
	fear_level = TETH_LEVEL
	ego_list = list(
		/datum/ego_datum/weapon/dream,
		/datum/ego_datum/armor/dream,
	)
	gift_type =  /datum/ego_gifts/dream
	observation_prompt = "\"There's nothing wrong with dreams. <br>\
		I go out and bring such sweet dreams to those who've only learned to stop dreaming, <br>\
		I'm not to blame if their dreams are so entrancing they become hollow people in their waking lives, am I not? <br>\
		Don't you want such sweet dreams too?\""


	var/punched = FALSE
	var/pulse_damage = 50
	var/ability_cooldown
	var/ability_cooldown_time = 12 SECONDS

/mob/living/simple_animal/hostile/abnormality/voiddream/Life()
	. = ..()
	if(!.)
		return
	PerformAbility()
	if(punched && prob(33))
		playsound(get_turf(src), "tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/voiddream/ambient_[pick(1,2)].ogg", 50, TRUE)

/mob/living/simple_animal/hostile/abnormality/voiddream/PickTarget(list/Targets)
	return

/mob/living/simple_animal/hostile/abnormality/voiddream/CanAttack(atom/the_target)
	return FALSE

//Getting hit
/mob/living/simple_animal/hostile/abnormality/voiddream/attackby(obj/item/I, mob/living/user, params)
	..()
	Transform()

/mob/living/simple_animal/hostile/abnormality/voiddream/bullet_act(obj/projectile/P)
	..()
	Transform()

/mob/living/simple_animal/hostile/abnormality/voiddream/proc/Transform()
	if(IsContained())
		return
	if(punched)
		return
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/32x64.dmi'
	punched = TRUE
	move_to_delay = 2
	ability_cooldown_time = 8 SECONDS
	ability_cooldown = 0
	REMOVE_TRAIT(src, TRAIT_MOVE_FLYING, ROUNDSTART_TRAIT)

/mob/living/simple_animal/hostile/abnormality/voiddream/proc/DelPassive()
	if(punched)
		return
	animate(src, alpha = 0, time = 5)
	QDEL_IN(src, 5)

/mob/living/simple_animal/hostile/abnormality/voiddream/proc/PerformAbility()
	if(ability_cooldown > world.time)
		return
	ability_cooldown = world.time + ability_cooldown_time
	if(punched)
		INVOKE_ASYNC(src, PROC_REF(Shout))
	else
		INVOKE_ASYNC(src, PROC_REF(SleepyDart))

/mob/living/simple_animal/hostile/abnormality/voiddream/proc/SleepyDart()
	var/list/possibletargets = list()
	for(var/mob/living/carbon/human/H in view(10, src))
		if(faction_check(src.faction, H.faction))
			continue
		if(H.IsSleeping())
			continue
		if(H.stat >= SOFT_CRIT)
			continue
		possibletargets += H
	if(!LAZYLEN(possibletargets))
		return

	playsound(get_turf(src), 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/voiddream/fire.ogg', 50, TRUE)
	var/obj/projectile/P = new /obj/projectile/sleepdart(get_turf(src))
	P.firer = src
	var/bullet_target = pick(possibletargets)
	P.original = bullet_target
	P.fire(get_angle(src, bullet_target))

/mob/living/simple_animal/hostile/abnormality/voiddream/proc/Shout()
	playsound(get_turf(src), 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/voiddream/shout.ogg', 75, FALSE, 5)
	for(var/mob/living/carbon/human/L in urange(10, src))
		if(faction_check(src.faction, L.faction)) // I LOVE NESTING IF STATEMENTS
			continue
		if(L.IsSleeping())
			L.SetSleeping(0)
			L.adjustSanityLoss(1000) //Die.
			continue
		L.apply_damage(pulse_damage, BRUTE)
	for(var/i = 1 to 5)
		var/obj/effect/temp_visual/screech/S = new(get_turf(src))
		S.pixel_y = 16
		S.color = COLOR_RED
		SLEEP_CHECK_DEATH(1, src)

// Work stuff
/mob/living/simple_animal/hostile/abnormality/voiddream/FailureEffect(mob/living/carbon/human/user)
	qliphoth_change(-1)
	return

/mob/living/simple_animal/hostile/abnormality/voiddream/PostWorkEffect(mob/living/carbon/human/user)
	if(user.get_clothing_class_level(CLOTHING_SERVICE) < 2)
		user.Sleeping(30 SECONDS) //Not a big fan of killing you, take a little nap.
		playsound(get_turf(user), 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/voiddream/skill.ogg', 50, TRUE)
	return

/mob/living/simple_animal/hostile/abnormality/voiddream/BreachEffect(mob/living/carbon/human/user, breach_type)
	. = ..()
	ability_cooldown = world.time + 4 SECONDS
	addtimer(CALLBACK(src, PROC_REF(DelPassive)), rand((3 MINUTES), (5 MINUTES)))

// Projectile code
/obj/projectile/sleepdart
	name = "void dream"
	icon_state = "antimagic"
	color = "#FCF344"
	damage = 0
	speed = 3
	homing_turn_speed = 25 //Angle per tick.
	var/homing_range = 9

/obj/projectile/sleepdart/Initialize()
	. = ..()
	var/list/targetslist = list()
	for(var/mob/living/carbon/human/H in view(homing_range, src))
		if(H.IsSleeping())
			continue
		targetslist += H
	if(!LAZYLEN(targetslist))
		return
	homing_target = pick(targetslist)

/obj/projectile/sleepdart/on_hit(atom/target, blocked = FALSE, pierce_hit)
	if(!ishuman(target))
		return
	var/mob/living/carbon/human/H = target
	if(H.IsSleeping())
		return
	H.SetSleeping(30 SECONDS) // Used to be a full minute
	playsound(get_turf(H), 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/voiddream/skill.ogg', 50, TRUE)
	return ..()

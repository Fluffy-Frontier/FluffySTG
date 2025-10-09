//Coded by Kirie Saito! EGO done by Chiemi <3
/mob/living/simple_animal/hostile/abnormality/titania
	name = "Titania"
	desc = "A gargantuan fairy."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/32x64.dmi'
	icon_state = "titania"
	icon_living = "titania"
	maxHealth = 3500
	health = 3500
	fear_level = ALEPH_LEVEL

	move_to_delay = 4
	can_breach = TRUE

	melee_damage_lower = 92
	melee_damage_upper = 99		//Will never one shot you.
	melee_damage_type = BRUTE
	damage_coeff = list(BURN = 1.2, BRAIN = 0.3, BRUTE = 0.5, TOX = 1)
	stat_attack = HARD_CRIT

	ego_list = list(
		/datum/ego_datum/weapon/soulmate,
		/datum/ego_datum/armor/soulmate,
	)
	gift_type = /datum/ego_gifts/soulmate
	observation_prompt = "Is that you Oberon? <br>My nemesis, my beloved devil. <br>Is it you, who applied the concotion of baneful herb to my eyes?"


	var/fairy_spawn_number = 2
	var/fairy_spawn_time = 5 SECONDS
	var/fairy_spawn_limit = 70 // Oh boy, what can go wrong?
	//Fairy spawn limit only matters for the spawn loop, players she kills and spawned via the law don't count
	var/list/spawned_mobs = list()
	var/list/worked = list()
	var/mob/living/carbon/human/nemesis			//Who is her nemesis?
	//The nemesis is referred to as Oberon in the rest of the comments.

	//Laws
	var/list/laws = list("melee", "ranged", "fairy", "armor", "nemesis", "ranged fairy")
	var/currentlaw
	var/nextlaw
	var/law_damage = 30		//Take damage, idiot
	var/law_timer = 60 SECONDS
	var/law_startup = 3 SECONDS
	//Oberon stuff
	var/fused = FALSE
	update_qliphoth = 0

/mob/living/simple_animal/hostile/abnormality/titania/Life()
	. = ..()
	if(fused) // So you can't just spoon her to death while in nobody is.
		adjustBruteLoss(-(maxHealth))

/mob/living/simple_animal/hostile/abnormality/titania/Move()
	if(fused)
		return FALSE
	return ..()

/mob/living/simple_animal/hostile/abnormality/titania/CanAttack(atom/the_target)
	if(fused)
		return FALSE
	return ..()

//Attacking code
/mob/living/simple_animal/hostile/abnormality/titania/AttackingTarget(atom/attacked_target)
	if(fused)
		return FALSE
	var/mob/living/carbon/human/H = attacked_target
	//Kills the weak immediately.
	if(ishuman(H) && H.get_clothing_class_level(H.get_major_clothing_class()) < 4)
		say("I rid you of your pain, mere human.")
		//Double Check
		SpawnFairies(fairy_spawn_number * 2, H, ignore_cap = TRUE)
		H.gib(DROP_ALL_REMAINS)
		return

	if(attacked_target == nemesis)	//Deals pale damage to Oberon, fuck you.
		melee_damage_type = BRUTE
		melee_damage_lower = 61
		melee_damage_upper = 72
	else if(nemesis)		//If there's still a nemesis, you need to reset the damage
		melee_damage_type = initial(melee_damage_type)
		melee_damage_lower = initial(melee_damage_lower)
		melee_damage_upper = initial(melee_damage_upper)
	. = ..()

	if(istype(H) && H.stat == DEAD && H == nemesis)		//Does she slay Oberon personally? If so, get buffed.
		move_to_delay = 0.5 SECONDS
		melee_damage_lower = 110
		melee_damage_upper = 140
		adjustBruteLoss(-maxHealth, forced = TRUE) // Round 2, baby

		to_chat(src, span_userdanger("[nemesis], my beloved devil, I finally get my revenge."))
		nemesis = null
		if(!client)
			say("Oberon. The abhorrent taker of my child. You are slain.")


//Spawning Fairies
/mob/living/simple_animal/hostile/abnormality/titania/proc/FairyLoop()
	SpawnFairies(fairy_spawn_number)
	addtimer(CALLBACK(src, PROC_REF(FairyLoop)), fairy_spawn_time)

/mob/living/simple_animal/hostile/abnormality/titania/proc/SpawnFairies(amount, mob/turf_mob, ignore_cap = FALSE)
	if(!ignore_cap && (length(spawned_mobs) > fairy_spawn_limit))
		return

	var/turf/spawn_turf
	if(turf_mob)
		spawn_turf = get_turf(turf_mob)
	else
		spawn_turf = get_turf(src)

	for(var/i in 1 to amount)
		var/mob/living/simple_animal/hostile/fairyswarm/fairy = new(spawn_turf)
		fairy.faction = faction
		fairy.mommy = src
		spawned_mobs += fairy

//Setting the nemesis
/mob/living/simple_animal/hostile/abnormality/titania/proc/ChooseNemesis()

	var/list/potentialmarked = list()
	for(var/mob/living/carbon/human/L in GLOB.player_list)
		if(L.stat >= HARD_CRIT || L.sanity_lost || z != L.z) // Dead or in hard crit, insane, or on a different Z level.
			continue
		if(L.get_clothing_class_level(L.get_major_clothing_class()) <= 4 )	//Only the strongest.
			continue
		potentialmarked += L
	if(LAZYLEN(potentialmarked))
		nemesis = pick(potentialmarked)

//Cleaning fairies
/mob/living/simple_animal/hostile/abnormality/titania/death(gibbed)
	for(var/mob/living/A in spawned_mobs)
		A.death()
	return ..()


//------------------------------------------------------------------------------
//Fairy Laws
//------------------------------------------------------------------------------

/mob/living/simple_animal/hostile/abnormality/titania/proc/SetLaw()

	var/lawmessage

	if(!nemesis || nemesis.stat == DEAD || fused)
		laws -= "nemesis"
	nextlaw = pick(laws.Copy() - currentlaw)

	switch(nextlaw)
		if("melee")
			lawmessage = "Thou shalt not hit thy queen with melee attacks."
		if("ranged")
			lawmessage = "Thou shalt not hit thy queen with ranged attacks."
		if("fairy")
			lawmessage = "Mine fairies are now heartier."
		if("armor")
			lawmessage = "Thy queen shalt not be hurt by red damage."
		if("nemesis")		//This mostly is so that you can tell who the nemesis is, and to encourage them to fight her.
			lawmessage = "No one but [nemesis] shalt hurt thy queen."
		if("ranged fairy")
			lawmessage = "Mine fairies will come to my aid if you strike me with ranged attacks."

	for(var/mob/living/carbon/human/H in GLOB.player_list)
		to_chat(H, span_colossus("[lawmessage]"))
	addtimer(CALLBACK(src, PROC_REF(ActivateLaw)), law_startup)	//Start Law 3 Seconds


/mob/living/simple_animal/hostile/abnormality/titania/proc/ActivateLaw()
	addtimer(CALLBACK(src, PROC_REF(SetLaw)), law_timer)	//Set Laws in 30 Seconds
	currentlaw = nextlaw
	to_chat(GLOB.clients, span_danger("The new law is now in effect."))

	if(currentlaw == "fairies")
		for(var/mob/living/simple_animal/L in spawned_mobs)
			L.ChangeResistances(list(BURN = 0.2, BRAIN = 0.2, BRUTE = 0.2, TOX = 1))
	else
		for(var/mob/living/simple_animal/L in spawned_mobs)
			L.ChangeResistances(list(BURN = 1, BRAIN = 1, BRUTE = 1, TOX = 1))


/mob/living/simple_animal/hostile/abnormality/titania/proc/Punishment(mob/living/sinner)
	to_chat(sinner, span_userdanger("You are hurt due to breaking Fairy Law."))
	sinner.apply_damage(law_damage, BRUTE)
	new /obj/effect/temp_visual/dir_setting/bloodsplatter(get_turf(sinner), pick(GLOB.alldirs))

//Ranged stuff
/mob/living/simple_animal/hostile/abnormality/titania/bullet_act(obj/projectile/Proj)
	..()

	if(!ishuman(Proj.firer))
		return

	var/mob/living/carbon/human/H = Proj.firer

	if(currentlaw == "ranged")
		Punishment(Proj.firer)

	if(currentlaw == "armor" && Proj.damage_type == BRUTE)
		Punishment(Proj.firer)

	if(currentlaw == "nemesis" && H != nemesis)
		Punishment(Proj.firer)

	if(currentlaw == "ranged fairy")
		SpawnFairies(1)

//Melee stuff
/mob/living/simple_animal/hostile/abnormality/titania/attacked_by(obj/item/I, mob/living/user)
	..()

	if(!user)
		return

	if(currentlaw == "melee")
		Punishment(user)

	if(currentlaw == "armor" && I.damtype == BRUTE && I.force >= 10)
		Punishment(user)

	if(currentlaw == "nemesis" && user != nemesis)
		Punishment(user)



//Breach, work, 'n' stuff
/mob/living/simple_animal/hostile/abnormality/titania/BreachEffect(mob/living/carbon/human/user)
	. = ..()
	ChooseNemesis()
	addtimer(CALLBACK(src, PROC_REF(FairyLoop)), 10 SECONDS)	//10 seconds from now you start spawning fairies
	addtimer(CALLBACK(src, PROC_REF(SetLaw)), law_timer)	//Set Laws in 30 Seconds
	if(nemesis)
		to_chat(src, span_userdanger("[nemesis], you are to die!"))
	if(!client && nemesis)
		say("[nemesis], you are a monster and I will slay you.")

/mob/living/simple_animal/hostile/abnormality/titania/PostWorkEffect(mob/living/carbon/human/user)
	if(!(user in worked))
		qliphoth_change(-1)
		worked+=user
	return ..()

/mob/living/simple_animal/hostile/abnormality/titania/FailureEffect(mob/living/carbon/human/user)
	qliphoth_change(-1)


//The Mini fairies
/mob/living/simple_animal/hostile/fairyswarm
	name = "fairy"
	desc = "A tiny, extremely hungry fairy."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/tegumobs.dmi'
	icon_state = "fairyswarm"
	icon_living = "fairyswarm"
	pass_flags = PASSTABLE | PASSMOB
	density = FALSE
	health = 80
	maxHealth = 80
	melee_damage_lower = 12
	melee_damage_upper = 15
	melee_damage_type = BRUTE
	obj_damage = 0
	environment_smash = ENVIRONMENT_SMASH_NONE
	attack_verb_continuous = "cuts"
	attack_verb_simple = "cut"
	attack_sound = 'sound/items/weapons/bladeslice.ogg'
	mob_size = MOB_SIZE_TINY
	del_on_death = TRUE
	var/mob/living/simple_animal/hostile/abnormality/titania/mommy

/mob/living/simple_animal/hostile/fairyswarm/Initialize()
	. = ..()
	pixel_x = rand(-16, 16)
	pixel_y = rand(-16, 16)

/mob/living/simple_animal/hostile/fairyswarm/Destroy()
	if(mommy)
		mommy.spawned_mobs -= src
		mommy = null
	return ..()

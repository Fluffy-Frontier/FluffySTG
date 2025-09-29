/mob/living/simple_animal/hostile/abnormality/fairy_festival
	name = "Fairy Festival"
	desc = "The abnormality is similar to a fairy, having two pairs of wings and a small body. The small fairies around it act as a cluster."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/tegumobs.dmi'
	icon_state = "fairy"
	icon_living = "fairy"
	maxHealth = 800
	health = 800
	move_to_delay = 5
	damage_coeff = list(BURN = 1, BRAIN = 1.2, BRUTE = 1.3, TOX = 2)
	melee_damage_lower = 8
	melee_damage_upper = 15
	stat_attack = DEAD
	attack_sound = 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/fairyfestival/fairyqueen_hit.ogg'
	fear_level = ZAYIN_LEVEL

	ego_list = list(
		/datum/ego_datum/weapon/wingbeat,
		/datum/ego_datum/armor/wingbeat,
	)
	gift_type =  /datum/ego_gifts/wingbeat
	gift_message = "Fairy Dust covers your hands..."

	var/heal_duration = 120 SECONDS
	var/heal_amount = 0.05
	var/heal_cooldown = 2 SECONDS
	var/heal_cooldown_base = 2 SECONDS
	var/list/mob/living/carbon/human/protected_people = list()
	var/summon_count = 0
	var/summon_type = /mob/living/simple_animal/hostile/mini_fairy
	var/summon_cooldown
	var/summon_cooldown_time = 30 SECONDS
	var/seek_cooldown
	var/seek_cooldown_time = 10 SECONDS
	var/summon_group_size = 6
	var/summon_maximum = 0
	var/eat_threshold = 0.8
	grouped_abnos = list(
		///mob/living/simple_animal/hostile/abnormality/fairy_gentleman = 1.5,
		/mob/living/simple_animal/hostile/abnormality/fairy_longlegs = 1.5,
		///mob/living/simple_animal/hostile/abnormality/faelantern = 1.5,
	)

	update_qliphoth = -1
	update_qliphoth_chance = 40
	action_cooldown = 20 SECONDS
	work_types = null

/mob/living/simple_animal/hostile/abnormality/fairy_festival/examine(mob/user)
	. = ..()
	. += "A gaggle of fairies flitter to and fro about the containment cell, they giggle as you approach.<br>\
		\"You're a peaceful child, aren't you? You're lucky to accept our care.\" <br>\
		They say in a sing-song all around you. \"Only good people ever speak to us, you're a good person too, right?\""

/mob/living/simple_animal/hostile/abnormality/fairy_festival/proc/FairyHeal()
	for(var/mob/living/carbon/human/P in protected_people)
		if(heal_cooldown <= world.time)
			P.adjustBruteLoss(-heal_amount*P.getMaxHealth())
			P.adjustFireLoss(-heal_amount*P.getMaxHealth())
	heal_cooldown = (world.time + heal_cooldown_base)
	return

/mob/living/simple_animal/hostile/abnormality/fairy_festival/try_working(mob/living/carbon/human/user)
	. = ..()
	if(!.)
		return
	if(user.stat != DEAD && istype(user))
		if(user in protected_people)
			return
		flick("fairy_blessing",src)
		protected_people += user
		RegisterSignal(user, COMSIG_DO_AFTER_BEGAN, PROC_REF(FairyGib))
		to_chat(user, span_nicegreen("You feel at peace under the fairies' care."))
		playsound(get_turf(user), 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/fairyfestival/fairylaugh.ogg', 50, 0, 2)
		user.add_overlay(mutable_appearance('tff_modular/modules/evento_needo/icons/Teguicons/tegu_effects.dmi', "fairy_heal", -MUTATIONS_LAYER))
		addtimer(CALLBACK(src, PROC_REF(FairyEnd), user), heal_duration)
	return

/mob/living/simple_animal/hostile/abnormality/fairy_festival/Life()
	. = ..()
	if(protected_people.len)
		FairyHeal()
	if(summon_count >= summon_maximum)
		return
	if((summon_cooldown < world.time) && !(HAS_TRAIT(src, TRAIT_GODMODE)))
		SummonGuys(summon_type)

/mob/living/simple_animal/hostile/abnormality/fairy_festival/proc/FairyEnd(mob/living/carbon/human/user)
	protected_people.Remove(user)
	user.cut_overlay(mutable_appearance('tff_modular/modules/evento_needo/icons/Teguicons/tegu_effects.dmi', "fairy_heal", -MUTATIONS_LAYER))
	to_chat(user, span_notice("The fairies giggle before returning to their queen."))
	UnregisterSignal(user, COMSIG_DO_AFTER_BEGAN)
	return

//not called by anything anymore, left here if somebody wants to readd it later for any reason.
/mob/living/simple_animal/hostile/abnormality/fairy_festival/proc/FairyGib(datum/source)
	SIGNAL_HANDLER
	var/mob/living/carbon/human/user = source
	if(!user)
		return
	if((user in protected_people) && HAS_TRAIT(user, TRAIT_GODMODE))
		to_chat(user, span_userdanger("With a beat of their wings, the fairies pounce on you and ravenously consume your body!"))
		playsound(get_turf(user), 'sound/effects/magic/demon_consume.ogg', 75, 0)
		UnregisterSignal(user, COMSIG_DO_AFTER_BEGAN)
		protected_people.Remove(user)
		user.gib(DROP_ALL_REMAINS)
	return

/mob/living/simple_animal/hostile/abnormality/fairy_festival/BreachEffect(mob/living/carbon/human/user)
	if(prob(50))
		summon_cooldown_time = 20 SECONDS
		summon_maximum = 15
		SummonGuys(summon_type)
	else
		can_breach = TRUE
		summon_type = /mob/living/simple_animal/hostile/fairy_mass
		summon_group_size = 1
		summon_maximum = 4
		SummonGuys(summon_type)
		icon = 'tff_modular/modules/evento_needo/icons/Teguicons/96x48.dmi'
		icon_state = "fairy_queen"
		pixel_x = -16
		maxHealth = 500
		playsound(get_turf(src), "tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/seasons/fall_change.ogg", 100, FALSE)
		playsound(get_turf(src), "tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/fairyfestival/fairyqueen_growl.ogg", 100, FALSE)
	return ..()

/mob/living/simple_animal/hostile/abnormality/fairy_festival/AttackingTarget(atom/attacked_target)
	. = ..()
	if(summon_type != /mob/living/simple_animal/hostile/fairy_mass)//does she have fairy masses?
		return
	if(istype(attacked_target, /mob/living/simple_animal/hostile/fairy_mass))
		var/mob/living/L = attacked_target
		if(L.health > 0)//fairies have to be alive; scarred meat isn't tasty
			L.gib(DROP_ALL_REMAINS)
			ProcessKill()
			playsound(get_turf(src), "tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/fairyfestival/fairyqueen_growl.ogg", 100, FALSE)
			return
		eat_threshold -= 0.2
	if(. && isliving(attacked_target))
		var/mob/living/L = attacked_target
		if(isliving(attacked_target) && (L.health < 0 || L.stat == DEAD))
			playsound(get_turf(src), "tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/fairyfestival/fairyqueen_growl.ogg", 100, FALSE)
			if(ishuman(L))
				ProcessKill()
			L.gib(DROP_ALL_REMAINS)

//Cannibalism
/mob/living/simple_animal/hostile/abnormality/fairy_festival/adjustHealth(amount, updating_health = TRUE, forced = FALSE)
	. = ..()
	if(summon_type != /mob/living/simple_animal/hostile/fairy_mass)//does she have fairy masses?
		return
	if(health < (maxHealth * eat_threshold)) //80% health or lower, 20% less for each eat.
		var/fairy_hp = 300
		var/mob/living/mytarget
		if(seek_cooldown < world.time)//this check can only be done once every ten seconds, for performance
			for(var/mob/living/simple_animal/hostile/fairy_mass/M in range(12, src))//finds the fairy with the lowest HP in the vicinity
				if(M.health <= 0)
					mytarget = M
					break
				if(M.health <= fairy_hp)
					fairy_hp = M.health
					mytarget = M
			if(mytarget)
				mytarget.faction = list("neutral")
				LoseTarget()
				GiveTarget(mytarget)
			seek_cooldown = world.time + seek_cooldown_time

/mob/living/simple_animal/hostile/abnormality/fairy_festival/proc/SummonGuys(summon_type)
	summon_cooldown = world.time + summon_cooldown_time
	var/mob/living/simple_animal/hostile/ordeal/pink_midnight/pink = locate() in GLOB.mob_living_list
	for(var/i = 1 to summon_group_size)
		var/turf/target_turf = get_turf(pink ? pink : src)
		var/mob/living/simple_animal/hostile/mini_fairy/new_fairy
		new_fairy = new summon_type(target_turf)
		summon_count += 1
		if(pink)
			new_fairy.faction += "pink_midnight"

/mob/living/simple_animal/hostile/abnormality/fairy_festival/proc/ProcessKill()
	eat_threshold -= 0.2
	adjustBruteLoss(-maxHealth)//FRESH MEAT!
	playsound(get_turf(src), "tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/fairyfestival/fairyqueen_growl.ogg", 100, FALSE)

/mob/living/simple_animal/hostile/mini_fairy
	name = "\improper Lost Fairy"
	desc = "They wander in search of food."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/tegumobs.dmi'
	icon_state = "fairy_bastard"
	icon_living = "fairy_bastard"
	maxHealth = 83
	health = 83
	attack_verb_continuous = "bites"
	attack_verb_simple = "bite"
	damage_coeff = list(BURN = 1, BRAIN = 1.2, BRUTE = 1.2, TOX = 1.2, BRUTE = 1.2)
	faction = list("hostile", "fairy")
	melee_damage_lower = 1
	melee_damage_upper = 5
	melee_damage_type = BRUTE
	obj_damage = 3
	rapid_melee = 3
	attack_sound = 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/fairyfestival/fairy_festival_bite.ogg'
	density = FALSE
	move_to_delay = 2
	del_on_death = TRUE
	stat_attack = DEAD

/mob/living/simple_animal/hostile/mini_fairy/Initialize()
	. = ..()
	AddComponent(/datum/component/swarming)
	summon_backup()

/mob/living/simple_animal/hostile/mini_fairy/AttackingTarget(atom/attacked_target)
	. = ..()
	var/friends = 0
	for(var/mob/living/simple_animal/hostile/mini_fairy/fren in ohearers(6, src))
		friends++
	if(friends < 3)
		summon_backup()
	if(ishuman(attacked_target))
		var/mob/living/L = attacked_target
		if(L.health < 0 || L.stat == DEAD)
			var/mob/living/simple_animal/hostile/mini_fairy/MF = new(get_turf(L))
			MF.faction = src.faction
			playsound(get_turf(src), 'sound/effects/magic/demon_consume.ogg', 75, 0)
			L.gib(DROP_ALL_REMAINS)
			summon_backup()

/mob/living/simple_animal/hostile/mini_fairy/summon_backup(distance = 6)
	for(var/mob/living/simple_animal/hostile/M in oview(distance, targets_from))
		if(faction_check_atom(M, TRUE))
			if(M.AIStatus == AI_OFF)
				continue
			else
				M.Goto(src,M.move_to_delay,M.minimum_distance)

/mob/living/simple_animal/hostile/fairy_mass
	name = "\improper Fairy Mass"
	desc = "They wander in search of food."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/tegumobs.dmi'
	icon_state = "fairy_mass"
	icon_living = "fairy_mass"
	icon_dead = "fairy_mass_dead"
	maxHealth = 150
	health = 150
	attack_verb_continuous = "bites"
	attack_verb_simple = "bite"
	damage_coeff = list(BURN = 1, BRAIN = 1.2, BRUTE = 1.2, TOX = 1.2, BRUTE = 1.2)
	faction = list("hostile", "fairy")
	melee_damage_lower = 1
	melee_damage_upper = 5
	melee_damage_type = BRUTE
	obj_damage = 3
	rapid_melee = 3
	attack_sound = 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/fairyfestival/fairy_festival_bite.ogg'
	density = FALSE
	move_to_delay = 2
	stat_attack = DEAD
	guaranteed_butcher_results = list(/obj/item/food/meat/slab = 1)

/mob/living/simple_animal/hostile/fairy_mass/AttackingTarget(atom/attacked_target)
	. = ..()
	if(iscarbon(attacked_target))
		var/mob/living/L = attacked_target
		if(L.health < 0 || L.stat == DEAD)
			playsound(get_turf(src), 'sound/effects/magic/demon_consume.ogg', 75, 0)
			L.gib(DROP_ALL_REMAINS)

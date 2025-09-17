/mob/living/simple_animal/hostile/abnormality/fairy_gentleman
	name = "Fairy Gentleman"
	desc = "A very wide humanoid with long arms made of green, dripping slime."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/96x64.dmi'
	icon_state = "fairy_gentleman"
	maxHealth = 900
	health = 900
	ranged = TRUE
	rapid_melee = 1
	melee_queue_distance = 2
	move_to_delay = 5
	damage_coeff = list(BURN = 1, BRAIN = 0.7, BRUTE = 1.5, TOX = 1, BRUTE = 2)
	melee_damage_lower = 6
	melee_damage_upper = 12
	melee_damage_type = BRUTE  //Low damage - makes you drunk on a hit
	stat_attack = HARD_CRIT
	attack_sound = 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/fairygentleman/ego_sloshing.ogg'
	attack_verb_continuous = "slaps"
	attack_verb_simple = "slap"
	can_breach = TRUE
	fear_level = TETH_LEVEL

	pixel_x = -34
	base_pixel_x = -34
	ego_list = list(
		/datum/ego_datum/weapon/sloshing,
		/datum/ego_datum/armor/sloshing,
	)
	gift_type = /datum/ego_gifts/sloshing
	gift_message = "This wine tastes quite good..."
	grouped_abnos = list(
		/mob/living/simple_animal/hostile/abnormality/fairy_festival = 1.5,
		/mob/living/simple_animal/hostile/abnormality/fairy_longlegs = 1.5,
		/mob/living/simple_animal/hostile/abnormality/faelantern = 1.5,
	)

	observation_prompt = "\"Care for a drink?\""


	var/can_act = TRUE
	var/jump_cooldown = 0
	var/jump_cooldown_time = 8 SECONDS
	var/jump_damage = 30
	var/jump_sound = 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/fairygentleman/jump.ogg'
	var/jump_aoe = 1

	var/list/give_drink = list(
		"You quite an interesting one, Feel free to take this drink! It is on the house!",
		"Attaboy, I think you deserve this! Drink! Drink 'til you're half seas over!",
		"HA HA HA HA!!! You can really talk an earful! Here, have one on me!",
		"Come on now, no need to worry. Try some of this giggle water, it's the bee's knees!",
		"Plum outta luck for eatery, I've already had all the food. Would ya care for a drink?",
	)
	var/list/disappointed = list(
		"Pipe down, pinko. I don't think this will help any of us if you continue like this.",
		"Come on now, what did I ever do to you? A little hootch never hurt nobody.",
		"This is how you treat me after giving you all of you my finest drinks?",
		"I have to go see a man about a dog.",
		"Are you okay? A big shot like yourself has no need to hold back.",
	)

	var/list/angry = list(
		"I'll wring you out!",
		"Come on, I'm taking you for a ride!",
		"This is all I got!",
		"I'll be havin' this!",
		"Scram!",
	)

//Action Buttons
	attack_action_types = list(
	/datum/action/innate/abnormality_attack/toggle/FairyJump,
	/datum/action/cooldown/gentleman_drink,
	)

/datum/action/innate/abnormality_attack/toggle/FairyJump
	name = "Toggle Jump"
	button_icon_state = "generic_toggle0"
	chosen_attack_num = 2
	chosen_message = span_colossus("You won't jump anymore.")
	button_icon_toggle_activated = "generic_toggle1"
	toggle_attack_num = 1
	toggle_message = span_colossus("You will now jump with your next attack when possible.")
	button_icon_toggle_deactivated = "generic_toggle0"

/datum/action/cooldown/gentleman_drink
	name = "Offer a drink"
	//button_icon = 'icons/obj/drinks.dmi'
	//button_icon_state = "fairy_wine"
	check_flags = AB_CHECK_CONSCIOUS
	transparent_when_unavailable = TRUE
	cooldown_time = 5 SECONDS

/datum/action/cooldown/gentleman_drink/Trigger(trigger_flags, atom/target)
	if(!..())
		return FALSE
	if(!istype(owner, /mob/living/simple_animal/hostile/abnormality/fairy_gentleman))
		return FALSE

//Work mechanics
/mob/living/simple_animal/hostile/abnormality/fairy_gentleman/SuccessEffect(mob/living/carbon/human/user)
	if(pe >= 11) // Almost perfect work
		var/turf/dispense_turf = get_step(src, pick(1,2,4,5,6,8,9,10))
		new/obj/item/reagent_containers/cup/fairywine(dispense_turf)
		visible_message(span_notice("[src] gives out some fairy wine."))
		say(pick(give_drink))
	return

/mob/living/simple_animal/hostile/abnormality/fairy_gentleman/PostWorkEffect(mob/living/carbon/human/user)
	if(user.get_major_clothing_class() == CLOTHING_ENGINEERING)
		user.reagents.add_reagent(/datum/reagent/consumable/ethanol/fairywine, 10)
		visible_message(span_notice("You take a drink with the fairy gentleman."))
		say("Ha! Easy on the good stuff, hot shot!")
	return

/mob/living/simple_animal/hostile/abnormality/fairy_gentleman/NeutralEffect(mob/living/carbon/human/user, work_type, pe)
	. = ..()
	say(pick(disappointed))

/mob/living/simple_animal/hostile/abnormality/fairy_gentleman/FailureEffect(mob/living/carbon/human/user)
	qliphoth_change(-1)
	return

//Breach Mechanics
/mob/living/simple_animal/hostile/abnormality/fairy_gentleman/BreachEffect(mob/living/carbon/human/user) //he flies
	. = ..()
	AddElement(/datum/element/knockback, 1, FALSE, TRUE)
	say(pick(angry))
	ADD_TRAIT(src, TRAIT_MOVE_FLYING, INNATE_TRAIT)

/mob/living/simple_animal/hostile/abnormality/fairy_gentleman/AttackingTarget(atom/attacked_target)
	if(!can_act)
		return
	melee_damage_type = BRUTE
	if(jump_cooldown <= world.time && prob(10) && !client)
		FairyJump(attacked_target)
		return
	if(!ishuman(attacked_target))
		return ..()
	var/mob/living/carbon/human/H = attacked_target
	H.drunkenness += 5
	to_chat(H, span_warning("Yuck, some of it got in your mouth!"))
	if(H.sanity_lost)
		melee_damage_type = BRUTE
	return ..()


/mob/living/simple_animal/hostile/abnormality/fairy_gentleman/Move()
	if(!can_act)
		return FALSE
	return ..()

/mob/living/simple_animal/hostile/abnormality/fairy_gentleman/OpenFire()
	if(!can_act)
		return FALSE
	if(client)
		if(chosen_attack != 1)
			return
		FairyJump(target)
		return

	var/dist = get_dist(target, src)
	if(jump_cooldown <= world.time)
		var/chance_to_jump = 25
		if(dist > 3)
			chance_to_jump = 100
		if(prob(chance_to_jump))
			FairyJump(target)
		return

// Attacks
/mob/living/simple_animal/hostile/abnormality/fairy_gentleman/proc/FairyJump(mob/living/target)
	if(!isliving(target) && !ismecha(target) || !can_act)
		return
	var/dist = get_dist(target, src)
	if(dist > 1 && jump_cooldown < world.time)
		say(pick(angry))
		jump_cooldown = world.time + jump_cooldown_time
		can_act = FALSE
		SLEEP_CHECK_DEATH(0.25 SECONDS, src)
		animate(src, alpha = 1, pixel_z = 16, time = 0.1 SECONDS)
		src.pixel_z = 16
		playsound(src, 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/ichthys/jump.ogg', 50, FALSE, 4)
		var/turf/target_turf = get_turf(target)
		SLEEP_CHECK_DEATH(1 SECONDS, src)
		forceMove(target_turf) //look out, someone is rushing you!
		playsound(src, jump_sound, 50, FALSE, 4)
		animate(src, alpha = 255, pixel_z = -16, time = 0.1 SECONDS)
		src.pixel_z = 0
		SLEEP_CHECK_DEATH(0.1 SECONDS, src)
		var/target_drunk
		for(var/turf/T in view(jump_aoe, src))
			var/obj/effect/temp_visual/small_smoke/halfsecond/FX =  new(T)
			FX.color = "#b52e19"
			for(var/mob/living/L in T)
				if(faction_check_atom(L))
					continue
				if(ishuman(L))
					var/mob/living/carbon/human/H = L
					if(H.drunkenness > 50) // easter egg - being drunk makes you stagger him
						target_drunk = TRUE
						jump_damage = 0
					else
						jump_damage = initial(jump_damage)
				L.apply_damage(jump_damage, BRUTE)
				if(L.health < 0)
					L.gib()
			for(var/obj/vehicle/sealed/mecha/V in T)
				V.take_damage(jump_damage, BRUTE)
		var/wait_time = 0.5 SECONDS
		if(target_drunk)
			wait_time += 3.5 SECONDS
			visible_message(span_boldwarning("[src] staggers around, exposing a weak point!"), span_nicegreen("You feel dizzy!"))
		SLEEP_CHECK_DEATH(wait_time, src)
		can_act = TRUE

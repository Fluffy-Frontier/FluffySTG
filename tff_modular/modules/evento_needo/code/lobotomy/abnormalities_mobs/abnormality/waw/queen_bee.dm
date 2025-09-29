/mob/living/simple_animal/hostile/abnormality/queen_bee
	name = "Queen Bee"
	desc = "A disfigured creature resembling a bee queen."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/48x64.dmi'
	icon_state = "queen_bee"
	icon_living = "queen_bee"
	faction = list("hostile")
	speak_emote = list("buzzes")

	pixel_x = -8
	base_pixel_x = -8

	fear_level = WAW_LEVEL
	ego_list = list(
		/datum/ego_datum/weapon/hornet,
		/datum/ego_datum/weapon/tattered_kingdom,
		/datum/ego_datum/armor/hornet,
	)
	gift_type =  /datum/ego_gifts/hornet
	grouped_abnos = list(
		///mob/living/simple_animal/hostile/abnormality/general_b = 5,
	)

	observation_prompt = "There was one summer so hot and unpleasant. <br>Bees were busily flying around the beehive. <br>\
		They live for the only one queen. <br>'Are they happy? Living only to work' I asked myself. <br>Then someone answered."


	var/datum/looping_sound/queenbee/soundloop
	var/breached_others = FALSE
	neutral_chance = 10
	negative_chance = 80

/mob/living/simple_animal/hostile/abnormality/queen_bee/Initialize()
	. = ..()
	soundloop = new(list(src), TRUE)

/mob/living/simple_animal/hostile/abnormality/queen_bee/Destroy()
	QDEL_NULL(soundloop)
	return ..()

/mob/living/simple_animal/hostile/abnormality/queen_bee/proc/emit_spores()
	var/turf/target_c = get_turf(src)
	var/list/turf_list = list()
	turf_list = spiral_range_turfs(36, target_c)
	playsound(target_c, 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/bee/spores.ogg', 50, 1, 5)
	for(var/turf/open/T in turf_list)
		if(prob(25))
			new /obj/effect/temp_visual/bee_gas(T)
		//for(var/mob/living/simple_animal/hostile/abnormality/general_b/Y in T.contents)
		//	if(breached_others == FALSE)
		//		Y.BreachEffect()
		//		breached_others = TRUE

/mob/living/simple_animal/hostile/abnormality/queen_bee/ZeroQliphoth(mob/living/carbon/human/user)
	emit_spores()
	qliphoth_change(1)
	return


/* Worker bees */
/mob/living/simple_animal/hostile/worker_bee
	name = "worker bee"
	desc = "A disfigured creature with nasty fangs."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/48x64.dmi'
	icon_state = "worker_bee"
	icon_living = "worker_bee"
	base_pixel_x = -8
	health = 450
	maxHealth = 450
	melee_damage_type = BRUTE
	damage_coeff = list(BURN = 1.2, BRAIN = 1.5, BRUTE = 0.8, TOX = 2)
	melee_damage_lower = 14
	melee_damage_upper = 18
	rapid_melee = 2
	obj_damage = 200
	robust_searching = TRUE
	stat_attack = HARD_CRIT
	del_on_death = TRUE
	death_sound = 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/bee/death.ogg'
	attack_verb_continuous = "bites"
	attack_verb_simple = "bite"
	attack_sound = 'sound/items/weapons/bite.ogg'
	speak_emote = list("buzzes")

/mob/living/simple_animal/hostile/worker_bee/Initialize()
	. = ..()
	playsound(get_turf(src), 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/bee/birth.ogg', 50, 1)
	var/matrix/init_transform = transform
	transform *= 0.1
	alpha = 25
	animate(src, alpha = 255, transform = init_transform, time = 5)

/mob/living/simple_animal/hostile/worker_bee/AttackingTarget(atom/attacked_target)
	. = ..()
	if(!ishuman(attacked_target))
		return
	var/mob/living/carbon/human/H = attacked_target
	if(H.health <= 0)
		var/turf/T = get_turf(H)
		visible_message(span_danger("[src] bites hard on \the [H] as another bee appears!"))
		H.emote("scream")
		H.gib(DROP_ALL_REMAINS)
		new /mob/living/simple_animal/hostile/worker_bee(T)

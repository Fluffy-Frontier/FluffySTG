//Coded by Coxswain
/mob/living/simple_animal/hostile/abnormality/clown
	name = "Clown Smiling at Me"
	desc = "An unnerving clown."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/tegumobs.dmi'
	icon_state = "clown_smiling"
	icon_living = "clown_smiling"
	var/icon_aggro = "clown_breach"
	icon_dead = "clown_breach"
	pixel_y = 64
	base_pixel_y = 64
	speak_emote = list("honks")
	maxHealth = 1800
	health = 1800
	rapid_melee = 4
	melee_queue_distance = 4
	damage_coeff = list(BURN = 1.0, BRAIN = 1.0, BRUTE = 1.0, TOX = 1.3, BRUTE = 1.5)
	melee_damage_lower = 15
	melee_damage_upper = 15
	melee_damage_type = BRUTE
	see_in_dark = 10
	stat_attack = DEAD
	move_to_delay = 3
	fear_level = WAW_LEVEL
	fear_level = ALEPH_LEVEL
	attack_sound = 'sound/items/weapons/bladeslice.ogg'
	attack_verb_continuous = "stabs"
	attack_verb_simple = "stab"
	friendly_verb_continuous = "honks"
	friendly_verb_simple = "honk"
	can_breach = TRUE
	good_hater = TRUE
	death_message = "blows up like a balloon!"
	speak_chance = 2
	emote_see = list("honks.")
	emote_hear = list("honks.")
	ranged = TRUE
	ranged_cooldown_time = 4 SECONDS
	projectiletype = /obj/projectile/clown_throw
	projectilesound = 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/clownsmiling/throw.ogg'

	ego_list = list(
		/datum/ego_datum/weapon/mini/mirth,
		/datum/ego_datum/weapon/mini/malice,
		/datum/ego_datum/armor/darkcarnival,
	)
	gift_type =  /datum/ego_gifts/darkcarnival
	gift_message = "Life isn't scary when you don't fear death."
//TODO : resprite
	observation_prompt = "One of the containment cells at Lobotomy Corporation houses a clown. <br>\
		Some people are afraid of clowns, but I don't mind them at all. <br>\
		Even then, nobody could be fooled into believing this \"clown\" was just a person in makeup. <br>\
		When I first met this thing, I started to understand how those people feel. <br>\
		Right now, during my attachment work, it started its usual clown performance. <br>\
		Things are looking good so far. <br>Out of its pocket, the clown pulls out..."


	del_on_death = FALSE //for explosions
	var/finishing = FALSE
	var/step = FALSE
	var/finishing_small_damage = 5
	var/finishing_big_damage = 30

/mob/living/simple_animal/hostile/abnormality/clown/Login()
	. = ..()
	to_chat(src, "<h1>You are Clown Smiling at Me, A Combat Role Abnormality.</h1><br>\
		<b>|Dark Carnival|: When you click on a tile which is outside your melee range, you will throw a knife towards that tile. Your knife will deal no damage to abnormalities, and will pass through them. \
		If you hit a human with this knife, you will deal RED damage to them, slow them down massively and inflict 8 'Bleed'. \
		Also, You blades are able to bounch against walls! Each time they bounch against a wall, their damage will be doubled!<br>\
		<br>\
		|Jovial Cutting|: When you attack a dead human, you will start rapidly gutting them, which will deal WHITE damage to all humans watching. \
		A few seconds after gutting that human, you will gib them.<br>\
		<br>\
		|Bleed|: When a target with bleed moves, they will take True damage equal to the stack, then it reduces by half.<br>\
		<br>\
		|A Show’s End|: Once you reach 0 HP, you will explode which deal great RED damage to nearby humans, inflict 30 'Bleed' and leave behind a few trails of lube, which can slip humans who cross them.</b>")

//A clown isn't a clown without his shoes
/mob/living/simple_animal/hostile/abnormality/clown/BreachEffect(mob/living/carbon/human/user)
	. = ..()
	update_icon()
	pixel_y = 0
	base_pixel_y = 0
	AddElement(/datum/element/waddling)
	playsound(get_turf(src), 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/clownsmiling/announce.ogg', 75, 1)
	GiveTarget(user)

/mob/living/simple_animal/hostile/abnormality/clown/Moved(atom/old_loc, movement_dir, forced, list/old_locs, momentum_change)
	. = ..()
	if(step)
		playsound(get_turf(src), 'sound/effects/footstep/clownstep2.ogg', 30, 0, 3)
		step = FALSE
		return
	playsound(get_turf(src), 'sound/effects/footstep/clownstep1.ogg', 30, 0, 3)
	step = TRUE

/mob/living/simple_animal/hostile/abnormality/clown/update_icon_state()
	if(HAS_TRAIT(src, TRAIT_GODMODE))	// Not breaching
		icon_state = initial(icon)
	else
		icon_state = icon_aggro
	return ..()

//Execution code from green dawn with inflated damage numbers
/mob/living/simple_animal/hostile/abnormality/clown/CanAttack(atom/the_target)
	if(isliving(the_target) && !ishuman(the_target))
		var/mob/living/L = the_target
		if(L.stat == DEAD)
			return FALSE
	return ..()

/mob/living/simple_animal/hostile/abnormality/clown/AttackingTarget(atom/attacked_target)
	. = ..()
	if(.)
		if(!ishuman(attacked_target))
			return
		var/mob/living/carbon/human/TH = attacked_target
		if(TH.health < 0)
			finishing = TRUE
			TH.Stun(4 SECONDS)
			forceMove(get_turf(TH))
			var/mob/living/simple_animal/hostile/from = locate(targets_from) in GLOB.simple_animals
			for(var/i = 1 to 7)
				if(!from.Adjacent(TH) || QDELETED(TH))
					finishing = FALSE
					return
				TH.attack_animal(src)
				for(var/mob/living/carbon/human/H in ohearers(7, get_turf(src)))
					H.apply_damage(finishing_small_damage, BRUTE)
				SLEEP_CHECK_DEATH(2, src)
			if(!from.Adjacent(TH) || QDELETED(TH))
				finishing = FALSE
				return
			playsound(get_turf(src), 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/clownsmiling/final_stab.ogg', 50, 1)
			TH.gib(DROP_ALL_REMAINS)
			for(var/mob/living/carbon/human/H in ohearers(7, get_turf(src)))
				H.apply_damage(finishing_big_damage, BRUTE)

/mob/living/simple_animal/hostile/abnormality/clown/MoveToTarget(list/possible_targets)
	if(ranged_cooldown <= world.time)
		OpenFire(target)
	return ..()

// Prevents knife throwing in mele range
/mob/living/simple_animal/hostile/abnormality/clown/OpenFire(atom/A)
	if(get_dist(src, A) <= 2) //no shooty in mele
		return FALSE
	return ..()

// Modified patrolling
/mob/living/simple_animal/hostile/abnormality/clown/handle_automated_movement()
	var/list/target_turfs = list() // Stolen from Punishing Bird
	for(var/mob/living/carbon/human/H in GLOB.human_list)
		if(H.z != z) // Not on our level
			continue
		if(get_dist(src, H) < 4) // Unnecessary for this distance
			continue
		target_turfs += get_turf(H)

	var/turf/target_turf = get_closest_atom(/turf/open, target_turfs, src)
	if(istype(target_turf))
		Goto(target_turf, 20 DECISECONDS, 1)
		return
	return ..()

//Death explosion
/mob/living/simple_animal/hostile/abnormality/clown/death(gibbed)
	animate(src, transform = matrix()*1.8, color = "#FF0000", time = 20)
	addtimer(CALLBACK(src, PROC_REF(DeathExplosion)), 20)
	..()

/mob/living/simple_animal/hostile/abnormality/clown/proc/DeathExplosion()
	if(QDELETED(src))
		return
	visible_message(span_danger("[src] suddenly explodes!"))
	playsound(get_turf(src), 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/clownsmiling/announcedead.ogg', 75, 1)
	for(var/mob/living/L in view(5, src))
		if(!faction_check_atom(L))
			L.apply_damage(25, BRUTE)
	var/datum/reagents/tmp_holder = new/datum/reagents(10)
	tmp_holder.my_atom = src
	tmp_holder.add_reagent(/datum/reagent/consumable/banana, 10)

	var/datum/effect_system/fluid_spread/foam/foam = new
	foam.set_up(1, holder = src, location = get_turf(src), carry = tmp_holder)
	foam.start()
	gib()

//Clown picture-related code
/mob/living/simple_animal/hostile/abnormality/clown/PostSpawn()
	..()
	if(locate(/obj/structure/clown_picture) in get_turf(src))
		return
	new /obj/structure/clown_picture(get_turf(src))

/obj/structure/clown_picture
	name = "clown picture"
	desc = "A picture of a clown, torn at the seams."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/tegumobs.dmi'
	icon_state = "clown_picture"
	anchored = TRUE
	density = FALSE
	layer = WALL_OBJ_LAYER
	resistance_flags = INDESTRUCTIBLE
	pixel_y = 64
	base_pixel_y = 64
	var/datum/looping_sound/clown_ambience/circustime

/obj/structure/clown_picture/Initialize()
	. = ..()
	circustime = new(list(src), TRUE)

/mob/living/simple_animal/hostile/abnormality/clayman
	name = "Generic Brand Modelling Clay"
	desc = "A small, rough humanoid figure made of clay."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/32x32.dmi'
	icon_state = "bluro"
	icon_living = "bluro"
	icon_dead = "bluro"
	del_on_death = TRUE
	maxHealth = 1000
	health = 1000
	ranged = TRUE
	rapid_melee = 1
	melee_queue_distance = 2
	move_to_delay = 3
	damage_coeff = list(BURN = 1, BRAIN = 1, BRUTE = 1, TOX = 1, BRUTE = 1)
	melee_damage_lower = 10
	melee_damage_upper = 12
	melee_damage_type = BRUTE
	attack_sound = 'sound/effects/hit_kick.ogg'
	attack_verb_continuous = "smashes"
	attack_verb_simple = "smash"
	friendly_verb_continuous = "bonks"
	friendly_verb_simple = "bonk"
	can_breach = TRUE
	fear_level = TETH_LEVEL
	death_message = "loses form."
	ego_list = list(
		/datum/ego_datum/weapon/clayman,
		/datum/ego_datum/armor/clayman,
	)
	var/dashready = TRUE
/mob/living/simple_animal/hostile/abnormality/clayman/PostWorkEffect(mob/living/carbon/human/user)
	. = ..()
	var/list/damtypes = list(BURN, BRAIN, BRUTE, TOX)
	var/damage = pick(damtypes)
	user.apply_damage(25, damage)

/mob/living/simple_animal/hostile/abnormality/clayman/CanAttack(atom/the_target)
	melee_damage_type = list(BURN, BRAIN, BRUTE, TOX)
	return ..()

/mob/living/simple_animal/hostile/abnormality/clayman/FailureEffect(mob/living/carbon/human/user)
	qliphoth_change(-1)

/mob/living/simple_animal/hostile/abnormality/clayman/proc/Skitter()
	visible_message(span_warning("[src] Skitters faster!"), span_notice("you hear the patter of hundreds of clay feet"))
	set_varspeed(speed - 2)
	addtimer(CALLBACK(src, PROC_REF(set_varspeed), speed + 2), 15 SECONDS)
	dashready = FALSE
	addtimer(CALLBACK(src, PROC_REF(dashreset)), 15 SECONDS)

/mob/living/simple_animal/hostile/abnormality/clayman/OpenFire(atom/A)
	if(get_dist(src, target) >= 3 && dashready)
		Skitter()

/mob/living/simple_animal/hostile/abnormality/clayman/proc/dashreset()
	dashready = TRUE

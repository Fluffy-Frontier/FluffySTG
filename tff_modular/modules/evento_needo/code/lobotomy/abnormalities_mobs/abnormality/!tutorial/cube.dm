/mob/living/simple_animal/hostile/abnormality/cube
	name = "THE CUBE"
	desc = "A strange floating cube."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/32x32.dmi'
	icon_state = "cube"
	icon_living = "cube"
	maxHealth = 50
	health = 50
	fear_level = TETH_LEVEL
	move_to_delay = 6
	damage_coeff = list(BURN = 1, BRAIN = 0.5, BRUTE = 1.5, TOX = 1)
	can_breach = TRUE
	can_spawn = FALSE // Normally doesn't appear
	var/pulse_cooldown
	var/pulse_cooldown_time = 3 SECONDS
	var/pulse_damage = 6
	update_qliphoth = -1

/mob/living/simple_animal/hostile/abnormality/cube/BreachEffect(mob/living/carbon/human/user, breach_type)
	. = ..()
	GiveTarget(user)
	addtimer(CALLBACK(src, PROC_REF(die)), 60 SECONDS)

/mob/living/simple_animal/hostile/abnormality/cube/proc/die()
	QDEL_NULL(src)

/mob/living/simple_animal/hostile/abnormality/cube/Life()
	. = ..()
	if(!.) // Dead
		return FALSE
	if((pulse_cooldown < world.time) && !(HAS_TRAIT(src, TRAIT_GODMODE)))
		WhitePulse()

/mob/living/simple_animal/hostile/abnormality/cube/AttackingTarget(atom/attacked_target)
	return

/mob/living/simple_animal/hostile/abnormality/cube/proc/WhitePulse()
	pulse_cooldown = world.time + pulse_cooldown_time
	playsound(src, 'sound/effects/magic/disable_tech.ogg', 50, FALSE, 4)
	for(var/mob/living/L in view(8, src))
		if(faction_check_atom(L))
			continue
		L.apply_damage(pulse_damage, BRUTE)
		new /obj/effect/temp_visual/dir_setting/bloodsplatter(get_turf(L), pick(GLOB.alldirs))


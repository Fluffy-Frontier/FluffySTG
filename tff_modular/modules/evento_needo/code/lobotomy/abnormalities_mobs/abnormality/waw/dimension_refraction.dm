/mob/living/simple_animal/hostile/abnormality/dimensional_refraction
	name = "Dimensional Refraction Variant"
	desc = "A barely visible haze"
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/64x64.dmi'
	icon_state = "dmr_abnormality"
	icon_living = "dmr_abnormality"
	del_on_death = TRUE
	pixel_x = -16
	base_pixel_x = -16
	pixel_y = -16
	base_pixel_y = -16

	maxHealth = 1200
	health = 1200
	blood_volume = 0
	density = FALSE
	damage_coeff = list(BURN = 0, BRAIN = 1.5, BRUTE = 0.8, TOX = 1)
	stat_attack = HARD_CRIT
	can_breach = TRUE
	fear_level = WAW_LEVEL
	fear_level = 0
	move_to_delay = 6
	ego_list = list(
		/datum/ego_datum/weapon/diffraction,
		/datum/ego_datum/armor/diffraction,
	)
	gift_type =  /datum/ego_gifts/diffraction
	observation_prompt = "It's invisible to almost all means of measurement, the only way I know it's there is due to the effect it has on the cup of water before me. <br>\
		I calmly observe the chamber's surroundings and make adjustments when I notice the surface of the cup's liquid begin to bubble."


	var/cooldown_time = 3
	var/aoe_damage = 12

/mob/living/simple_animal/hostile/abnormality/dimensional_refraction/proc/Melter()
	for(var/mob/living/L in view(1, src))
		if(faction_check_atom(L))
			continue
		L.apply_damage(aoe_damage, BRUTE)
		new /obj/effect/temp_visual/dir_setting/bloodsplatter(get_turf(L), pick(GLOB.alldirs))
	addtimer(CALLBACK(src, PROC_REF(Melter)), cooldown_time)


/mob/living/simple_animal/hostile/abnormality/dimensional_refraction/AttackingTarget()
	return FALSE

/mob/living/simple_animal/hostile/abnormality/dimensional_refraction/PickTarget(list/Targets)
	return

//Cannot be automatically followed by manager camera follow command.
/mob/living/simple_animal/hostile/abnormality/dimensional_refraction/can_track(mob/living/user)
	return FALSE

/* Qliphoth/Breach effects */
/mob/living/simple_animal/hostile/abnormality/dimensional_refraction/BreachEffect(mob/living/carbon/human/user, breach_type)
	. = ..()
	alpha = 30
	addtimer(CALLBACK(src, PROC_REF(Melter)), cooldown_time)

/mob/living/simple_animal/hostile/abnormality/riblin
	name = "Rise Of the Riblin"
	desc = "A humanoid wearing an odd mask."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/48x64.dmi'
	icon_state = "mcrib"
	icon_living = "mcrib"
	maxHealth = 600
	health = 600
	damage_coeff = list(BRUTE = 1, BRUTE = 1, BRUTE = 1)

	stat_attack = HARD_CRIT

	ego_list = list(
		/datum/ego_datum/weapon/mcrib,
		/datum/ego_datum/armor/mcrib,
	)

/mob/living/simple_animal/hostile/abnormality/riblin/attackby(obj/item/attacking_item, mob/living/user, list/modifiers, list/attack_modifiers)
	. = ..()
	if(!.)
		return
	if(prob(10))
		playsound(src, 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/mcrib/evillaugh.ogg', 50, FALSE)
		user.gib()
	next_action_time = world.time + 20 SECONDS

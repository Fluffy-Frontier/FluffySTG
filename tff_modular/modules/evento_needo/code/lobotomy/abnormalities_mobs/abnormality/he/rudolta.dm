//ho ho hoe -gail
/mob/living/simple_animal/hostile/abnormality/rudolta
	name = "Rudolta of the Sleigh"
	desc = "An abnormality consisting of three parts: A hornless, disfigured reindeer, \"Santa\" and a sleigh. \
	Rudolta is a fair creature that will give gifts equally to everyone, whether you like them or not."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/64x48.dmi'
	icon_state = "rudolta"
	icon_living = "rudolta"
	icon_dead = "rudolta_dead"
	maxHealth = 1200
	health = 1200
	pixel_x = -16
	base_pixel_x = -16
	damage_coeff = list(BURN = 1.5, BRAIN = 0.5, BRUTE = 1, TOX = 2, FIRE = 1.5)
	stat_attack = HARD_CRIT
	can_breach = TRUE
	fear_level = HE_LEVEL
	move_to_delay = 6
	minimum_distance = 2 // Don't move all the way to melee
	friendly_verb_continuous = "scorns"
	friendly_verb_simple = "scorns"

	ego_list = list(
		/datum/ego_datum/weapon/christmas,
		/datum/ego_datum/armor/christmas,
	)
	gift_type =  /datum/ego_gifts/christmas
	//Try not to make other observations this long - This is by PM though so, we have to use it. -Coxswain
	observation_prompt = "I heard about a man who could give you anything you want once a year. <br>Good kids have a better chance of seeing him. <br>\
		A man who carries giant sack on his back. <br>A man who can go anywhere in the world with his reindeer-pulled sled. <br>\
		Alex got a present. <br>Even though he was a naughty kid. <br>It was unfair. <br>I could not accept it. <br>The next Christmas, I went to Alex's. <br>\
		If that man comes only for Alex this time again, I will ask him why had he not come to me. <br>\
		That night, when everyone was sleeping. <br>I waited for the man, sitting next to sleeping Alex. <br>\
		Sometimes, for someone, an absurd fairy tale is a silver lining of hope. <br>When I met Santa, I imagined dismembering him. <br>... <br>\
		In front of me is Santa. <br>My ideal. <br>People don't call it Santa. <br>Something is twitching inside of that sack. I......"


	var/pulse_cooldown
	var/pulse_cooldown_time = 1.8 SECONDS
	var/pulse_damage = 20

/mob/living/simple_animal/hostile/abnormality/rudolta/NeutralEffect(mob/living/carbon/human/user, work_type, pe)
	. = ..()
	if(prob(40))
		qliphoth_change(-1)
	return

/mob/living/simple_animal/hostile/abnormality/rudolta/FailureEffect(mob/living/carbon/human/user)
	if(prob(80))
		qliphoth_change(-1)
	return

/mob/living/simple_animal/hostile/abnormality/rudolta/PickTarget(list/Targets)
	return

/mob/living/simple_animal/hostile/abnormality/rudolta/Life()
	. = ..()
	if(!.) // Dead
		return FALSE
	if((pulse_cooldown < world.time) && !(HAS_TRAIT(src, TRAIT_GODMODE)))
		WhitePulse()

/mob/living/simple_animal/hostile/abnormality/rudolta/AttackingTarget()
	return FALSE

/mob/living/simple_animal/hostile/abnormality/rudolta/proc/WhitePulse()
	pulse_cooldown = world.time + pulse_cooldown_time
	playsound(src, 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/rudolta/throw.ogg', 50, FALSE, 4)
	for(var/mob/living/L in view(8, src))
		if(faction_check_atom(L))
			continue
		L.apply_damage(pulse_damage, BRUTE)
		new /obj/effect/temp_visual/dir_setting/bloodsplatter(get_turf(L), pick(GLOB.alldirs))


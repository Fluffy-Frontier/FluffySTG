/mob/living/simple_animal/hostile/abnormality/training_rabbit
	name = "Standard Training-Dummy Rabbit"
	desc = "A rabbit-like training dummy. Should be completely harmless."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/tegumobs.dmi'
	icon_state = "training_rabbit"
	icon_living = "training_rabbit"
	maxHealth = 14 //hit with baton twice
	health = 14
	fear_level = TETH_LEVEL
	fear_level = 0 //rabbit not scary
	move_to_delay = 16
	damage_coeff = list(BURN = 0.5, BRAIN = 1.5, BRUTE = 1, TOX = 1)
	can_breach = TRUE
	can_spawn = FALSE // Normally doesn't appear
	//ego_list = list(datum/ego_datum/weapon/training, datum/ego_datum/armor/training)
	gift_type =  /datum/ego_gifts/standard
	wander = FALSE
	secret_chance = TRUE // people NEEDED a bunny girl waifu
	secret_icon_file = 'tff_modular/modules/evento_needo/icons/Teguicons/64x64.dmi'
	secret_icon_state = "Bungal"
	secret_horizontal_offset = -16
	secret_gift = /datum/ego_gifts/bunny

	observation_prompt = "This is the training dummy that Lobotomy Corporation uses for training new agents. <br>\
		But is that really all there is to it? <br>\
		Looking closely, you find..."


/mob/living/simple_animal/hostile/abnormality/training_rabbit/BreachEffect(mob/living/carbon/human/user)
	. = ..()
	GiveTarget(user)
	if(!client)
		addtimer(CALLBACK(src, PROC_REF(kill_dummy)), 30 SECONDS)
	if(icon_state == "Bungal")
		icon = 'tff_modular/modules/evento_needo/icons/Teguicons/64x96.dmi'
		icon_state = "Bungal_breach"
		pixel_x = -16

/mob/living/simple_animal/hostile/abnormality/training_rabbit/PostWorkEffect(mob/living/carbon/human/user)
	..()
	if(user.get_major_clothing_class() == CLOTHING_ARMORED)
		qliphoth_change(-1)
	return

/mob/living/simple_animal/hostile/abnormality/training_rabbit/proc/kill_dummy()
	QDEL_NULL(src)

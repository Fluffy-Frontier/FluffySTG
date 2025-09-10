//Very simple, funny little guy.
/mob/living/simple_animal/hostile/abnormality/smile
	name = "Gone with a Simple Smile"
	desc = "An abnormality seeming to make up a floating cat face."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/32x32.dmi'
	icon_state = "smile"
	icon_living = "smile"
	del_on_death = TRUE
	maxHealth = 400		//He's a little shit.
	health = 400
	rapid_melee = 2
	move_to_delay = 2
	damage_coeff = list(BURN = 1, BRAIN = 1.2, BRUTE = 0.8, TOX = 2)
	melee_damage_lower = 5
	melee_damage_upper = 5
	melee_damage_type = BRUTE
	stat_attack = HARD_CRIT
	attack_verb_continuous = "bumps"
	attack_verb_simple = "bumps"
	faction = list("hostile")
	can_breach = TRUE
	fear_level = TETH_LEVEL
	ranged = 1
	retreat_distance = 3
	minimum_distance = 1
	ego_list = list(
		/datum/ego_datum/weapon/trick,
		/datum/ego_datum/armor/trick,
	)
	gift_type =  /datum/ego_gifts/trick
	observation_prompt = "The abnormality appears to you from out of thin air, and swipes away your weapon."


	var/list/stats = list(CLOTHING_ARMORED, CLOTHING_ENGINEERING, CLOTHING_SCIENCE, CLOTHING_SERVICE)

	var/lucky_counter



/mob/living/simple_animal/hostile/abnormality/smile/AttackingTarget(atom/attacked_target)
	. = ..()
	if(ishuman(attacked_target))
		var/mob/living/carbon/human/L = attacked_target
		L.Knockdown(20)
		var/obj/item/held = L.get_active_held_item()
		L.dropItemToGround(held) //Drop weapon


	var/list/pullable = list()
	for (var/obj/item/ego_weapon/Y in range(1, src))
		pullable += Y

	for (var/obj/item/ego_weapon/ranged/Z in range(1, src))
		pullable += Z

	if(!LAZYLEN(pullable))
		return

	src.pulled(pick(pullable))

/mob/living/simple_animal/hostile/abnormality/smile/PostWorkEffect(mob/living/carbon/human/user)
	for(var/attribute in stats)
		if(user.get_clothing_class_level(attribute) >= 2)
			lucky_counter += 1
	if(lucky_counter > 3)
		qliphoth_change(-1)
	lucky_counter = 0
	return ..()

/mob/living/simple_animal/hostile/abnormality/smile/FailureEffect(mob/living/carbon/human/user)
	qliphoth_change(-1)
	return





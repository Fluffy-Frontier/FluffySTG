/mob/living/simple_animal/hostile/abnormality/eris
	name = "Eris"
	desc = "A towering, intimidating woman without a mouth."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/48x48.dmi'
	icon_state = "eris"
	icon_living = "eris"
	maxHealth = 1100
	health = 1100
	ranged = TRUE
	attack_verb_continuous = "claws"
	attack_verb_simple = "claw"
	stat_attack = HARD_CRIT
	melee_damage_lower = 11
	melee_damage_upper = 12
	move_to_delay = 2.6
	damage_coeff = list(BURN = 1, BRAIN = 0.7, BRUTE = 1.3, TOX = 0.7, BRUTE = 1)
	speak_emote = list("croons")
	pixel_x = -8

	can_breach = TRUE
	fear_level = HE_LEVEL
	ego_list = list(
		/datum/ego_datum/weapon/coiling,
		/datum/ego_datum/armor/coiling,
	)
	gift_type =  /datum/ego_gifts/coiling
	observation_prompt = "I am seated at a banquet. <br>\
		The tablecloth is of the finest red velvet, and seated across from me is the abnormality Eris.<br>\
		\"Well, how is it?\" <br>The monster, disguised as a human asks me. <br>\
		There is a sweet, revolting scent in the air. <br>\
		Raw meat and organs are piled high on the serving plates, being attacked by the occasional fly. <br>The monster in front of me dines with knife and fork.<br>\
		A human head is on prominent display on my plate.<br> It belongs to someone who was assigned to work on \"Eris\", not too long ago.<br>\
		\"Not hungry? Perhaps you'd like to visit my boudoir?\"<br>\
		Vile, disgusting. <br>I want to get out of here."


	var/girlboss_level = 0
	update_qliphoth = 0
	work_types = null

/mob/living/simple_animal/hostile/abnormality/eris/Login()
	. = ..()
	to_chat(src, "<h1>You are Eris, A Tank Role Abnormality.</h1><br>\
		<b>|Humanoid Disguise|: You are only able to attack humans who only have a very low amount of health, or if they are dead.<br>\
		If they attack a human who fulfills the above conditions, you will devor them, and gain a stack of 'Girl Boss'<br>\
		<br>\
		|Dine with me...|: Every second, you heal ALL targets that you can see.<br>\
		Your healing increases depending on the amount of 'Girl Boss' you have.<br>\
		<br>\
		|Elegant Form|: When you are attacked by a human, deal WHITE damage to the attack. This damage is increase depending on your 'Girl Boss' stacks.</b>")

//Okay, but here's the breach on death
/mob/living/simple_animal/hostile/abnormality/eris/Initialize()
	. = ..()
	RegisterSignal(SSdcs, COMSIG_GLOB_MOB_DEATH, PROC_REF(on_mob_death)) // Hell

/mob/living/simple_animal/hostile/abnormality/eris/Destroy()
	UnregisterSignal(SSdcs, COMSIG_GLOB_MOB_DEATH)
	return ..()

/mob/living/simple_animal/hostile/abnormality/eris/proc/on_mob_death(datum/source, mob/living/died, gibbed)
	SIGNAL_HANDLER
	if(!IsContained()) // If it's breaching right now
		return FALSE
	if(!ishuman(died))
		return FALSE
	if(died.z != z)
		return FALSE
	if(!died.mind)
		return FALSE
	qliphoth_change(-1) // One death reduces it
	return TRUE



//Okay, but here's the life stuff
/mob/living/simple_animal/hostile/abnormality/eris/Life()
	..()
	if(IsContained())
		return
	healpulse()

//Okay, but here's the patrolling stuff
/mob/living/simple_animal/hostile/abnormality/eris/handle_automated_movement()
	var/list/target_turfs = list() // Stolen from Punishing Bird
	for(var/mob/living/carbon/human/H in GLOB.human_list)
		if(H.z != z) // Not on our level
			continue
		if(H.stat >= SOFT_CRIT) // prefer the near dead.
			continue
		target_turfs += get_turf(H)

	var/turf/target_turf = get_closest_atom(/turf/open, target_turfs, src)
	if(istype(target_turf))
		Goto(target_turf, move_to_delay, 1)
		return
	return ..()


//Okay, but here's the attacking stuff
/mob/living/simple_animal/hostile/abnormality/eris/CanAttack(atom/the_target)
	if(!ishuman(the_target))
		return FALSE
	var/mob/living/H = the_target
	if(H.stat >= SOFT_CRIT)
		return TRUE
	return FALSE

/mob/living/simple_animal/hostile/abnormality/eris/AttackingTarget(atom/attacked_target)
	if(ishuman(attacked_target))
		var/mob/living/H = attacked_target
		if(H.stat >= SOFT_CRIT)
			Dine(attacked_target)
			return
	..()

//Okay, but here's the cannibalism
/mob/living/simple_animal/hostile/abnormality/eris/proc/Dine(mob/living/carbon/human/poorfuck)
	manual_emote("unhinges her jaw, revealing many rows of teeth!")
	playsound(get_turf(src), 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/bigbird/bite.ogg', 50, 1, 2)
	for(var/obj/item/organ/O in poorfuck.get_organ_slot(BODY_ZONE_HEAD, TRUE))
		O.Remove(poorfuck)
		O.forceMove(get_turf(poorfuck))
	poorfuck.gib(DROP_ALL_REMAINS)
	new /obj/effect/gibspawner/generic/silent(get_turf(poorfuck))

	//Lose sanity
	for(var/mob/living/carbon/human/H in view(10, get_turf(src)))
		H.apply_damage(girlboss_level*10, BRUTE)

	SLEEP_CHECK_DEATH(10, src)
	manual_emote("wipes her mouth with a hankerchief")
	SLEEP_CHECK_DEATH(15, src)
	say("Thank you for the meal, love.")
	girlboss_level += 1

//Okay, but here's the Sex work
/mob/living/simple_animal/hostile/abnormality/eris/try_working(mob/living/carbon/human/user)
	. = ..()
	if(!.)
		return
	if(!(HAS_TRAIT(src, TRAIT_GODMODE)))
		return

	emote("giggles")
	user.Stun(30 SECONDS)
	SLEEP_CHECK_DEATH(20, src)
	say("I'm glad you've come for dinner, my dear.")
	SLEEP_CHECK_DEATH(20, src)
	say("Oh you look just so... delicious.")
	SLEEP_CHECK_DEATH(20, src)
	emote("giggles")
	SLEEP_CHECK_DEATH(20, src)
	say("Here's your reward. You're mine forever.")
	SLEEP_CHECK_DEATH(20, src)
	manual_emote("unhinges her jaw, revealing many rows of teeth!")

	playsound(get_turf(src), 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/bigbird/bite.ogg', 50, 1, 2)
	new /obj/effect/gibspawner/generic/silent(get_turf(user))
	for(var/obj/item/organ/O in user.get_organ_slot(BODY_ZONE_HEAD, TRUE))
		O.Remove(user)
		O.forceMove(get_turf(user))
	user.gib(DROP_ALL_REMAINS)

	SLEEP_CHECK_DEATH(20, src)
	manual_emote("wipes her mouth with a hankerchief")
	SLEEP_CHECK_DEATH(20, src)
	say("Thank you for the meal, dear.")
	girlboss_level += 5
	qliphoth_change(-3)

//Okay, but here's the math
/mob/living/simple_animal/hostile/abnormality/eris/proc/healpulse()
	for(var/mob/living/H in view(10, get_turf(src)))
		if(H.stat >= SOFT_CRIT)
			continue
		//Shamelessly fucking stolen from risk of rain's teddy bear. Maxes out at 20.
		var/healamount = 20 * (TOUGHER_TIMES(girlboss_level))
		H.adjustBruteLoss(-healamount)	//Healing for those around.
		new /obj/effect/temp_visual/heal(get_turf(H), "#FF4444")

//Okay but here's the defensive options
/mob/living/simple_animal/hostile/abnormality/eris/bullet_act(obj/projectile/Proj)
	..()
	if(!ishuman(Proj.firer))
		return
	var/mob/living/carbon/human/H = Proj.firer
	H.apply_damage(40*(TOUGHER_TIMES(girlboss_level)), BRUTE)


/mob/living/simple_animal/hostile/abnormality/eris/attacked_by(obj/item/I, mob/living/user)
	..()
	if(!user)
		return
	user.apply_damage(40*(TOUGHER_TIMES(girlboss_level)), BRUTE)


//Okay, but here's the work effects

/mob/living/simple_animal/hostile/abnormality/eris/PostWorkEffect(mob/living/carbon/human/user)
	if(user.get_major_clothing_class() == CLOTHING_SERVICE)
		if(prob(20))
			Dine(user)
	return ..()

/mob/living/simple_animal/hostile/abnormality/eris/FailureEffect(mob/living/carbon/human/user)
	qliphoth_change(-3)
	return

/mob/living/simple_animal/hostile/abnormality/eris/BreachEffect(mob/living/carbon/human/user)
	. = ..()
	update_icon()
	GiveTarget(user)



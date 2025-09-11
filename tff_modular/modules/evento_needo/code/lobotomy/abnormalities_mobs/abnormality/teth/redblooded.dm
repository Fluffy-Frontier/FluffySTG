/mob/living/simple_animal/hostile/abnormality/redblooded
	name = "Red Blooded American"
	desc = "A bright red demon with oversized arms and greasy black hair. It is keeping its eyes focused on you."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/32x48.dmi'
	icon_state = "american_idle"
	icon_living = "american_idle"
	var/icon_furious = "american_idle_injured"
	del_on_death = TRUE
	maxHealth = 825
	health = 825
	rapid_melee = 1
	melee_queue_distance = 2
	move_to_delay = 4
	attack_sound = 'tff_modular/modules/evento_needo/sounds/Tegusounds/weapons/ego/mace1.ogg'
	attack_verb_continuous = "slams"
	attack_verb_simple = "slam"
	melee_damage_type = BRUTE
	stat_attack = HARD_CRIT
	ranged = TRUE
	ranged_cooldown_time = 4 SECONDS
	casingtype = /obj/item/ammo_casing/caseless/true_patriot
	projectilesound = 'sound/items/weapons/gun/shotgun/shot.ogg'
	damage_coeff = list(BURN = 0.7, BRAIN = 1.5, BRUTE = 1, TOX = 2)
	melee_damage_lower = 10
	melee_damage_upper = 15
	faction = list("hostile")
	speak_emote = list("snarls")
	can_breach = TRUE
	fear_level = TETH_LEVEL
	ego_list = list(
		/datum/ego_datum/weapon/patriot,
		/datum/ego_datum/armor/patriot,
	)
	gift_type = /datum/ego_gifts/patriot
	gift_message = "Protect and serve."
	observation_prompt = "\"I was a good soldier, you know.\" <br>\
		\"Blowing freakshits away with my shotgun. <br>Talking with my brothers in arms.\" <br>\
		\"That's all I ever needed. <br>All I ever wanted. <br>Even now, I fight for the glory of my country.\" <br>\
		\"Do you have anything, anyone, to serve and protect?\""


	var/ammo = 6
	var/max_ammo = 6
	var/reload_time = 2 SECONDS
	var/last_reload_time = 0
	var/bloodlust = 0 //more you do repression, more damage it deals. decreases on other works.
	var/list/fighting_quotes = list(
		"Go ahead, freakshit! Do your best!",
		"Pft. Go ahead and try, freakshit.",
		"Good, something fun for once. Go ahead, freakshit.",
		"One of you finally has some balls.",
		"Pathetic. You're too weak for this, you know?",
	)

	var/list/bored_quotes = list(
		"Boring. C'mon, we both know a little roughhousing would be better.",
		"Aw, what a wimp. Alright, you do your thing, pansy.",
		"Yawn. Damn, you freakshits are lame.",
		"Commies. None of them have any fight in them, do they?",
		"Why was I sent here if I was just going to sit around waiting all day?",
	)

	var/list/breach_quotes = list(
		"Time to wipe you freakshits out!",
		"HA! It's over for you freaks!",
		"You're outmatched! Just drop dead already!",
		"Eat shit, you fucking commies!",
		"This is going to be fun!",
	)

/mob/living/simple_animal/hostile/abnormality/redblooded/Login()
	. = ..()
	if(!. || !client)
		return FALSE
	to_chat(src, "<h1>You are Red Blooded American, A Support Role Abnormality.</h1><br>\
		<b>|The American Way|: When you pick on a tile at least 2 sqrs away, You will consume 1 ammo to fire 6 pellets which deal 18 damage each.<br>\
		You passively reload 1 ammo every 2 seconds, but you can also reload 1 ammo by hitting humans or mechs.</b>")

/mob/living/simple_animal/hostile/abnormality/redblooded/try_working(mob/living/carbon/human/user)
	if(user.get_major_clothing_class() == CLOTHING_ARMORED)
		say(pick(fighting_quotes))
		bloodlust +=2
	if(bloodlust >= 6)
		icon_state = icon_furious
	else
		icon_state = "american_idle"
	. = ..()

/mob/living/simple_animal/hostile/abnormality/redblooded/NeutralEffect(mob/living/carbon/human/user, work_type, pe)
	. = ..()
	if(prob(50)) //slightly higher than other TETHs, given that the counter can be raised
		qliphoth_change(-1)
	return

/mob/living/simple_animal/hostile/abnormality/redblooded/FailureEffect(mob/living/carbon/human/user)
	qliphoth_change(-1)
	return

/mob/living/simple_animal/hostile/abnormality/redblooded/PostWorkEffect(mob/living/carbon/human/user)
	if(user.get_major_clothing_class() == CLOTHING_ARMORED)
		qliphoth_change(1)
	if(user.get_major_clothing_class() != CLOTHING_ARMORED)
		if(bloodlust > 0)
			bloodlust -= ( 1 + round(bloodlust / 5)) //just to keep high bloodlust from being impossibly hard to lower
		if(bloodlust == 0)
			say(pick(bored_quotes))
	return ..()

/mob/living/simple_animal/hostile/abnormality/redblooded/ZeroQliphoth(mob/living/carbon/human/user)
	say(pick(breach_quotes))
	BreachEffect()
	return

//Breach
/mob/living/simple_animal/hostile/abnormality/redblooded/proc/Reload()
	playsound(src, 'sound/items/weapons/gun/general/bolt_rack.ogg', 25, TRUE)
	to_chat(src, span_nicegreen("You reload your shotgun..."))
	ammo += 1

/mob/living/simple_animal/hostile/abnormality/redblooded/Life()
	. = ..()
	if (last_reload_time < world.time - reload_time)
		last_reload_time = world.time
		if (ammo < max_ammo)
			Reload()

/mob/living/simple_animal/hostile/abnormality/redblooded/AttackingTarget(atom/attacked_target)
	if(ammo < max_ammo)
		if(isliving(attacked_target))
			Reload()
		if(ismecha(attacked_target))
			Reload()
	return ..()

/mob/living/simple_animal/hostile/abnormality/redblooded/BreachEffect(mob/living/carbon/human/user)
	. = ..()
	icon_state = "american_aggro"
	GiveTarget(user)

/mob/living/simple_animal/hostile/abnormality/redblooded/MoveToTarget(list/possible_targets)
	if(ranged_cooldown <= world.time)
		OpenFire(target)
	return ..()

/mob/living/simple_animal/hostile/abnormality/redblooded/OpenFire(atom/A)
	if(get_dist(src, A) >= 2)
		if(ammo <= 0)
			to_chat(src, span_warning("Out of ammo!"))
			return FALSE
		else
			ammo -= 1
			return ..()
	else
		return FALSE

//Projectiles
/obj/item/ammo_casing/caseless/true_patriot
	name = "true patriot casing"
	desc = "a true patriot casing"
	projectile_type = /obj/projectile/true_patriot
	pellets = 6
	variance = 25

/obj/projectile/true_patriot
	name = "american pellet"
	desc = "100% real, surplus military ammo."
	damage_type = BRUTE

	damage = 8

/obj/item/ammo_casing/caseless/rcorp_true_patriot
	name = "true patriot casing"
	desc = "a true patriot casing"
	projectile_type = /obj/projectile/rcorp_true_patriot
	pellets = 6
	variance = 25

/obj/projectile/rcorp_true_patriot
	name = "american pellet"
	desc = "100% real, surplus military ammo."
	damage_type = BRUTE

	damage = 18


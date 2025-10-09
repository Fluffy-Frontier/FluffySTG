/mob/living/simple_animal/hostile/abnormality/dealerdamned
	name = "Dealer of the Damned"
	desc = "A towering figure with a revolver for a head. It's seated in front of a poker table."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/64x64.dmi'
	icon_state = "dealerdamned"
	maxHealth = 400
	health = 400
	fear_level = TETH_LEVEL
	speak_emote = list("states")
	ego_list = list(
		/datum/ego_datum/weapon/luckdraw,
		/datum/ego_datum/armor/luckdraw,
	)
	gift_type =  /datum/ego_gifts/luckdraw
	pixel_x = -16
	var/coin_status
	var/has_flipped
	var/static/gambled_prior = list()
	var/work_count = 0

	observation_prompt = "You awaken to a building flooded with stimulation; guests mingle and drink as slot machines whirr and blare their tunes, drowning out the mourning of those who have lost it all. <br>\
	Amidst all this, you find yourself sat in front of a poker table, already in the middle of a game. The Dealer turns to you, eagerly awaiting your next move."
	work_types = null


//Coinflip V1; Expect Jank
/mob/living/simple_animal/hostile/abnormality/dealerdamned/try_working(mob/living/carbon/human/user)
	if(has_flipped)
		say("Woah there, hotshot. We've already had a game recently!")
		return
	if((user.ckey in gambled_prior))
		say("Hey, I know I'm all for high stakes, but you've already put your life on the line once. I've got standards.")
		return FALSE
	. = ..()
	if(!.)
		return
	var/flip_modifier = 0
	has_flipped = TRUE
	user.apply_damage(user.maxHealth*0.2, BRUTE)
	icon_state = "dealerflip"
	manual_emote("flips a gold coin.")
	SLEEP_CHECK_DEATH(10, src)
	icon_state = "dealerdamned"
	if(prob(35)+flip_modifier)
		say("Heads, huh? Looks like you win this one.")
		coin_status = TRUE
		user.adjustBruteLoss(-user.maxHealth*0.2)
	else
		say("Tails. Sorry, high roller, but a deal's a deal.")
	return

//TODO: Add the revolver open sprite, replace gibbing with "death" sprite
/mob/living/simple_animal/hostile/abnormality/dealerdamned/PostWorkEffect(mob/living/carbon/human/user)
	..()
	say("Feelin' like putting your life on the line, huh? Sounds good to me!")
	user.Immobilize(15)
	SLEEP_CHECK_DEATH(10, src)
	playsound(user, "revolver_spin", 70, FALSE)
	gambled_prior |= user.ckey
	//We need to set if the game is going on, who's being shot, and then spent chambers
	var/russian_roulette = TRUE
	var/player_shot = TRUE
	var/spent_chambers = 0
	var/roulette_modifier = 0
	while(russian_roulette)
		user.Immobilize(spent_chambers*5)
		SLEEP_CHECK_DEATH(spent_chambers*5, src)
		spent_chambers+=1
		if(prob((16.666+roulette_modifier)*spent_chambers) || spent_chambers == 6) //Failsafe thanks to J corp RNG
			playsound(user, 'sound/items/weapons/gun/revolver/shot_alt.ogg', 100, FALSE)
			russian_roulette = FALSE
			if(player_shot)
				user.gib()
				say("Shame. Was quite fun havin' ya here, but you know how it is.")
			else
				new /obj/item/ego_weapon/ranged/pistol/deathdealer(get_turf(user))
				new /obj/effect/gibspawner/generic/silent(get_turf(src))
				gib()
		else
			playsound(user, 'sound/items/weapons/gun/revolver/dry_fire.ogg', 100, FALSE)
			if(player_shot)
				player_shot = FALSE
			else
				player_shot = TRUE

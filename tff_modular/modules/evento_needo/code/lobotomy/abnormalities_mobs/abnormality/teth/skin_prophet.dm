/mob/living/simple_animal/hostile/abnormality/skin_prophet
	name = "Skin Prophet"
	desc = "A little fleshy being reading a tiny book."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/32x48.dmi'
	icon_state = "skin_prophet"
	maxHealth = 600
	health = 600
	fear_level = TETH_LEVEL
	ego_list = list(
		/datum/ego_datum/weapon/visions,
		/datum/ego_datum/armor/visions,
	)
	gift_type = /datum/ego_gifts/visions
	observation_prompt = "Candles quietly burn away. <br>\
		Scribbling sounds are all that fill the air. <br>\
		A trio of eyes takes turns glaring into a grand tome, bound in skin. <br>\
		You can’t tell what it’s referencing, <br>\
		or if there is any deliberation in its writing; <br>\
		hands are busy nonetheless. <br>\
		Yearning for destruction and doom, it writes and writes and writes. <br>\
		You feel the passages it’s writing may be prophecies for someplace and sometime."


	var/list/speak_list = list(
		"!@)(!@&)&*%(%@!@#*(#)*(%&!@#$",
		"@$*@)$?",
		"@#$!!@#*!",
		"@*()!%&$(^!!!!@&(@)",
	)
	var/candles = 0

///mob/living/simple_animal/hostile/abnormality/skin_prophet/WorkChance(mob/living/carbon/human/user, chance)
//	//work damage starts at 7, + candles stuffed
//	//If you're doing rep or temeprance then your work chance is your total buffs combined, and damage is increased too
//	if(chance == 0)
//		var/totalbuff = get_level_buff(user, FORTITUDE_ATTRIBUTE) + get_level_buff(user, PRUDENCE_ATTRIBUTE) + get_level_buff(user, TEMPERANCE_ATTRIBUTE) + get_level_buff(user, JUSTICE_ATTRIBUTE)
//		chance = totalbuff
//	return chance

///mob/living/simple_animal/hostile/abnormality/skin_prophet/WorktickFailure(mob/living/carbon/human/user)
//	if(prob(30))
//		say(pick(speak_list))
//	..()

//If you success on temperance or repression, clear all your temperance/justice buffs and then add to your max stats.
//You're on the hook for any changes in your attribute
/mob/living/simple_animal/hostile/abnormality/skin_prophet/SuccessEffect(mob/living/carbon/human/user)
	if(user.get_major_clothing_class() == CLOTHING_SERVICE)
		say(pick(speak_list))

		//Don't try it without any buffs.
		if(user.get_clothing_class_level(CLOTHING_SERVICE) == 1)
			user.dust()
			return
		user.physiology.brute_mod -= (user.get_clothing_class_level(CLOTHING_SERVICE)) / 100

	if(user.get_major_clothing_class() == CLOTHING_ARMORED)
		say(pick(speak_list))

		if(user.get_clothing_class_level(CLOTHING_ARMORED) == 1)
			user.dust()
			return

		user.physiology.tox_mod -= (user.get_clothing_class_level(CLOTHING_ARMORED)) / 100
	return

/mob/living/simple_animal/hostile/abnormality/skin_prophet/FailureEffect(mob/living/carbon/human/user)
	say(pick(speak_list))
	//He has 10 candles. Each snuffed candle deals more work damage
	if(candles != 10)
		candles += 1
	return


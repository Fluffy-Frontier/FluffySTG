/mob/living/simple_animal/hostile/abnormality/an_abnormality
	name = "\"An Abnormality\""
	desc = "An entity lacking in description due to developer laziness."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/actions_abnormality.dmi'
	icon_state = "abnormality"
	icon_living = "abnormality"
	maxHealth = 700
	health = 700
	damage_coeff = list(BURN = 1, BRAIN = 1, BRUTE = 1, TOX = 1)
	melee_damage_lower = 8
	melee_damage_upper = 12
	ego_list = list(
		/datum/ego_datum/weapon/an_ego,
		/datum/ego_datum/armor/an_ego,
	)
	gift_type =  /datum/ego_gifts/standard // Way too lazy to make its own gift

/mob/living/simple_animal/hostile/abnormality/an_abnormality/attackby(obj/item/attacking_item, mob/living/user, list/modifiers, list/attack_modifiers)
	. = ..()
	if(!.)
		return
	to_chat(user, span_notice("We're no strangers to love <br>\
		You know the rules and so do I <br>\
		A full commitment's what I'm thinkin' of <br>\
		You wouldn't get this from any other guy <br>\
		I just wanna tell you how I'm feeling <br>\
		Gotta make you understand <br>\
		Never gonna give you up, never gonna let you down <br>\
		Never gonna run around and desert you <br>\
		Never gonna make you cry, never gonna say goodbye <br>\
		Never gonna tell a lie and hurt you <br>\
		We've known each other for so long <br>\
		Your heart's been aching, but you're too shy to say it <br>\
		Inside, we both know what's been going on <br>\
		We know the game and we're gonna play it <br>\
		And if you ask me how I'm feeling <br>\
		Don't tell me you're too blind to see <br>\
		Never gonna give you up, never gonna let you down <br>\
		Never gonna run around and desert you <br>\
		Never gonna make you cry, never gonna say goodbye <br>\
		Never gonna tell a lie and hurt you <br>\
		Never gonna give you up, never gonna let you down <br>\
		Never gonna run around and desert you <br>\
		Never gonna make you cry, never gonna say goodbye <br>\
		Never gonna tell a lie and hurt you <br>\
		We've known each other for so long <br>\
		Your heart's been aching, but you're too shy to say it <br>\
		Inside, we both know what's been going on <br>\
		We know the game and we're gonna play it <br>\
		I just wanna tell you how I'm feeling <br>\
		Gotta make you understand <br>\
		Never gonna give you up, never gonna let you down <br>\
		Never gonna run around and desert you <br>\
		Never gonna make you cry, never gonna say goodbye <br>\
		Never gonna tell a lie and hurt you <br>\
		Never gonna give you up, never gonna let you down <br>\
		Never gonna run around and desert you <br>\
		Never gonna make you cry, never gonna say goodbye <br>\
		Never gonna tell a lie and hurt you <br>\
		Never gonna give you up, never gonna let you down <br>\
		Never gonna run around and desert you <br>\
		Never gonna make you cry, never gonna say goodbye <br>\
		Never gonna tell a lie and hurt you"))
	GiftUser(user, 20)

/mob/living/simple_animal/hostile/abnormality/an_abnormality/PostSpawn()
	. = ..()
	dir = SOUTH

//Egoshards - used to upgrade the armor and weapons in the lcorp files.
/obj/item/egoshard
	name = "cracked red egoshard"
	desc = "An egoshard in a pathetic, but still usable state."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/teguitems.dmi'
	icon_state = "egoshard_r"
	var/stat_requirement = 60 //Stat requirements should match the E.G.O. tier +20, similar to city equipment
	//Weapon stats
	var/damage_type = BURN
	var/base_damage = 30 //Base damage of the tier
	var/tier = 1 //used to figure out gun damage
	//Armor stats
	var/burn_bonus = 20 //50 from the base of 20 in red, so 70
	var/brain_bonus = 10
	var/brute_bonus = 10
	var/tox_bonus = 10

/obj/item/egoshard/examine(mob/user)
	. = ..()
	if(stat_requirement)
		. += span_warning("Equipment enhanced with this egoshard will require [stat_requirement] in all attributes to use.")
	switch(damage_type)
		if(BURN)
			. += span_notice("This one looks red.")
		if(BRAIN)
			. += span_notice("This one looks white.")
		if(BRUTE)
			. += span_notice("This one looks black.")
		if(TOX)
			. += span_notice("This one looks pale.")


/obj/item/egoshard/white
	name = "cracked white egoshard"
	icon_state = "egoshard_w"
	damage_type = BRAIN
	burn_bonus = -10
	brain_bonus = 40
	brute_bonus = 10
	tox_bonus = 10

/obj/item/egoshard/black
	name = "cracked black egoshard"
	icon_state = "egoshard_b"
	damage_type = BRUTE
	burn_bonus = -10
	brain_bonus = 10
	brute_bonus = 40
	tox_bonus = 10

/obj/item/egoshard/bad
	name = "red egoshard"
	desc = "A small egoshard."
	tier = 2
	base_damage = 40
	stat_requirement = 80
	burn_bonus = 40 //100 from the base of 20 in red, so 120
	brain_bonus = 20
	brute_bonus = 20
	tox_bonus = 20
	custom_price = 750

/obj/item/egoshard/bad/white
	name = "white egoshard"
	icon_state = "egoshard_w"
	damage_type = BRAIN
	burn_bonus = 0 //100 from the base of 20 in red, so 120
	brain_bonus = 60
	brute_bonus = 20
	tox_bonus = 20
	custom_price = 750

/obj/item/egoshard/bad/black
	name = "black egoshard"
	icon_state = "egoshard_b"
	damage_type = BRUTE
	burn_bonus = 0 //100 from the base of 20 in red, so 120
	brain_bonus = 20
	brute_bonus = 60
	tox_bonus = 20
	custom_price = 750

/obj/item/egoshard/good
	name = "red egoshard"
	desc = "A decently sized egoshard."
	tier = 3
	base_damage = 60
	stat_requirement = 100
	burn_bonus = 50 //160 from the base of 20 in red, so 180
	brain_bonus = 30
	brute_bonus = 40
	tox_bonus = 40
	custom_price = 2000

/obj/item/egoshard/good/white
	name = "white egoshard"
	icon_state = "egoshard_w"
	damage_type = BRAIN
	burn_bonus = 20 //160 from the base of 20 in red, so 180
	brain_bonus = 70
	brute_bonus = 30
	tox_bonus = 40
	custom_price = 2000

/obj/item/egoshard/good/black
	name = "black egoshard"
	icon_state = "egoshard_b"
	damage_type = BRUTE
	burn_bonus = 20 //160 from the base of 20 in red, so 180
	brain_bonus = 40
	brute_bonus = 70
	tox_bonus = 30
	custom_price = 2000

/obj/item/egoshard/good/pale
	name = "pale egoshard"
	icon_state = "egoshard_p"
	damage_type = TOX
	base_damage = 45
	burn_bonus = 20 //160 from the base of 20 in red, so 180
	brain_bonus = 30
	brute_bonus = 40
	tox_bonus = 70
	custom_price = 2000

/obj/item/egoshard/great
	name = "flawless red egoshard"
	desc = "A pretty egoshard."
	tier = 4
	base_damage = 80
	stat_requirement = 120
	burn_bonus = 60 //220 from the base of 20 in red, so 240
	brain_bonus = 60
	brute_bonus = 40
	tox_bonus = 60
	custom_price = 4000

/obj/item/egoshard/great/white
	name = "flawless white egoshard"
	icon_state = "egoshard_w"
	damage_type = BRAIN
	burn_bonus = 20 //220 from the base of 20 in red, so 240
	brain_bonus = 80
	brute_bonus = 60
	tox_bonus = 60
	custom_price = 4000

/obj/item/egoshard/great/black
	name = "flawless black egoshard"
	icon_state = "egoshard_b"
	damage_type = BRUTE
	burn_bonus = 20 //220 from the base of 20 in red, so 240
	brain_bonus = 60
	brute_bonus = 80
	tox_bonus = 60
	custom_price = 4000

/obj/item/egoshard/great/pale
	name = "flawless pale egoshard"
	icon_state = "egoshard_p"
	damage_type = TOX
	base_damage = 60
	burn_bonus = 20 //220 from the base of 20 in red, so 240
	brain_bonus = 60
	brute_bonus = 60
	tox_bonus = 80
	custom_price = 4000

//These exist, but I'm not sure where I would put ALEPH++ tier egoshards in terms of loot
/obj/item/egoshard/excellent
	name = "perfect red egoshard"
	desc = "An expensive-looking egoshard."
	tier = 5
	base_damage = 100
	stat_requirement = 140
	burn_bonus = 60 //280 from the base of 20 in red, so 300
	brain_bonus = 70
	brute_bonus = 70
	tox_bonus = 80

/obj/item/egoshard/excellent/white
	name = "perfect white egoshard"
	icon_state = "egoshard_w"
	damage_type = BRAIN
	burn_bonus = 50 //280 from the base of 20 in red, so 300
	brain_bonus = 80
	brute_bonus = 70
	tox_bonus = 80

/obj/item/egoshard/excellent/black
	name = "perfect black egoshard"
	icon_state = "egoshard_b"
	damage_type = BRUTE
	burn_bonus = 60 //280 from the base of 20 in red, so 300
	brain_bonus = 70
	brute_bonus = 80
	tox_bonus = 70

/obj/item/egoshard/excellent/pale
	name = "perfect pale egoshard"
	icon_state = "egoshard_p"
	damage_type = TOX
	base_damage = 80
	burn_bonus = 50 //280 from the base of 20 in red, so 300
	brain_bonus = 80
	brute_bonus = 70
	tox_bonus = 80

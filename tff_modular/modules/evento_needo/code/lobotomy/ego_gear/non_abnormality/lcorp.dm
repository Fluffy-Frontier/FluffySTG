//Armor vest
/obj/item/clothing/suit/armor/vest/alt
	desc = "A cheap plastic vest that provides practically no protection against abnormalities."
	icon_state = "armor"
	inhand_icon_state = "armor"

/obj/item/clothing/suit/armor/ego_gear/city/lcorp_vest
	name = "l-corp armor vest"
	desc = "Special armor issued by L-Corp to those who cannot utilize E.G.O."
	icon_state = "armorvest"
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/ego_gear/lcorp.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/icons/Teguicons/ego_gear/lcorp.dmi'
	flags_inv = NONE
	new_armor = list(BURN = 20, BRAIN = 0, BRUTE = 0, TOX = 0)

	custom_price = 100
	var/installed_shard
	var/equipped

/obj/item/clothing/suit/armor/ego_gear/city/lcorp_vest/examine(mob/user)
	. = ..()
	if(!installed_shard)
		. += span_warning("This armor can be enhanced with an egoshard.")
	else
		. += span_nicegreen("It has a [installed_shard] installed.")

/obj/item/clothing/suit/armor/ego_gear/city/lcorp_vest/equipped(mob/user, slot, initial = FALSE)
	..()
	equipped = TRUE

/obj/item/clothing/suit/armor/ego_gear/city/lcorp_vest/dropped(mob/user)
	..()
	equipped = FALSE

/obj/item/clothing/suit/armor/ego_gear/city/lcorp_vest/attackby(obj/item/I, mob/living/user, params)
	..()
	if(equipped)
		to_chat(user, span_warning("You need to put down [src] before attempting this!"))
		return
	if(installed_shard)
		to_chat(user, span_warning("[src] already has an egoshard installed!"))
		return
	installed_shard = I.name
	//IncreaseAttributes(user, I)
	playsound(get_turf(src), 'sound/effects/light_flicker.ogg', 50, TRUE)
	qdel(I)

/*Extraction officer coat.
I don't want them gaming ego right off the bat beacuse this one actually looks pretty okay.
It's not great though.
*/
/obj/item/clothing/suit/armor/extraction
	name = "patchwork coat"
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/ego_gear/lcorp.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/icons/Teguicons/ego_gear/lcorp.dmi'
	desc = "A poorly made patchwork coat made from a bunch of spare cloth, dyed black. Worn by the extraction officer"
	icon_state = "extraction"
	var/new_armor = list(BURN = 20, BRAIN = 20, BRUTE = 20, TOX = 20)

/obj/item/clothing/suit/armor/extraction/Initialize(mapload)
	for(var/key in new_armor)
		set_armor_rating(key, new_armor[key])
	return ..()


/obj/item/clothing/suit/armor/extraction/arbiter
	name = "arbiter's armored coat"
	desc = "A coat made out of quality cloth, providing immense protection against most damage sources. It is quite heavy."
	new_armor = list(BURN = 90, BRAIN = 90, BRUTE = 90, TOX = 90)
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS|HEAD
	cold_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS|HEAD
	heat_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS|HEAD
	w_class = WEIGHT_CLASS_BULKY
	slowdown = 1.5
	allowed = list(/obj/item/gun, /obj/item/ego_weapon, /obj/item/melee)

/obj/item/clothing/suit/armor/records
	name = "old coat"
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/ego_gear/lcorp.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/icons/Teguicons/ego_gear/lcorp.dmi'
	desc = "A poorly made patchwork coat made from a bunch of spare cloth, dyed grey. Worn by the records officer"
	icon_state = "records"
	var/new_armor = list(BURN = 20, BRAIN = 20, BRUTE = 20, TOX = 20)

/obj/item/clothing/suit/armor/records/Initialize(mapload)
	for(var/key in new_armor)
		set_armor_rating(key, new_armor[key])
	return ..()

/obj/item/clothing/suit/armor/training
	name = "worn coat"
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/ego_gear/lcorp.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/icons/Teguicons/ego_gear/lcorp.dmi'
	desc = "A coat that has been use for a very long time, by a very experienced officer. This one is orange with an intricate copper pattern on it. Worn by the Training Officer"
	icon_state = "training"
	var/new_armor = list(BURN = 20, BRAIN = 20, BRUTE = 20, TOX = 20)

/obj/item/clothing/suit/armor/training/Initialize(mapload)
	for(var/key in new_armor)
		set_armor_rating(key, new_armor[key])
	return ..()

/obj/item/clothing/suit/armor/control
	name = "ragged coat"
	icon = 'icons/obj/clothing/suits/wintercoat.dmi'
	worn_icon = 'icons/mob/clothing/suits/wintercoat.dmi'
	desc = "A coat that has been use for a very long time, by an officer that is very observant. This one is brown, from both dye and dirt. Worn by the control officer"
	icon_state = "coatcargo"		//Temporary sprite
	var/new_armor = list(BURN = 20, BRAIN = 20, BRUTE = 20, TOX = 20)

/obj/item/clothing/suit/armor/control/Initialize(mapload)
	for(var/key in new_armor)
		set_armor_rating(key, new_armor[key])
	return ..()

//Disc officer
/obj/item/clothing/suit/armor/ego_gear/disc_off
	name = "discipline officer's jacket"
	desc = "An armored jacket used by the disciplinary officer."
	icon_state = "disc_officer"
	new_armor = list(BURN = 20, BRAIN = 20, BRUTE = 20, TOX = 20)
	equip_slowdown = 0

//This is tutorial armor
/obj/item/clothing/suit/armor/ego_gear/rookie
	name = "rookie"
	desc = "This armor is strong to red, check it's defenses to see!"
	icon_state = "rookie"
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/ego_gear/lcorp.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/icons/Teguicons/ego_gear/lcorp.dmi'
	new_armor = list(BURN = 40, BRAIN = -40, BRUTE = 0, TOX = 0)

/obj/item/clothing/suit/armor/ego_gear/fledgling
	name = "fledgling"
	desc = "This armor is strong to white, check it's defenses to see!"
	icon_state = "fledgling"
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/ego_gear/lcorp.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/icons/Teguicons/ego_gear/lcorp.dmi'
	new_armor = list(BURN = 0, BRAIN = 40, BRUTE = -40, TOX = 0)

/obj/item/clothing/suit/armor/ego_gear/apprentice
	name = "apprentice"
	desc = "This armor is strong to black, check it's defenses to see!"
	icon_state = "apprentice"
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/ego_gear/lcorp.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/icons/Teguicons/ego_gear/lcorp.dmi'
	new_armor = list(BURN = 0, BRAIN = 0, BRUTE = 40, TOX = -40)

/obj/item/clothing/suit/armor/ego_gear/freshman
	name = "freshman"
	desc = "This armor is strong to pale, check it's defenses to see!"
	icon_state = "freshman"
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/ego_gear/lcorp.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/icons/Teguicons/ego_gear/lcorp.dmi'
	new_armor = list(BURN = -40, BRAIN = 0, BRUTE = 0, TOX = 40)

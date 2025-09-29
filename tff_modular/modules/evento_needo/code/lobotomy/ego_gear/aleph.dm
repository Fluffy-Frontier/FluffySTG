// ALEPH armor, go wild, but attempt to keep total armor at ~240 total.

/* Lead Developer's note:
Think before you code!
Any attempt to code risk class armor will result in a 10 day Github ban.*/

/*Developer's note - All LC13 armor has 50% of its BRUTE armor as fire armor by default. */

/obj/item/clothing/suit/armor/ego_gear/aleph
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/clothing/ego_gear/abnormality/aleph.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/icons/Teguicons/mob/ego_gear/abnormality/aleph.dmi'

/obj/item/clothing/suit/armor/ego_gear/aleph/paradise
	name = "paradise lost"
	desc = "\"My loved ones, do not worry; I have heard your prayers. \
	Have you not yet realized that pain is but a speck to a determined mind?\""
	icon_state = "paradise"
	new_armor = list(BURN = 90, BRAIN = 90, BRUTE = 90, TOX = 90) // 280


/obj/item/clothing/suit/armor/ego_gear/aleph/justitia
	name = "justitia"
	desc = "A black, bandaged coat with golden linings covering it."
	icon_state = "justitia"
	new_armor = list(BURN = 80, BRAIN = 70, BRUTE = 70, TOX = 100) // 240


/obj/item/clothing/suit/armor/ego_gear/aleph/star
	name = "sound of a star"
	desc = "At the heart of the armor is a shard that emits an arcane gleam. \
	The gentle glow feels somehow more brilliant than a flashing light."
	icon_state = "star"
	new_armor = list(BURN = 90, BRAIN = 90, BRUTE = 80, TOX = 60) // 240


/obj/item/clothing/suit/armor/ego_gear/aleph/da_capo
	name = "da capo"
	desc = "A splendid tailcoat perfect for a symphony. \
	Superb leadership is required to create a perfect ensemble."
	icon_state = "da_capo"
	new_armor = list(BURN = 80, BRAIN = 100, BRUTE = 80, TOX = 40) // 240


/obj/item/clothing/suit/armor/ego_gear/aleph/mimicry
	name = "mimicry"
	desc = "It takes human hide to protect human flesh. To protect humans, you need something made out of humans."
	icon_state = "mimicry"
	new_armor = list(BURN = 100, BRAIN = 70, BRUTE = 70, TOX = 80) // 240


/obj/item/clothing/suit/armor/ego_gear/aleph/twilight
	name = "twilight"
	desc = "The three birds united their efforts to defeat the beast. \
	This could stop countless incidents, but you’ll have to be prepared to step into the Black Forest…"
	icon_state = "twilight"
	new_armor = list(BURN = 100, BRAIN = 80, BRUTE = 100, TOX = 100) // 300


/obj/item/clothing/suit/armor/ego_gear/aleph/adoration
	name = "adoration"
	desc = "It is not as unpleasant to wear as it is to look at. \
	In fact, it seems to give you an illusion of comfort and bravery."
	icon_state = "adoration"
	new_armor = list(BURN = 90, BRAIN = 70, BRUTE = 90, TOX = 70) // 240


/obj/item/clothing/suit/armor/ego_gear/aleph/smile
	name = "smile"
	desc = "It is holding all of the laughter of those who cannot be seen here."
	icon_state = "smile"
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT
	new_armor = list(BURN = 70, BRAIN = 70, BRUTE = 100, TOX = 80) // 240


/obj/item/clothing/suit/armor/ego_gear/aleph/blooming
	name = "blooming"
	desc = "Just looking at this, you feel quite tacky."
	icon_state = "blooming"
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT
	new_armor = list(BURN = 100, BRAIN = 100, BRUTE = 0, TOX = 100) // 240


/obj/item/clothing/suit/armor/ego_gear/aleph/flowering
	name = "flowering night"
	desc = "Ah, magicians are actually in greater need of mercy."
	icon_state = "air"
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT
	new_armor = list(BURN = 100, BRAIN = 100, BRUTE = 50, TOX = 90) // 280


/obj/item/clothing/suit/armor/ego_gear/aleph/praetorian
	name = "praetorian"
	desc = "The queen's last line of defense."
	icon_state = "praetorian"
	new_armor = list(BURN = 100, BRAIN = 80, BRUTE = 80, TOX = 60)	//armor was made before the abnormality.


/obj/item/clothing/suit/armor/ego_gear/aleph/mockery
	name = "mockery"
	desc = "It's smug aura is almost mocking you."
	icon_state = "mockery"
	new_armor = list(BURN = 90, BRAIN = 50, BRUTE = 100, TOX = 80) // 240


/obj/item/clothing/suit/armor/ego_gear/aleph/censored
	name = "CENSORED"
	desc = "Goodness, that’s disgusting."
	icon_state = "censored"
	new_armor = list(BURN = 80, BRAIN = 60, BRUTE = 100, TOX = 80)


/obj/item/clothing/suit/armor/ego_gear/aleph/soulmate
	name = "Soulmate"
	desc = "I’ll follow thee and make a heaven of hell, to die upon the hand I love so well."
	icon_state = "soulmate"
	new_armor = list(BURN = 100, BRAIN = 70, BRUTE = 60, TOX = 90)



/obj/item/clothing/suit/armor/ego_gear/aleph/space
	name = "out of space"
	desc = "It was just a colour out of space, a frightful messenger from unformed realms of infinity beyond all Nature as we know it."
	icon_state = "space"
	new_armor = list(BURN = 50, BRAIN = 100, BRUTE = 100, TOX = 70)


/obj/item/clothing/suit/armor/ego_gear/aleph/nihil
	name = "nihil"
	desc = "The jester retraced the steps of a path everybody would’ve taken. The jester always found itself at the end of that road. \
	There was no way to know if they had gathered to become the jester, or if the jester had come to resemble them."
	icon_state = "nihil"
	new_armor = list(BURN = 80, BRAIN = 90, BRUTE = 90, TOX = 60) // 240 - 300, 15 per upgrade; caps out at 70,80,80,70

	var/equipped
	var/list/powers = list("hatred", "despair", "greed", "wrath")

/obj/item/clothing/suit/armor/ego_gear/aleph/nihil/equipped(mob/user, slot, initial = FALSE)
	..()
	equipped = TRUE

/obj/item/clothing/suit/armor/ego_gear/aleph/nihil/dropped(mob/user)
	..()
	equipped = FALSE

/obj/item/clothing/suit/armor/ego_gear/aleph/nihil/attackby(obj/item/I, mob/living/user, params)
	..()
	if(!istype(I, /obj/item/nihil))
		return

	if(equipped)
		to_chat(user, span_warning("You need to put down [src] before attempting this!"))
		return

	if(powers[1] == "hatred" && istype(I, /obj/item/nihil/heart))
		powers[1] = "hearts"
		IncreaseAttributes(user, powers[1])
		qdel(I)
	else if(powers[2] == "despair" && istype(I, /obj/item/nihil/spade))
		powers[2] = "spades"
		IncreaseAttributes(user, powers[2])
		qdel(I)
	else if(powers[3] == "greed" && istype(I, /obj/item/nihil/diamond))
		powers[3] = "diamonds"
		IncreaseAttributes(user, powers[3])
		qdel(I)
	else if(powers[4] == "wrath" && istype(I, /obj/item/nihil/club))
		powers[4]= "clubs"
		IncreaseAttributes(user, powers[4])
		qdel(I)
	else
		to_chat(user, span_warning("You have already used this upgrade!"))

/obj/item/clothing/suit/armor/ego_gear/aleph/nihil/proc/IncreaseAttributes(user, current_suit)
	for(var/atr in attribute_requirements)
		//if(atr == TEMPERANCE_ATTRIBUTE)
		//	attribute_requirements[atr] += 5
		//else
		//	attribute_requirements[atr] += 10
	to_chat(user, span_warning("The requirements to equip [src] have increased!"))

	//switch(current_suit)
	//	if("hearts")
	//		new_armor = armor.modifyRating(white = 10, pale = 5)
	//		to_chat(user, span_nicegreen("[src] has gained extra resistance to WHITE and PALE damage!"))
//
	//	if("spades")
	//		new_armor = armor.modifyRating(pale = 15)
	//		to_chat(user, span_nicegreen("[src] has gained extra resistance to PALE damage!"))
//
	//	if("diamonds")
	//		new_armor = armor.modifyRating(red = 10, pale = 5, fire = 5)
	//		to_chat(user, span_nicegreen("[src] has gained extra resistance to RED damage!"))
//
	//	if("clubs")
	//		new_armor = armor.modifyRating(black = 10, pale = 5)
	//		to_chat(user, span_nicegreen("[src] has gained extra resistance to BLACK and PALE damage!"))

/obj/item/clothing/suit/armor/ego_gear/aleph/seasons
	name = "Seasons Greetings"
	desc = "This is a placeholder."
	icon_state = "spring"
	new_armor = list(BURN = 80, BRAIN = 80, BRUTE = 80, TOX = 80, FIRE = 80) // Placeholder values, changed later.

	actions_types = list(
		/datum/action/cooldown/spell_action/seasons_toggle,
	)
	var/mob/current_holder
	var/current_season = "winter"
	var/stored_season = "winter"
	var/list/season_list = list(
		"spring" = list("vernal equinox", "Some heavy armor, completely overtaken by foilage."),
		"summer" = list("summer solstice","It looks painful to wear!"),
		"fall" = list("autumnal equinox","Even though it glows faintly, it is cold to the touch."),
		"winter" = list("winter solstice","In the past, folk believed that the dead would visit as winter came.")
		)
	var/transforming = TRUE

/obj/item/clothing/suit/armor/ego_gear/aleph/seasons/Initialize()
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)
	RegisterSignal(SSdcs, COMSIG_GLOB_SEASON_CHANGE, PROC_REF(Transform))
	Transform()

/obj/item/clothing/suit/armor/ego_gear/aleph/seasons/equipped(mob/living/carbon/human/user, slot)
	. = ..()
	if(!user)
		return
	current_holder = user

/obj/item/clothing/suit/armor/ego_gear/aleph/seasons/dropped(mob/user)
	. = ..()
	current_holder = null

/obj/item/clothing/suit/armor/ego_gear/aleph/seasons/proc/Transform()
	current_season = SSlobotomy_events.current_season
	if(!transforming) //No need to do all of the icon updates and stuff if we aren't changing
		desc = season_list[current_season][2]  + " \n This E.G.O. will not transform to match the seasons."
	else
		icon_state = "[current_season]"
		update_icon_state()
		to_chat(current_holder, span_notice("[src] suddenly transforms!"))
		name = season_list[current_season][1]
		desc = season_list[current_season][2]  + " \n This E.G.O. will transform to match the seasons."
		stored_season = current_season
		if(current_holder) //Notify the user we've changed
			playsound(current_holder, "tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/seasons/[current_season]_change.ogg", 50, FALSE)
	var/weakened = FALSE
	var/warning_message
	//switch(stored_season) //Hopefully someday someone finds a more efficient way to change armor values
	//	if("spring")
	//		src.armor = getArmor(red = 80, white = 100, black = 60, pale = 80, fire = 50)	//240
	//		if(stored_season != current_season) //Our drip is out of season
	//			src.armor = getArmor(red = 70, white = 100, black = 60, pale = 70, fire = 50)	//220
	//			weakened = TRUE
	//			if(current_season == "fall")
	//				src.armor = getArmor(red = 70, white = 90, black = 50, pale = 70, fire = 50)	//200
	//				warning_message = "Fall has come, the leaves on your armor wither and die."
	//	if("summer")
	//		src.armor = getArmor(red = 100, white = 60, black = 80, pale = 80, fire = 90)
	//		if(stored_season != current_season) //Our drip is out of season
	//			src.armor = getArmor(red = 100, white = 60, black = 70, pale = 70, fire = 90)
	//			weakened = TRUE
	//			if(current_season == "winter")
	//				src.armor = getArmor(red = 90, white = 50, black = 70, pale = 70, fire = 90)
	//				warning_message = "Winter is here. Your armor reacts, becoming stiff and brittle."
	//	if("fall")
	//		src.armor = getArmor(red = 60, white = 80, black = 100, pale = 80, fire = 90)
	//		if(stored_season != current_season) //Our drip is out of season
	//			src.armor = getArmor(red = 60, white = 70, black = 100, pale = 70, fire = 90)
	//			weakened = TRUE
	//			if(current_season == "spring")
	//				src.armor = getArmor(red = 50, white = 70, black = 90, pale = 70, fire = 90)
	//				warning_message = "The arrival of spring weakens your armor further."
	//	if("winter")
	//		src.armor = getArmor(red = 60, white = 80, black = 80, pale = 100, fire = 10)
	//		if(stored_season != current_season) //Our drip is out of season
	//			src.armor = getArmor(red = 60, white = 70, black = 70, pale = 100, fire = 10)
	//			weakened = TRUE
	//			if(current_season == "summer")
	//				src.armor = getArmor(red = 50, white = 70, black = 70, pale = 90, fire = 0)
	//				warning_message = "The summer heat is melting your armor."

	if(current_holder && (weakened == TRUE))
		playsound(current_holder, "tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/seasons/[current_season]_change.ogg", 50, FALSE)
		if(!warning_message)
			to_chat(current_holder, span_notice("[src] has been weakened by the turn of a new season."))
			return
		to_chat(current_holder, span_notice("[warning_message]"))

/datum/action/cooldown/spell_action/seasons_toggle
	name = "Transformation"
	desc = "Toggle whether or not Season's Greetings will transform."
	button_icon_state = null
	cooldown_time = 0 SECONDS

/datum/action/cooldown/spell_action/seasons_toggle/Activate(target, mob/user)
	var/obj/item/clothing/suit/armor/ego_gear/aleph/seasons/T = user.get_item_by_slot(ITEM_SLOT_OCLOTHING)
	if(!istype(T))
		to_chat(user, span_warning("You must have the corrosponding armor equipped to use this ability!"))
		return
	if(T.transforming)
		to_chat(user, span_warning("[T.name] will no longer transform to match the seasons."))
		T.transforming = FALSE
		T.Transform()
		return ..()
	if(!T.transforming)
		to_chat(user, span_warning("[src] will now transform to match the seasons."))
		T.transforming = TRUE
		T.desc = T.season_list[T.current_season][2]  + " \n This E.G.O. will transform to match the seasons."
		return ..()
	return ..()

/obj/item/clothing/suit/armor/ego_gear/aleph/distortion
	name = "distortion"
	desc = "To my eyes, I’m the only one who doesn’t appear distorted. In a world full of distorted people, could the one person who remains unchanged be the \"distorted\" one?"
	icon_state = "distortion"
	new_armor = list(BURN = 100, BRAIN = 90, BRUTE = 100, TOX = 70, FIRE = 90) // 280


/obj/item/clothing/suit/armor/ego_gear/aleph/willing
	name = "flesh is willing"
	desc = "Is it immoral if you want it to happen?"
	icon_state = "willing"
	new_armor = list(BURN = 100, BRAIN = 80, BRUTE = 80, TOX = 60) // 240


/obj/item/clothing/suit/armor/ego_gear/aleph/pink
	name = "Pink"
	desc = "A pink military uniform. Its pockets allow the wearer to carry various types of ammunition. It soothes the wearer; they say pink provides psychological comfort to many people."
	icon_state = "pink"
	new_armor = list(BURN = 70, BRAIN = 90, BRUTE = 90, TOX = 70) // 240


/obj/item/clothing/suit/armor/ego_gear/aleph/arcadia
	name = "Et in Arcadia Ego"
	desc = "An old, dusty brown suit."
	icon_state = "arcadia"
	new_armor = list(BURN = 90, BRAIN = 70, BRUTE = 80, TOX = 80) // 240


/obj/item/clothing/suit/armor/ego_gear/aleph/giant
	name = "giant"
	desc = "You are a Giant."
	icon_state = "giant"
	new_armor = list(BURN = 100, BRAIN = 50, BRUTE = 100, TOX = 70) // 240


/obj/item/clothing/suit/armor/ego_gear/aleph/throne
	name = "false throne"
	desc = "And here I sit upon a throne of lies."
	icon_state = "throne"
	new_armor = list(BURN = 80, BRAIN = 80, BRUTE = 80, TOX = 80) // 240 - Maybe do something special with this one in the future.


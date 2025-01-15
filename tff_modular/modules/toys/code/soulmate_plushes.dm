/obj/item/toy/plush/tff/soulmates
	/// Typepath of our soulmate. Used to determine with whom we could kiss and... :flooshed:
	var/missing_one
	/// link to our actual soulmate. One and only
	var/obj/item/toy/plush/tff/soulmates/bindedsoul
	/// icon_state when we are not on the same tile with [bindedsoul]
	var/depressed_icon_state = ""
	/// icon_state when we are on the same tile with [bindedsoul]
	var/happy_icon_state = ""
	/// same as [depressed_icon_state] but for description
	var/depressed_desc = " It seems that toy is unhappy... sad."
	/// same as [happy_icon_state] but for description
	var/happy_desc = " Oh! The toy is happy!"

/obj/item/toy/plush/tff/soulmates/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_MOVABLE_MOVED, PROC_REF(check_the_mate))

/obj/item/toy/plush/tff/soulmates/Destroy()
	. = ..()
	UnregisterSignal(src, COMSIG_MOVABLE_MOVED)
	if(bindedsoul)
		bindedsoul.bindedsoul = null
		bindedsoul = null

/// Signal handler for [COMSIG_MOVABLE_MOVED]. Used to check when we are in proximitty with our soulmate to change our [icon_state] accordingly
/obj/item/toy/plush/tff/soulmates/proc/check_the_mate()
	SIGNAL_HANDLER
	var/obj/item/toy/plush/tff/soulmates/that_missing_one = locate() in range(1, src)
	if(istype(that_missing_one, missing_one))
		if(that_missing_one == bindedsoul && that_missing_one.bindedsoul == src)
			src.happy()
			that_missing_one.happy()
		else
			src.drama()
			if(bindedsoul)
				bindedsoul.drama()
	else
		src.drama()
		if(bindedsoul)
			bindedsoul.drama()

/obj/item/toy/plush/tff/soulmates/love(obj/item/toy/plush/tff/soulmates/kisser, mob/living/user)
	if(istype(kisser, missing_one))
		if(kisser != bindedsoul)
			if(kisser.bindedsoul)
				kisser.bindedsoul.bindedsoul = null
				kisser.bindedsoul.check_the_mate()
				kisser.bindedsoul = null
			if(bindedsoul)
				src.bindedsoul.bindedsoul = null
				src.bindedsoul.check_the_mate()
				src.bindedsoul = null
			src.bindedsoul = kisser
			kisser.bindedsoul = src
			kisser.check_the_mate()
		user.visible_message(span_notice("[user] makes [kisser] kiss [src]!"),
		span_notice("You make [kisser] kiss [src]!"))
	return

/// set our icon and message to sad state
/obj/item/toy/plush/tff/soulmates/proc/drama()
	icon_state = depressed_icon_state
	mood_message = depressed_desc
	update_appearance()

//set our icon and message to happy state
/obj/item/toy/plush/tff/soulmates/proc/happy()
	icon_state = happy_icon_state
	mood_message = happy_desc
	update_appearance()

/obj/item/toy/plush/tff/soulmates/junnia
	name = "Junnia plushie"
	gender = FEMALE
	desc = "Looking for her beloved human."
	icon_state = "plush_junnia_depressed"
	depressed_icon_state = "plush_junnia_depressed"
	happy_icon_state = "plush_junnia"
	missing_one = /obj/item/toy/plush/tff/soulmates/howe
	attack_verb_continuous = list("kisses", "hugs", "cuddles against", "bites", "dismisses")
	attack_verb_simple = list("kiss", "hug", "cuddle against", "bite", "dismiss")
	squeak_override = list('modular_nova/modules/emotes/sound/emotes/blush.ogg' = 1, 'modular_nova/modules/emotes/sound/voice/wurble.ogg' = 1, 'modular_nova/modules/emotes/sound/voice/peep_once.ogg' = 1)

/obj/item/toy/plush/tff/soulmates/howe
	name = "Howe plushie"
	gender = MALE
	desc = "Looking for his beloved teshari."
	icon_state = "plush_howe_depressed"
	depressed_icon_state = "plush_howe_depressed"
	happy_icon_state = "plush_howe"
	missing_one = /obj/item/toy/plush/tff/soulmates/junnia
	attack_verb_continuous = list("hugs", "cuddles against", "protects")
	attack_verb_simple = list("hug", "cuddle against", "protect")
	squeak_override = list('modular_nova/modules/emotes/sound/emotes/blush.ogg' = 1)

/obj/item/toy/plush/tff/soulmates/duo
	name = "Duo plushie"
	gender = MALE
	desc = "A cute plush toy, created be image of famous protogen, or not protogen?... however, when you look at him, you can feel responsibility and a desire for new achievements, as well as a little stupidity. Do not let him near the mechs under any circumstances!"
	icon = 'tff_modular/master_files/icons/donator/obj/toys/plushie.dmi'
	icon_state = "plush_duo"
	happy_icon_state = "plush_duo"
	depressed_icon_state = "plush_duo"
	missing_one = /obj/item/toy/plush/tff/soulmates/amy
	squeak_override = list('modular_nova/modules/emotes/sound/emotes/dwoop.ogg' = 1)

/obj/item/toy/plush/tff/soulmates/amy
	name = "Amy plushie"
	gender = FEMALE
	desc = "An adorable plushy that resembles a slimy xenobiologist. A look at it, despite her cuteness, provokes a feeling of danger."
	icon = 'tff_modular/master_files/icons/donator/obj/toys/plushie.dmi'
	icon_state = "plush_amy"
	happy_icon_state = "plush_amy"
	depressed_icon_state = "plush_amy"
	missing_one = /obj/item/toy/plush/tff/soulmates/duo
	squeak_override = list('modular_nova/modules/emotes/sound/voice/slime_squish.ogg' = 1)

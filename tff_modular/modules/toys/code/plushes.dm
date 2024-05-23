// Просто наше плюшевые игрушки. Nothing personal. aka плюшки
/obj/item/toy/plush/tff
	icon = 'tff_modular/modules/toys/icons/plushes.dmi'
	icon_state = "debug"
	inhand_icon_state = null

/obj/item/toy/plush/tff/braiden
	name = "Braiden plushie"
	desc = "An adorable stuffed toy, resembling tired Braiden!"
	icon_state = "plush_braiden"
	attack_verb_continuous = list("pokes", "hugs", "cuddles against", "attacks")
	attack_verb_simple = list("poke", "hug", "cuddle against", "attack")
	squeak_override = list('modular_nova/modules/emotes/sound/emotes/blush.ogg' = 1)

/obj/item/toy/plush/tff/cara
	name = "Cara plushie"
	desc = "An adorable stuffed toy, resembling a giant shark!"
	icon_state = "plush_cara"
	attack_verb_continuous = list("noms", "gnashes at", "bites", "hugs")
	attack_verb_simple = list("nom", "gnash at", "bite", "hug")
	squeak_override = list('sound/weapons/bite.ogg' = 1)

/obj/item/toy/plush/tff/grant
	name = "Grant-ED plushie"
	desc = "An adorable stuffed toy, resembling a lovely synth lizard!"
	icon_state = "plush_grant"
	attack_verb_continuous = list("beeps at", "hisses at", "hugs", "bites")
	attack_verb_simple = list("beep at", "hiss at", "hug", "bite")
	squeak_override = list('sound/machines/beep.ogg' = 1,'sound/machines/twobeep.ogg' = 1,'tff_modular/modules/toys/sounds/error.ogg' = 1)

/obj/item/toy/plush/tff/kylius
	name = "Kylius plushie"
	desc = "An adorable stuffed toy, resembling a red vulpkanin!"
	icon_state = "plush_kylius"
	attack_verb_continuous = list("bites", "barks at", "hugs", "yaffs at")
	attack_verb_simple = list("bite", "bark at", "hug", "yaff at")
	squeak_override = list('tff_modular/modules/toys/sounds/fox.ogg' = 1)

/obj/item/toy/plush/tff/nataly
	name = "Nataly plushie"
	desc = "An adorable stuffed toy, resembling a lovely cat lady!"
	icon_state = "plush_nataly"
	attack_verb_continuous = list("meows at", "nuzzles against", "noms", "hugs")
	attack_verb_simple = list("meow at", "nuzzle against", "nom", "hug")
	squeak_override = list('tff_modular/modules/toys/sounds/nya.ogg' = 1, 'modular_nova/modules/emotes/sound/voice/feline_purr.ogg' = 1)

/obj/item/toy/plush/tff/novelia
	name = "Novelia plushie"
	desc = "An adorable stuffed toy, resembling a very shy lovely lady!"
	icon_state = "plush_novelia"
	attack_verb_continuous = list("pokes", "hugs", "cuddles against", "attacks")
	attack_verb_simple = list("poke", "hug", "cuddle against", "attack")
	squeak_override = list('tff_modular/modules/toys/sounds/blush.ogg' = 1)

/obj/item/toy/plush/tff/v404
	name = "V404.1 plushie"
	desc = "An adorable stuffed toy, resembling malfunctioning synth lizard!"
	icon_state = "plush_404"
	attack_verb_continuous = list("beeps at", "hisses at", "hugs", "bites", "mews at")
	attack_verb_simple = list("beep at", "hiss at", "hug", "bite", "mew at")
	squeak_override = list('tff_modular/modules/toys/sounds/error.ogg' = 1,'sound/machines/twobeep.ogg' = 1,'tff_modular/modules/toys/sounds/mewo.ogg' = 1)

/obj/item/toy/plush/tff/wojciecha
	name = "Wojciecha plushie"
	desc = "An adorable stuffed toy, resembling your biggest threat!"
	icon_state = "plush_wojciecha"
	attack_verb_continuous = list("bites", "attacks", "pushes", "hugs", "sucks blood from")
	attack_verb_simple = list("bite", "attack", "push", "hug", "suck blood from")
	squeak_override = list('sound/items/drink.ogg' = 1)

/obj/item/toy/plush/tff/yulia
	name = "Yulia plushie"
	desc = "An adorable stuffed toy, resembling a smol mako shark!"
	icon_state = "plush_yulia"
	attack_verb_continuous = list("attacks", "bites", "gnashes at", "hugs")
	attack_verb_simple = list("attack", "bite", "gnash at", "hug")
	squeak_override = list('sound/weapons/bite.ogg' = 1,'modular_nova/modules/emotes/sound/voice/feline_purr.ogg' = 1)

/obj/item/toy/plush/tff/soulmates
	// Whom we should finde to do be happy toy
	var/missing_one
	var/obj/item/toy/plush/tff/soulmates/bindedsoul
	var/depressed_icon_state = ""
	var/happy_icon_state = ""
	var/happy_desc = " Oh! The toy is happy!"
	var/depressed_desc = " It seems that toy is unhappy... sad."

/obj/item/toy/plush/tff/soulmates/Destroy()
	. = ..()
	if(bindedsoul)
		bindedsoul.bindedsoul = null
		bindedsoul = null

/obj/item/toy/plush/tff/soulmates/Moved(atom/old_loc, movement_dir, forced, list/old_locs, momentum_change = TRUE)
	. = ..()
	check_the_mate()

/obj/item/toy/plush/tff/soulmates/proc/check_the_mate()
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

/obj/item/toy/plush/tff/soulmates/proc/drama()
	icon_state = depressed_icon_state
	mood_message = depressed_desc
	update_appearance()

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

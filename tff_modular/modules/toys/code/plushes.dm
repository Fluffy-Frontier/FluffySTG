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
	squeak_override = list('modular_skyrat/modules/emotes/sound/emotes/blush.ogg' = 1)

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
	squeak_override = list('tff_modular/modules/toys/sounds/nya.ogg' = 1, 'modular_skyrat/modules/emotes/sound/voice/feline_purr.ogg' = 1)

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
	squeak_override = list('sound/weapons/bite.ogg' = 1,'modular_skyrat/modules/emotes/sound/voice/feline_purr.ogg' = 1)

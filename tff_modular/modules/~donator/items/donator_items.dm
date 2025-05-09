/obj/item/toy/plush/oktavia
	name = "\improper Oktavia"
	desc = "A plush toy of a certain character from the ancient animated series \"BOSS HELL\""
	icon = 'tff_modular/master_files/icons/donator/obj/toys/plushie.dmi'
	icon_state = "zanozkin_plushie"
	gender = FEMALE
	squeak_override = list('modular_nova/modules/emotes/sound/voice/trills.ogg' = 1)

/obj/item/toy/plush/maru
	name = "Maru plushie"
	desc = "An adorable stuffed toy, resembling a shark, wearing a formal maid suit. Beware of runes on the floor!"
	icon = 'tff_modular/master_files/icons/donator/obj/toys/plushie.dmi'
	icon_state = "plush_ivolga"
	attack_verb_continuous = list("attacks", "bites", "gnashes at", "casts at")
	attack_verb_simple = list("attack", "bite", "gnash at", "cast at")
	squeak_override = list('sound/items/weapons/bite.ogg' = 1,'tff_modular/modules/toys/sounds/castsummon.ogg' = 1)

/obj/item/toy/plush/mironov
	name = "Anatoly Mironov plushie"
	desc = "You see before you a plush representative of the Tajaran race, shaped like a NanoTrasen Central Command officer. It is roughly large in size."
	icon = 'tff_modular/master_files/icons/donator/obj/toys/plushie.dmi'
	icon_state = "plush_mironov"
	attack_verb_continuous = list("attacks", "bites", "scratches")
	attack_verb_simple = list("attack", "bite", "scratch")
	squeak_override = list('modular_nova/modules/emotes/sound/voice/mggaow.ogg' = 1, 'sound/machines/beep/beep.ogg' = 1)

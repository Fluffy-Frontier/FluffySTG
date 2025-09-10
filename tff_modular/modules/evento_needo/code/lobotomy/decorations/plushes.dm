/obj/item/toy/plush/lobotomycorp
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/plushes.dmi'
	icon_state = "apocbird"

/* LC plushes */
// The good guys
/obj/item/toy/plush/lobotomycorp/ayin
	name = "ayin plushie"
	desc = "A plushie depicting a researcher that did <b>nothing wrong</b>." // Fight me
	icon_state = "ayin"
	gender = MALE

/obj/item/toy/plush/lobotomycorp/benjamin
	name = "benjamin plushie"
	desc = "A plushie depicting a researcher that resembles Hokma a bit too much."
	icon_state = "benjamin"
	gender = MALE

/obj/item/toy/plush/lobotomycorp/carmen
	name = "carmen plushie"
	desc = "A plushie depicting an ambitious and altruistic researcher."
	icon_state = "carmen"
	gender = FEMALE

// Sephirots
/obj/item/toy/plush/lobotomycorp/malkuth
	name = "malkuth plushie"
	desc = "A plushie depicting a diligent worker."
	icon_state = "malkuth"
	gender = FEMALE

/obj/item/toy/plush/lobotomycorp/yesod
	name = "yesod plushie"
	desc = "A plushie depicting a researcher in a turtleneck."
	icon_state = "yesod"
	gender = MALE

/obj/item/toy/plush/lobotomycorp/netzach
	name = "netzach plushie"
	desc = "A plushie depicting a person that likes alcohol a bit too much."
	icon_state = "netzach"
	gender = MALE

/obj/item/toy/plush/lobotomycorp/hod
	name = "hod plushie"
	desc = "A plushie depicting a person who hopes to make everything right."
	icon_state = "hod"
	gender = FEMALE

/obj/item/toy/plush/lobotomycorp/lisa
	name = "tiphereth-A plushie"
	desc = "A plushie depicting a person with high expectations."
	icon_state = "lisa"
	gender = FEMALE

/obj/item/toy/plush/lobotomycorp/enoch
	name = "tiphereth-B plushie"
	desc = "A plushie depicting an optimistic person with kind heart."
	icon_state = "enoch"
	gender = MALE

/obj/item/toy/plush/lobotomycorp/chesed
	name = "chesed plushie"
	desc = "A plushie depicting a sleepy person with a mug of coffee in their hand."
	icon_state = "chesed"
	gender = MALE

/obj/item/toy/plush/lobotomycorp/gebura
	name = "gebura plushie"
	desc = "A plushie depicting very strong and brave person."
	icon_state = "gebura"
	gender = FEMALE

/obj/item/toy/plush/lobotomycorp/hokma
	name = "hokma plushie"
	desc = "A plushie depicting a wise person with a fancy monocle. He knows much more than you."
	icon_state = "hokma"
	gender = MALE

/obj/item/toy/plush/lobotomycorp/binah
	name = "binah plushie"
	desc = "A plushie depicting a sadistic person who lacks any emotions."
	icon_state = "binah"
	gender = FEMALE

/obj/item/toy/plush/lobotomycorp/angela
	name = "angela plushie"
	desc = "A plushie depicting Lobotomy Corporation's AI."
	icon_state = "angela"
	gender = FEMALE

	//Limbus Sinners
/obj/item/toy/plush/lobotomycorp/yisang
	name = "yi sang plushie"
	desc = "A plushie depicting a ruminating sinner."
	icon_state = "yisang"
	attack_verb_continuous = list("shanks", "stabs")
	attack_verb_simple = list("shank", "stab")
	gender = MALE

/obj/item/toy/plush/lobotomycorp/faust
	name = "faust plushie"
	desc = "A plushie depicting an insufferable sinner."
	icon_state = "faust"
	attack_verb_continuous = list("slices", "cleaves")
	attack_verb_simple = list("slice", "cleaves")
	gender = FEMALE

/obj/item/toy/plush/lobotomycorp/don
	name = "don quixote plushie"
	desc = "A plushie depicting a heroic sinner."
	icon_state = "don"
	attack_verb_continuous = list("impales", "jousts")
	attack_verb_simple = list("impale", "joust")
	gender = FEMALE

/obj/item/toy/plush/lobotomycorp/don/attack_self(mob/user)
	..()
	icon_state = "don_yahoo"
	addtimer(CALLBACK(src, PROC_REF(sprite_return)), 3 SECONDS)

//So you can make her yahoo again
/obj/item/toy/plush/lobotomycorp/don/proc/sprite_return(mob/user)
	icon_state = "don"

/obj/item/toy/plush/lobotomycorp/ryoshu
	name = "ryoshu plushie"
	desc = "A plushie depicting a artistic sinner."
	icon_state = "ryoshu"
	attack_verb_continuous = list("slices", "cleaves")
	attack_verb_simple = list("slice", "cleaves")
	gender = FEMALE

/obj/item/toy/plush/lobotomycorp/meursault
	name = "meursault plushie"
	desc = "A plushie depicting a neutral sinner."
	icon_state = "meursault"
	attack_verb_continuous = list("bashes", "slams", "bludgeons")
	attack_verb_simple = list("bash", "slam", "bludgeon")
	gender = MALE

/obj/item/toy/plush/lobotomycorp/honglu
	name = "hong lu plushie"
	desc = "A plushie depicting a sheltered sinner."
	icon_state = "honglu"
	attack_verb_continuous = list("slices", "cleaves")
	attack_verb_simple = list("slice", "cleaves")
	gender = MALE

/obj/item/toy/plush/lobotomycorp/heathcliff
	name = "heathcliff plushie"
	desc = "A plushie depicting a brash sinner."
	icon_state = "heathcliff"
	attack_verb_continuous = list("bashes", "slams", "bludgeons")
	attack_verb_simple = list("bash", "slam", "bludgeon")
	gender = MALE

/obj/item/toy/plush/lobotomycorp/ishmael
	name = "ishmael plushie"
	desc = "A plushie depicting a reliable sinner."
	icon_state = "ishmael"
	attack_verb_continuous = list("bashes", "slams", "bludgeons")
	attack_verb_simple = list("bash", "slam", "bludgeon")
	gender = FEMALE

/obj/item/toy/plush/lobotomycorp/rodion
	name = "rodion plushie"
	desc = "A plushie depicting a backstreets born sinner."
	icon_state = "rodion"
	attack_verb_continuous = list("slices", "cleaves")
	attack_verb_simple = list("slice", "cleaves")
	gender = FEMALE

/obj/item/toy/plush/lobotomycorp/sinclair
	name = "sinclair plushie"
	desc = "A plushie depicting a insecure sinner."
	icon_state = "sinclair"
	attack_verb_continuous = list("slices", "cleaves")
	attack_verb_simple = list("slice", "cleaves")
	gender = MALE

/obj/item/toy/plush/lobotomycorp/dante
	name = "dante plushie"
	desc = "A plushie depicting a clock headed manager."
	icon_state = "dante"
	gender = MALE

/obj/item/toy/plush/lobotomycorp/outis
	name = "outis plushie"
	desc = "A plushie depicting a strategic sinner."
	icon_state = "outis"
	attack_verb_continuous = list("shanks", "stabs")
	attack_verb_simple = list("shank", "stab")
	gender = FEMALE

/obj/item/toy/plush/lobotomycorp/gregor
	name = "bug guy plushie"
	desc = "A plushie depicting a genetically altered sinner."
	icon_state = "gregor"
	attack_verb_continuous = list("shanks", "stabs")
	attack_verb_simple = list("shank", "stab")
	gender = MALE

// Misc LC stuff
/obj/item/toy/plush/lobotomycorp/pierre
	name = "pierre plushie"
	desc = "A plushie depicting a friendly cook."
	icon_state = "pierre"
	gender = FEMALE
	squeak_override = list('tff_modular/modules/evento_needo/sounds/Tegusounds/wow.ogg'=1)

/obj/item/toy/plush/lobotomycorp/myo
	name = "myo plushie"
	desc = "A plushie depicting a mercenary captain."
	icon_state = "myo"
	gender = FEMALE
	squeak_override = list('tff_modular/modules/evento_needo/sounds/Tegusounds/yem.ogg'=1)

/obj/item/toy/plush/lobotomycorp/rabbit
	name = "rabbit plushie"
	desc = "A plushie depicting a mercenary."
	icon_state = "rabbit"
	squeak_override = list('sound/items/radio/radio_receive.ogg'=1)

/obj/item/toy/plush/lobotomycorp/yuri
	name = "yuri plushie"
	desc = "A plushie depicting an L corp employee who had the potential to walk alongside the sinners."
	icon_state = "yuri"
	gender = FEMALE

/obj/item/toy/plush/lobotomycorp/attackby(obj/item/I, mob/living/user, params)
	. = ..()
	if(istype(I, /obj/item/food/grown/apple/gold))
		if(do_after(user, 2 SECONDS, target = user))
			user.visible_message("<span class='notice'>[src] is violently absorbed by the [I]!</span>")
			qdel(src)
			return
		to_chat(user, "<span class='notice'>You feel as if you prevented something weird and terrible from happening again.</span>")

/obj/item/toy/plush/lobotomycorp/samjo
	name = "samjo plushie"
	desc = "A plushie depicting a K corp secretary, their devotion deserved recognition."
	icon_state = "samjo"
	gender = MALE

/obj/item/toy/plush/lobotomycorp/zena
	name = "zena plushie"
	desc = "A plushie depicting an aloof arbiter."
	icon_state = "zena"
	gender = FEMALE

/obj/item/toy/plush/lobotomycorp/blank
	name = "plushie blank"
	desc = "A humanoid plush that had been freshly made or stripped down to its cloth. Despite its lack of identity, the mere aknowelegement of this plushie makes it unique."
	icon_state = "blank"


// Abnormalities
/obj/item/toy/plush/lobotomycorp/qoh
	name = "queen of hatred plushie"
	desc = "A plushie depicting a magical girl whose goal is fighting all evil in the universe!"
	icon_state = "qoh"
	gender = FEMALE

/obj/item/toy/plush/lobotomycorp/kog
	name = "king of greed plushie"
	desc = "A plushie depicting a magical girl whose desires got the best of her."
	icon_state = "kog"
	gender = FEMALE

/obj/item/toy/plush/lobotomycorp/kod
	name = "knight of despair plushie"
	desc = "A plushie depicting a magical girl who abandoned those who needed her most."
	icon_state = "kod"
	gender = FEMALE

/obj/item/toy/plush/lobotomycorp/sow
	name = "servant of wrath plushie"
	desc = "A plushie depicting a magical girl who was betrayed by someone they trusted dearly."
	icon_state = "sow"
	gender = FEMALE

/obj/item/toy/plush/lobotomycorp/nihil
	name = "jester of nihil plushie"
	desc = "A plushie depicting a black and white jester, usually found alongside the magical girls."
	icon_state = "nihil"

/obj/item/toy/plush/lobotomycorp/bigbird
	name = "big bird plushie"
	desc = "A plushie depicting a big bird with a lantern that burns forever. How does it even work..?"
	icon_state = "bigbird"

/obj/item/toy/plush/lobotomycorp/pbird
	name = "small bird plushie"
	desc = "A plushie depicting a tiny bird with a small beak and red splotch on its chest."
	icon_state = "pbird"
	attack_verb_continuous = list("pecks", "punishes")
	attack_verb_simple = list("peck", "punish")

/obj/item/toy/plush/lobotomycorp/jbird
	name = "tall bird plushie"
	desc = "A plushie depicting a tall bird with a bandaged head. It's so thin!"
	icon_state = "jbird"
	attack_verb_continuous = list("judges")
	attack_verb_simple = list("judge")

/obj/item/toy/plush/lobotomycorp/mosb
	name = "mountain of smiling bodies plushie"
	desc = "A plushie depicting a mountain of corpses merged into one. Yuck!"
	icon_state = "mosb"

/obj/item/toy/plush/lobotomycorp/big_bad_wolf
	name = "big and will be bad wolf plushie"
	desc = "A plushie depicting quite a not so bad and very much so marketable wolf plush."
	icon_state = "big_bad_wolf"

/obj/item/toy/plush/lobotomycorp/melt
	name = "melting love plushie"
	desc = "A plushie depicting a slime girl, you think."
	icon_state = "melt"
	attack_verb_continuous = list("blorbles", "slimes", "absorbs")
	attack_verb_simple = list("blorble", "slime", "absorb")
	squeak_override = list('sound/effects/blob/blobattack.ogg' = 1)

/obj/item/toy/plush/lobotomycorp/scorched
	name = "scorched girl plushie"
	desc = "A plushie depicting scorched girl."
	icon_state = "scorched"
	gender = FEMALE
	squeak_override = list('tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/scorchedgirl/pre_ability.ogg'=1)

/obj/item/toy/plush/lobotomycorp/pinocchio
	name = "pinocchio plushie"
	desc = "A plushie depicting pinocchio."
	icon_state = "pinocchio"

// Others
/obj/item/toy/plush/lobotomycorp/bongbong
	name = "bongbong plushie"
	desc = "A plushie depicting the Lobotomy Corporation"
	icon_state = "bongbong"

/obj/item/toy/plush/lobotomycorp/fumo
	name = "cirno fumo"
	desc = "A plushie depicting an adorable ice fairy. It's cold to the touch."
	icon_state = "fumo_cirno"

// Special
/obj/item/toy/plush/lobotomycorp/bongy
	name = "bongy plushie"
	desc = "It looks like a raw chicken. A cute raw chicken!"
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/plushes.dmi'
	icon_state = "bongy"
	squeak_override = list('tff_modular/modules/evento_needo/sounds/Tegusounds/lc13_creatures/bongy/kweh.ogg'=1)

/obj/item/toy/plush/lobotomycorp/apocbird
	name = "apocalypse bird plushie"
	desc = "A large plushie that resembles the beast of the black forest."
	icon_state = "apocbird"



/obj/structure/fluff/arc/angela
	name = "\proper the cerebrum"
	desc = "Welcome to Lobotomy Corp. Face the fear, build the future."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/tomb.dmi'
	icon_state = "commandstatue"

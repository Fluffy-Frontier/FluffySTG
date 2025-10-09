// WAW Armor should be kept at ~140 total armor.

/* Lead Developer's note:
Think before you code!
Any attempt to code risk class armor will result in a 10 day Github ban.*/

/*Developer's note - All LC13 armor has 50% of its BURN armor as fire armor by default. */

/obj/item/clothing/suit/armor/ego_gear/waw
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/clothing/ego_gear/abnormality/waw.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/icons/Teguicons/mob/ego_gear/abnormality/waw.dmi'

/obj/item/clothing/suit/armor/ego_gear/waw/hornet
	name = "hornet armor"
	desc = "A dark coat with yellow details. You feel as if you can hear faint buzzing coming out of it."
	icon_state = "hornet"
	new_armor = list(BURN = 50, BRAIN = 30, BRUTE = 40, TOX = 20) // 140


/obj/item/clothing/suit/armor/ego_gear/waw/lamp
	name = "lamp armor"
	desc = "A dark coat with thousands of eyes on it. They are looking at you as you move."
	icon_state = "lamp"
	new_armor = list(BURN = 20, BRAIN = 30, BRUTE = 60, TOX = 30) // 140


/obj/item/clothing/suit/armor/ego_gear/waw/correctional
	name = "correctional armor"
	desc = "A white, lightly bloodstained coat. it goes all the way down to your ankles."
	icon_state = "correctional"
	new_armor = list(BURN = 50, BRAIN = 0, BRUTE = 60, TOX = 30) // 140


/obj/item/clothing/suit/armor/ego_gear/waw/despair
	name = "armor sharpened with tears"
	desc = "Tears fall like ash, embroidered as if they were constellations."
	icon_state = "despair"
	new_armor = list(BURN = 20, BRAIN = 40, BRUTE = 20, TOX = 60) // 140


/obj/item/clothing/suit/armor/ego_gear/waw/despair/attackby(obj/item/I, mob/living/user, params)
	..()
	if(!istype(I, /obj/item/nihil/spade))
		return
	new /obj/item/clothing/suit/armor/ego_gear/despair_nihil(get_turf(src))
	to_chat(user,"<span class='warning'>The [I] seems to drain all of the light away as it is absorbed into [src]!</span>")
	playsound(user, 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/nihil/filter.ogg', 15, FALSE, -3)
	qdel(I)
	qdel(src)

/obj/item/clothing/suit/armor/ego_gear/waw/hatred
	name = "in the name of love and hate"
	desc = "A magical one-piece dress imbued with the love and justice of a magical girl. \
	Wearing it may ignite your spirit of justice and the desire to protect the world. \
	Then you'll hear the sound of hatred, sinking deeper than love."
	icon_state = "hatred"
	new_armor = list(BURN = 30, BRAIN = 20, BRUTE = 60, TOX = 30) // 140


/obj/item/clothing/suit/armor/ego_gear/waw/hatred/attackby(obj/item/I, mob/living/user, params)
	..()
	if(!istype(I, /obj/item/nihil/heart))
		return
	new /obj/item/clothing/suit/armor/ego_gear/hatred_nihil(get_turf(src))
	to_chat(user,"<span class='warning'>The [I] seems to drain all of the light away as it is absorbed into [src]!</span>")
	playsound(user, 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/nihil/filter.ogg', 15, FALSE, -3)
	qdel(I)
	qdel(src)

/obj/item/clothing/suit/armor/ego_gear/waw/oppression
	name = "oppression"
	desc = "And I shall hold you here, forever."
	icon_state = "oppression"
	new_armor = list(BURN = 50, BRAIN = 20, BRUTE = 40, TOX = 30) //140


/obj/item/clothing/suit/armor/ego_gear/waw/totalitarianism
	name = "totalitarianism"
	desc = "Or are you trapped here by me?"
	icon_state = "totalitarianism"
	new_armor = list(BURN = 40, BRAIN = 20, BRUTE = 50, TOX = 30) // 140


/obj/item/clothing/suit/armor/ego_gear/waw/goldrush
	name = "gold rush"
	desc = "Bare armor. lightweight and ready for combat."
	icon_state = "gold_rush"
	new_armor = list(BURN = 70, BRAIN = 40, BRUTE = 30, TOX = 0) // 140


/obj/item/clothing/suit/armor/ego_gear/waw/goldrush/attackby(obj/item/I, mob/living/user, params)
	..()
	if(!istype(I, /obj/item/nihil/diamond))
		return
	new /obj/item/clothing/suit/armor/ego_gear/goldrush_nihil(get_turf(src))
	to_chat(user,"<span class='warning'>The [I] seems to drain all of the light away as it is absorbed into [src]!</span>")
	playsound(user, 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/nihil/filter.ogg', 15, FALSE, -3)
	qdel(I)
	qdel(src)

/obj/item/clothing/suit/armor/ego_gear/waw/tiara
	name = "tiara"
	desc = "Who will look after you when I am gone?"
	icon_state = "tiara"
	new_armor = list(BURN = 10, BRAIN = 50, BRUTE = 30, TOX = 50)


/obj/item/clothing/suit/armor/ego_gear/waw/cobalt
	name = "cobalt scar"
	desc = "The armor is torn up with countless traces that recount the history of the unending battle."
	icon_state = "cobalt_scar"
	new_armor = list(BURN = 60, BRAIN = 30, BRUTE = 40, TOX = 10)


/obj/item/clothing/suit/armor/ego_gear/waw/crimson
	name = "crimson scar"
	desc = "It seems only darkness awaits those who find the value of their lives in nothing but destruction."
	icon_state = "crimson_scar"
	new_armor = list(BURN = 60, BRAIN = 40, BRUTE = 30, TOX = 10)


/obj/item/clothing/suit/armor/ego_gear/waw/spore
	name = "spore"
	desc = "When stars light the night sky, its true form will be revealed."
	icon_state = "spore"
	new_armor = list(BURN = 10, BRAIN = 60, BRUTE = 30, TOX = 40)


/obj/item/clothing/suit/armor/ego_gear/waw/stem
	name = "green stem"
	desc = "Letting go of the obsession may ease the suffering a little."
	icon_state = "green_stem"
	new_armor = list(BURN = 40, BRAIN = 10, BRUTE = 70, TOX = 20)


/obj/item/clothing/suit/armor/ego_gear/waw/loyalty
	name = "loyalty"
	desc = "And god have mercy on anyone who hurt her queen."
	icon_state = "loyalty"
	new_armor = list(BURN = 60, BRAIN = 30, BRUTE = 30, TOX = 20)


/obj/item/clothing/suit/armor/ego_gear/waw/executive
	name = "executive"
	desc = "A VERY expensive suit. Just by looking at it, you can tell it's the cream of the crop. And so are you."
	icon_state = "executive"
	new_armor = list(BURN = 40, BRAIN = 40, BRUTE = 40, TOX = 20) // 140


/obj/item/clothing/suit/armor/ego_gear/waw/ecstasy
	name = "ecstasy"
	desc = "The colorful pattern is fancy, quite akin to a child's costume."
	icon_state = "ecstasy"
	new_armor = list(BURN = 40, BRAIN = 70, BRUTE = 10, TOX = 20)


/obj/item/clothing/suit/armor/ego_gear/waw/intentions
	name = "good intentions"
	desc = "All aboard!"
	icon_state = "intentions"
	new_armor = list(BURN = 40, BRAIN = 10, BRUTE = 60, TOX = 30)


/obj/item/clothing/suit/armor/ego_gear/waw/aroma
	name = "faint aroma"
	desc = "The ceramic surface is tough as if it had been glazed several times. \
			It may crumble back into primal clay if it is exposed to a powerful mental attack."
	icon_state = "aroma"
	new_armor = list(BURN = 0, BRAIN = 70, BRUTE = 40, TOX = 30) // 140


/obj/item/clothing/suit/armor/ego_gear/waw/thirteen
	name = "dead silence"
	desc = "No one can go against the flow of time."
	icon_state = "thirteen"
	new_armor = list(BURN = 10, BRAIN = 10, BRUTE = 50, TOX = 70) // 140


/obj/item/clothing/suit/armor/ego_gear/waw/assonance
	name = "assonance"
	desc = "What is good if there is no evil?"
	icon_state = "assonance"
	new_armor = list(BURN = 30, BRAIN = 60, BRUTE = 20, TOX = 30) // 140


/obj/item/clothing/suit/armor/ego_gear/waw/exuviae
	name = "exuviae"
	desc = "Its scales are multi layered, suitable for protection against external threats."
	icon_state = "exuviae"
	new_armor = list(BURN = 60, BRAIN = 40, BRUTE = 20, TOX = 20) // 140


/obj/item/clothing/suit/armor/ego_gear/waw/ebony_stem
	name = "ebony stem"
	desc = "Someone must endure the pain to spare the rest of suffering."
	icon_state = "ebony_stem"
	new_armor = list(BURN = 10, BRAIN = 10, BRUTE = 70, TOX = 50) // 140


/obj/item/clothing/suit/armor/ego_gear/waw/feather
	name = "Feather of Honor"
	desc = "Bright as the abnormality it was extracted from, but somehow does not give off any heat. \
			Maybe keep it away from the cold..."
	icon_state = "featherofhonor"
	new_armor = list(BURN = 50, BRAIN = 50, BRUTE = 30, TOX = 10, FIRE = 60) //140


/obj/item/clothing/suit/armor/ego_gear/waw/warring
	name = "feather of valor"
	desc = "Wearing this undyed leather poncho fills you with contempt. \
	Only war will stop their barbaric sacrilege."
	icon_state = "warring"
	new_armor = list(BURN = 10, BRAIN = 50, BRUTE = 40, TOX = 40) // 140


/obj/item/clothing/suit/armor/ego_gear/waw/animalism
	name = "Animalism"
	desc = "Nothing left behind your eyes, just animal instinct and a hollow mind - impervious to everything and everyone."
	icon_state = "animalism"
	new_armor = list(BURN = 10, BRAIN = 50, BRUTE = 40, TOX = 40) //140


/obj/item/clothing/suit/armor/ego_gear/waw/darkcarnival
	name = "Dark Carnival"
	desc = "The only bad things are those we make in our minds."
	icon_state = "dark_carnival"
	new_armor = list(BURN = 60, BRAIN = 60, BRUTE = 10, TOX = 10) // 140


/obj/item/clothing/suit/armor/ego_gear/waw/dipsia
	name = "dipsia"
	desc = "The blood, in its purest and clearest form! Bring me eternal happiness!"
	icon_state = "dipsia"
	new_armor = list(BURN = 70, BRAIN = 0, BRUTE = 40, TOX = 30) // 140


/obj/item/clothing/suit/armor/ego_gear/waw/pharaoh
	name = "pharaoh"
	desc = "What creature walks on four legs in the morning, two legs at noon, and three in the evening?"
	icon_state = "pharaoh"
	new_armor = list(BURN = 30, BRAIN = 60, BRUTE = 50, TOX = 0) // 140


/obj/item/clothing/suit/armor/ego_gear/waw/moonlight
	name = "moonlight"
	desc = "A classic, dark dress whose edge resembles an ink cap. \
			You may take a step towards the truth of the moon that was so difficult to understand if you wear it. "
	icon_state = "moonlight"
	new_armor = list(BURN = 30, BRAIN = 70, BRUTE = 40, TOX = 0) // 140


/obj/item/clothing/suit/armor/ego_gear/waw/blind_rage
	name = "Blind Rage"
	desc = "There is no sorrow like the betrayal of a friend. \
			Nor is there such rage."
	icon_state = "blind_rage"
	new_armor = list(BURN = 50, BRAIN = 0, BRUTE = 50, TOX = 40) // 140


/obj/item/clothing/suit/armor/ego_gear/waw/blind_rage/attackby(obj/item/I, mob/living/user, params)
	..()
	if(!istype(I, /obj/item/nihil/club))
		return
	new /obj/item/clothing/suit/armor/ego_gear/blind_rage_nihil(get_turf(src))
	to_chat(user,"<span class='warning'>The [I] seems to drain all of the light away as it is absorbed into [src]!</span>")
	playsound(user, 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/nihil/filter.ogg', 15, FALSE, -3)
	qdel(I)
	qdel(src)

/obj/item/clothing/suit/armor/ego_gear/waw/heart
	name = "bleeding heart"
	desc = "And the prayer shall inevitably end with the eternal despair of its worshiper."
	icon_state = "heart"
	new_armor = list(BURN = 70, BRAIN = 10, BRUTE = 10, TOX = 50) // 140


/obj/item/clothing/suit/armor/ego_gear/waw/diffraction
	name = "diffraction"
	desc = "You can ignore the ridiculous advice that you can see it with your mind."
	icon_state = "diffraction"
	new_armor = list(BURN = 50, BRAIN = 30, BRUTE = 30, TOX = 30) // 140


/obj/item/clothing/suit/armor/ego_gear/waw/infinity
	name = "infinity"
	desc = "You know it to be true."
	icon_state = "infinity"
	new_armor = list(BURN = 30, BRAIN = 30, BRUTE = 30, TOX = 50) // 140


/obj/item/clothing/suit/armor/ego_gear/waw/amrita
	name = "amrita"
	desc = "You can smell old dirt and fire if you put your nose close enough."
	icon_state = "amrita"
	new_armor = list(BURN = 60, BRAIN = 0, BRUTE = 50, TOX = 30) // 140


/obj/item/clothing/suit/armor/ego_gear/waw/discord
	name = "discord"
	desc = "What is evil if there is no good?"
	icon_state = "discord"
	new_armor = list(BURN = 20, BRAIN = 40, BRUTE = 60, TOX = 20) // 140


/obj/item/clothing/suit/armor/ego_gear/waw/innocence
	name = "childhood memories"
	desc = "In my dreams as child, Peter Pan would reach out a hand for me to hold and take me to Neverland. I had forgotten all of that, until I went into that room."
	icon_state = "innocence"
	new_armor = list(BURN = 0, BRAIN = 70, BRUTE = 40, TOX = 30) //140


/obj/item/clothing/suit/armor/ego_gear/waw/rimeshank
	name = "rimeshank"
	desc = "Well, I can't just shiver in the cold forever, can I?"
	icon_state = "rimeshank"
	new_armor = list(BURN = 70, BRAIN = 40, BRUTE = 0, TOX = 30, FIRE = 20) //140


/obj/item/clothing/suit/armor/ego_gear/waw/hypocrisy
	name = "hypocrisy armor"
	desc = "All things natural are bound to turn to dust someday. Thus, this evergreen robe must be kept far apart from mother nature."
	icon_state = "hypocrisy"
	new_armor = list(BURN = 70, BRAIN = 40, BRUTE = 0, TOX = 30) // 140


/obj/item/clothing/suit/armor/ego_gear/waw/my_own_bride
	name = "My own Bride"
	desc = "May your life work, Come back for you."
	icon_state = "wife"
	new_armor = list(BURN = 30, BRAIN = 60, BRUTE = 30, TOX = 20) // 140


/obj/item/clothing/suit/armor/ego_gear/waw/swan
	name = "black swan"
	desc = "Whenever she felt exhausted from the agony and struggle, she looked at her brooch, a memento of the past, to stifle her feelings."
	icon_state = "swan"
	new_armor = list(BURN = 60, BRAIN = 20, BRUTE = 50, TOX = 10) // 140


/obj/item/clothing/suit/armor/ego_gear/waw/psychic
	name = "psychic dagger"
	desc = "But a mermaid has no tears, and therefore she suffers so much more."
	icon_state = "psychic"
	new_armor = list(BURN = 30, BRAIN = 70, BRUTE = 40, TOX = 60) // 140


/obj/item/clothing/suit/armor/ego_gear/waw/scene
	name = "as written in the scenario"
	desc = "Title: Peccatum Proprium. Today, we perform for the king. Characters : A, The failed, The Abandoned, The Broken, The Coward, and......."
	icon_state = "scenario"
	new_armor = list(BURN = 30, BRAIN = 50, BRUTE = 50, TOX = 10) // 140


/obj/item/clothing/suit/armor/ego_gear/waw/rosa
	name = "garden of thorns"
	desc = "Our only wish is that our garden will bloom full of flowers."
	icon_state = "rosa"
	new_armor = list(BURN = 30, BRAIN = 50, BRUTE = 30, TOX = 30) // 140


/obj/item/clothing/suit/armor/ego_gear/waw/blind_obsession
	name = "blind obsession"
	desc = "Allow me to describe this grand and epic beast!"
	icon_state = "blind_obsession"
	new_armor = list(BURN = 60, BRAIN = 10, BRUTE = 50, TOX = 40)//140


/obj/item/clothing/suit/armor/ego_gear/waw/holiday
	name = "holiday"
	desc = "A snazzy outfit for bringing Christmas cheer to all the boys and girls."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/joke_abnos/joke_armor.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/icons/Teguicons/joke_abnos/joke_worn.dmi'
	icon_state = "ultimate_christmas"
	new_armor = list(BURN = 60, BRAIN = 50, BRUTE = 10, TOX = 20) // 140


/obj/item/clothing/suit/armor/ego_gear/waw/sunyata
	name = "ya sunyata tad rupam"
	desc = "Karma shall find its way back to you, and rest atop your head."
	icon_state = "sunyata"
	new_armor = list(BURN = 50, BRAIN = 50, BRUTE = 10, TOX = 50)//140


/obj/item/clothing/suit/armor/ego_gear/waw/effervescent
	name = "effervescent corrosion"
	desc = "Coalesce all your flaws and fears into something stronger."
	icon_state = "shell"
	new_armor = list(BURN = 50, BRAIN = 60, BRUTE = 20, TOX = 10) // 140


/obj/item/clothing/suit/armor/ego_gear/waw/havana
	name = "havana"
	desc = "Sit down, relax and take a deep breath."
	icon_state = "havana"
	new_armor = list(BURN = 30, BRAIN = 20, BRUTE = 30, TOX = 60) // 140


/obj/item/clothing/suit/armor/ego_gear/waw/heaven
	name = "heaven"
	desc = "That's what a gaze is. Attention. An invisible string that connects us."
	icon_state = "heaven"
	new_armor = list(BURN = 10, BRAIN = 60, BRUTE = 60, TOX = 10) // 140. LobCorp original stats: 1.2, 0.8, 0.6, 1.2.

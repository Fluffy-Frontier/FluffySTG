// ZAYIN Armor should be kept below 10 total armor.

/* Lead Developer's note:
Think before you code!
Any attempt to code risk class armor will result in a 10 day Github ban.*/

/*Developer's note - All LC13 armor has 50% of its BRUTE armor as fire armor by default. */

/obj/item/clothing/suit/armor/ego_gear/zayin
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/clothing/ego_gear/abnormality/zayin.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/icons/Teguicons/mob/ego_gear/abnormality/zayin.dmi'

/obj/item/clothing/suit/armor/ego_gear/zayin/penitence
	name = "penitence"
	desc = "A piece of EGO armor intended to protect its user from mental decay. This suit will be no better than rags to those who have no sense of guilt."
	icon_state = "penitence"
	new_armor = list(BURN = 10, BRAIN = 30, BRUTE = 10, TOX = 10)

/obj/item/clothing/suit/armor/ego_gear/zayin/tough
	name = "tough jacket"
	desc = "A leather jacket with an unusually luxurious figure. Only those who maintain a clean “hairstyle” with no impurities on their head will be deemed worthy of equipping this suit."
	icon_state = "tough"
	new_armor = list(BURN = 10, BRAIN = 10, BRUTE = 30, TOX = 10)

/obj/item/clothing/suit/armor/ego_gear/zayin/tough/SpecialEgoCheck(mob/living/carbon/human/H)
	if(HAS_TRAIT(H, TRAIT_BALD))
		return TRUE
	to_chat(H, "<span class='notice'>Only the ones with dedication to clean hairstyle can use [src]!</span>")
	return FALSE

/obj/item/clothing/suit/armor/ego_gear/zayin/tough/SpecialGearRequirements()
	return "\n<span class='warning'>The user must have clean hairstyle.</span>"

/obj/item/clothing/suit/armor/ego_gear/zayin/soda
	name = "soda armor"
	desc = "A suit of armor that feels like you're wearing aluminum. \
	It’s quite light for armor, so it is rather comfortable to wear."
	icon_state = "soda"
	new_armor = list(BURN = 30, BRAIN = 10, BRUTE = 10, TOX = 10)

/obj/item/clothing/suit/armor/ego_gear/zayin/little_alice
	name = "little alice"	//Looks like alice from Shin Megami Tensei
	desc = "Oh, they are so very beautiful."
	icon_state = "little_alice"
	new_armor = list(BURN = 10, BRAIN = 10, BRUTE = 30, TOX = 10)

/obj/item/clothing/suit/armor/ego_gear/zayin/wingbeat
	name = "wingbeat"
	desc = "Most of the employees do not know the true meaning of The Fairies’ Care."
	icon_state = "wingbeat"
	new_armor = list(BURN = 30, BRAIN = 10, BRUTE = 10, TOX = 10)

/obj/item/clothing/suit/armor/ego_gear/zayin/change
	name = "change"
	desc = "Everything can be changed if you try hard enough!"
	icon_state = "change"
	new_armor = list(BURN = 30, BRAIN = 10, BRUTE = 10, TOX = 10)

/obj/item/clothing/suit/armor/ego_gear/zayin/doze
	name = "dozing"
	desc = "While this looks like a set of pajamas, it protects the user from mental damage."
	icon_state = "doze"
	new_armor = list(BURN = 10, BRAIN = 30, BRUTE = 10, TOX = 10)

/obj/item/clothing/suit/armor/ego_gear/zayin/nostalgia
	name = "nostalgia"
	desc = "An old brown jacket. What seems to be an L corp logo is stitched into the side. This logo, strangely, is not one for the company you work at"
	icon_state = "nostalgia"
	new_armor = list(BURN = 10, BRAIN = 30, BRUTE = 10, TOX = 10)

/obj/item/clothing/suit/armor/ego_gear/zayin/evening
	name = "evening twilight"
	desc = "If you accept it, your whole world will change."
	icon_state = "evening"
	new_armor = list(BURN = 10, BRAIN = 10, BRUTE = 10, TOX = 30)

/obj/item/clothing/suit/armor/ego_gear/zayin/cavernous_wailing
	name = "cavernous wailing"
	desc = "Doesn't it make you more gloomy than anything?"
	icon_state = "cavernous_wailing"
	new_armor = list(BURN = 10, BRAIN = 10, BRUTE = 30, TOX = 10)

/obj/item/clothing/suit/armor/ego_gear/zayin/nightshade
	name = "nightshade"
	desc = "It could hear all the meaningless words I have said and will say in the future and perfectly understand them."
	icon_state = "nightshade"
	new_armor = list(BURN = 10, BRAIN = 10, BRUTE = 30, TOX = 10)

/obj/item/clothing/suit/armor/ego_gear/zayin/hugs
	name = "hugs"
	desc = "Soft and squishy, you could hug it for days."
	icon_state = "hugs"
	new_armor = list(BURN = 10, BRAIN = 30, BRUTE = 10, TOX = 10)

/obj/item/clothing/suit/armor/ego_gear/zayin/letter_opener
	name = "letter opener"
	desc = "Liberty. Reason. Justice. Civility. Edification. Perfection. MAIL!"
	icon_state = "letter_opener"
	new_armor = list(BURN = 30, BRAIN = 10, BRUTE = 10, TOX = 10)

/obj/item/clothing/suit/armor/ego_gear/zayin/eclipse
	name = "eclipse of scarlet moths"
	desc = "A bright suit that brings you warmth."
	icon_state = "eclipse"
	new_armor = list(BURN = 10, BRAIN = 30, BRUTE = 10, TOX = 10)

/obj/item/clothing/suit/armor/ego_gear/zayin/oceanic
	name = "taste of the sea"
	desc = "A suit that's old and dyed crimson, and made of thin plastic."
	icon_state = "oceanic"
	new_armor = list(BURN = 30, BRAIN = 10, BRUTE = 10, TOX = 10)

/obj/item/clothing/suit/armor/ego_gear/zayin/dead_dream
	name = "dead dream"
	desc = "We guarantee cryopreservation is as safe as can be. The future is just one dream away."
	icon_state = "dead_dream"
	new_armor = list(BURN = 10, BRAIN = 30, BRUTE = 10, TOX = 10)

/obj/item/clothing/suit/armor/ego_gear/zayin/cord
	name = "cord"
	desc = "A suit that resembles a sweater.."
	icon_state = "cord"
	new_armor = list(BURN = 10, BRAIN = 30, BRUTE = 10, TOX = 10)



//This one will get messy.
//Anything Zwei related goes here. That's Zwei, Streetlight and anything else under Zwei.
//Base Zwei is Grade 6, Vet is Grade 5.

/obj/item/ego_weapon/city/zweihander
	name = "zweihander"
	desc = "A zweihander used by the zwei association."
	special = "Use in hand to buff your defense, and those of everyone around you."
	icon_state = "zwei"
	force = 55
	attack_speed = 7
	damtype = BRUTE
	swingstyle = WEAPONSWING_LARGESWEEP

	hitsound = 'sound/items/weapons/bladeslice.ogg'
	attack_verb_continuous = list("attacks", "slashes", "stabs", "slices", "tears", "lacerates", "rips", "dices", "cuts")
	attack_verb_simple = list("attack", "slash", "stab", "slice", "tear", "lacerate", "rip", "dice", "cut")
	var/ready = TRUE
	var/defense_buff_self = 0.5
	var/defense_buff_others = 0.8
	var/list/buffed_people = list()

/obj/item/ego_weapon/city/zweihander/attack_self(mob/living/carbon/human/user)
	..()
	if(!CanUseEgo(user))
		return

	if(!ready)
		return
	ready = FALSE
	user.Immobilize(3 SECONDS)
	to_chat(user, span_userdanger("HOLD THE LINE!"))

	playsound(src, 'sound/items/whistle/whistle.ogg', 50, TRUE)

//Vet Zwei
/obj/item/ego_weapon/city/zweihander/vet
	name = "veteran zweihander"
	desc = "A zweihander used by veterans of the zwei association."
	icon_state = "zwei_vet"
	force = 80
	defense_buff_self = 0.3

//Mini Zwei
/obj/item/ego_weapon/city/zweihander/knife
	name = "einhander"
	desc = "A shortsword used by some zwei personnel."
	icon_state = "zwei_mini"
	force = 32
	attack_speed = 6

//Noreqs for the ERT
/obj/item/ego_weapon/city/zweihander/noreq
	attribute_requirements = list()

/obj/item/ego_weapon/city/zweihander/vet/noreq
	attribute_requirements = list()

//the funny zwei baton
/obj/item/ego_weapon/city/zweibaton
	name = "zwei association baton"
	desc = "A riot club used by the zwei association."
	special = "Attack a human to stun them after a period of time."
	icon_state = "zwei_baton"
	inhand_icon_state = "zwei_baton"
	force = 40
	attack_speed = 7
	damtype = BRUTE

	attack_verb_continuous = list("bashes", "crushes")
	attack_verb_simple = list("bash", "crush")


/obj/item/ego_weapon/city/zweibaton/attack(mob/living/target, mob/living/carbon/human/user)
	..()
	if(!ishuman(target))
		return
	var/mob/living/carbon/human/T = target
	T.adjustStaminaLoss(force*2, TRUE, TRUE)

	SEND_SIGNAL(T, COMSIG_LIVING_MINOR_SHOCK)

	playsound(src, 'sound/items/weapons/egloves.ogg', 50, TRUE, -1)

/obj/item/ego_weapon/city/zweiwest
	name = "zwei knight greatsword"
	desc = "A bulky rectangular greatsword used by the zwei of the west."
	special = "If used at 2 range you will lunge fowards then block, if you fail to lunge you will hesitate."
	icon_state = "zweiwest"
	inhand_icon_state = "zweiwest"
	force = 50
	reach = 2
	attack_speed = 7
	damtype = BRUTE
	swingstyle = WEAPONSWING_LARGESWEEP
	var/defense_buff = 0.8

	hitsound = 'sound/items/weapons/bladeslice.ogg'
	attack_verb_continuous = list("attacks", "slashes", "slices", "tears", "lacerates", "rips", "dices", "cuts")
	attack_verb_simple = list("attack", "slash", "slice", "tear", "lacerate", "rip", "dice", "cut")

/obj/item/ego_weapon/city/zweiwest/attack(mob/living/target, mob/living/carbon/human/user)
	..()
	if(!CanUseEgo(user))
		return
	if(target.stat == DEAD)
		return

	if(get_dist(target, user) < 2)//You need to use your range to trigger the guard
		return

	var/dodgelanding
	if(user.dir == 1)
		dodgelanding = locate(user.x, user.y + 1, user.z)
	if(user.dir == 2)
		dodgelanding = locate(user.x, user.y - 1, user.z)
	if(user.dir == 4)
		dodgelanding = locate(user.x + 1, user.y, user.z)
	if(user.dir == 8)
		dodgelanding = locate(user.x - 1, user.y, user.z)
	user.throw_at(dodgelanding, 1, 1, spin = FALSE)

	if(isliving(target))
		if(get_dist(target, user) > 1)//If you try to use the greatsword like a spear you deserve this
			user.changeNext_move(CLICK_CD_MELEE * 2)
			user.Knockdown(2 SECONDS)
			var/obj/item/held = user.get_active_held_item()
			user.dropItemToGround(held)
			to_chat(user, span_userdanger("Your swing is too wide leading you to lose your balance!"))
			return

	if(!isliving(target))
		return

	user.Immobilize(2 SECONDS)
	user.changeNext_move(CLICK_CD_MELEE * 0.15)
	to_chat(user, span_userdanger("You slam your greatsword onto the ground!"))
	user.say("Greatsword Guard!")

	playsound(src, 'tff_modular/modules/evento_needo/sounds/Tegusounds/weapons/ego/shield1.ogg', 50, TRUE)

	addtimer(CALLBACK(src, PROC_REF(Return), user), 2 SECONDS)

/obj/item/ego_weapon/city/zweiwest/proc/Return(mob/living/carbon/human/user)
	to_chat(user, span_notice("You raise your greatsword once more!"))

/obj/item/ego_weapon/city/zweiwest/vet
	name = "veteran zwei knight greatsword"
	desc = "A bulky rectangular greatsword used by the veterans of the zwei of the west."
	icon_state = "zweiwest_fat"
	inhand_icon_state = "zweiwest_fat"
	force = 72
	defense_buff = 0.5

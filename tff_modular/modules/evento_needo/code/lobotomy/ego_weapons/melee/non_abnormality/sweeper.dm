//Regular is Grade 7, rest are grade 5
/obj/item/ego_weapon/city/sweeper
	name = "sweeper hook"
	desc = "A hook cut off a sweeper. When night comes in the backstreets..."
	special = "Attack dead bodies to heal."
	icon_state = "sweeper_hook"
	force = 27
	damtype = BRUTE

	attack_verb_continuous = list("stabs")
	attack_verb_simple = list("stab")
	hitsound = 'tff_modular/modules/evento_needo/sounds/Tegusounds/ordeals/indigo/stab_1.ogg'

/obj/item/ego_weapon/city/sweeper/attack(mob/living/target, mob/living/carbon/human/user)
	if(!CanUseEgo(user))
		return
	..()
	if((target.stat == DEAD))
		target.gib()
		user.adjustBruteLoss(-user.maxHealth * 0.1)	//Heal 10% HP

/obj/item/ego_weapon/city/sweeper/sickle
	name = "sweeper_sickle"
	desc = "A sickle cut off a sweeper captain. When night comes in the backstreets..."
	icon_state = "sweeper_sickle"
	force = 37

/obj/item/ego_weapon/city/sweeper/hooksword
	name = "sweeper hooksword"
	desc = "A hooksword cut off a sweeper captain. When night comes in the backstreets..."
	icon_state = "sweeper_hooksword"
	force = 55
	attack_speed = 6.5

/obj/item/ego_weapon/city/sweeper/claw
	name = "sweeper claw"
	desc = "A claw cut off a sweeper captain. When night comes in the backstreets..."
	icon_state = "sweeper_claw"
	force = 24
	attack_speed = CLICK_CD_RAPID

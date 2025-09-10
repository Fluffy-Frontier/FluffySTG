//Bottom tier of the syndicate workshop, still very good.

/obj/item/ego_weapon/city/district23
	name = "district 23 butcher knife"
	desc = "A cleaver found in the backstreets of district 23. This one is rusted, but still performs it's functions."
	special = "This weapon heals you on hit."
	icon_state = "jack"
	force = 28
	attack_speed = 2
	swingstyle = WEAPONSWING_LARGESWEEP
	damtype = BRUTE

	attack_verb_continuous = list("cleavess", "cuts")
	attack_verb_simple = list("slash", "slice", "rip", "cut")
	hitsound = 'sound/items/weapons/guillotine.ogg'

/obj/item/ego_weapon/city/district23/attack(mob/living/target, mob/living/carbon/human/user)
	if(!CanUseEgo(user))
		return
	if(!(HAS_TRAIT(target, TRAIT_GODMODE)) && target.stat != DEAD)
		var/heal_amt = force*0.2
		user.adjustBruteLoss(-heal_amt)
	..()

/obj/item/ego_weapon/city/district23/pierre
	name = "district 23 carving knife"
	desc = "A carving knife found in the backstreets of district 23. This one is rusted, and seems to require a bit of skill to wield.."
	icon_state = "pierre"
	force = 24
	attack_speed = 1
	attack_verb_continuous = list("slashes", "slices", "rips", "cuts")
	attack_verb_simple = list("slash", "slice", "rip", "cut")
	hitsound = 'sound/items/weapons/bladeslice.ogg'

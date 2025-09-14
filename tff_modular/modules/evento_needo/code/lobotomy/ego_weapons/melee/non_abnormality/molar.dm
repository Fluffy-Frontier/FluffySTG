//Grade 4-5 Weapons, heal sanity on kill
/obj/item/ego_weapon/city/molar
	name = "molar chainsword"
	desc = "A chainsword used by the Molar Office. It's heavy, and well made."
	special = "On kill, heal 30 sanity."
	icon_state = "mika"
	force = 44
	damtype = BRUTE

	attack_verb_continuous = list("slices", "saws", "rips")
	attack_verb_simple = list("slice", "saw", "rip")
	hitsound = 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/helper/attack.ogg'

/obj/item/ego_weapon/city/molar/attack(mob/living/target, mob/living/carbon/human/user)
	var/living = FALSE
	if(!CanUseEgo(user))
		return
	if(target.stat != DEAD)
		living = TRUE
	..()
	if(target.stat == DEAD && living)
		user.adjustSanityLoss(-30)
		living = FALSE

/obj/item/ego_weapon/city/molar/olga
	name = "molar chainknife"
	desc = "A short chainsword used by the Molar Office's leader. Its chain sings with the speed it moves at."
	icon_state = "olga"
	force = 37
	attack_speed = CLICK_CD_RAPID
	swingstyle = WEAPONSWING_LARGESWEEP

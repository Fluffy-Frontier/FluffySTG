//Wedge - Grade 4 with two range.
/obj/item/ego_weapon/city/wedge
	name = "wedge office spear"
	desc = "A black, ornate spear. Some say it pierces any weakness... Though that may just be what the office who used these says."
	icon_state = "wedge"
	force = 74
	reach = 2		//Has 2 Square Reach.
	attack_speed = 6
	stuntime = 5
	damtype = BRUTE

	attack_verb_continuous = list("pokes", "jabs", "tears", "lacerates", "gores")
	attack_verb_simple = list("poke", "jab", "tear", "lacerate", "gore")
	hitsound = 'tff_modular/modules/evento_needo/sounds/Tegusounds/weapons/ego/spear1.ogg'

/obj/item/ego_weapon/city/fixerblade
	name = "fixer blade"
	desc = "A common fixer blade, mass-produced and easy to use."
	icon_state = "fixer_blade"
	force = 20
	damtype = BRUTE

	hitsound = 'sound/items/weapons/bladeslice.ogg'
	attack_verb_continuous = list("attacks", "slashes", "stabs", "slices", "tears", "lacerates", "rips", "dices", "cuts")
	attack_verb_simple = list("attack", "slash", "stab", "slice", "tear", "lacerate", "rip", "dice", "cut")
	swingstyle = WEAPONSWING_LARGESWEEP

/obj/item/ego_weapon/city/fixergreatsword
	name = "fixer greatsword"
	desc = "A heftier variant of the more common fixer blade."
	icon_state = "fixer_greatsword"
	force = 36
	attack_speed = 7
	damtype = BRUTE

	hitsound = 'sound/items/weapons/genhit3.ogg'
	attack_verb_continuous = list("attacks", "slashes", "stabs", "slices", "tears", "lacerates", "rips", "dices", "cuts")
	attack_verb_simple = list("attack", "slash", "stab", "slice", "tear", "lacerate", "rip", "dice", "cut")
	swingstyle = WEAPONSWING_LARGESWEEP

/obj/item/ego_weapon/city/fixerhammer
	name = "fixer hammer"
	desc = "A poorly balanced hammer used by many fixers."
	icon_state = "fixer_hammer"
	force = 32
	attack_speed = CLICK_CD_MELEE
	damtype = BRUTE

	attack_verb_continuous = list("bashes", "clubs")
	attack_verb_simple = list("bashes", "clubs")
	hitsound = 'tff_modular/modules/evento_needo/sounds/Tegusounds/weapons/fixer/generic/club1.ogg'

/obj/item/ego_weapon/city/fixerpen
	name = "fixer pen"
	desc = "Mightier than the sword."
	icon = 'icons/obj/service/bureaucracy.dmi'
	icon_state = "pen"
	force = 0
	attack_speed = CLICK_CD_RAPID
	damtype = BRUTE

	attack_verb_continuous = list("pokes", "jabs", "tears", "lacerates", "gores")
	attack_verb_simple = list("poke", "jab", "tear", "lacerate", "gore")
	hitsound = 'tff_modular/modules/evento_needo/sounds/Tegusounds/weapons/ego/spear1.ogg'
	var/mode = 0

/obj/item/ego_weapon/city/fixerpen/attack_self(mob/living/user)
	playsound(user, mode ? 'sound/items/weapons/magin.ogg' : 'sound/items/weapons/magout.ogg', 40, TRUE)
	if(mode == 0)
		mode = 1
		force = 21
		icon = 'tff_modular/modules/evento_needo/icons/Teguicons/lc13_weapons.dmi'
		return
	mode = 0
	force = initial(force)
	icon = initial(icon)

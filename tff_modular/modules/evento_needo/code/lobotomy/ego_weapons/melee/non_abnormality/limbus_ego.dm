//Sinner EGO - WAW
/obj/item/ego_weapon/lance/sangre
	name = "le sangre de sancho"
	desc = "Ride on, Rocinante!"
	icon_state = "sangre"
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/limbus_weapons.dmi'
	lefthand_file = 'tff_modular/modules/evento_needo/icons/Teguicons/96x96_lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/icons/Teguicons/96x96_righthand.dmi'
	inhand_x_dimension = 96
	inhand_y_dimension = 96
	force = 70
	reach = 2 //Has 2 Square Reach.
	stuntime = 5
	attack_speed = CLICK_CD_MELEE // really slow
	damtype = BRUTE

	attack_verb_continuous = list("bludgeons", "whacks")
	attack_verb_simple = list("bludgeon", "whack")
	hitsound = 'tff_modular/modules/evento_needo/sounds/Tegusounds/weapons/fixer/generic/spear3.ogg'
	couch_cooldown_time = 4 SECONDS
	force_cap = 90
	force_per_tile = 5
	speed_per_tile = 0.3
	pierce_threshold = 0.8
	pierce_speed_cost = 1.0
	pierce_force_cost = 15

/obj/item/ego_weapon/lance/sangre/attack(mob/living/target, mob/living/carbon/human/user)
	if(!CanUseEgo(user))
		return
	if(!(HAS_TRAIT(target, TRAIT_GODMODE)) && target.stat != DEAD)
		var/heal_amt = force*0.10
		user.adjustBruteLoss(-heal_amt)
		..()

/obj/item/ego_weapon/mini/crow
	name = "Crow's Eye View"
	desc = "Now, break this birdcage... and fly free."
	special = "This weapon attacks very fast. Attacking with this weapon from a distance will make you rush towards your target."
	icon_state = "crow"
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/limbus_weapons.dmi'
	inhand_icon_state = "shiv"
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	force = 24
	attack_speed = CLICK_CD_RAPID //this shit goes FAST
	swingstyle = WEAPONSWING_LARGESWEEP
	damtype = BRUTE
	attack_verb_continuous = list("stabs", "slices", "rips", "shanks")
	attack_verb_simple = list("stab", "slice", "rip", "shank")
	var/dash_range = 7 //7 tile dash range.

/obj/item/ego_weapon/mini/crow/afterattack(atom/A, mob/living/user, proximity_flag, params)
	if(!CanUseEgo(user))
		return
	if(!isliving(A))
		return
	if((!(can_see(user, A, dash_range))))
		to_chat(user, span_warning("You cannot see your target."))
		return
	if(get_dist(user, A) < 2)
		return
	..()
	for(var/i in 2 to get_dist(user, A))
		step_towards(user,A)
	if((get_dist(user, A) < 2))
		A.attackby(src,user)
	playsound(get_turf(src), 'sound/items/weapons/fwoosh.ogg', 300, FALSE, 9)
	to_chat(user, span_warning("You dash to [A]!"))

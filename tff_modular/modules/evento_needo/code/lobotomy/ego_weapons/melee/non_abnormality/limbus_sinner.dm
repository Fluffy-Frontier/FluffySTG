//Sinner weapons - TETH
/obj/item/ego_weapon/mini/hayong
	name = "ha yong"
	desc = "Have you heard of the taxidermied genius?"
	special = "This weapon attacks very fast. Use this weapon in hand to dodgeroll."
	icon_state = "hayong"
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/limbus_weapons.dmi'
	lefthand_file = 'tff_modular/modules/evento_needo/icons/Teguicons/limbus_lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/icons/Teguicons/limbus_righthand.dmi'
	force = 7
	attack_speed = 6
	damtype = BRUTE
	hitsound = 'sound/items/weapons/bladeslice.ogg'
	var/dodgelanding

/obj/item/ego_weapon/mini/hayong/attack_self(mob/living/carbon/user)
	if(user.dir == 1)
		dodgelanding = locate(user.x, user.y + 5, user.z)
	if(user.dir == 2)
		dodgelanding = locate(user.x, user.y - 5, user.z)
	if(user.dir == 4)
		dodgelanding = locate(user.x + 5, user.y, user.z)
	if(user.dir == 8)
		dodgelanding = locate(user.x - 5, user.y, user.z)
	user.adjustStaminaLoss(20, TRUE, TRUE)
	user.throw_at(dodgelanding, 3, 2, spin = TRUE)

/obj/item/ego_weapon/shield/walpurgisnacht
	name = "walpurgisnacht"
	desc = "Man errs so long as he strives."
	icon_state = "walpurgisnacht"
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/limbus_weapons.dmi'
	lefthand_file = 'tff_modular/modules/evento_needo/icons/Teguicons/limbus_lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/icons/Teguicons/limbus_righthand.dmi'
	force = 33
	attack_speed = 6.5
	damtype = BRUTE
	swingstyle = WEAPONSWING_LARGESWEEP

	attack_verb_continuous = list("cuts", "smacks", "bashes")
	attack_verb_simple = list("cuts", "smacks", "bashes")
	hitsound = 'sound/items/weapons/bladeslice.ogg'
	reductions = list(20, 30, 10, 0) // 60
	projectile_block_duration = 1 SECONDS
	block_duration = 1 SECONDS
	block_cooldown = 3 SECONDS
	block_sound = 'tff_modular/modules/evento_needo/sounds/Tegusounds/weapons/ego/clash1.ogg'
	projectile_block_message = "You swat the projectile out of the air!"
	block_message = "You attempt to parry the attack!"
	hit_message = "parries the attack!"
	block_cooldown_message = "You rearm your blade."

/obj/item/ego_weapon/lance/suenoimpossible
	name = "sueno impossible"
	desc = "To reach the unreachable star!"
	icon_state = "sueno_impossible"
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/limbus_weapons.dmi'
	lefthand_file = 'tff_modular/modules/evento_needo/icons/Teguicons/96x96_lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/icons/Teguicons/96x96_righthand.dmi'
	inhand_x_dimension = 96
	inhand_y_dimension = 96
	force = 38
	reach = 2		//Has 2 Square Reach.
	stuntime = 5
	attack_speed = 6.5// really slow
	damtype = BRUTE

	attack_verb_continuous = list("bludgeons", "whacks")
	attack_verb_simple = list("bludgeon", "whack")
	hitsound = 'tff_modular/modules/evento_needo/sounds/Tegusounds/weapons/fixer/generic/spear2.ogg'

/obj/item/ego_weapon/shield/sangria
	name = "S.A.N.G.R.I.A"
	desc = "Succinct abbreviation naturally germinates rather immaculate art."
	icon_state = "sangria"
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/limbus_weapons.dmi'
	lefthand_file = 'tff_modular/modules/evento_needo/icons/Teguicons/limbus_lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/icons/Teguicons/limbus_righthand.dmi'
	hitsound = 'sound/items/weapons/bladeslice.ogg'
	force = 12
	attack_speed = CLICK_CD_RAPID
	damtype = BRUTE
	swingstyle = WEAPONSWING_LARGESWEEP

	attack_verb_continuous = list("pokes", "jabs", "tears", "lacerates", "gores")
	attack_verb_simple = list("poke", "jab", "tear", "lacerate", "gore")
	reductions = list(20, 20, 20, 0) // 60 - Diet Diet Daredevil
	projectile_block_duration = 0 SECONDS //No ranged parry
	block_duration = 0.5 SECONDS
	block_cooldown = 3 SECONDS
	block_sound = 'sound/items/weapons/parry.ogg'
	block_message = "You attempt to parry the attack!"
	hit_message = "parries the attack!"
	block_cooldown_message = "You rearm your blade."

/obj/item/ego_weapon/shield/sangria/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK)
	return 0 //Prevents ranged  parry

/obj/item/ego_weapon/mini/soleil
	name = "soleil"
	desc = "Today I killed my mother, or maybe it was yesterday?"
	icon_state = "soleil"
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/limbus_weapons.dmi'
	lefthand_file = 'tff_modular/modules/evento_needo/icons/Teguicons/limbus_lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/icons/Teguicons/limbus_righthand.dmi'
	force = 11
	attack_speed = CLICK_CD_RAPID
	damtype = BRUTE


/obj/item/ego_weapon/taixuhuanjing
	name = "tai xuhuan jing"
	desc = "Jade has its flaws, and life its vicissitudes."
	icon_state = "tai_xuhuan_jing"
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/limbus_weapons.dmi'
	lefthand_file = 'tff_modular/modules/evento_needo/icons/Teguicons/limbus_lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/icons/Teguicons/limbus_righthand.dmi'
	force = 22
	reach = 2		//Has 2 Square Reach.
	attack_speed = CLICK_CD_MELEE
	damtype = BRUTE

	attack_verb_continuous = list("pokes", "jabs", "tears", "lacerates", "gores")
	attack_verb_simple = list("poke", "jab", "tear", "lacerate", "gore")
	hitsound = 'tff_modular/modules/evento_needo/sounds/Tegusounds/weapons/ego/sword1.ogg'

/obj/item/ego_weapon/revenge
	name = "revenge"
	desc = "I have not broken your heart - YOU have; and in breaking it, you have broken mine."
	icon_state = "revenge"
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/limbus_weapons.dmi'
	lefthand_file = 'tff_modular/modules/evento_needo/icons/Teguicons/limbus_lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/icons/Teguicons/limbus_righthand.dmi'
	force = 35
	attack_speed = 6.5
	damtype = BRUTE

	attack_verb_continuous = list("beats", "smacks")
	attack_verb_simple = list("beat", "smack")

/obj/item/ego_weapon/revenge/attack(mob/living/target, mob/living/user)
	. = ..()
	if(!.)
		return FALSE
	var/atom/throw_target = get_edge_target_turf(target, user.dir)
	if(!target.anchored)
		var/whack_speed = (prob(60) ? 1 : 4)
		target.throw_at(throw_target, rand(1, 2), whack_speed, user)

/obj/item/ego_weapon/mini/hearse
	name = "hearse"
	desc = "That bastard's still alive out there..."
	icon_state = "hearse"
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/limbus_weapons.dmi'
	lefthand_file = 'tff_modular/modules/evento_needo/icons/Teguicons/limbus_lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/icons/Teguicons/limbus_righthand.dmi'
	force = 33				//Lots of damage, way less DPS
	damtype = BRUTE

	attack_speed = 7 // Really Slow
	attack_verb_continuous = list("smashes", "bludgeons", "crushes")
	attack_verb_simple = list("smash", "bludgeon", "crush")

/obj/item/ego_weapon/shield/hearse
	name = "hearse"
	desc = "Call me Ishmael."
	special = "This weapon has a slow attack speed and deals atrocious damage."
	icon_state = "hearse_shield"
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/limbus_weapons.dmi'
	lefthand_file = 'tff_modular/modules/evento_needo/icons/Teguicons/limbus_lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/icons/Teguicons/limbus_righthand.dmi'
	force = 40
	damtype = BRUTE

	attack_verb_continuous = list("shoves", "bashes")
	attack_verb_simple = list("shove", "bash")
	hitsound = 'sound/items/weapons/genhit2.ogg'
	reductions = list(40, 20, 30, 0) // 90
	projectile_block_duration = 3 SECONDS
	block_duration = 3 SECONDS
	block_cooldown = 3 SECONDS
	block_sound_volume = 30

/obj/item/ego_weapon/raskolot //horn but a boomerang
	name = "raskolot"
	desc = "If only she could forget everything and begin afresh."
	icon_state = "raskolot"
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/limbus_weapons.dmi'
	lefthand_file = 'tff_modular/modules/evento_needo/icons/Teguicons/limbus_lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/icons/Teguicons/limbus_righthand.dmi'
	force = 22
	throwforce = 50
	throw_speed = 1
	throw_range = 7
	damtype = BRUTE

	hitsound = 'tff_modular/modules/evento_needo/sounds/Tegusounds/weapons/ego/axe2.ogg'

/obj/item/ego_weapon/raskolot/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	var/caught = hit_atom.hitby(src, FALSE, FALSE, throwingdatum=throwingdatum)
	if(hit_atom && !caught)
		addtimer(CALLBACK(src, TYPE_PROC_REF(/atom/movable, throw_at), hit_atom, throw_range+2, throw_speed, null, TRUE), 1)
	if(caught)
		return
	else
		return ..()

/obj/item/ego_weapon/vogel
	name = "vogel"
	desc = "The world of evil had begun there, right in the middle of our house."
	icon_state = "vogel"
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/limbus_weapons.dmi'
	lefthand_file = 'tff_modular/modules/evento_needo/icons/Teguicons/limbus_lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/icons/Teguicons/limbus_righthand.dmi'
	force = 22
	reach = 2		//Has 2 Square Reach.
	attack_speed = CLICK_CD_MELEE
	damtype = BRUTE

	attack_verb_continuous = list("pokes", "jabs", "tears", "lacerates", "gores")
	attack_verb_simple = list("poke", "jab", "tear", "lacerate", "gore")
	hitsound = 'tff_modular/modules/evento_needo/sounds/Tegusounds/weapons/ego/axe2.ogg'

/obj/item/ego_weapon/nobody
	name = "nobody"
	desc = "I am nothing at all."
	special = "This E.G.O. functions as both a gun and a melee weapon."
	icon_state = "nobody"
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/limbus_weapons.dmi'
	lefthand_file = 'tff_modular/modules/evento_needo/icons/Teguicons/limbus_lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/icons/Teguicons/limbus_righthand.dmi'
	force = 19
	damtype = BRUTE
	swingstyle = WEAPONSWING_LARGESWEEP

	attack_speed = CLICK_CD_MELEE
	attack_verb_continuous = list("cuts", "slices")
	attack_verb_simple = list("cuts", "slices")
	hitsound = 'tff_modular/modules/evento_needo/sounds/Tegusounds/weapons/ego/sword2.ogg'

	var/gun_cooldown
	var/blademark_cooldown
	var/gunmark_cooldown
	var/gun_cooldown_time = 1.2 SECONDS

/obj/item/ego_weapon/nobody/Initialize()
	RegisterSignal(src, COMSIG_PROJECTILE_ON_HIT, PROC_REF(on_projectile_hit))
	return ..()

/obj/item/ego_weapon/nobody/afterattack(atom/target, mob/living/user, proximity_flag, clickparams)
	if(!CanUseEgo(user))
		return
	if(!proximity_flag && gun_cooldown <= world.time)
		var/turf/proj_turf = user.loc
		if(!isturf(proj_turf))
			return
		var/obj/projectile/ego_bullet/nobody/G = new /obj/projectile/ego_bullet/nobody(proj_turf)
		G.fired_from = src //for signal check
		playsound(user, 'sound/items/weapons/gun/shotgun/shot_alt.ogg', 100, TRUE)
		G.firer = user
		G.set_angle(get_angle(user, target))
		G.fire()
		gun_cooldown = world.time + gun_cooldown_time
		return

/obj/item/ego_weapon/nobody/proc/on_projectile_hit(atom/fired_from, atom/movable/firer, atom/target, Angle)
	SIGNAL_HANDLER
	return TRUE

/obj/projectile/ego_bullet/nobody
	name = "gunblade bullet"
	damage = 20
	damage_type = BRUTE


/obj/item/ego_weapon/ungezifer
	name = "ungezifer"
	desc = "As I awoke one morning from uneasy dreams I found myself transformed in my bed into a gigantic insect."
	icon_state = "ungezifer"
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/limbus_weapons.dmi'
	lefthand_file = 'tff_modular/modules/evento_needo/icons/Teguicons/limbus_lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/icons/Teguicons/limbus_righthand.dmi'
	force = 38				//Lots of damage, way less DPS
	damtype = BRUTE

	attack_speed = 7 // Really Slow
	attack_verb_continuous = list("smashes", "bludgeons", "crushes")
	attack_verb_simple = list("smash", "bludgeon", "crush")
	hitsound = 'tff_modular/modules/evento_needo/sounds/Tegusounds/weapons/ego/justitia2.ogg'

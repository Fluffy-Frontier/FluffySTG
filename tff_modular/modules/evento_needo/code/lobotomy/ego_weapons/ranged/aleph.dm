#define SHOT_MODE 0
#define DOT_MODE 1
#define AOE_MODE 2

/obj/item/ego_weapon/ranged/star
	name = "sound of a star"
	desc = "The star shines brighter as our despair gathers. The weapon's small, evocative sphere fires a warm ray."
	icon_state = "star"
	inhand_icon_state = "star"
	special = "This gun scales with remaining SP."

	force = 33
	damtype = BRUTE
	attack_speed = CLICK_CD_RAPID

	projectile_path = /obj/projectile/ego_bullet/star
	weapon_weight = WEAPON_HEAVY
	spread = 5

	autofire = 0.25 SECONDS
	shotsleft = 333
	reloadtime = 2.1 SECONDS

	fire_sound = 'tff_modular/modules/evento_needo/sounds/Tegusounds/weapons/ego/star.ogg'
	vary_fire_sound = TRUE
	fire_sound_volume = 25

/obj/item/ego_weapon/ranged/star/fire_projectile(atom/target, mob/living/user, params, distro, quiet, zone_override, spread, atom/fired_from, temporary_damage_multiplier)
	if(!ishuman(user))
		return ..()

	var/mob/living/carbon/human/H = user
	temporary_damage_multiplier = 1 + (H.sanityhealth / H.maxSanity * 0.5) // Maximum SP will add 50% to the damage
	return ..()

/obj/item/ego_weapon/ranged/star/suicide_act(mob/living/carbon/user)
	. = ..()
	user.visible_message(span_suicide("[user]'s legs distort and face opposite directions, as [user.p_their()] torso seems to pulsate! It looks like [user.p_theyre()] trying to commit suicide!"))
	playsound(src, 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/bluestar/pulse.ogg', 50, FALSE, 40, falloff_distance = 10)
	user.unequip_everything()
	QDEL_IN(user, 1)
	return MANUAL_SUICIDE

/obj/item/ego_weapon/ranged/adoration
	name = "adoration"
	desc = "A big mug filled with mysterious slime that never runs out. \
	It’s the byproduct of some horrid experiment in a certain laboratory that eventually failed."
	icon_state = "adoration"
	inhand_icon_state = "adoration"
	special = "Use in hand to swap between AOE, DOT and shotgun modes."

	force = 56
	damtype = BRUTE

	projectile_path = /obj/projectile/ego_bullet/adoration
	weapon_weight = WEAPON_HEAVY
	fire_delay = 10
	pellets = 3
	variance = 20

	fire_sound = 'sound/effects/blob/attackblob.ogg'
	fire_sound_volume = 50


	var/mode = 0

/obj/item/ego_weapon/ranged/adoration/attack_self(mob/user)
	. = ..()
	switch(mode)
		if(SHOT_MODE)
			to_chat(user,"<span class='warning'>You focus, changing for a DOT blast</span>")
			projectile_path = /obj/projectile/ego_bullet/adoration/dot
			pellets = 1
			variance = 0
			mode = DOT_MODE
			return
		if(DOT_MODE)
			to_chat(user,"<span class='warning'>You focus, changing for an AOE blast</span>")
			projectile_path = /obj/projectile/ego_bullet/adoration/aoe
			mode = AOE_MODE
			return
		if(AOE_MODE)
			to_chat(user,"<span class='warning'>You focus, changing for a shotgun blast</span>")
			projectile_path = /obj/projectile/ego_bullet/adoration
			pellets = initial(pellets)
			variance = initial(variance)
			mode = SHOT_MODE
			return

#undef SHOT_MODE
#undef DOT_MODE
#undef AOE_MODE

/obj/item/ego_weapon/ranged/nihil
	name = "nihil"
	desc = "Having decided to trust its own intuition, the jester spake the names of everyone it had met on that path with each step it took."
	icon_state = "nihil"
	inhand_icon_state = "nihil"
	force = 56
	damtype = BRUTE
	projectile_path = /obj/projectile/ego_bullet/nihil
	weapon_weight = WEAPON_HEAVY
	pellets = 4
	variance = 20
	fire_sound = 'tff_modular/modules/evento_needo/sounds/Tegusounds/weapons/fixer/generic/energy1.ogg'
	fire_sound_volume = 50
	fire_delay = 10

	var/wrath
	var/despair
	var/greed
	var/hate
	var/list/powers = list("hatred", "despair", "greed", "wrath")

/obj/item/ego_weapon/ranged/nihil/attackby(obj/item/I, mob/living/user, params)
	. = ..()
	if(!istype(I, /obj/item/nihil))
		return

	if(powers[1] == "hatred" && istype(I, /obj/item/nihil/heart))
		powers[1] = "hearts"
		force += 7
		qdel(I)
	else if(powers[2] == "despair" && istype(I, /obj/item/nihil/spade))
		powers[2] = "spades"
		fire_delay -= 5
		qdel(I)
	else if(powers[3] == "greed" && istype(I, /obj/item/nihil/diamond))
		powers[3] = "diamonds"
		weapon_weight = WEAPON_MEDIUM
		qdel(I)
	else if(powers[4] == "wrath" && istype(I, /obj/item/nihil/club))
		powers[4]= "clubs"
		force += 7
		qdel(I)
	else
		to_chat(user,"<span class='warning'>You have already used this upgrade!</span>")

/obj/item/ego_weapon/ranged/pink
	name = "pink"
	desc = "Pink is considered to be the color of warmth and love, but is that true? \
			Can guns really bring peace and love?"
	icon_state = "pink"
	inhand_icon_state = "pink"
	special = "This weapon has a scope, and fires projectiles with zero travel time. Damage dealt is increased when hitting targets further away. Middle mouse button click/alt click to zoom in that direction."
	force = 56
	damtype = BRUTE
	projectile_path = /obj/projectile/ego_bullet/pink
	weapon_weight = WEAPON_HEAVY
	fire_sound = 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/armyinblack/pink.ogg'
	fire_delay = 9
	zoomable = TRUE
	zoom_amt = 10
	zoom_out_amt = 13
	shotsleft = 5
	reloadtime = 2.1 SECONDS

	var/mob/current_holder

///obj/item/ego_weapon/ranged/pink/zoom(mob/living/user, direc, forced_zoom)
//	if(!CanUseEgo(user))
//		return
//	if(!user || !user.client)
//		return
//	if(isnull(forced_zoom))
//		zoomed = !zoomed
//	else
//		zoomed = forced_zoom
//	if(src != user.get_active_held_item())
//		if(!zoomed)
//			UnregisterSignal(user, COMSIG_MOVABLE_MOVED)
//			UnregisterSignal(user, COMSIG_ATOM_DIR_CHANGE)
//			user.client.view_size.zoomIn()
//		return
//	if(!zoomed)
//		UnregisterSignal(user, COMSIG_MOVABLE_MOVED)
//		UnregisterSignal(user, COMSIG_ATOM_DIR_CHANGE)
//		user.client.view_size.zoomIn()
//	else
//		RegisterSignal(user, COMSIG_ATOM_DIR_CHANGE, PROC_REF(rotate))
//		RegisterSignal(user, COMSIG_MOVABLE_MOVED, PROC_REF(UserMoved))
//		user.client.view_size.zoomOut(zoom_out_amt, zoom_amt, direc)
//	return zoomed
//
///obj/item/ego_weapon/ranged/pink/proc/UserMoved(mob/living/user, direc)
//	SIGNAL_HANDLER
//	zoom(user)//disengage

/obj/item/ego_weapon/ranged/pink/Destroy(mob/user)//FIXME: causes component runtimes
	if(!user)
		return ..()
	//if(zoomed)
	//	UnregisterSignal(current_holder, COMSIG_MOVABLE_MOVED)
	//	UnregisterSignal(current_holder, COMSIG_ATOM_DIR_CHANGE)
	//	current_holder = null
	//	return ..()

/obj/item/ego_weapon/ranged/pink/dropped(mob/user)
	. = ..()
	if(!user)
		return
	//if(zoomed)
	//	UnregisterSignal(current_holder, COMSIG_MOVABLE_MOVED)
	//	UnregisterSignal(current_holder, COMSIG_ATOM_DIR_CHANGE)
	//	current_holder = null

/obj/item/ego_weapon/ranged/arcadia
	name = "Et in Arcadia Ego"
	desc = "With the waxing of the sun, humanity wanes."
	icon_state = "arcadia"
	inhand_icon_state = "arcadia"
	special = "Use in hand to load bullets."
	force = 56
	projectile_path = /obj/projectile/ego_bullet/arcadia
	weapon_weight = WEAPON_HEAVY
	spread = 5
	recoil = 1.5
	fire_sound = 'sound/items/weapons/gun/rifle/shot.ogg'
	vary_fire_sound = TRUE
	fire_sound_volume = 30
	fire_delay = 7

	shotsleft = 16	//Based off a henry .44
	reloadtime = 0.5 SECONDS

/obj/item/ego_weapon/ranged/arcadia/reload_ego(mob/user)
	if(shotsleft == initial(shotsleft))
		return
	is_reloading = TRUE
	to_chat(user,"<span class='notice'>You start loading a bullet.</span>")
	if(do_after(user, reloadtime, src)) //gotta reload
		playsound(src, 'sound/items/weapons/gun/general/slide_lock_1.ogg', 50, TRUE)
		shotsleft +=1
	is_reloading = FALSE

/obj/item/ego_weapon/ranged/arcadia/judge
	name = "Judge"
	desc = "You will be judged; as I have."
	icon_state = "judge"
	inhand_icon_state = "judge"
	force = 56
	damtype = BRUTE
	weapon_weight = WEAPON_MEDIUM	//Cannot be dual wielded
	recoil = 2
	fire_sound_volume = 30
	fire_delay = 3	//FAN THE HAMMER

	shotsleft = 6	//Based off a colt Single Action Navy
	reloadtime = 1 SECONDS


/obj/item/ego_weapon/ranged/havana
	name = "havana"
	desc = "Within it's simple design lies a lot of struggle"
	icon_state = "havana"
	inhand_icon_state = "havana"
	force = 20
	damtype = BRUTE
	projectile_path = /obj/projectile/ego_bullet/ego_hookah
	weapon_weight = WEAPON_HEAVY
	spread = 20
	fire_sound = 'sound/effects/smoke.ogg'
	autofire = 0.04 SECONDS
	fire_sound_volume = 5

	shotsleft = 200

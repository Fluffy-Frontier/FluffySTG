
//эдит code\modules\projectiles\guns\ballistic\shotguns.dmi
// Bulldog shotgun //

/obj/item/gun/ballistic/shotgun/bulldog
	name = "\improper Bulldog Shotgun"
	desc = "A 2-round burst fire, mag-fed shotgun for combat in narrow corridors, \
		nicknamed 'Bulldog' by boarding parties. Compatible only with specialized 8-round drum magazines. \
		Can have a secondary magazine attached to quickly swap between ammo types, or just to keep shooting."
	icon_state = "bulldog"
	lefthand_file = 'icons/mob/inhands/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/guns_righthand.dmi'
	inhand_icon_state = "bulldog"
	worn_icon = 'icons/mob/clothing/back.dmi'
	worn_icon_state = "bulldog"
	inhand_x_dimension = 32
	inhand_y_dimension = 32
	projectile_damage_multiplier = 1.2
	weapon_weight = WEAPON_MEDIUM
	accepted_magazine_type = /obj/item/ammo_box/magazine/m12g
	can_suppress = FALSE
	burst_size = 2
	fire_delay = 3 //NOVA EDIT - Original: 0 // FF EDIT 3. NOVA VALUE: 10
	pin = /obj/item/firing_pin/implant/pindicate
	fire_sound = 'sound/items/weapons/gun/shotgun/shot_alt.ogg'
	actions_types = list(/datum/action/item_action/toggle_firemode)
	mag_display = TRUE
	empty_indicator = TRUE
	empty_alarm = TRUE
	special_mags = TRUE
	mag_display_ammo = TRUE
	semi_auto = TRUE
	internal_magazine = FALSE
	tac_reloads = TRUE
	burst_fire_selection = TRUE
	/// The type of secondary magazine for the bulldog
	var/secondary_magazine_type
	/// The secondary magazine
	var/obj/item/ammo_box/magazine/secondary_magazine

/obj/item/gun/ballistic/shotgun/bulldog/Initialize(mapload)
	. = ..()
	secondary_magazine_type = secondary_magazine_type || spawn_magazine_type
	secondary_magazine = new secondary_magazine_type(src)
	update_appearance()

/obj/item/gun/ballistic/shotgun/bulldog/Destroy()
	QDEL_NULL(secondary_magazine)
	return ..()

/obj/item/gun/ballistic/shotgun/bulldog/examine(mob/user)
	. = ..()
	if(secondary_magazine)
		var/secondary_ammo_count = secondary_magazine.ammo_count()
		. += "There is a secondary magazine."
		. += "It has [secondary_ammo_count] round\s remaining."
		. += "Shoot with right-click to swap to the secondary magazine after firing."
		. += "If the magazine is empty, [src] will automatically swap to the secondary magazine."
	. += "You can load a secondary magazine by right-clicking [src] with the magazine you want to load."
	. += "You can remove a secondary magazine by alt-right-clicking [src]."
	. += "Right-click to swap the magazine to the secondary position, and vice versa."

/obj/item/gun/ballistic/shotgun/bulldog/update_overlays()
	. = ..()
	if(secondary_magazine)
		. += "[icon_state]_secondary_mag_[initial(secondary_magazine.icon_state)]"
		if(!secondary_magazine.ammo_count())
			. += "[icon_state]_secondary_mag_empty"

/obj/item/gun/ballistic/shotgun/bulldog/handle_chamber(empty_chamber = TRUE, from_firing = TRUE, chamber_next_round = TRUE)
	if(!secondary_magazine)
		return ..()
	var/secondary_shells_left = LAZYLEN(secondary_magazine.stored_ammo)
	if(magazine)
		var/shells_left = LAZYLEN(magazine.stored_ammo)
		if(shells_left <= 0 && secondary_shells_left >= 1)
			toggle_magazine()
	else
		toggle_magazine()
	return ..()

/obj/item/gun/ballistic/shotgun/bulldog/attack_self_secondary(mob/user, modifiers)
	toggle_magazine()
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/item/gun/ballistic/shotgun/bulldog/ranged_interact_with_atom_secondary(atom/interacting_with, mob/living/user, list/modifiers)
	if(secondary_magazine)
		toggle_magazine()
	return ..()

/obj/item/gun/ballistic/shotgun/bulldog/item_interaction_secondary(mob/living/user, obj/item/tool, list/modifiers)
	if(!istype(tool, secondary_magazine_type))
		return ..()
	if(!user.transferItemToLoc(tool, src))
		return ITEM_INTERACT_BLOCKING
	var/obj/item/ammo_box/magazine/old_mag = secondary_magazine
	secondary_magazine = tool
	if(old_mag)
		user.put_in_hands(old_mag)
	balloon_alert(user, "secondary [magazine_wording] loaded")
	playsound(src, load_empty_sound, load_sound_volume, load_sound_vary)
	update_appearance()
	return ITEM_INTERACT_SUCCESS

/obj/item/gun/ballistic/shotgun/bulldog/click_alt_secondary(mob/user)
	if(secondary_magazine)
		var/obj/item/ammo_box/magazine/old_mag = secondary_magazine
		secondary_magazine = null
		user.put_in_hands(old_mag)
		update_appearance()
		playsound(src, load_empty_sound, load_sound_volume, load_sound_vary)

/obj/item/gun/ballistic/shotgun/bulldog/proc/toggle_magazine()
	var/primary_magazine = magazine
	var/alternative_magazine = secondary_magazine
	magazine = alternative_magazine
	secondary_magazine = primary_magazine
	playsound(src, load_empty_sound, load_sound_volume, load_sound_vary)
	update_appearance()

/obj/item/gun/ballistic/shotgun/bulldog/unrestricted
	pin = /obj/item/firing_pin

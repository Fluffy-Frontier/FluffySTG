/obj/item/attachment/energy_bayonet
	name = "energy bayonet"
	desc = "Stabby-Stabby"
	icon_state = "ebayonet"
	force = 3
	throwforce = 2
	hitsound = 'sound/items/weapons/bladeslice.ogg'
	sharpness = NONE
	slot = ATTACHMENT_SLOT_MUZZLE
	attach_features_flags = ATTACH_TOGGLE | ATTACH_REMOVABLE_HAND

	light_range = 2
	light_power = 0.6
	light_on = FALSE
	light_color = COLOR_MOSTLY_PURE_RED

	toggle_on_sound = 'sound/items/weapons/saberon.ogg'
	toggle_off_sound = 'sound/items/weapons/saberoff.ogg'

	pixel_shift_x = 1
	pixel_shift_y = 4
	spread_mod = 1
/obj/item/attachment/energy_bayonet/on_preattack(obj/item/gun/gun, atom/target, mob/living/user, list/params)
	if(user.combat_mode && toggled != 0)
		melee_attack_chain(user, target, params)
		return COMPONENT_CANCEL_ATTACK_CHAIN


/obj/item/attachment/energy_bayonet/toggle_attachment(obj/item/gun/gun, mob/user)
	. = ..()
	set_light_on(toggled)
	update_icon()
	sharpness = toggled ? SHARP_POINTY : NONE
	force = toggled ? 19 : 3
	throwforce = toggled ? 14 : 2

/obj/item/attachment/energy_bayonet/attack_self(mob/user)
	toggle_attachment()

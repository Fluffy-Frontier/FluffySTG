/obj/item/attachment/bayonet
	name = "bayonet"
	desc = "Stabby-Stabby"
	icon_state = "bayonet"
	force = 15
	throwforce = 10
	hitsound = 'sound/items/weapons/bladeslice.ogg'
	sharpness = SHARP_POINTY
	slot = ATTACHMENT_SLOT_MUZZLE

	pixel_shift_x = 1
	pixel_shift_y = 4
	spread_mod = 1
/obj/item/attachment/bayonet/on_preattack(obj/item/gun/gun, atom/target, mob/living/user, list/params)
	if(user.combat_mode)
		melee_attack_chain(user, target, params)
		return COMPONENT_CANCEL_ATTACK_CHAIN


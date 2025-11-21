/obj/item/attachment/long_scope
	name = "long range scope"
	desc = "An attachment for the scope of a weapon. Allows one to aim down the sight."
	icon_state = "scope"

	slot = ATTACHMENT_SLOT_SCOPE
	pixel_shift_x = 1
	pixel_shift_y = 2
	size_mod = 1
	var/min_recoil_mod = 0.1
	var/aim_slowdown_mod = 0.4


/obj/item/attachment/long_scope/apply_attachment(obj/item/gun/gun, mob/user)
	. = ..()
	if(!gun.GetComponent(/datum/component/scope))
		gun.min_recoil_aimed = min_recoil_mod
		gun.aimed_wield_slowdown += aim_slowdown_mod
		gun.AddComponent(/datum/component/scope, range_modifier = 2)
	else
		to_chat(user, span_notice("Can't have multiple scopes!"))
		return FALSE

/obj/item/attachment/long_scope/remove_attachment(obj/item/gun/gun, mob/user)
	. = ..()
	gun.min_recoil_aimed = initial(gun.min_recoil_aimed)
	gun.aimed_wield_slowdown = initial(gun.aimed_wield_slowdown)
	qdel(gun.GetComponent(/datum/component/scope))
	return TRUE

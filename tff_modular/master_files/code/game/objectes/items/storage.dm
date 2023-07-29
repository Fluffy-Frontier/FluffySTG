/obj/item/storage/MouseDrop_T(mob/user)
	. = ..()
	if(istype(src, /obj/item/storage/backpack/duffelbag))
		if(ishuman(user) && user == usr)
			var/mob/living/carbon/human/h = user
			h.try_put_to_bag(src)

/obj/item/storage/MouseDrop_T(mob/user)
	. = ..()
	if(istype(src, /obj/item/storage/backpack/duffelbag))
		if(ishuman(user))
			var/mob/living/carbon/human/h = user
			if(h.client == usr.client)
				h.try_put_to_bag(src)

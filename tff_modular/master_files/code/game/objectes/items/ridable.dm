/obj/item/riding_offhand/pre_attack(atom/A, mob/living/user, params)
	if(istype(A, /obj/item/storage/backpack))
		var/obj/item/storage/backpack/bag = A
		var/mob/living/carbon/human/human_to_put = rider
		if(human_to_put.try_put_to_bag(bag, TRUE, parent))
			Destroy()
	..(A, user, params)



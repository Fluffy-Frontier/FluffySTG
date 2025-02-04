/datum/preference/choiced/backpack/icon_for(value)
	. = ..()
	switch (value)
		if (GWAISTBAG)
			return /obj/item/storage/backpack/waistbag
		if (DWAISTBAG)
			return /obj/item/storage/backpack/waistbag/med

/datum/preference/choiced/backpack/init_possible_values()
	. = ..()
	. += list(
		GWAISTBAG,
		DWAISTBAG,
	)

/datum/outfit/job/pre_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	if(ispath(back, /obj/item/storage/backpack))
		switch(H.backpack)
			if(GWAISTBAG)
				back = /obj/item/storage/backpack/waistbag
			if(DWAISTBAG)
				back = waistbag

//Ripley
/datum/design/ripley_chassis
	name = "Exosuit Chassis (APLU \"Ripley\")"
	id = "ripley_chassis"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/chassis/ripley
	materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT*40)
	construction_time = 10 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_RIPLEY + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/ripley_torso
	name = "Exosuit Torso (APLU \"Ripley\")"
	id = "ripley_torso"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/ripley_torso
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*40,
		/datum/material/glass =SHEET_MATERIAL_AMOUNT*15,
	)
	construction_time = 20 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_RIPLEY + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/ripley_left_arm
	name = "Exosuit Left Arm (APLU \"Ripley\")"
	id = "ripley_left_arm"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/ripley_left_arm
	materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT*30)
	construction_time = 15 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_RIPLEY + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/ripley_right_arm
	name = "Exosuit Right Arm (APLU \"Ripley\")"
	id = "ripley_right_arm"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/ripley_right_arm
	materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT*30)
	construction_time = 15 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_RIPLEY + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/ripley_left_leg
	name = "Exosuit Left Leg (APLU \"Ripley\")"
	id = "ripley_left_leg"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/ripley_left_leg
	materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT*30)
	construction_time = 15 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_RIPLEY + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/ripley_right_leg
	name = "Exosuit Right Leg (APLU \"Ripley\")"
	id = "ripley_right_leg"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/ripley_right_leg
	materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT*30)
	construction_time = 15 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_RIPLEY + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

//Odysseus
/datum/design/odysseus_chassis
	name = "Exosuit Chassis (\"Odysseus\")"
	id = "odysseus_chassis"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/chassis/odysseus
	materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT*40)
	construction_time = 10 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_ODYSSEUS + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/odysseus_torso
	name = "Exosuit Torso (\"Odysseus\")"
	id = "odysseus_torso"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/odysseus_torso
	materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT*24)
	construction_time = 18 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_ODYSSEUS + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/odysseus_head
	name = "Exosuit Head (\"Odysseus\")"
	id = "odysseus_head"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/odysseus_head
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*12,
		/datum/material/glass =SHEET_MATERIAL_AMOUNT*20
	)
	construction_time = 10 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_ODYSSEUS + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/odysseus_left_arm
	name = "Exosuit Left Arm (\"Odysseus\")"
	id = "odysseus_left_arm"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/odysseus_left_arm
	materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT*12)
	construction_time = 12 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_ODYSSEUS + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/odysseus_right_arm
	name = "Exosuit Right Arm (\"Odysseus\")"
	id = "odysseus_right_arm"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/odysseus_right_arm
	materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT*12)
	construction_time = 12 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_ODYSSEUS + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/odysseus_left_leg
	name = "Exosuit Left Leg (\"Odysseus\")"
	id = "odysseus_left_leg"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/odysseus_left_leg
	materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT*14)
	construction_time = 13 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_ODYSSEUS + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/odysseus_right_leg
	name = "Exosuit Right Leg (\"Odysseus\")"
	id = "odysseus_right_leg"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/odysseus_right_leg
	materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT*14)
	construction_time = 13 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_ODYSSEUS + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

//Gygax
/datum/design/gygax_chassis
	name = "Exosuit Chassis (\"Gygax\")"
	id = "gygax_chassis"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/chassis/gygax
	materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT*40)
	construction_time = 10 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_GYGAX + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/gygax_torso
	name = "Exosuit Torso (\"Gygax\")"
	id = "gygax_torso"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/gygax_torso
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*40,
		/datum/material/glass =SHEET_MATERIAL_AMOUNT*20,
		/datum/material/gold=SHEET_MATERIAL_AMOUNT*4,
		/datum/material/silver=SHEET_MATERIAL_AMOUNT*4,
	)
	construction_time = 30 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_GYGAX + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/gygax_head
	name = "Exosuit Head (\"Gygax\")"
	id = "gygax_head"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/gygax_head
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*20,
		/datum/material/glass =SHEET_MATERIAL_AMOUNT * 10,
		/datum/material/gold=SHEET_MATERIAL_AMOUNT*4,
		/datum/material/silver=SHEET_MATERIAL_AMOUNT*4,
	)
	construction_time = 20 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_GYGAX + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/gygax_left_arm
	name = "Exosuit Left Arm (\"Gygax\")"
	id = "gygax_left_arm"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/gygax_left_arm
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*30,
		/datum/material/gold=SHEET_MATERIAL_AMOUNT*2,
		/datum/material/silver=SHEET_MATERIAL_AMOUNT*2,
	)
	construction_time = 20 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_GYGAX + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/gygax_right_arm
	name = "Exosuit Right Arm (\"Gygax\")"
	id = "gygax_right_arm"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/gygax_right_arm
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*30,
		/datum/material/gold=SHEET_MATERIAL_AMOUNT*2,
		/datum/material/silver=SHEET_MATERIAL_AMOUNT*2,
	)
	construction_time = 20 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_GYGAX + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/gygax_left_leg
	name = "Exosuit Left Leg (\"Gygax\")"
	id = "gygax_left_leg"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/gygax_left_leg
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*30,
		/datum/material/gold=SHEET_MATERIAL_AMOUNT*2,
		/datum/material/silver=SHEET_MATERIAL_AMOUNT*2,
	)
	construction_time = 20 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_GYGAX + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/gygax_right_leg
	name = "Exosuit Right Leg (\"Gygax\")"
	id = "gygax_right_leg"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/gygax_right_leg
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*30,
		/datum/material/gold=SHEET_MATERIAL_AMOUNT*2,
		/datum/material/silver=SHEET_MATERIAL_AMOUNT*2,
	)
	construction_time = 20 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_GYGAX + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/gygax_armor
	name = "Exosuit Armor (\"Gygax\")"
	id = "gygax_armor"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/gygax_armor
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*30,
		/datum/material/gold=SHEET_MATERIAL_AMOUNT*20,
		/datum/material/silver=SHEET_MATERIAL_AMOUNT*20,
		/datum/material/titanium=SHEET_MATERIAL_AMOUNT*20,
	)
	construction_time = 60 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_GYGAX + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

//Durand
/datum/design/durand_chassis
	name = "Exosuit Chassis (\"Durand\")"
	id = "durand_chassis"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/chassis/durand
	materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT*50)
	construction_time = 10 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_DURAND + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/durand_torso
	name = "Exosuit Torso (\"Durand\")"
	id = "durand_torso"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/durand_torso
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*50,
		/datum/material/glass =SHEET_MATERIAL_AMOUNT*20,
		/datum/material/silver=SHEET_MATERIAL_AMOUNT*20,
	)
	construction_time = 30 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_DURAND + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/durand_head
	name = "Exosuit Head (\"Durand\")"
	id = "durand_head"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/durand_head
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*20,
		/datum/material/glass =SHEET_MATERIAL_AMOUNT*30,
		/datum/material/silver=SHEET_MATERIAL_AMOUNT*4,
	)
	construction_time = 20 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_DURAND + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/durand_left_arm
	name = "Exosuit Left Arm (\"Durand\")"
	id = "durand_left_arm"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/durand_left_arm
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*20,
		/datum/material/silver=SHEET_MATERIAL_AMOUNT*8,
	)
	construction_time = 20 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_DURAND + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/durand_right_arm
	name = "Exosuit Right Arm (\"Durand\")"
	id = "durand_right_arm"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/durand_right_arm
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*20,
		/datum/material/silver=SHEET_MATERIAL_AMOUNT*8,
	)
	construction_time = 20 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_DURAND + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/durand_left_leg
	name = "Exosuit Left Leg (\"Durand\")"
	id = "durand_left_leg"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/durand_left_leg
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*20,
		/datum/material/silver=SHEET_MATERIAL_AMOUNT*8,
	)
	construction_time = 20 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_DURAND + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/durand_right_leg
	name = "Exosuit Right Leg (\"Durand\")"
	id = "durand_right_leg"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/durand_right_leg
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*20,
		/datum/material/silver=SHEET_MATERIAL_AMOUNT*8,
	)
	construction_time = 20 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_DURAND + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/durand_armor
	name = "Exosuit Armor (\"Durand\")"
	id = "durand_armor"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/durand_armor
	materials = list(
		/datum/material/iron=SMALL_MATERIAL_AMOUNT * 1200,
		/datum/material/uranium=SHEET_MATERIAL_AMOUNT*50,
		/datum/material/titanium=SHEET_MATERIAL_AMOUNT*40,
	)
	construction_time = 60 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_DURAND + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

//H.O.N.K
/datum/design/honk_chassis
	name = "Exosuit Chassis (\"H.O.N.K\")"
	id = "honk_chassis"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/chassis/honker
	materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT*40)
	construction_time = 10 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_HONK + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/honk_torso
	name = "Exosuit Torso (\"H.O.N.K\")"
	id = "honk_torso"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/honker_torso
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*40,
		/datum/material/glass =SHEET_MATERIAL_AMOUNT*20,
		/datum/material/bananium=SHEET_MATERIAL_AMOUNT*20,
	)
	construction_time = 30 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_HONK + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/honk_head
	name = "Exosuit Head (\"H.O.N.K\")"
	id = "honk_head"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/honker_head
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*20,
		/datum/material/glass =SHEET_MATERIAL_AMOUNT * 10,
		/datum/material/bananium=SHEET_MATERIAL_AMOUNT * 10,
	)
	construction_time = 20 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_HONK + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/honk_left_arm
	name = "Exosuit Left Arm (\"H.O.N.K\")"
	id = "honk_left_arm"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/honker_left_arm
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*30,
		/datum/material/bananium=SHEET_MATERIAL_AMOUNT * 10,
	)
	construction_time = 20 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_HONK + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/honk_right_arm
	name = "Exosuit Right Arm (\"H.O.N.K\")"
	id = "honk_right_arm"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/honker_right_arm
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*30,
		/datum/material/bananium=SHEET_MATERIAL_AMOUNT * 10,
	)
	construction_time = 20 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_HONK + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/honk_left_leg
	name = "Exosuit Left Leg (\"H.O.N.K\")"
	id = "honk_left_leg"
	build_type = MECHFAB
	build_path =/obj/item/mecha_parts/part/honker_left_leg
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*30,
		/datum/material/bananium=SHEET_MATERIAL_AMOUNT * 10,
	)
	construction_time = 20 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_HONK + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/honk_right_leg
	name = "Exosuit Right Leg (\"H.O.N.K\")"
	id = "honk_right_leg"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/honker_right_leg
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*30,
		/datum/material/bananium=SHEET_MATERIAL_AMOUNT * 10,
	)
	construction_time = 20 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_HONK + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

//Phazon
/datum/design/phazon_chassis
	name = "Exosuit Chassis (\"Phazon\")"
	id = "phazon_chassis"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/chassis/phazon
	materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT*40)
	construction_time = 10 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_PHAZON + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/phazon_torso
	name = "Exosuit Torso (\"Phazon\")"
	id = "phazon_torso"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/phazon_torso
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*70,
		/datum/material/glass =SHEET_MATERIAL_AMOUNT*20,
		/datum/material/plasma=SHEET_MATERIAL_AMOUNT*40,
	)
	construction_time = 30 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_PHAZON + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/phazon_head
	name = "Exosuit Head (\"Phazon\")"
	id = "phazon_head"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/phazon_head
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*30,
		/datum/material/glass =SHEET_MATERIAL_AMOUNT * 10,
		/datum/material/plasma=SHEET_MATERIAL_AMOUNT*20,
	)
	construction_time = 20 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_PHAZON + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/phazon_left_arm
	name = "Exosuit Left Arm (\"Phazon\")"
	id = "phazon_left_arm"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/phazon_left_arm
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*40,
		/datum/material/plasma=SHEET_MATERIAL_AMOUNT*20,
	)
	construction_time = 20 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_PHAZON + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/phazon_right_arm
	name = "Exosuit Right Arm (\"Phazon\")"
	id = "phazon_right_arm"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/phazon_right_arm
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*40,
		/datum/material/plasma=SHEET_MATERIAL_AMOUNT*20,
	)
	construction_time = 20 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_PHAZON + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/phazon_left_leg
	name = "Exosuit Left Leg (\"Phazon\")"
	id = "phazon_left_leg"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/phazon_left_leg
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*40,
		/datum/material/plasma=SHEET_MATERIAL_AMOUNT*20,
	)
	construction_time = 20 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_PHAZON + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/phazon_right_leg
	name = "Exosuit Right Leg (\"Phazon\")"
	id = "phazon_right_leg"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/phazon_right_leg
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*40,
		/datum/material/plasma=SHEET_MATERIAL_AMOUNT*20,
	)
	construction_time = 20 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_PHAZON + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/phazon_armor
	name = "Exosuit Armor (\"Phazon\")"
	id = "phazon_armor"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/phazon_armor
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*50,
		/datum/material/plasma=SHEET_MATERIAL_AMOUNT*40,
		/datum/material/titanium=SHEET_MATERIAL_AMOUNT*40,
	)
	construction_time = 30 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_PHAZON + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

//Savannah-Ivanov
/datum/design/savannah_ivanov_chassis
	name = "Exosuit Chassis (\"Savannah-Ivanov\")"
	id = "savannah_ivanov_chassis"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/chassis/savannah_ivanov
	materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT*40)
	construction_time = 10 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_SAVANNAH_IVANOV + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/savannah_ivanov_torso
	name = "Exosuit Torso (\"Savannah-Ivanov\")"
	id = "savannah_ivanov_torso"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/savannah_ivanov_torso
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*40,
		/datum/material/glass =SHEET_MATERIAL_AMOUNT*15,
	)
	construction_time = 20 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_SAVANNAH_IVANOV + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/savannah_ivanov_head
	name = "Exosuit Head (\"Savannah-Ivanov\")"
	id = "savannah_ivanov_head"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/savannah_ivanov_head
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*12,
		/datum/material/glass =SHEET_MATERIAL_AMOUNT*20,
	)
	construction_time = 10 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_SAVANNAH_IVANOV + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/savannah_ivanov_left_arm
	name = "Exosuit Left Arm (\"Savannah-Ivanov\")"
	id = "savannah_ivanov_left_arm"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/savannah_ivanov_left_arm
	materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT*30)
	construction_time = 15 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_SAVANNAH_IVANOV + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/savannah_ivanov_right_arm
	name = "Exosuit Right Arm (\"Savannah-Ivanov\")"
	id = "savannah_ivanov_right_arm"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/savannah_ivanov_right_arm
	materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT*30)
	construction_time = 15 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_SAVANNAH_IVANOV + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/savannah_ivanov_chassis
	name = "Exosuit Chassis (\"Savannah-Ivanov\")"
	id = "savannah_ivanov_chassis"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/chassis/savannah_ivanov
	materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT*50)
	construction_time = 10 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_SAVANNAH_IVANOV + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/savannah_ivanov_torso
	name = "Exosuit Torso (\"Savannah-Ivanov\")"
	id = "savannah_ivanov_torso"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/savannah_ivanov_torso
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*50,
		/datum/material/glass =SHEET_MATERIAL_AMOUNT*20,
		/datum/material/silver=SHEET_MATERIAL_AMOUNT*20,
	)
	construction_time = 30 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_SAVANNAH_IVANOV + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/savannah_ivanov_head
	name = "Exosuit Head (\"Savannah-Ivanov\")"
	id = "savannah_ivanov_head"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/savannah_ivanov_head
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*20,
		/datum/material/glass =SHEET_MATERIAL_AMOUNT*30,
		/datum/material/silver=SHEET_MATERIAL_AMOUNT*4,
	)
	construction_time = 20 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_SAVANNAH_IVANOV + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/savannah_ivanov_left_arm
	name = "Exosuit Left Arm (\"Savannah-Ivanov\")"
	id = "savannah_ivanov_left_arm"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/savannah_ivanov_left_arm
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*20,
		/datum/material/silver=SHEET_MATERIAL_AMOUNT*8,
	)
	construction_time = 20 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_SAVANNAH_IVANOV + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/savannah_ivanov_right_arm
	name = "Exosuit Right Arm (\"Savannah-Ivanov\")"
	id = "savannah_ivanov_right_arm"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/savannah_ivanov_right_arm
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*20,
		/datum/material/silver=SHEET_MATERIAL_AMOUNT*8,
	)
	construction_time = 20 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_SAVANNAH_IVANOV + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/savannah_ivanov_left_leg
	name = "Exosuit Left Leg (\"Savannah-Ivanov\")"
	id = "savannah_ivanov_left_leg"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/savannah_ivanov_left_leg
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*20,
		/datum/material/silver=SHEET_MATERIAL_AMOUNT*8,
	)
	construction_time = 20 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_SAVANNAH_IVANOV + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/savannah_ivanov_right_leg
	name = "Exosuit Right Leg (\"Savannah-Ivanov\")"
	id = "savannah_ivanov_right_leg"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/savannah_ivanov_right_leg
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*20,
		/datum/material/silver=SHEET_MATERIAL_AMOUNT*8,
	)
	construction_time = 20 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_SAVANNAH_IVANOV + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/savannah_ivanov_armor
	name = "Exosuit Armor (\"Savannah-Ivanov\")"
	id = "savannah_ivanov_armor"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/savannah_ivanov_armor
	materials = list(
		/datum/material/iron=SMALL_MATERIAL_AMOUNT * 1200,
		/datum/material/uranium=SHEET_MATERIAL_AMOUNT*50,
		/datum/material/titanium=SHEET_MATERIAL_AMOUNT*40,
	)
	construction_time = 60 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_SAVANNAH_IVANOV + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

//Clarke
/datum/design/clarke_chassis
	name = "Exosuit Chassis (\"Clarke\")"
	id = "clarke_chassis"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/chassis/clarke
	materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT*40)
	construction_time = 10 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CLARKE + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/clarke_torso
	name = "Exosuit Torso (\"Clarke\")"
	id = "clarke_torso"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/clarke_torso
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*40,
		/datum/material/glass =SHEET_MATERIAL_AMOUNT*15,
		)
	construction_time = 20 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CLARKE + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/clarke_head
	name = "Exosuit Head (\"Clarke\")"
	id = "clarke_head"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/clarke_head
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*12,
		/datum/material/glass =SHEET_MATERIAL_AMOUNT*20,
	)
	construction_time = 10 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CLARKE + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/clarke_left_arm
	name = "Exosuit Left Arm (\"Clarke\")"
	id = "clarke_left_arm"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/clarke_left_arm
	materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT*30)
	construction_time = 15 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CLARKE + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/clarke_right_arm
	name = "Exosuit Right Arm (\"Clarke\")"
	id = "clarke_right_arm"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/clarke_right_arm
	materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT*30)
	construction_time = 15 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CLARKE + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

//Exosuit Equipment
/datum/design/ripleyupgrade
	name = "Ripley MK-I to MK-II Conversion Kit"
	id = "ripleyupgrade"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/mecha_equipment/ripleyupgrade
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*20,
		/datum/material/plasma=SHEET_MATERIAL_AMOUNT*20,
	)
	construction_time = 10 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_EQUIPMENT + RND_SUBCATEGORY_MECHFAB_EQUIPMENT_MODULES,
		RND_CATEGORY_MECHFAB_RIPLEY + RND_SUBCATEGORY_MECHFAB_SUPPORTED_EQUIPMENT,
	)

/datum/design/paddyupgrade
	name = "Ripley MK-I to Paddy Conversion Kit"
	id = "paddyupgrade"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/mecha_equipment/ripleyupgrade/paddy
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 40,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 20,
		/datum/material/titanium = SHEET_MATERIAL_AMOUNT * 20,
	)
	construction_time = 10 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_EQUIPMENT + RND_SUBCATEGORY_MECHFAB_EQUIPMENT_MODULES,
		RND_CATEGORY_MECHFAB_PADDY + RND_SUBCATEGORY_MECHFAB_CHASSIS,
	)

/datum/design/mech_hydraulic_clamp
	name = "Hydraulic Clamp"
	id = "mech_hydraulic_clamp"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/mecha_equipment/hydraulic_clamp
	materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT*20)
	construction_time = 10 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_EQUIPMENT + RND_SUBCATEGORY_MECHFAB_EQUIPMENT_MISC,
		RND_CATEGORY_MECHFAB_RIPLEY + RND_SUBCATEGORY_MECHFAB_SUPPORTED_EQUIPMENT,
	)

/datum/design/mech_hydraulic_claw
	name = "Hydraulic Claw"
	id = "mech_hydraulic_claw"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/mecha_equipment/weapon/paddy_claw
	materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT*20)
	construction_time = 10 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_EQUIPMENT + RND_SUBCATEGORY_MECHFAB_EQUIPMENT_MISC,
		RND_CATEGORY_MECHFAB_PADDY + RND_SUBCATEGORY_MECHFAB_SUPPORTED_EQUIPMENT,
	)

/datum/design/mech_drill
	name = "Mining Drill"
	id = "mech_drill"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/mecha_equipment/drill
	materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT*20)
	construction_time = 10 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_EQUIPMENT + RND_SUBCATEGORY_MECHFAB_EQUIPMENT_MINING,
		RND_CATEGORY_MECHFAB_RIPLEY + RND_SUBCATEGORY_MECHFAB_SUPPORTED_EQUIPMENT,
		RND_CATEGORY_MECHFAB_GYGAX + RND_SUBCATEGORY_MECHFAB_SUPPORTED_EQUIPMENT,
		RND_CATEGORY_MECHFAB_DURAND + RND_SUBCATEGORY_MECHFAB_SUPPORTED_EQUIPMENT,
		RND_CATEGORY_MECHFAB_HONK + RND_SUBCATEGORY_MECHFAB_SUPPORTED_EQUIPMENT,
		RND_CATEGORY_MECHFAB_PHAZON + RND_SUBCATEGORY_MECHFAB_SUPPORTED_EQUIPMENT,
		RND_CATEGORY_MECHFAB_CLARKE + RND_SUBCATEGORY_MECHFAB_SUPPORTED_EQUIPMENT
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/mech_mining_scanner
	name = "Mining Scanner"
	id = "mech_mscanner"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/mecha_equipment/mining_scanner
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT * 10,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT *5,
	)
	construction_time = 5 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_EQUIPMENT + RND_SUBCATEGORY_MECHFAB_EQUIPMENT_MINING,
		RND_CATEGORY_MECHFAB_RIPLEY + RND_SUBCATEGORY_MECHFAB_SUPPORTED_EQUIPMENT,
		RND_CATEGORY_MECHFAB_CLARKE + RND_SUBCATEGORY_MECHFAB_SUPPORTED_EQUIPMENT
	)

/datum/design/mech_extinguisher
	name = "Extinguisher"
	id = "mech_extinguisher"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/mecha_equipment/extinguisher
	materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT*20)
	construction_time = 10 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_EQUIPMENT + RND_SUBCATEGORY_MECHFAB_EQUIPMENT_MISC,
		RND_CATEGORY_MECHFAB_RIPLEY + RND_SUBCATEGORY_MECHFAB_SUPPORTED_EQUIPMENT,
		RND_CATEGORY_MECHFAB_CLARKE + RND_SUBCATEGORY_MECHFAB_SUPPORTED_EQUIPMENT
	)

/datum/design/mech_generator
	name = "Plasma Generator"
	id = "mech_generator"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/mecha_equipment/generator
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*20,
		/datum/material/glass =SHEET_MATERIAL_AMOUNT*2,
		/datum/material/silver=SHEET_MATERIAL_AMOUNT*4,
		/datum/material/plasma=SHEET_MATERIAL_AMOUNT * 10,
	)
	construction_time = 10 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_EQUIPMENT + RND_SUBCATEGORY_MECHFAB_EQUIPMENT_MISC,
		RND_CATEGORY_MECHFAB_RIPLEY + RND_SUBCATEGORY_MECHFAB_SUPPORTED_EQUIPMENT,
		RND_CATEGORY_MECHFAB_GYGAX + RND_SUBCATEGORY_MECHFAB_SUPPORTED_EQUIPMENT,
		RND_CATEGORY_MECHFAB_DURAND + RND_SUBCATEGORY_MECHFAB_SUPPORTED_EQUIPMENT,
		RND_CATEGORY_MECHFAB_HONK + RND_SUBCATEGORY_MECHFAB_SUPPORTED_EQUIPMENT,
		RND_CATEGORY_MECHFAB_PHAZON + RND_SUBCATEGORY_MECHFAB_SUPPORTED_EQUIPMENT,
		RND_CATEGORY_MECHFAB_CLARKE + RND_SUBCATEGORY_MECHFAB_SUPPORTED_EQUIPMENT
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/mech_mousetrap_mortar
	name = "Mousetrap Mortar"
	id = "mech_mousetrap_mortar"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/mecha_equipment/weapon/ballistic/launcher/mousetrap_mortar
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*40,
		/datum/material/bananium=SHEET_MATERIAL_AMOUNT * 10,
	)
	construction_time = 30 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_EQUIPMENT + RND_SUBCATEGORY_MECHFAB_EQUIPMENT_HONK,
		RND_CATEGORY_MECHFAB_HONK + RND_SUBCATEGORY_MECHFAB_SUPPORTED_EQUIPMENT
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/mech_banana_mortar
	name = "Banana Mortar"
	id = "mech_banana_mortar"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/mecha_equipment/weapon/ballistic/launcher/banana_mortar
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*40,
		/datum/material/bananium=SHEET_MATERIAL_AMOUNT * 10,
	)
	construction_time = 30 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_EQUIPMENT + RND_SUBCATEGORY_MECHFAB_EQUIPMENT_HONK,
		RND_CATEGORY_MECHFAB_HONK + RND_SUBCATEGORY_MECHFAB_SUPPORTED_EQUIPMENT
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/mech_honker
	name = "HoNkER BlAsT 5000"
	id = "mech_honker"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/mecha_equipment/weapon/honker
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*40,
		/datum/material/bananium=SHEET_MATERIAL_AMOUNT*20,
	)
	construction_time = 50 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_EQUIPMENT + RND_SUBCATEGORY_MECHFAB_EQUIPMENT_HONK,
		RND_CATEGORY_MECHFAB_HONK + RND_SUBCATEGORY_MECHFAB_SUPPORTED_EQUIPMENT
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/mech_punching_glove
	name = "Oingo Boingo Punch-face"
	id = "mech_punching_face"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/mecha_equipment/weapon/ballistic/launcher/punching_glove
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*40,
		/datum/material/bananium=SHEET_MATERIAL_AMOUNT*15,
	)
	construction_time = 40 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_EQUIPMENT + RND_SUBCATEGORY_MECHFAB_EQUIPMENT_HONK,
		RND_CATEGORY_MECHFAB_HONK + RND_SUBCATEGORY_MECHFAB_SUPPORTED_EQUIPMENT
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/mech_radio
	name = "Mech Radio"
	id = "mech_radio"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/mecha_equipment/radio
	materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT*10)
	construction_time = 10 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_EQUIPMENT + RND_SUBCATEGORY_MECHFAB_EQUIPMENT_MINING,
		RND_CATEGORY_MECHFAB_RIPLEY + RND_SUBCATEGORY_MECHFAB_SUPPORTED_EQUIPMENT,
		RND_CATEGORY_MECHFAB_GYGAX + RND_SUBCATEGORY_MECHFAB_SUPPORTED_EQUIPMENT,
		RND_CATEGORY_MECHFAB_DURAND + RND_SUBCATEGORY_MECHFAB_SUPPORTED_EQUIPMENT,
		RND_CATEGORY_MECHFAB_HONK + RND_SUBCATEGORY_MECHFAB_SUPPORTED_EQUIPMENT,
		RND_CATEGORY_MECHFAB_PHAZON + RND_SUBCATEGORY_MECHFAB_SUPPORTED_EQUIPMENT,
		RND_CATEGORY_MECHFAB_CLARKE + RND_SUBCATEGORY_MECHFAB_SUPPORTED_EQUIPMENT
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/mech_air_tank
	name = "Mech Air Tank"
	id = "mech_air_tank"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/mecha_equipment/air_tank
	materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT*20)
	construction_time = 10 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_EQUIPMENT + RND_SUBCATEGORY_MECHFAB_EQUIPMENT_MINING,
		RND_CATEGORY_MECHFAB_RIPLEY + RND_SUBCATEGORY_MECHFAB_SUPPORTED_EQUIPMENT,
		RND_CATEGORY_MECHFAB_GYGAX + RND_SUBCATEGORY_MECHFAB_SUPPORTED_EQUIPMENT,
		RND_CATEGORY_MECHFAB_DURAND + RND_SUBCATEGORY_MECHFAB_SUPPORTED_EQUIPMENT,
		RND_CATEGORY_MECHFAB_HONK + RND_SUBCATEGORY_MECHFAB_SUPPORTED_EQUIPMENT,
		RND_CATEGORY_MECHFAB_PHAZON + RND_SUBCATEGORY_MECHFAB_SUPPORTED_EQUIPMENT,
		RND_CATEGORY_MECHFAB_CLARKE + RND_SUBCATEGORY_MECHFAB_SUPPORTED_EQUIPMENT
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

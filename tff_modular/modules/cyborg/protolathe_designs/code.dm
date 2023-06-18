/datum/design/alien_surg
	name = "Alien Surgery Toolset Implant"
	desc = "An advanced surgery toolset implant obtained through Abductor technology."
	id = "alien_surgt"
	build_path = /obj/item/organ/internal/cyberimp/arm/toolset/alien_med
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	materials = list(
		/datum/material/iron =30000,
		/datum/material/silver =6000,
		/datum/material/plasma =8000,
		/datum/material/titanium =20000,
		/datum/material/bluespace =10000
	)
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_IMPLANTS_UTILITY
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/alien_surg
	name = "Alien Engineering Toolset Implant"
	desc = "An advanced engineering toolset implant obtained through Abductor technology."
	id = "alien_engt"
	build_path = /obj/item/organ/internal/cyberimp/arm/toolset/alien_eng
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	materials = list(
		/datum/material/iron =30000,
		/datum/material/silver =6000,
		/datum/material/plasma =8000,
		/datum/material/titanium =20000,
		/datum/material/diamond =4000,
		/datum/material/bluespace =10000
	)
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_IMPLANTS_UTILITY
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/borg_alienmed
	name = "Alien Surgery Tools Upgrade"
	desc = "An advanced surgery toolkit for cyborgs, obtained through Abductor technology."
	id = "borg_alien_surg"
	build_path = /obj/item/borg/upgrade/alien_surgerytools
	build_type = MECHFAB
	materials = list(
		/datum/material/iron =30000,
		/datum/material/silver =6000,
		/datum/material/plasma =8000,
		/datum/material/titanium =20000,
		/datum/material/diamond =4000,
		/datum/material/bluespace =10000
		)
	category = list(
		RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_ALL + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_MEDICAL
	)

/datum/design/borg_alieneng
	name = "Alien Engineering Tools Upgrade"
	desc = "An advanced engineering toolkit for cyborgs, obtained through Abductor technology."
	id = "borg_alien_eng"
	build_path = /obj/item/borg/upgrade/alien_engitools
	build_type = MECHFAB
	materials = list(
		/datum/material/iron =30000,
		/datum/material/silver =6000,
		/datum/material/plasma =8000,
		/datum/material/titanium =20000,
		/datum/material/diamond =4000,
		/datum/material/bluespace =10000
		)
	category = list(
		RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_ALL + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_ENGINEERING
	)

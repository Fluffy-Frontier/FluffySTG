//Секурити худы
/obj/item/clothing/glasses/hud/security
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Blue Hud" = list(
			RESKIN_ICON = 'modular_skyrat/master_files/icons/obj/clothing/glasses.dmi',
			RESKIN_ICON_STATE = "security_hud",
			RESKIN_WORN_ICON = 'modular_skyrat/master_files/icons/mob/clothing/eyes.dmi',
			RESKIN_WORN_ICON_STATE = "security_hud"
		),
		"Red Hud" = list(
			RESKIN_ICON = 'icons/obj/clothing/glasses.dmi',
			RESKIN_ICON_STATE = "securityhud",
			RESKIN_WORN_ICON = 'icons/mob/clothing/eyes.dmi',
			RESKIN_WORN_ICON_STATE = "securityhud"
		),
	)

/obj/item/clothing/glasses/hud/security/night
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Blue Nightvision" = list(
			RESKIN_ICON = 'modular_skyrat/master_files/icons/obj/clothing/glasses.dmi',
			RESKIN_ICON_STATE = "security_hud_nv",
			RESKIN_WORN_ICON = 'modular_skyrat/master_files/icons/mob/clothing/eyes.dmi',
			RESKIN_WORN_ICON_STATE = "security_hud_nv"
		),
		"Red Nightvision" = list(
			RESKIN_ICON = 'icons/obj/clothing/glasses.dmi',
			RESKIN_ICON_STATE = "securityhudnight",
			RESKIN_WORN_ICON = 'icons/mob/clothing/eyes.dmi',
			RESKIN_WORN_ICON_STATE = "securityhudnight"
		),
	)

/obj/item/clothing/glasses/hud/security/sunglasses/Initialize(mapload)
	. = ..()
	unique_reskin += list(
		"Red Sunglasses" = list(
			RESKIN_ICON = 'icons/obj/clothing/glasses.dmi',
			RESKIN_ICON_STATE = "sunhudsec",
			RESKIN_WORN_ICON = 'icons/mob/clothing/eyes.dmi',
			RESKIN_WORN_ICON_STATE = "sunhudsec"
		),
	)

//ну и удаляем эти скины из подтипов, ведь им это тоже меняет...
/obj/item/clothing/glasses/hud/security/sunglasses/eyepatch/Initialize(mapload)
	. = ..()
	unique_reskin -= list(
		"Red Sunglasses" = list(
			RESKIN_ICON = 'icons/obj/clothing/glasses.dmi',
			RESKIN_ICON_STATE = "sunhudsec",
			RESKIN_WORN_ICON = 'icons/mob/clothing/eyes.dmi',
			RESKIN_WORN_ICON_STATE = "sunhudsec"
		),
	)

/obj/item/clothing/glasses/hud/security/sunglasses/gars/Initialize(mapload)
	. = ..()
	unique_reskin -= list(
		"Red Sunglasses" = list(
			RESKIN_ICON = 'icons/obj/clothing/glasses.dmi',
			RESKIN_ICON_STATE = "sunhudsec",
			RESKIN_WORN_ICON = 'icons/mob/clothing/eyes.dmi',
			RESKIN_WORN_ICON_STATE = "sunhudsec"
		),
	)

/obj/item/clothing/glasses/hud/security/sunglasses/eyepatch
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Blue Eyepatch" = list(
			RESKIN_ICON = 'modular_skyrat/master_files/icons/obj/clothing/glasses.dmi',
			RESKIN_ICON_STATE = "security_eyepatch",
			RESKIN_WORN_ICON = 'modular_skyrat/master_files/icons/mob/clothing/eyes.dmi',
			RESKIN_WORN_ICON_STATE = "security_eyepatch"
		),
		"Red Eyepatch" = list(
			RESKIN_ICON = 'icons/obj/clothing/glasses.dmi',
			RESKIN_ICON_STATE = "hudpatch",
			RESKIN_WORN_ICON = 'icons/mob/clothing/eyes.dmi',
			RESKIN_WORN_ICON_STATE = "hudpatch"
		),
	)

/obj/item/clothing/glasses/hud/security/sunglasses/gars
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Blue Gars" = list(
			RESKIN_ICON = 'modular_skyrat/master_files/icons/obj/clothing/glasses.dmi',
			RESKIN_ICON_STATE = "gar_sec",
			RESKIN_WORN_ICON = 'modular_skyrat/master_files/icons/mob/clothing/eyes.dmi',
			RESKIN_WORN_ICON_STATE = "gar_sec"
		),
		"Red Gars" = list(
			RESKIN_ICON = 'icons/obj/clothing/glasses.dmi',
			RESKIN_ICON_STATE = "gar_sec",
			RESKIN_WORN_ICON = 'icons/mob/clothing/eyes.dmi',
			RESKIN_WORN_ICON_STATE = "gar_sec"
		),
	)

/obj/item/clothing/glasses/hud/security/sunglasses/gars/giga
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Blue Gigagars" = list(
			RESKIN_ICON = 'modular_skyrat/master_files/icons/obj/clothing/glasses.dmi',
			RESKIN_ICON_STATE = "gigagar_sec",
			RESKIN_WORN_ICON = 'modular_skyrat/master_files/icons/mob/clothing/eyes.dmi',
			RESKIN_WORN_ICON_STATE = "gigagar_sec"
		),
		"Red Gigagars" = list(
			RESKIN_ICON = 'icons/obj/clothing/glasses.dmi',
			RESKIN_ICON_STATE = "gigagar_sec",
			RESKIN_WORN_ICON = 'icons/mob/clothing/eyes.dmi',
			RESKIN_WORN_ICON_STATE = "gigagar_sec"
		),
	)

//Вещи Security Officer
/obj/item/clothing/head/security_cap/Initialize(mapload)
	. = ..()
	unique_reskin += list(
		"Red Variant" = list(
			RESKIN_ICON = 'icons/obj/clothing/head/hats.dmi',
			RESKIN_ICON_STATE = "secsoft",
			RESKIN_WORN_ICON = 'icons/mob/clothing/head/hats.dmi',
			RESKIN_WORN_ICON_STATE = "secsoft"
		),
	)

/obj/item/clothing/under/rank/security/skyrat/utility
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Blue Variant" = list(
			RESKIN_ICON_STATE = "util_sec",
			RESKIN_WORN_ICON_STATE = "util_sec"
		),
		"Red Variant" = list(
			RESKIN_ICON_STATE = "util_sec_old",
			RESKIN_WORN_ICON_STATE = "util_sec_old"
		),
	)

/obj/item/clothing/under/rank/security/officer/Initialize(mapload)
	. = ..()
	unique_reskin += list(
		"Red Variant" = list(
			RESKIN_ICON = 'icons/obj/clothing/under/security.dmi',
			RESKIN_ICON_STATE = "rsecurity",
			RESKIN_WORN_ICON = 'icons/mob/clothing/under/security.dmi',
			RESKIN_WORN_ICON_STATE = "rsecurity"
		),
		"Red Skirt" = list(
			RESKIN_ICON = 'icons/obj/clothing/under/security.dmi',
			RESKIN_ICON_STATE = "secskirt",
			RESKIN_WORN_ICON = 'icons/mob/clothing/under/security.dmi',
			RESKIN_WORN_ICON_STATE = "secskirt"
		),
	)

/obj/item/clothing/suit/toggle/jacket/sec
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Blue Variant" = list(
			RESKIN_ICON_STATE = "sec_dep_jacket",
			RESKIN_WORN_ICON_STATE = "sec_dep_jacket"
		),
		"Red Variant" = list(
			RESKIN_ICON_STATE = "sec_dep_jacket_old",
			RESKIN_WORN_ICON_STATE = "sec_dep_jacket_old"
		),
	)

/obj/item/clothing/suit/reskin_obj(mob/M)
	. = ..()
	if(current_skin)
		var/datum/component/toggle_icon/toggler = GetComponent(/datum/component/toggle_icon)
		if(!toggler)
			return
		toggler.base_icon_state = unique_reskin[current_skin][RESKIN_ICON_STATE]


/obj/item/clothing/gloves/color/black/security/Initialize(mapload)
	. = ..()
	unique_reskin += list(
		"Basic Gloves" = list(
			RESKIN_ICON = 'icons/obj/clothing/gloves.dmi',
			RESKIN_ICON_STATE = "black",
			RESKIN_WORN_ICON = 'icons/mob/clothing/hands.dmi',
			RESKIN_WORN_ICON_STATE = "black"
		),
	)

/obj/item/storage/belt/security/Initialize(mapload)
	. = ..()
	if(!unique_reskin)
		return
	unique_reskin += list(
		"Red Variant" = list(
			RESKIN_ICON = 'icons/obj/clothing/belts.dmi',
			RESKIN_ICON_STATE = "security",
			RESKIN_WORN_ICON = 'icons/mob/clothing/belt.dmi',
			RESKIN_WORN_ICON_STATE = "security"
		),
	)

/obj/item/clothing/shoes/jackboots/sec/Initialize(mapload)
	. = ..()
	unique_reskin += list(
		"Pure Black" = list(
			RESKIN_ICON = 'icons/obj/clothing/shoes.dmi',
			RESKIN_ICON_STATE = "jackboots",
		),
	)

/obj/item/storage/backpack/duffelbag/sec/Initialize(mapload)
	. = ..()
	unique_reskin += list(
		"Red Variant" = list(
			RESKIN_ICON = 'icons/obj/storage/backpack.dmi',
			RESKIN_ICON_STATE = "duffel-security",
			RESKIN_WORN_ICON = 'icons/mob/clothing/back/backpack.dmi',
			RESKIN_WORN_ICON_STATE = "duffel-security"
		),
	)

/obj/item/storage/backpack/satchel/sec //у сатчели не было скинов, поэтому их лучше так добавить.
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Red Variant" = list(
			RESKIN_ICON = 'icons/obj/storage/backpack.dmi',
			RESKIN_ICON_STATE = "satchel-security",
			RESKIN_WORN_ICON = 'icons/mob/clothing/back/backpack.dmi',
			RESKIN_WORN_ICON_STATE = "satchel-security"
		),
		"Blue Variant" = list(
			RESKIN_ICON = 'modular_skyrat/master_files/icons/obj/clothing/backpacks.dmi',
			RESKIN_ICON_STATE = "satchel_security",
			RESKIN_WORN_ICON = 'modular_skyrat/master_files/icons/mob/clothing/back.dmi',
			RESKIN_WORN_ICON_STATE = "satchel_security"
		),
	)

/obj/item/storage/backpack/security/Initialize(mapload)
	. = ..()
	unique_reskin += list(
		"Red Variant" = list(
			RESKIN_ICON = 'icons/obj/storage/backpack.dmi',
			RESKIN_ICON_STATE = "backpack-security",
			RESKIN_WORN_ICON = 'icons/mob/clothing/back/backpack.dmi',
			RESKIN_WORN_ICON_STATE = "backpack-security"
		),
	)

/obj/item/clothing/head/helmet/sec //У шлема так же нет рескинов.
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Black Variant" = list(
			RESKIN_ICON = 'modular_skyrat/master_files/icons/obj/clothing/head/helmet.dmi',
			RESKIN_ICON_STATE = "security_helmet",
			RESKIN_WORN_ICON = 'modular_skyrat/master_files/icons/mob/clothing/head/helmet.dmi',
			RESKIN_WORN_ICON_STATE = "security_helmet"
		),
		"Red Variant" = list(
			RESKIN_ICON = 'icons/obj/clothing/head/helmet.dmi',
			RESKIN_ICON_STATE = "helmet",
			RESKIN_WORN_ICON = 'icons/mob/clothing/head/helmet.dmi',
			RESKIN_WORN_ICON_STATE = "helmet"
		),
	)

/obj/item/clothing/suit/armor/vest/alt/sec/Initialize(mapload)
	. = ..()
	unique_reskin += list(
		"Black-Red" = list(
			RESKIN_ICON = 'icons/obj/clothing/suits/armor.dmi',
			RESKIN_ICON_STATE = "armor_sec",
			RESKIN_WORN_ICON = 'icons/mob/clothing/suits/armor.dmi',
			RESKIN_WORN_ICON_STATE = "armor_sec"
		)
	)

//Warden
/obj/item/clothing/head/hats/warden
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Blue Variant" = list(
			RESKIN_ICON_STATE = "policehelm",
			RESKIN_WORN_ICON_STATE = "policehelm"
		),
		"Red Variant" = list(
			RESKIN_ICON_STATE = "wardenhat",
			RESKIN_WORN_ICON_STATE = "wardenhat"
		),
	)

/obj/item/clothing/under/rank/security/warden
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Blue and Black" = list(
			RESKIN_ICON = 'modular_skyrat/master_files/icons/obj/clothing/under/security.dmi',
			RESKIN_ICON_STATE = "warden_black",
			RESKIN_WORN_ICON = 'modular_skyrat/master_files/icons/mob/clothing/under/security.dmi',
			RESKIN_WORN_ICON_STATE = "warden_black"
		),
		"Red Suit" = list(
			RESKIN_ICON = 'icons/obj/clothing/under/security.dmi',
			RESKIN_ICON_STATE = "rwarden",
			RESKIN_WORN_ICON = 'icons/mob/clothing/under/security.dmi',
			RESKIN_WORN_ICON_STATE = "rwarden"
		),
		"Red Skirt" = list(
			RESKIN_ICON = 'icons/obj/clothing/under/security.dmi',
			RESKIN_ICON_STATE = "rwarden_skirt",
			RESKIN_WORN_ICON = 'icons/mob/clothing/under/security.dmi',
			RESKIN_WORN_ICON_STATE = "rwarden_skirt"
		),
	)

/obj/item/clothing/under/rank/security/warden/formal
	current_skin = "wardenblueclothes"


/obj/item/clothing/suit/armor/vest/warden/Initialize(mapload)
	. = ..()
	unique_reskin += list(
		"Red Variant" = list(
			RESKIN_ICON = 'icons/obj/clothing/suits/armor.dmi',
			RESKIN_ICON_STATE = "warden_jacket",
			RESKIN_WORN_ICON = 'icons/mob/clothing/suits/armor.dmi',
			RESKIN_WORN_ICON_STATE = "warden_jacket"
		),
	)

/obj/item/clothing/gloves/krav_maga/sec
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Blue Krav Maga" = list(
			RESKIN_ICON = 'modular_skyrat/master_files/icons/obj/clothing/gloves.dmi',
			RESKIN_ICON_STATE = "fightgloves_blue",
			RESKIN_WORN_ICON = 'modular_skyrat/master_files/icons/mob/clothing/hands.dmi',
			RESKIN_WORN_ICON_STATE = "fightgloves_blue"
		),
		"Red Krav Maga" = list(
			RESKIN_ICON = 'icons/obj/clothing/gloves.dmi',
			RESKIN_ICON_STATE = "fightgloves",
			RESKIN_WORN_ICON = 'icons/mob/clothing/hands.dmi',
			RESKIN_WORN_ICON_STATE = "fightgloves"
		),
	)

//Head of Security
/obj/item/clothing/head/hats/hos/cap/Initialize(mapload)
	. = ..()
	unique_reskin += list(
		"Red Cap" = list(
			RESKIN_ICON = 'icons/obj/clothing/head/hats.dmi',
			RESKIN_ICON_STATE = "hoscap",
			RESKIN_WORN_ICON = 'icons/mob/clothing/head/hats.dmi',
			RESKIN_WORN_ICON_STATE = "hoscap"
		),
	)

/obj/item/clothing/under/rank/security/head_of_security
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Blue and Black" = list(
			RESKIN_ICON = 'modular_skyrat/master_files/icons/obj/clothing/under/security.dmi',
			RESKIN_ICON_STATE = "hos_black",
			RESKIN_WORN_ICON = 'modular_skyrat/master_files/icons/mob/clothing/under/security.dmi',
			RESKIN_WORN_ICON_STATE = "hos_black"
		),
		"Red Suit" = list(
			RESKIN_ICON = 'icons/obj/clothing/under/security.dmi',
			RESKIN_ICON_STATE = "rhos",
			RESKIN_WORN_ICON = 'icons/mob/clothing/under/security.dmi',
			RESKIN_WORN_ICON_STATE = "rhos"
		),
		"Red Skirt" = list(
			RESKIN_ICON = 'icons/obj/clothing/under/security.dmi',
			RESKIN_ICON_STATE = "rhos_skirt",
			RESKIN_WORN_ICON = 'icons/mob/clothing/under/security.dmi',
			RESKIN_WORN_ICON_STATE = "rhos_skirt"
		),
	)

/obj/item/clothing/under/rank/security/head_of_security/grey
	current_skin = "hos"

/obj/item/clothing/under/rank/security/head_of_security/alt
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Blue Variant" = list(
			RESKIN_ICON = 'modular_skyrat/master_files/icons/obj/clothing/under/security.dmi',
			RESKIN_ICON_STATE = "hosalt_blue",
			RESKIN_WORN_ICON = 'modular_skyrat/master_files/icons/mob/clothing/under/security.dmi',
			RESKIN_WORN_ICON_STATE = "hosalt_blue"
		),
		"Red Variant" = list(
			RESKIN_ICON = 'icons/obj/clothing/under/security.dmi',
			RESKIN_ICON_STATE = "hosalt",
			RESKIN_WORN_ICON = 'icons/mob/clothing/under/security.dmi',
			RESKIN_WORN_ICON_STATE = "hosalt"
		),
	)

/obj/item/clothing/under/rank/security/head_of_security/alt/skirt
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Blue Variant" = list(
			RESKIN_ICON = 'modular_skyrat/master_files/icons/obj/clothing/under/security.dmi',
			RESKIN_ICON_STATE = "hosalt_skirt_blue",
			RESKIN_WORN_ICON = 'modular_skyrat/master_files/icons/mob/clothing/under/security.dmi',
			RESKIN_WORN_ICON_STATE = "hosalt_skirt_blue"
		),
		"Red Variant" = list(
			RESKIN_ICON = 'icons/obj/clothing/under/security.dmi',
			RESKIN_ICON_STATE = "hosalt_skirt",
			RESKIN_WORN_ICON = 'icons/mob/clothing/under/security.dmi',
			RESKIN_WORN_ICON_STATE = "hosalt_skirt"
		),
	)

/obj/item/clothing/under/rank/security/head_of_security/parade
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Blue Variant" = list(
			RESKIN_ICON = 'modular_skyrat/master_files/icons/obj/clothing/under/security.dmi',
			RESKIN_ICON_STATE = "hos_parade_male_blue",
			RESKIN_WORN_ICON = 'modular_skyrat/master_files/icons/mob/clothing/under/security.dmi',
			RESKIN_WORN_ICON_STATE = "hos_parade_male_blue"
		),
		"Red Variant" = list(
			RESKIN_ICON = 'icons/obj/clothing/under/security.dmi',
			RESKIN_ICON_STATE = "hos_parade_male",
			RESKIN_WORN_ICON = 'icons/mob/clothing/under/security.dmi',
			RESKIN_WORN_ICON_STATE = "hos_parade_male"
		),
	)

/obj/item/clothing/under/rank/security/head_of_security/parade/female
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Blue Variant" = list(
			RESKIN_ICON = 'modular_skyrat/master_files/icons/obj/clothing/under/security.dmi',
			RESKIN_ICON_STATE = "hos_parade_fem_blue",
			RESKIN_WORN_ICON = 'modular_skyrat/master_files/icons/mob/clothing/under/security.dmi',
			RESKIN_WORN_ICON_STATE = "hos_parade_fem_blue"
		),
		"Red Variant" = list(
			RESKIN_ICON = 'icons/obj/clothing/under/security.dmi',
			RESKIN_ICON_STATE = "hos_parade_fem",
			RESKIN_WORN_ICON = 'icons/mob/clothing/under/security.dmi',
			RESKIN_WORN_ICON_STATE = "hos_parade_fem"
		),
	)

/obj/item/clothing/suit/armor/hos/hos_formal
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Blue Variant" = list(
			RESKIN_ICON = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi',
			RESKIN_ICON_STATE = "hosformal_blue",
			RESKIN_WORN_ICON = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi',
			RESKIN_WORN_ICON_STATE = "hosformal_blue"
		),
		"Red Variant" = list(
			RESKIN_ICON = 'icons/obj/clothing/suits/armor.dmi',
			RESKIN_ICON_STATE = "hosformal",
			RESKIN_WORN_ICON = 'icons/mob/clothing/suits/armor.dmi',
			RESKIN_WORN_ICON_STATE = "hosformal"
		),
	)

/obj/item/clothing/neck/cloak/hos
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Blue Variant" = list(
			RESKIN_ICON = 'modular_skyrat/master_files/icons/obj/clothing/neck.dmi',
			RESKIN_ICON_STATE = "hoscloak_blue",
			RESKIN_WORN_ICON = 'modular_skyrat/master_files/icons/mob/clothing/neck.dmi',
			RESKIN_WORN_ICON_STATE = "hoscloak_blue"
		),
		"Red Variant" = list(
			RESKIN_ICON = 'icons/obj/clothing/cloaks.dmi',
			RESKIN_ICON_STATE = "hoscloak",
			RESKIN_WORN_ICON = 'icons/mob/clothing/neck.dmi',
			RESKIN_WORN_ICON_STATE = "hoscloak"
		),
	)

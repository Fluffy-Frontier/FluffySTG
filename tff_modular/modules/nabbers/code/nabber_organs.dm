#define NABBER_COLD_THRESHOLD_1 180
#define NABBER_COLD_THRESHOLD_2 140
#define NABBER_COLD_THRESHOLD_3 100

#define NABBER_HEAT_THRESHOLD_1 300
#define NABBER_HEAT_THRESHOLD_2 440
#define NABBER_HEAT_THRESHOLD_3 600

#define ORGGAN_ICON_NABBER 'tff_modular/modules/nabbers/icons/organs/nabber_organs.dmi'

/obj/item/organ/tongue/nabber
	name = "nabber tongue"
	liked_foodtypes = RAW | GORE | GRAIN
	disliked_foodtypes = CLOTH | FRIED | TOXIC
	toxic_foodtypes = DAIRY
	var/static/list/languages_possible_gas = typecacheof(list(
		/datum/language/common,
		/datum/language/nabber,
	))

/obj/item/organ/tongue/nabber/get_possible_languages()
	RETURN_TYPE(/list)
	return languages_possible_gas

/obj/item/organ/ears/nabber
	name = "nabber ears"
	icon = ORGGAN_ICON_NABBER
	icon_state = "ears"

/obj/item/organ/heart/nabber
	name = "nabber heart"
	icon = ORGGAN_ICON_NABBER
	icon_state = "heart"

/obj/item/organ/brain/nabber
	name = "nabber brain"
	icon = ORGGAN_ICON_NABBER
	icon_state = "brain"

/obj/item/organ/eyes/nabber
	name = "nabber eyes"
	desc = "Small orange orbs. With pair welding shield linses."
	icon = ORGGAN_ICON_NABBER
	icon_state = "eyes"
	flash_protect = FLASH_PROTECTION_SENSITIVE
	actions_types = list(/datum/action/item_action/organ_action/toggle)
	var/active = FALSE

/obj/item/organ/eyes/nabber/ui_action_click(mob/user, actiontype)
	if (istype(actiontype, /datum/action/item_action/organ_action/toggle))
		toggle_shielding()

/obj/item/organ/eyes/nabber/proc/toggle_shielding()
	if(!owner)
		return

	active = !active
	playsound(owner, 'sound/machines/click.ogg', 50, TRUE)

	if(active)
		flash_protect = FLASH_PROTECTION_WELDER
		tint = 2
		owner.update_tint()
		owner.balloon_alert(owner, "Welder eyelids shut!")
		return

	flash_protect = FLASH_PROTECTION_SENSITIVE
	tint = 0
	owner.update_tint()
	owner.balloon_alert(owner, "Welder eyelids open!")

/obj/item/organ/eyes/nabber/on_mob_remove(mob/living/carbon/eye_owner, special, movement_flags)
	. = ..()
	active = TRUE
	toggle_shielding()

/obj/item/organ/lungs/nabber
	name = "nabber lungs"
	icon = ORGGAN_ICON_NABBER
	icon_state = "lungs"

	cold_message = "You can't stand the freezing cold with every breath you take!"
	cold_level_1_threshold = NABBER_COLD_THRESHOLD_1
	cold_level_2_threshold = NABBER_COLD_THRESHOLD_2
	cold_level_3_threshold = NABBER_COLD_THRESHOLD_3
	cold_level_1_damage = COLD_GAS_DAMAGE_LEVEL_1 //Keep in mind with gas damage levels, you can set these to be negative, if you want someone to heal, instead.
	cold_level_2_damage = COLD_GAS_DAMAGE_LEVEL_1
	cold_level_3_damage = COLD_GAS_DAMAGE_LEVEL_2
	cold_damage_type = BRUTE


	hot_message = "You can't stand the searing heat with every breath you take!"
	heat_level_1_threshold = NABBER_HEAT_THRESHOLD_1
	heat_level_2_threshold = NABBER_HEAT_THRESHOLD_2
	heat_level_3_threshold = NABBER_HEAT_THRESHOLD_3
	heat_level_1_damage = HEAT_GAS_DAMAGE_LEVEL_2
	heat_level_2_damage = HEAT_GAS_DAMAGE_LEVEL_3
	heat_level_3_damage = HEAT_GAS_DAMAGE_LEVEL_3
	heat_damage_type = BURN

/obj/item/organ/liver/nabber
	name = "nabber liver"
	icon_state = "liver"
	icon = ORGGAN_ICON_NABBER
	liver_resistance = 0.8 * LIVER_DEFAULT_TOX_RESISTANCE // -40%

#undef ORGGAN_ICON_NABBER

#define ORGGAN_ICON_NABBER 'tff_modular/modules/nabbers/icons/organs/nabber_organs.dmi'

/obj/item/organ/internal/ears/nabber
	name = "nabber ears"
	icon = ORGGAN_ICON_NABBER
	icon_state = "ears"

/obj/item/organ/internal/heart/nabber
	name = "nabber heart"
	icon = ORGGAN_ICON_NABBER
	icon_state = "heart"

/obj/item/organ/internal/brain/nabber
	name = "nabber brain"
	icon = ORGGAN_ICON_NABBER
	icon_state = "brain"

/obj/item/organ/internal/eyes/nabber
	name = "nabber eyes"
	desc = "Small orange orbs."
	icon = ORGGAN_ICON_NABBER
	icon_state = "eyes"
	flash_protect = FLASH_PROTECTION_SENSITIVE

/obj/item/organ/internal/eyes/robotic/nabber
	name = "nabber eyes"
	desc = "Small orange orbs. With pair welding shield linses."
	icon = ORGGAN_ICON_NABBER
	icon_state = "eyes"
	flash_protect = FLASH_PROTECTION_SENSITIVE
	var/datum/action/toggle_welding/shield
	var/active = FALSE

/obj/item/organ/internal/eyes/robotic/nabber/Insert(mob/living/carbon/eye_recipient, special, drop_if_replaced)
	. = ..()
	shield = new(eye_recipient)
	shield.button_icon = ORGGAN_ICON_NABBER
	shield.button_icon_state = "eyes"
	shield.Grant(eye_recipient)
	shield.eyes = src

/obj/item/organ/internal/eyes/robotic/nabber/Destroy()
	. = ..()
	shield.Destroy()
	active = FALSE
	toggle_shielding()

/obj/item/organ/internal/eyes/robotic/nabber/proc/toggle_shielding()
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


/obj/item/organ/internal/eyes/robotic/nabber/Remove(mob/living/carbon/eye_owner, special)
	. = ..()
	shield.Destroy()
	active = FALSE
	toggle_shielding()

/obj/item/organ/internal/eyes/robotic/nabber/

/obj/item/organ/internal/lungs/nabber
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

/obj/item/organ/internal/liver/nabber
	name = "nabber liver"
	icon_state = "liver"
	icon = ORGGAN_ICON_NABBER
	liver_resistance = 0.8 * LIVER_DEFAULT_TOX_RESISTANCE // -40%

#undef ORGGAN_ICON_NABBER

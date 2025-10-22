/// TFF MODULAR - Улучшения вскрытия
/// Сохраняем метод и тип урона самоубийства для отображения в autopsy

/mob/living/apply_suicide_damage(obj/item/suicide_tool, damage_type = NONE)
	if(suicide_tool)
		suicide_method = suicide_tool.name
	else
		suicide_method = "unknown method"

	suicide_damage_type = damage_type
	return ..()

/mob/living/carbon/human/apply_suicide_damage(obj/item/suicide_tool, damage_type = NONE)
	if(damage_type == NONE)
		return ..()

	if(suicide_tool)
		suicide_method = suicide_tool.name
	else if(combat_mode)
		suicide_method = "bare hands (combat mode)"
	else
		var/obj/item/organ/brain/userbrain = get_organ_by_type(/obj/item/organ/brain)
		if(userbrain?.damage >= 75)
			suicide_method = "bare hands (brain damage)"
		else
			suicide_method = "bare hands"

	suicide_damage_type = damage_type
	return ..()


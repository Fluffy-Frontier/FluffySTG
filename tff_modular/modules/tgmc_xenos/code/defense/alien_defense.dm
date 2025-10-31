/// TGMC_XENOS (old nova sector xenos)

/mob/living/carbon/alien/adult/tgmc/attack_alien(mob/living/carbon/alien/user, list/modifiers)
	if(!user.combat_mode)
		if(user == src)
			return

		playsound(loc, 'sound/items/weapons/thudswoosh.ogg', 50, TRUE, -1)
		if(on_fire && fire_stacks > 0)
			adjust_fire_stacks(-2)

			if(fire_stacks > 0)
				user.visible_message(span_danger("[user] tries to put out the fire on [src]!"), span_warning("You try to put out the fire on [src]!"), vision_distance = 5)
			else
				user.visible_message(span_danger("[user] has successfully extinguished the fire on [src]!"), span_notice("You extinguished the fire on [src]!"), vision_distance = 5)

			AdjustStun(-6 SECONDS)
			AdjustKnockdown(-6 SECONDS)
			AdjustImmobilized(-6 SECONDS)
			AdjustParalyzed(-6 SECONDS)
			AdjustUnconscious(-6 SECONDS)
			AdjustSleeping(-10 SECONDS)
			return
	return ..()

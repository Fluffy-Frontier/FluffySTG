#define DAMAGE_HEALING_SHTSPWN -8

/obj/item/gun/medbeam/shitspawn
	name = "God damn medigun!!!"
	desc = "MEDIGUNN!!! IT'S REAALL!!! Still remember not to cross the beams."
	icon = 'icons/obj/chronos.dmi'
	icon_state = "chronogun"
	inhand_icon_state = "chronogun"
	w_class = WEIGHT_CLASS_NORMAL



/obj/item/gun/medbeam/shitspawn/on_beam_tick(mob/living/target)
	new /obj/effect/temp_visual/heal(get_turf(target), "#dd1b1b")
	var/need_mob_update
	need_mob_update += target.adjust_brute_loss(DAMAGE_HEALING_SHTSPWN, updating_health = FALSE)
	need_mob_update += target.adjust_fire_loss(DAMAGE_HEALING_SHTSPWN, updating_health = FALSE)
	need_mob_update += target.adjust_tox_loss(DAMAGE_HEALING_SHTSPWN, updating_health = FALSE)
	need_mob_update += target.adjust_oxy_loss(DAMAGE_HEALING_SHTSPWN, updating_health = FALSE)
	if(need_mob_update)
		target.updatehealth()
	return

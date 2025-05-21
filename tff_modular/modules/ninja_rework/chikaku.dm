#define ATTACK_CHIKAKU_SLASH "chikaku slash"
#define ATTACK_CHIKAKU_CHOP "chikaku chop"
#define ATTACK_CHIKAKU_BLUNT "chikaku blunt"

/obj/item/chikaku
	name = "strange energy katana"
	desc = "It's a strange energy katana filled with some kind of energy."
	icon = 'icons/obj/weapons/sword.dmi'
	icon_state = "energy_katana"
	inhand_icon_state = "energy_katana"
	worn_icon_state = "energy_katana"
	icon_angle = 35
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	force = 25
	throwforce = 30
	block_chance = 60
	armour_penetration = 50
	w_class = WEIGHT_CLASS_NORMAL
	hitsound = 'sound/items/weapons/bladeslice.ogg'
	pickup_sound = 'sound/items/unsheath.ogg'
	drop_sound = 'sound/items/sheath.ogg'
	block_sound = 'sound/items/weapons/block_blade.ogg'
	attack_verb_continuous = list("attacks", "slashes", "slices", "tears", "lacerates", "rips", "dices", "cuts")
	attack_verb_simple = list("attack", "slash", "slice", "tear", "lacerate", "rip", "dice", "cut")
	slot_flags = ITEM_SLOT_BACK|ITEM_SLOT_BELT
	sharpness = SHARP_EDGED
	max_integrity = 200
	resistance_flags = LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	var/static/list/combo_list = list(
		ATTACK_CHIKAKU_SLASH = list(COMBO_STEPS = list(LEFT_ATTACK, LEFT_ATTACK, RIGHT_ATTACK, RIGHT_ATTACK), COMBO_PROC = PROC_REF(chikaku_slash)),
		ATTACK_CHIKAKU_CHOP = list(COMBO_STEPS = list(LEFT_ATTACK, RIGHT_ATTACK, LEFT_ATTACK, LEFT_ATTACK), COMBO_PROC = PROC_REF(chikaku_chop)),
		ATTACK_CHIKAKU_BLUNT = list(COMBO_STEPS = list(LEFT_ATTACK, LEFT_ATTACK, RIGHT_ATTACK, LEFT_ATTACK), COMBO_PROC = PROC_REF(chikaku_blunt_blow)),
	)
	var/datum/effect_system/spark_spread/spark_system
	var/datum/action/innate/dash/chikaku/jaunt
	var/teleport_uses = 0

/obj/item/chikaku/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/boomerang, throw_range, TRUE)
	jaunt = new(src)
	spark_system = new /datum/effect_system/spark_spread()
	spark_system.set_up(5, 0, src)
	spark_system.attach(src)

/obj/item/chikaku/examine(mob/user)
	. = ..()
	if(IS_SPACE_NINJA(user))
		. += span_nicegreen("It's a Chikaku! Fast, convenient and pleasant to use katana developed by the Spider Clan. it is known for it's combinations of attacks. \
					Chikaku is designed to storm and quickly kill a group of opponents, but is weak at long range due to the lack of an effective method of movement.")

/obj/item/chikaku/equipped(mob/user, slot, initial)
	. = ..()
	AddComponent( \
		/datum/component/combo_attacks, \
		combos = combo_list, \
		max_combo_length = 4, \
		examine_message = span_nicegreen("<i>You know how to use it. You just need to focus on the katana.</i>"), \
		reset_message = "you return to neutral stance", \
		can_attack_callback = CALLBACK(src, PROC_REF(can_combo_attack)) \
	)
	if(!QDELETED(jaunt))
		jaunt.Grant(user, src)

/obj/item/chikaku/dropped(mob/user)
	. = ..()
	if(!QDELETED(jaunt))
		jaunt.Remove(user)

/obj/item/chikaku/Destroy()
	QDEL_NULL(spark_system)
	QDEL_NULL(jaunt)
	return ..()

/obj/item/chikaku/ranged_interact_with_atom_secondary(atom/interacting_with, mob/living/user, list/modifiers)
	if(!teleport_uses)
		return

	if(!interacting_with.density)
		jaunt?.teleport(user, interacting_with)
		--teleport_uses
		return ITEM_INTERACT_SUCCESS
	return NONE

/obj/item/chikaku/proc/can_combo_attack(mob/user, mob/living/target)
	return target.stat != DEAD && target != user && IS_SPACE_NINJA(user)

/obj/item/chikaku/attack(mob/living/target_mob, mob/living/user, list/modifiers)
	. = ..()
	if(target_mob.stat == HARD_CRIT)
		execution(target_mob, user)
		return
	if(target_mob.health <= 20 && target_mob.health > -1)
		chikaku_dash(target_mob, user)
		return

/obj/item/chikaku/proc/chikaku_slash(mob/living/target, mob/user)
	user.do_attack_animation(target, ATTACK_EFFECT_SLASH)
	user.visible_message(span_warning("[user] slashes around with [src]!"),
		span_notice("You slashes [target]!"))
	to_chat(target, span_userdanger("You've been struck by [user]!"))
	playsound(src, 'sound/items/weapons/genhit3.ogg', 50, TRUE)
	new /obj/effect/temp_visual/chikaku_slash(get_turf(user))
	for(var/mob/living/something_living in range(1, get_turf(user)))
		if(something_living.stat >= UNCONSCIOUS)
			continue
		if(something_living == user)
			continue
		if(IS_SPACE_NINJA(something_living))
			continue
		if(prob(30))
			var/obj/item/bodypart/cut_bodypart = something_living.get_bodypart(pick(BODY_ZONE_R_ARM, BODY_ZONE_R_LEG, BODY_ZONE_L_ARM, BODY_ZONE_L_LEG))
			cut_bodypart?.dismember(BRUTE)
		something_living.apply_damage(35, BRUTE)
	playsound(user, 'sound/vehicles/mecha/mech_stealth_attack.ogg', 75, FALSE)

/obj/item/chikaku/proc/chikaku_chop(mob/living/target, mob/user)
	user.do_attack_animation(target, ATTACK_EFFECT_SLASH)
	user.visible_message(span_warning("[user] chops [target] with [src]!"),
		span_notice("You chops [target]!"))
	to_chat(target, span_userdanger("You've been chopped by [user]!"))
	target.apply_damage(20, BRUTE)
	var/obj/item/bodypart/cut_bodypart = target.get_bodypart(pick(BODY_ZONE_R_ARM, BODY_ZONE_L_ARM))
	cut_bodypart?.dismember(BRUTE)

/obj/item/chikaku/proc/chikaku_dash(mob/living/target, mob/user)
	user.visible_message(span_warning("[user] dashes through [target]!"),
		span_notice("You dash through [target]!"))
	to_chat(target, span_userdanger("[user] dashes through you!"))
	playsound(src, 'sound/effects/magic/blink.ogg', 50, TRUE)
	var/obj/item/bodypart/cut_bodypart = target.get_bodypart(BODY_ZONE_HEAD)
	cut_bodypart?.dismember(BRUTE)
	var/turf/dash_target = get_turf(target)
	for(var/distance in 0 to 2)
		var/turf/current_dash_target = dash_target
		current_dash_target = get_step(current_dash_target, user.dir)
		if(!current_dash_target.is_blocked_turf(TRUE))
			dash_target = current_dash_target
		else
			break
	new /obj/effect/temp_visual/guardian/phase/out(get_turf(user))
	new /obj/effect/temp_visual/guardian/phase(dash_target)
	do_teleport(user, dash_target, channel = TELEPORT_CHANNEL_MAGIC)
	++teleport_uses

/obj/item/chikaku/proc/chikaku_blunt_blow(mob/living/target, mob/user)
	user.do_attack_animation(target, ATTACK_EFFECT_SMASH)
	target.apply_damage(damage = 20, bare_wound_bonus = 10)
	var/atom/throw_target = get_edge_target_turf(target, user.dir)
	target.throw_at(throw_target, 2, 2, user)
	target.Paralyze(0.5 SECONDS)

/obj/item/chikaku/proc/execution(mob/living/target, mob/user)
	user.do_attack_animation(target, ATTACK_EFFECT_SLASH)
	var/obj/item/bodypart/cut_bodypart = target.get_bodypart(BODY_ZONE_HEAD)
	cut_bodypart?.dismember(BRUTE)
	target.apply_damage(50, BRUTE)
	++teleport_uses

/obj/effect/temp_visual/chikaku_slash
	name = "chikaku slash"
	icon = 'icons/effects/160x160.dmi'
	icon_state = "dagger_slash"
	duration = 1.75 SECONDS
	pixel_y = -64
	base_pixel_y = -64
	pixel_x = -64
	base_pixel_x = -64

/datum/action/innate/dash/chikaku
	current_charges = 5
	max_charges = 5
	beam_length = 1 SECONDS
	charge_rate = null
	recharge_sound = null

/datum/action/innate/dash/chikaku/GiveAction(mob/viewer) //this action should be invisible, as its handled by right-click
	return

/datum/action/innate/dash/chikaku/HideFrom(mob/viewer)
	return

/obj/item/chikaku/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user] is using energy katana to commit hara-kiri! It looks like [user.p_theyre()] trying to commit suicide!"))

#undef ATTACK_CHIKAKU_SLASH
#undef ATTACK_CHIKAKU_CHOP
#undef ATTACK_CHIKAKU_BLUNT

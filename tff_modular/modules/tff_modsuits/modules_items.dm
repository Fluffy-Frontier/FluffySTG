/obj/item/storage/part_replacer/bluespace/mod
	name = "MOD bluespace rapid part exchange device"
	icon = 'tff_modular/master_files/icons/obj/clothing/modsuits/mod_modules.dmi'
	icon_state = "module_part_replacer"
	custom_materials = null
	force = 0
	pshoom_or_beepboopblorpzingshadashwoosh = 'tff_modular/master_files/sounds/energy_emit.ogg'
	alt_sound = 'tff_modular/master_files/sounds/energy_emit.ogg'

/obj/item/pipe_dispenser/mod
	name = "MOD pipe dispenser"
	icon = 'tff_modular/master_files/icons/obj/clothing/modsuits/mod_modules.dmi'
	icon_state = "module_pipe_dispanser"
	custom_materials = null
	force = 0

/obj/item/experi_scanner/mod
	name = "MOD Experi-Scanner"
	icon = 'tff_modular/master_files/icons/obj/clothing/modsuits/mod_modules.dmi'
	icon_state = "module_research_scaner"

/**
 * МОД КОПЬЕ
 */

/obj/item/energy_spear
	name = "\improper MOD energy spear"
	desc = "A spear made of pure energy, incredibly light to the touch."
	icon = 'tff_modular/master_files/icons/obj/mod.dmi'
	icon_state = "energy_spear"
	force = 0
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = null
	throwforce = 20
	// Оно невероятно быстрое и сможет догнать кого угодно, в любой среде!
	throw_speed = 10
	demolition_mod = 2
	// Убедимся, что даже если оно попадет в кого-нибудь и застрянет, то никакоого эффекта это не даст.
	embedding = list("impact_pain_mult" = 0, "remove_pain_mult" = 0, "jostle_chance" = 0)
	armour_penetration = 50
	custom_materials = null
	wound_bonus = -50
	bare_wound_bonus = 30

	inhand_icon_state = "energy_spear"
	lefthand_file = 'tff_modular/master_files/icons/mob/inhands/melee_lefthand.dmi'
	righthand_file = 'tff_modular/master_files/icons/mob/inhands/melee_righthand.dmi'
	mob_throw_hit_sound = 'tff_modular/master_files/sounds/energy_spear_throw.ogg'

/**
 * МОД КЛИНОК
 */

/obj/item/melee/mod_blade
	name = "\improper MOD blade"
	desc = "A sharp, stylish and massive MOD blade built into the hand."
	icon = 'tff_modular/master_files/icons/obj/mod.dmi'
	icon_state = "mod_blade"
	force = 15
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = null
	throwforce = 0
	throw_speed =0
	demolition_mod = 2
	embedding = list("impact_pain_mult" = 0, "remove_pain_mult" = 0, "jostle_chance" = 0)
	armour_penetration = 50
	custom_materials = null
	wound_bonus = -10
	bare_wound_bonus = 30

	inhand_icon_state = "mod_blade"
	lefthand_file = 'tff_modular/master_files/icons/mob/inhands/melee_lefthand.dmi'
	righthand_file = 'tff_modular/master_files/icons/mob/inhands/melee_righthand.dmi'
	// Урон от альтернативной атаки.
	var/alt_attack_force = 10
	// Время перезарядки альтерантивной атаки.
	var/alt_attack_cooldown = 3 SECONDS
	COOLDOWN_DECLARE(cooldown_aoe)
	// Цена по энергии для второстепенной атаки.
	var/alt_attack_power_cost = 50
	//Мод костюм к которому привязан клинок.
	var/obj/item/mod/control/mod

/obj/item/melee/mod_blade/Initialize(mapload, obj/item/mod/control/connected_mod)
	. = ..()
	mod = connected_mod

/obj/item/melee/mod_blade/Destroy(force)
	. = ..()
	mod = null

/obj/item/melee/mod_blade/examine(mob/user)
	. = ..()
	. += span_notice("Right click for AOE attack.")

/obj/item/melee/mod_blade/pre_attack_secondary(atom/target, mob/living/user, params)
	. = ..()
	if(!COOLDOWN_FINISHED(src, cooldown_aoe))
		user.balloon_alert(user, "On cooldown!")
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
	if(!mod.subtract_charge(alt_attack_power_cost))
		user.balloon_alert(user, "No power!")
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
	COOLDOWN_START(src, cooldown_aoe, alt_attack_cooldown)
	var/turf/user_turf = get_turf(user)
	var/dir_to_target = get_dir(user_turf, get_turf(target))
	var/static/list/attack_angles = list(0, -45, 45)
	for(var/i in attack_angles)
		var/turf/turf = get_step(user_turf, turn(dir_to_target, i))
		for(var/mob/living/living_target in turf)
			if(user.Adjacent(living_target) && living_target.body_position != LYING_DOWN)
				living_target.apply_damage(alt_attack_force, BRUTE, attacking_item = src)
	playsound(get_turf(user), 'tff_modular/master_files/sounds/anomaly_attack_slice.ogg', 40)
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/item/melee/mod_blade/syndicate
	name = "\improper MOD armblade"
	desc = "A sharp, stylish and massive MOD blade built into the hand. This blade is especially strong, \
			colored blood red, and can cut through flesh like butter."
	icon_state = "mod_armblade"
	inhand_icon_state = "mod_armblade"
	force = 30
	wound_bonus = 30
	bare_wound_bonus = 30
	alt_attack_force = 20
	alt_attack_cooldown = 1 SECONDS
	alt_attack_power_cost = 100

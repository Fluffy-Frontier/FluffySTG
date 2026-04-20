#define HAMMER_FLING_DISTANCE 2
#define HAMMER_THROW_FLING_DISTANCE 3
#define COGSCARAB_BOW_DRAW_TIME_MULT 20

/obj/item/clockwork/weapon
	name = "clockwork weapon"
	desc = "Something"
	icon = 'tff_modular/modules/antagonists/clock_cult/icons/obj/clockwork_weapons.dmi'
	lefthand_file = 'tff_modular/modules/antagonists/clock_cult/icons/mob/clockwork_lefthand.dmi'
	righthand_file = 'tff_modular/modules/antagonists/clock_cult/icons/mob/clockwork_righthand.dmi'
	worn_icon = 'tff_modular/modules/antagonists/clock_cult/icons/mob/clockwork_garb_worn.dmi'
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
	throwforce = 20
	throw_speed = 4
	armour_penetration = 10
	hitsound = 'sound/items/weapons/bladeslice.ogg'
	attack_verb_continuous = list("attacks", "pokes", "jabs", "tears", "gores")
	attack_verb_simple = list("attack", "poke", "jab", "tear", "gore")
	sharpness = SHARP_EDGED
	wound_bonus = -15 //wounds are really strong for clock cult, so im making their weapons slightly worse then normal at wounding
	var/static/list/effect_turf_typecache_bronze = typecacheof(/turf/open/floor/bronze)
	var/static/list/effect_turf_typecache_void = typecacheof(/turf/open/indestructible/reebe_void)
	var/static/list/effect_turf_typecache_engine = typecacheof(/turf/open/floor/engine/clockwork)
	var/static/list/effect_turf_typecache_reebe = typecacheof(/turf/open/indestructible/reebe_flooring)

/obj/item/clockwork/weapon/attack(mob/living/target_mob, mob/living/user, list/modifiers, list/attack_modifiers)
	. = ..()
	var/turf/gotten_turf = get_turf(user.loc)
	if(is_type_in_typecache(gotten_turf, effect_turf_typecache_bronze) || is_type_in_typecache(gotten_turf, effect_turf_typecache_void) || is_type_in_typecache(gotten_turf, effect_turf_typecache_engine) || is_type_in_typecache(gotten_turf, effect_turf_typecache_reebe))

		if(QDELETED(target_mob))
			return

		if(ismob(target_mob))
			if(target_mob.stat != DEAD && !IS_CLOCK(target_mob) && !target_mob.can_block_magic(MAGIC_RESISTANCE_HOLY))
				mob_hit_effect(target_mob, user)
			return

		atom_hit_effect(target_mob, user)

/obj/item/clockwork/weapon/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	. = ..()
	if(.)
		return

	if(!isliving(hit_atom))
		return

	var/mob/living/target = hit_atom
	if(!target.can_block_magic(MAGIC_RESISTANCE_HOLY) && !IS_CLOCK(target))
		mob_hit_effect_thrown(target, throwingdatum.thrower)

/// What occurs to non-holy mobs when attacked from brass tiles
/obj/item/clockwork/weapon/proc/mob_hit_effect_thrown(mob/living/target, mob/living/user)
	return

/// What occurs to non-holy mobs when attacked from brass tiles
/obj/item/clockwork/weapon/proc/mob_hit_effect(mob/living/target, mob/living/user)
	return

/// What occurs to non-mob atoms when attacked from brass tiles
/obj/item/clockwork/weapon/proc/atom_hit_effect(mob/living/target, mob/living/user)
	return

// Копье, которое можно кидать во врагов и призывать в ручки
/obj/item/clockwork/weapon/brass_spear
	name = "brass spear"
	desc = "A razor-sharp spear made of brass. It thrums with barely-contained energy."
	base_icon_state = "ratvarian_spear"
	icon_state = "ratvarian_spear0"
	embed_type = /datum/embedding/brass_spear
	throwforce = 40
	force = 12.5
	armour_penetration = 40
	block_chance = 15
	clockwork_desc = "Can be summoned back to its last holder every 10 seconds if they are standing on bronze."

/datum/embedding/brass_spear
	pain_mult = 1.5
	embed_chance = 80
	fall_chance = 5
	ignore_throwspeed_threshold = TRUE
	impact_pain_mult = 1.5

/obj/item/clockwork/weapon/brass_spear/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/two_handed, \
		force_multiplier = 2, \
		icon_wielded = "[base_icon_state]1", \
		wield_callback = CALLBACK(src, PROC_REF(on_wield)), \
		unwield_callback = CALLBACK(src, PROC_REF(on_unwield)), \
	)

/obj/item/clockwork/weapon/brass_spear/update_icon_state()
	icon_state = "[base_icon_state]0"
	return ..()

/obj/item/clockwork/weapon/brass_spear/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text, final_block_chance, damage, attack_type)
	if(HAS_TRAIT(src, TRAIT_WIELDED))
		final_block_chance += 30
	return ..()

/obj/item/clockwork/weapon/brass_spear/proc/on_wield()
	attack_speed = max(attack_speed - 3, 1)

/obj/item/clockwork/weapon/brass_spear/proc/on_unwield()
	attack_speed += 3 //yes technically this could break with the max() in on_wield() but you should not be getting attack speed that low anyway so its only there for sanity

// Молот, атакующий в 2 раза медленнее чем другое оружие, но с большим АП и уроном, еще и отбрасывает на тайлах бронзы/при броске.
/obj/item/clockwork/weapon/brass_battlehammer
	name = "brass battle-hammer"
	desc = "A brass hammer glowing with energy."
	base_icon_state = "ratvarian_hammer"
	icon_state = "ratvarian_hammer0"
	force = 15
	throwforce = 30
	armour_penetration = 35
	attack_verb_simple = list("bash", "hammer", "attack", "smash")
	attack_verb_continuous = list("bashes", "hammers", "attacks", "smashes")
	attack_speed = 16
	clockwork_desc = "Enemies hit by this will be flung back while you are on bronze tiles."
	sharpness = FALSE
	hitsound = 'sound/items/weapons/smash.ogg'
	block_chance = 10
	demolition_mod = 2

/obj/item/clockwork/weapon/brass_battlehammer/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/two_handed, \
		force_unwielded = 15, \
		icon_wielded = "[base_icon_state]1", \
		force_wielded = 30, \
	)

/obj/item/clockwork/weapon/brass_battlehammer/mob_hit_effect(mob/living/target, mob/living/user)
	if(HAS_TRAIT(src, TRAIT_WIELDED))
		var/atom/throw_target = get_edge_target_turf(target, get_dir(src, get_step_away(target, src)))
		target.throw_at(throw_target, HAMMER_FLING_DISTANCE, 4)

/obj/item/clockwork/weapon/brass_battlehammer/mob_hit_effect_thrown(mob/living/target, mob/living/user)
	var/atom/throw_target = get_edge_target_turf(target, get_dir(src, get_step_away(target, src)))
	target.throw_at(throw_target, HAMMER_THROW_FLING_DISTANCE, 4)

/obj/item/clockwork/weapon/brass_battlehammer/update_icon_state()
	icon_state = "[base_icon_state]0"
	return ..()

// Меч атакующий концентрированным ЭМИ. Имеет хороший урон, АП и небольшой шанс блока.
/obj/item/clockwork/weapon/brass_sword
	name = "brass longsword"
	desc = "A large sword made of brass."
	icon_state = "ratvarian_sword"
	force = 25
	throwforce = 15
	armour_penetration = 30
	attack_verb_simple = list("attack", "slash", "cut", "tear", "gore")
	attack_verb_continuous = list("attacks", "slashes", "cuts", "tears", "gores")
	clockwork_desc = "Enemies and mechs will be struck with a powerful electromagnetic pulse while you are on bronze tiles, with a cooldown. It seems to only be able to parry melee attacks."
	block_chance = 20
	COOLDOWN_DECLARE(emp_cooldown)

/obj/item/clockwork/weapon/brass_sword/mob_hit_effect(mob/living/target, mob/living/user, thrown)
	if(!COOLDOWN_FINISHED(src, emp_cooldown))
		return

	COOLDOWN_START(src, emp_cooldown, 30 SECONDS)

	target.emp_act(EMP_LIGHT)
	new /obj/effect/temp_visual/emp/pulse(get_turf(target))
	addtimer(CALLBACK(src, PROC_REF(send_message), user), 30 SECONDS)
	to_chat(user, span_brass("You strike [target] with an electromagnetic pulse!"))
	playsound(user, 'sound/effects/magic/lightningshock.ogg', 40)

/obj/item/clockwork/weapon/brass_sword/atom_hit_effect(atom/attacked, mob/living/user, thrown)
	if(!istype(attacked, /obj/vehicle) || !COOLDOWN_FINISHED(src, emp_cooldown))
		return

	var/obj/vehicle/target = attacked
	COOLDOWN_START(src, emp_cooldown, 20 SECONDS)
	target.emp_act(EMP_HEAVY)
	new /obj/effect/temp_visual/emp/pulse(get_turf(target))
	addtimer(CALLBACK(src, PROC_REF(send_message), user), 20 SECONDS)
	to_chat(user, span_brass("You strike [target] with an electromagnetic pulse!"))
	playsound(user, 'sound/effects/magic/lightningshock.ogg', 40)

/obj/item/clockwork/weapon/brass_sword/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text, final_block_chance, damage, attack_type)
	return attack_type == MELEE_ATTACK && ..()

/obj/item/clockwork/weapon/brass_sword/proc/send_message(mob/living/target)
	to_chat(target, span_brass("[src] glows, indicating the next attack will disrupt electronics of the target."))

// фу...
/obj/item/gun/ballistic/bow/clockwork
	name = "brass bow"
	desc = "A bow made from brass and other components that you can't quite understand. It glows with a deep energy and frabricates arrows by itself. \
			It's bolts destabilize hit structures, making them lose additional integrity."
	icon = 'tff_modular/modules/antagonists/clock_cult/icons/obj/clockwork_weapons.dmi'
	lefthand_file = 'tff_modular/modules/antagonists/clock_cult/icons/mob/clockwork_lefthand.dmi'
	righthand_file = 'tff_modular/modules/antagonists/clock_cult/icons/mob/clockwork_righthand.dmi'
	icon_state = "bow_clockwork_unchambered_undrawn"
	inhand_icon_state = "clockwork_bow"
	base_icon_state = "bow_clockwork"
	force = 10
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/bow/clockwork
	/// Time between bolt recharges
	var/recharge_time = 1.5 SECONDS
	var/empowered = FALSE
	var/static/list/effect_turf_typecache_bronze = typecacheof(/turf/open/floor/bronze)
	var/static/list/effect_turf_typecache_void = typecacheof(/turf/open/indestructible/reebe_void)
	var/static/list/effect_turf_typecache_engine = typecacheof(/turf/open/floor/engine/clockwork)
	var/static/list/effect_turf_typecache_reebe = typecacheof(/turf/open/indestructible/reebe_flooring)

/obj/item/gun/ballistic/bow/clockwork/Initialize(mapload)
	. = ..()
	update_icon_state()
	AddElement(/datum/element/clockwork_description, "Firing from brass tiles will halve the time that it takes to recharge a bolt.")
	AddElement(/datum/element/clockwork_pickup)

/obj/item/gun/ballistic/bow/clockwork/try_fire_gun(atom/target, mob/living/user, params)
	if(!drawn || !chambered)
		to_chat(user, span_notice("[src] must be drawn to fire a shot!"))
		return FALSE
	return ..()

/obj/item/gun/ballistic/bow/clockwork/shoot_live_shot(mob/living/user, pointblank, atom/pbtarget, message)
	. = ..()
	var/turf/gotten_turf = get_turf(user.loc)
	if(is_type_in_typecache(gotten_turf, effect_turf_typecache_bronze) || is_type_in_typecache(gotten_turf, effect_turf_typecache_void) || is_type_in_typecache(gotten_turf, effect_turf_typecache_engine) || is_type_in_typecache(gotten_turf, effect_turf_typecache_reebe))
		recharge_time = 0.75 SECONDS

	addtimer(CALLBACK(src, PROC_REF(recharge_bolt)), recharge_time)
	recharge_time = initial(recharge_time)

/obj/item/gun/ballistic/bow/clockwork/attack_self(mob/living/user)
	if(drawn || !chambered)
		return

	if(!do_after(user, 0.5 SECONDS * (iscogscarab(user) ? COGSCARAB_BOW_DRAW_TIME_MULT : 1), src))
		return

	to_chat(user, span_notice("You draw back the bowstring."))
	drawn = TRUE
	playsound(src, 'sound/items/weapons/draw_bow.ogg', 75, 0) //gets way too high pitched if the freq varies
	update_icon()

/// Recharges a bolt, done after the delay in shoot_live_shot
/obj/item/gun/ballistic/bow/clockwork/proc/recharge_bolt()
	var/obj/item/ammo_casing/caseless/arrow/clockbolt/bolt = new
	magazine.give_round(bolt)
	chambered = bolt
	update_icon()

/obj/item/gun/ballistic/bow/clockwork/attackby(obj/item/attacking_item, mob/user, list/modifiers, list/attack_modifiers)
	return

/obj/item/gun/ballistic/bow/clockwork/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]_[chambered ? "chambered" : "unchambered"]_[drawn ? "drawn" : "undrawn"]"

/obj/item/ammo_box/magazine/internal/bow/clockwork
	ammo_type = /obj/item/ammo_casing/caseless/arrow/clockbolt
	start_empty = FALSE

/obj/item/ammo_casing/caseless/arrow/clockbolt
	name = "energy bolt"
	desc = "An arrow made from a strange energy."
	icon = 'tff_modular/modules/antagonists/clock_cult/icons/obj/ammo.dmi'
	icon_state = "arrow_redlight"
	projectile_type = /obj/projectile/energy/clockbolt

/obj/projectile/energy/clockbolt
	name = "energy bolt"
	icon = 'tff_modular/modules/antagonists/clock_cult/icons/obj/projectiles.dmi'
	icon_state = "arrow_energy"
	damage = 35
	damage_type = BURN

//double damage to non clockwork structures and machines(if we rework reebe itself this will no longer be needed)
/obj/projectile/energy/clockbolt/on_hit(atom/target, blocked, pierce_hit)
	if(ismob(target))
		var/mob/mob_target = target
		if(IS_CLOCK(mob_target)) //friendly fire is bad
			return

	. = ..()
	if(!.)
		return

	if(!QDELETED(target) && (istype(target, /obj/structure) || istype(target, /obj/machinery)) && !istype(target, /obj/structure/destructible/clockwork))
		target.update_integrity(target.get_integrity() - 25)

/obj/item/gun/ballistic/rifle/lionhunter/clockwork
	name = "brass rifle"
	desc = "An antique, brass rifle made with the finest of care. It has an ornate scope in the shape of a cog built into the top."
	icon = 'modular_nova/modules/clock_cult/icons/weapons/clockwork_weapons_40x32.dmi'
	lefthand_file = 'modular_nova/modules/clock_cult/icons/weapons/clockwork_lefthand.dmi'
	righthand_file = 'modular_nova/modules/clock_cult/icons/weapons/clockwork_righthand.dmi'
	worn_icon = 'modular_nova/modules/clock_cult/icons/clockwork_garb_worn.dmi'
	slot_flags = ITEM_SLOT_BACK
	icon_state = "clockwork_rifle"
	inhand_icon_state = "clockwork_rifle"
	worn_icon_state = "clockwork_rifle"
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/boltaction/lionhunter/clockwork
	fire_sound = 'sound/items/weapons/gun/sniper/shot.ogg'
	show_bolt_icon = FALSE

/obj/item/gun/ballistic/rifle/lionhunter/clockwork/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/clockwork_pickup)

/obj/item/ammo_box/magazine/internal/boltaction/lionhunter/clockwork
	name = "brass rifle internal magazine"
	ammo_type = /obj/item/ammo_casing/strilka310/lionhunter/clock

/obj/item/ammo_casing/strilka310/lionhunter/clock
	name = "brass rifle round"
	projectile_type = /obj/projectile/bullet/strilka310/lionhunter/clock
	min_distance = 3

/obj/projectile/bullet/strilka310/lionhunter/clock
	name = "brass .310 bullet"
	damage = 35
	stamina = 35

/obj/item/ammo_box/speedloader/strilka310/lionhunter/clock
	name = "stripper clip (.310 brass)"
	desc = "A stripper clip that's just as brass as the rounds it holds."
	icon = 'modular_nova/modules/clock_cult/icons/weapons/ammo.dmi'
	icon_state = "762_brass"
	ammo_type = /obj/item/ammo_casing/strilka310/lionhunter/clock
	max_ammo = 20
	multiple_sprites = AMMO_BOX_PER_BULLET

/obj/item/storage/pouch/ammo/clock

/obj/item/storage/pouch/ammo/clock/PopulateContents()
	var/static/items_inside = list(
		/obj/item/ammo_box/speedloader/strilka310/lionhunter/clock = 1
	)

	generate_items_inside(items_inside, src)

#undef HAMMER_FLING_DISTANCE
#undef HAMMER_THROW_FLING_DISTANCE
#undef COGSCARAB_BOW_DRAW_TIME_MULT

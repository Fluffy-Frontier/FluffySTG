GLOBAL_LIST_EMPTY(enchantment_datums_by_type)

/datum/component/enchanted
	dupe_mode = COMPONENT_DUPE_ALLOWED
	///Current enchantment level
	var/level
	///The span we warp our examine text in
	var/used_span
	///A ref to the enchantment datum we are using
	var/datum/enchantment/used_enchantment
	///A list of all enchantments
	var/static/list/all_enchantments = list()

/datum/component/enchanted/Initialize(list/select_enchants_from = subtypesof(/datum/enchantment), used_span = "<span class='purple'>", level_override)
	if(!isitem(parent))
		return COMPONENT_INCOMPATIBLE

	if(!length(select_enchants_from))
		stack_trace("[src.type] calling Initialize with unset select_enchants_from.")
		return COMPONENT_INCOMPATIBLE

	if(!length(all_enchantments))
		generate_enchantment_datums()

	for(var/entry in select_enchants_from)
		if(ispath(entry))
			select_enchants_from -= entry
			select_enchants_from += GLOB.enchantment_datums_by_type[entry]

	used_enchantment = pick(select_enchants_from)
	src.used_span = used_span
	level = level_override || rand(1, used_enchantment.max_level)

/datum/component/enchanted/RegisterWithParent()
	var/list/component_list = used_enchantment.components_by_parent[parent]
	if(!component_list)
		used_enchantment.components_by_parent[parent] = list(text_ref(used_enchantment) = src) //used_enchantment is not being taken as a ref?
	else
		component_list[used_enchantment] = src
	used_enchantment.apply_effect(parent, level)
	RegisterSignal(parent, COMSIG_ATOM_EXAMINE, PROC_REF(on_examine))

/datum/component/enchanted/UnregisterFromParent()
	UnregisterSignal(parent, COMSIG_ATOM_EXAMINE)
	var/list/component_list = used_enchantment.components_by_parent[parent]
	component_list -= used_enchantment
	if(!length(component_list))
		used_enchantment.components_by_parent -= parent

/datum/component/enchanted/Destroy(force)
	used_enchantment = null
	return ..()

/datum/component/enchanted/proc/on_examine(datum/source, mob/user, list/examine_list)
	SIGNAL_HANDLER

	if(!used_enchantment.examine_description)
		return

	if(isobserver(user) || HAS_MIND_TRAIT(user, TRAIT_MAGICALLY_GIFTED))
		if(used_span)
			examine_list += "[used_span][used_enchantment.examine_description]</span>"
			examine_list += "[used_span]It's blessing has a power of [level]!</span><br/>"
			return
		examine_list += "[used_enchantment.examine_description]"
		examine_list += "It's blessing has a power of [level]!<br/>"
	else
		examine_list += "It is glowing slightly!"
		var/mob/living/living_user = user
		if(istype(living_user.get_item_by_slot(ITEM_SLOT_EYES), /obj/item/clothing/glasses/science))
			examine_list += "It emits a readable EMF factor of [level]."

/datum/enchantment
	///Examine text
	var/examine_description
	///Maximum enchantment level
	var/max_level = 1
	///Typecache of items we are allowed on, generation handled in get_allowed_on
	var/list/allowed_on
	///A recursive assoc list keyed as: [parent] = list(text_ref(enchant_component.used_enchantment) = enchant_component)
	var/static/list/list/datum/component/enchanted/components_by_parent = list()

/datum/enchantment/New()
	. = ..()
	allowed_on = get_allowed_on()

/**
 * Because of dumb BYOND reasons in order to get fine manual control we need to handle generation of allowed_on this way(via setting the default passed values)
 *
 * allowed_on_base - Typecache of items we are allowed on
 *
 * denied_from - Anything in this list will be set to FALSE in allowed_on
 *
 * overriden_types - Any values in this list will override allowed_on, this is handled last
 */
/datum/enchantment/proc/get_allowed_on(list/allowed_on_base = typecacheof(/obj/item), list/denied_from = typesof(/obj/item/clothing), list/overriden_types = list()) //AHHHHH
	if(denied_from)
		for(var/denied_entry in denied_from)
			allowed_on_base[denied_entry] = 0
	if(overriden_types)
		for(var/entry in overriden_types)
			allowed_on_base[entry] = overriden_types[entry]
	return allowed_on_base

/datum/enchantment/proc/get_component_from_parent(obj/item/parent) as /datum/component/enchanted
	RETURN_TYPE(/datum/component/enchanted)
	var/list/parent_list = components_by_parent[parent]
	if(!parent_list)
		return FALSE
	return parent_list[text_ref(src)]

/datum/enchantment/proc/can_apply_to(obj/item/checked)
	return allowed_on[checked.type] && examine_description

/datum/enchantment/proc/apply_effect(obj/item/target, level)
	register_item(target)

///Handle comsig reg here
/datum/enchantment/proc/register_item(obj/item/target)
	return

///Handle comsig unreg here
/datum/enchantment/proc/unregister_item(obj/item/target)
	return

/datum/enchantment/clothing

/datum/enchantment/clothing/get_allowed_on(list/allowed_on_base = typecacheof(/obj/item/clothing), list/denied_from = list(), list/overriden_types)
	return ..()

/proc/attempt_enchantment(obj/item/enchanted, list/valid_enchant_types = subtypesof(/datum/enchantment), description_span = "<span class='purple'>", level_override)
	if(!isitem(enchanted))
		return FALSE

	if(!length(GLOB.enchantment_datums_by_type))
		generate_enchantment_datums()

	if(!islist(valid_enchant_types))
		valid_enchant_types = list(valid_enchant_types)

	for(var/datum/enchantment/enchant as anything in valid_enchant_types)
		valid_enchant_types -= enchant
		enchant = GLOB.enchantment_datums_by_type[enchant]
		if(enchant.can_apply_to(enchanted))
			valid_enchant_types += enchant

	if(!length(valid_enchant_types))
		return FALSE
	return enchanted.AddComponent(/datum/component/enchanted, valid_enchant_types, description_span, level_override)

/proc/generate_enchantment_datums()
	for(var/datum/enchantment/enchant as anything in subtypesof(/datum/enchantment))
		GLOB.enchantment_datums_by_type[enchant] = new enchant()

/datum/enchantment/blinding
	examine_description = "It has been blessed with the power to emit a blinding light when striking a target."
	max_level = 1

/datum/enchantment/blinding/register_item(obj/item/target)
	RegisterSignal(target, COMSIG_ITEM_ATTACK, PROC_REF(flash_target))

/datum/enchantment/blinding/unregister_item(obj/item/target)
	UnregisterSignal(target, COMSIG_ITEM_ATTACK)

/datum/enchantment/blinding/proc/flash_target(obj/item/source, mob/living/target, mob/living/user)
	if(!istype(target))
		return
	source.visible_message(span_danger("\The [source] emits a blinding light!"))
	target.flash_act(2, affect_silicon = TRUE, length = 3 SECONDS) //might want to make this not effect borgs

//might have to change this due to us having TG instead of bee blocking
/datum/enchantment/blocking
	examine_description = "It has been blessed with the gift of blocking."
	max_level = 3

/datum/enchantment/blocking/apply_effect(obj/item/target, level)
	target.block_chance += 5 * level

/datum/enchantment/burn
	examine_description = "It has been blessed with the power of fire and will set struck targets on fire."
	max_level = 3

/datum/enchantment/burn/apply_effect(obj/item/target, level)
	. = ..()
	target.damtype = BURN

/datum/enchantment/burn/register_item(obj/item/target)
	RegisterSignal(target, COMSIG_ITEM_ATTACK, PROC_REF(burn_target))

/datum/enchantment/burn/unregister_item(obj/item/target)
	UnregisterSignal(target, COMSIG_ITEM_ATTACK)
	return ..()

/datum/enchantment/burn/proc/burn_target(obj/item/source, atom/movable/target, mob/living/user)
	if(!isliving(target))
		return
	var/datum/component/enchanted/comp = get_component_from_parent(source)
	if(!comp)
		return

	var/mob/living/living_target = target
	living_target.adjust_fire_stacks(comp.level)
	living_target.ignite_mob()

/datum/enchantment/electricution
	max_level = 3
	examine_description = "It has been blessed with the power of electricity and will shock targets."

/datum/enchantment/electricution/register_item(obj/item/target)
	RegisterSignal(target, COMSIG_ITEM_ATTACK, PROC_REF(shock_target))

/datum/enchantment/electricution/unregister_item(obj/item/target)
	UnregisterSignal(target, COMSIG_ITEM_ATTACK)

/datum/enchantment/electricution/proc/shock_target(obj/item/source, atom/movable/target, mob/living/user)
	user.Beam(target, icon_state = "lightning[rand(1,12)]", time = 2, maxdistance = 32)
	if(!iscarbon(target))
		return
	var/datum/component/enchanted/comp = get_component_from_parent(source)
	if(!comp)
		return

	var/mob/living/carbon/carbon_target = target
	if(carbon_target.electrocute_act(comp.level * 3, user, 1, SHOCK_NOSTUN)) //need to make this ark, also this seems to work on any living mob
		carbon_target.visible_message(span_danger("[user] electrocutes [target]!"), span_userdanger("[user] electrocutes you!"))

/datum/enchantment/haste
	examine_description = "It has been blessed with the ability to warp time around it so that it's user may attack faster with it."
	max_level = 1

/datum/enchantment/haste/apply_effect(obj/item/target)
	target.attack_speed = max(1, target.attack_speed - 2)

/datum/enchantment/penetration
	examine_description = "It has been blessed with the gift of armor penetration, allowing it to cut through targets with ease."
	max_level = 5

/datum/enchantment/penetration/apply_effect(obj/item/target, level)
	target.armour_penetration = max(15 * level, target.armour_penetration)

/datum/enchantment/sharpness
	examine_description = "It has been blessed with the gift of sharpness."
	max_level = 5

/datum/enchantment/sharpness/apply_effect(obj/item/target, level)
	target.force += 2 * level

/datum/enchantment/soul_tap
	examine_description = "It has been blessed with the power of ripping the energy from target's souls and will heal the wielder when a target is struck."
	max_level = 3

/datum/enchantment/soul_tap/unregister_item(obj/item/target)
	UnregisterSignal(target, COMSIG_ITEM_ATTACK)

/datum/enchantment/soul_tap/register_item(obj/item/target)
	RegisterSignal(target, COMSIG_ITEM_ATTACK, PROC_REF(tap_soul))

/datum/enchantment/soul_tap/proc/tap_soul(obj/item/source, mob/living/target, mob/living/user)
	if(!istype(target) || target.stat != CONSCIOUS)
		return
	var/datum/component/enchanted/comp = get_component_from_parent(source)
	if(!comp)
		return
	var/health_back = CEILING(comp.level * source.force * 0.1, 1)
	user.heal_overall_damage(health_back, health_back)
	new /obj/effect/temp_visual/heal(get_turf(user), "#eeba6b")

/datum/enchantment/tiny
	examine_description = "It has been blessed and distorts reality into a tiny space around it."
	max_level = 1

/datum/enchantment/tiny/get_allowed_on(list/allowed_on_base, list/denied_from = list(), list/overriden_types)
	. = ..()

/datum/enchantment/tiny/apply_effect(obj/item/target)
	target.w_class = WEIGHT_CLASS_TINY

/obj/item/mod/module/tool_arms
	name = "MOD tools arms module"
	desc = "A module installed to users spine. That gift\
			Thwo mechanical robotics arm with kit of basic tools."
	complexity = 2
	module_type = MODULE_USABLE
	use_power_cost = DEFAULT_CHARGE_DRAIN * 2

	//Инструменты которые мы можем будем использовать.
	var/list/tool_list = list(
		/obj/item/screwdriver/cyborg,
		/obj/item/wrench/cyborg,
		/obj/item/weldingtool/electric,
		/obj/item/crowbar/cyborg,
		/obj/item/wirecutters/cyborg,
		/obj/item/multitool/cyborg,
	)
	//Инструменты выбранный в данный момент.
	var/obj/item/selected_tool = null


/obj/item/mod/module/tool_arms/Initialize(mapload)
	. = ..()
	for(var/typepath in tool_list)
		if(!ispath(typepath))
			continue
		var/atom/tool = new typepath(src)
		tool_list += WEAKREF(tool)

/obj/item/mod/module/tool_arms/Destroy()
	. = ..()
	if(selected_tool)
		detach(selected_tool)
	for(var/datum/weakref/ref in tool_list)
		var/obj/item/to_del = ref.resolve()
		if(!to_del)
			continue
		qdel(to_del)
	tool_list.Cut()

/obj/item/mod/module/tool_arms/on_activation()
	. = ..()
	var/list/opinions = list()
	for(var/datum/weakref/tool_ref as anything in tool_list)
		var/obj/item/tool_to_add = tool_ref.resolve()
		if(!tool_to_add)
			continue
		opinions[tool_to_add] = image(tool_to_add)
	if(!opinions)
		return
	var/obj/item/pick = show_radial_menu(mod.wearer, mod.wearer, opinions)
	if(!pick)
		return
	if(selected_tool)
		if(!detach(pick))
			return
		selected_tool = null
		if(pick = selected_tool)
			return
	if(extend(pick))
		mod.subtract_charge(DEFAULT_CHARGE_DRAIN)

/obj/item/mod/module/tool_arms/on_suit_deactivation(deleting)
	. = ..()
	if(selected_tool)
		detach(selected_tool)


/obj/item/mod/module/tool_arms/proc/extend(obj/item/extend_tool)
	if(!istype(extend_tool))
		return FALSE
	if(!mod.wearer.put_in_hand(extend_tool))
		mod.wearer.balloon_alert(mod.wearer, "Hands occuped!")
		return FALSE
	ADD_TRAIT(extend_tool, TRAIT_NODROP, ABSTRACT_ITEM_TRAIT)
	extend_tool.resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	extend_tool.slot_flags = null
	extend_tool.set_custom_materials(null)
	mod.wearer.visible_message(span_notice("[mod.wearer] use [mod.name] mechanical [extend_tool]."), span_notice("You extend [mod.name], [extend_tool], in you hand."), span_hear("You hear energy hiss."))
	mod.wearer.balloon_alert(mod.wearer, "Tool extendet!")
	playsound(get_turf(mod.wearer), 'tff_modular/master_files/sounds/energy_emit.ogg', 40)
	return TRUE

/obj/item/mod/module/tool_arms/proc/detach(obj/item/detach_tool)
	if(!istype(detach_tool))
		return FALSE
	if(!selected_tool)
		return FALSE
	selected_tool.forceMove(src)
	playsound(get_turf(mod.wearer), 'tff_modular/master_files/sounds/energy_emit.ogg', 40)
	mod.wearer.balloon_alert(mod.wearer, "Tool detached!")
	return TRUE

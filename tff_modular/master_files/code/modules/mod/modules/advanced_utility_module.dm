/obj/item/mod/module/itemgive
	module_type = MODULE_USABLE
	use_power_cost = DEFAULT_CHARGE_DRAIN * 2
	cooldown_time = 1 SECONDS

	icon = 'tff_modular/master_files/icons/obj/clothing/modsuits/mod_modules.dmi'
	overlay_icon_file = 'tff_modular/master_files/icons/mob/clothing/modsuits/mod_modules.dmi'
	var/list/items_to_give = list()
	var/obj/item/selected_item

/obj/item/mod/module/itemgive/Initialize(mapload)
	. = ..()
	for(var/typepath in items_to_give)
		if(!ispath(typepath))
			continue
		var/atom/item_to_create = new typepath(src)
		items_to_give += WEAKREF(item_to_create)
		items_to_give -= typepath

/obj/item/mod/module/itemgive/Destroy()
	. = ..()
	if(selected_item)
		detach(selected_item)
	for(var/datum/weakref/ref in items_to_give)
		var/obj/item/to_del = ref.resolve()
		if(!to_del)
			continue
		qdel(to_del)
	items_to_give.Cut()

/obj/item/mod/module/itemgive/on_use()
	. = ..()
	if(selected_item)
		if(!detach(selected_item))
			return
	var/list/opinions = list()
	var/obj/item/pick
	if(items_to_give.len > 1)
		for(var/datum/weakref/tool_ref as anything in items_to_give)
			var/obj/item/tool_to_add = tool_ref.resolve()
			if(!tool_to_add)
				continue
			opinions[tool_to_add] = image(tool_to_add)
		if(!opinions)
			return
		pick = show_radial_menu(mod.wearer, mod.wearer, opinions)
		if(!pick)
			return
	else if(items_to_give.len)
		var/datum/weakref/ref = items_to_give[1]
		pick = ref.resolve()

	extend(pick)
	mod.subtract_charge(DEFAULT_CHARGE_DRAIN)

/obj/item/mod/module/itemgive/on_suit_deactivation(deleting)
	. = ..()
	if(selected_item)
		detach(selected_item)

/obj/item/mod/module/itemgive/proc/extend(obj/item/extend_tool)
	if(!istype(extend_tool))
		return FALSE
	//Проверим ли, можем мы выдать предмет.
	if(!mod.wearer.put_in_hands(extend_tool))
		mod.wearer.balloon_alert(mod.wearer, "Hands occuped!")
		mod.wearer.transferItemToLoc(extend_tool, src, force = TRUE)
		return FALSE
	ADD_TRAIT(extend_tool, TRAIT_NODROP, REF(src))
	RegisterSignal(mod.wearer, COMSIG_KB_MOB_DROPITEM_DOWN, PROC_REF(on_drop))
	selected_item = extend_tool
	extend_tool.resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	extend_tool.slot_flags = null
	extend_tool.set_custom_materials(null)
	mod.wearer.visible_message(span_notice("[mod.wearer] use [mod.name] mechanical [extend_tool]."), span_notice("You extend [mod.name], [extend_tool], in you hand."), span_hear("You hear energy hiss."))
	mod.wearer.balloon_alert(mod.wearer, "Tool extendet!")
	playsound(get_turf(mod.wearer), 'tff_modular/master_files/sounds/energy_emit.ogg', 40)
	return TRUE

/obj/item/mod/module/itemgive/proc/detach(obj/item/detach_tool)
	if(!istype(detach_tool))
		return FALSE
	UnregisterSignal(mod.wearer, COMSIG_KB_MOB_DROPITEM_DOWN)
	selected_item.forceMove(src)
	selected_item = null
	playsound(get_turf(mod.wearer), 'tff_modular/master_files/sounds/energy_emit.ogg', 40)
	mod.wearer.balloon_alert(mod.wearer, "Tool detached!")
	return TRUE

/obj/item/mod/module/itemgive/proc/on_drop()
	if(!selected_item)
		return
	detach(selected_item)

/**
 * Модули
 */

/obj/item/mod/module/itemgive/tool_arms
	name = "MOD tools arms module"
	desc = "A module installed to users spine. That gift\
			Thwo mechanical robotics arm with kit of basic tools."
	complexity = 2

	overlay_state_inactive = "toolarm_module"
	icon_state = "module_toolarm"
	items_to_give = list(
		/obj/item/screwdriver/cyborg,
		/obj/item/wrench/cyborg,
		/obj/item/weldingtool/largetank/cyborg,
		/obj/item/crowbar/cyborg,
		/obj/item/wirecutters/cyborg,
		/obj/item/multitool/cyborg,
	)

/obj/item/mod/module/itemgive/rpd
	name = "MOD rpd module"
	desc = "A MOD module installed in users arm, gift a portable version of RPD device."
	complexity = 2
	icon_state = "module_pipe_dispanser"
	items_to_give = list(/obj/item/pipe_dispenser/mod)

/obj/item/mod/module/itemgive/part_replacer
	name = "MOD part replacer module"
	desc = "A MOD module installed in users arm, gift a portable version of bluespace part replacer device."
	complexity = 1
	icon_state = "module_part_replacer"
	items_to_give = list(/obj/item/storage/part_replacer/bluespace/mod)

/obj/item/mod/module/itemgive/experiscanner
	name = "MOD research scaner module"
	desc = "A MOD module installed in users arm, gift a portable version of research scaner."
	complexity = 1
	icon_state = "module_research_scaner"
	items_to_give = list(/obj/item/experi_scanner/mod)

/**
 * Предметы
 */

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

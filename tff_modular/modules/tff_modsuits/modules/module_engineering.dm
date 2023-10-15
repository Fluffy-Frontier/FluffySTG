/**
 * Модуль защиты от шока: несовместим с многими модулями, уменьшает защиту пользователя, но дает защиту от шока.
 */

/obj/item/mod/module/shock_protect
	name = "MOD shock protect module"
	desc = "A MOD module installed in users chest and arms, gift a shock resistant to suit parts,\
	but make this weak."
	icon = 'tff_modular/master_files/icons/obj/clothing/modsuits/mod_modules.dmi'
	icon_state = "module_shock_protect"
	complexity = 3
	idle_power_cost = DEFAULT_CHARGE_DRAIN * 0.5
	incompatible_modules = list(
		/obj/item/mod/module/shock_protect,
		/obj/item/mod/module/armor_booster,
		/obj/item/mod/module/magnetic_harness,
		/obj/item/mod/module/projectile_dampener,
		/obj/item/mod/module/rad_protection,
		/obj/item/mod/module/emp_shield,
		/obj/item/mod/module/stealth,
	)

/obj/item/mod/module/shock_protect/on_suit_activation()
	. = ..()
	for(var/obj/item/part as anything in mod.mod_parts)
		part.siemens_coefficient = 0


/obj/item/mod/module/shock_protect/on_suit_deactivation(deleting)
	. = ..()
	for(var/obj/item/part as anything in mod.mod_parts)
		part.siemens_coefficient = initial(part.siemens_coefficient)

/obj/item/mod/module/shock_protect/emp_act(severity)
	. = ..()
	if(!mod.wearer)
		return
	mod.wearer.electrocute_act(20, src, 1)
	to_chat(mod.wearer, span_userdanger("You feel like you [mod.name], throw powerfull electrical pusle in you!"))

/**
 * Модуль механических рук
 */

/obj/item/mod/module/itemgive/tool_arms
	name = "MOD tools arms module"
	desc = "A module installed to users spine. That gift\
			Thwo mechanical robotics arm with kit of basic tools."
	complexity = 2

	overlay_state_inactive = "toolarm_module"
	icon_state = "module_toolarm"
	incompatible_modules = list(/obj/item/mod/module/itemgive/tool_arms)
	items_to_give = list(
		/obj/item/screwdriver/cyborg,
		/obj/item/wrench/cyborg,
		/obj/item/weldingtool/largetank/cyborg,
		/obj/item/crowbar/cyborg,
		/obj/item/wirecutters/cyborg,
		/obj/item/multitool/cyborg,
	)

/**
 * Модуль РПД
 */

/obj/item/mod/module/itemgive/rpd
	name = "MOD rpd module"
	desc = "A MOD module installed in users arm, gift a portable version of RPD device."
	complexity = 2
	icon_state = "module_pipe_dispanser"
	items_to_give = list(/obj/item/pipe_dispenser/mod)
	incompatible_modules = list(/obj/item/mod/module/itemgive/rpd)

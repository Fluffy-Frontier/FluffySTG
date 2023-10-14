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

	var/datum/armor/mod_module_shock_protect/armor_debaf

/obj/item/mod/module/shock_protect/on_suit_activation()
	. = ..()
	for(var/obj/item/part as anything in mod.mod_parts)
		part.siemens_coefficient = 0
		part.set_armor(part.get_armor().add_other_armor(armor_debaf))

/obj/item/mod/module/shock_protect/on_suit_deactivation(deleting)
	. = ..()
	for(var/obj/item/part as anything in mod.mod_parts)
		part.siemens_coefficient = initial(part.siemens_coefficient)
		part.set_armor(initial(part.armor))

/datum/armor/mod_module_shock_protect
	melee = -10
	bullet = -10
	laser = -15

/**
 * Модуль энерго-копья.
 */
/obj/item/mod/module/energy_spear
	name = "MOD energy spear module"
	desc = "MOD module installed in the users arm, when activated, uses the suit's energy to \
			create a short-lived energy beam in the form of a spear. It has extremely high speed and \
			penetration characteristics."
	cooldown_time = 10 SECONDS
	module_type = MODULE_USABLE

	use_power_cost = POWER_CELL_USE_INSANE * 2
	icon = 'tff_modular/master_files/icons/obj/clothing/modsuits/mod_modules.dmi'
	icon_state = "module_energy_spear"
	incompatible_modules = list(
		/obj/item/mod/module/energy_spear,
		/obj/item/mod/module/holster,
	)
	var/deployed = FALSE
	var/datum/weakref/spear_ref

/obj/item/mod/module/energy_spear/on_use()
	if(!..())
		return
	//Если прошлое копье еще существует(каким-то образом), останавливаем создание нового.
	if(deployed)
		mod.wearer.balloon_alert(mod.wearer, "Old spear exist!")
		return FALSE
	var/obj/item/energy_spear/spear = new(src)
	if(!mod.wearer.put_in_hands(spear))
		mod.wearer.balloon_alert(mod.wearer, "Hands occuped!")
		qdel(spear)
		return FALSE
	spear_ref = WEAKREF(spear)
	mod.wearer.balloon_alert(mod.wearer, "Spear materialized for 10 seconds!")
	mod.wearer.visible_message(span_warning("[mod.wearer], materialize [spear.name] in [mod.wearer.p_they()], hand ready to throw!"), span_warning("You materialize energy spear in your hand."), span_hear("You hear energy clack."))
	RegisterSignal(spear, COMSIG_MOVABLE_PRE_THROW, PROC_REF(on_spear_throw))
	RegisterSignal(spear, COMSIG_QDELETING, PROC_REF(on_spear_delete))
	addtimer(CALLBACK(src, PROC_REF(spear_timeout)), 10 SECONDS)
	deployed = TRUE
	playsound(get_turf(mod.wearer), 'tff_modular/master_files/sounds/energy_emit.ogg', 40)
	icon_state = "module_energy_spear_deploed"
	update_icon_state()

/obj/item/mod/module/energy_spear/proc/spear_timeout()
	if(deployed)
		var/obj/item/energy_spear/spear = spear_ref.resolve()
		UnregisterSignal(spear, COMSIG_MOVABLE_PRE_THROW)
		qdel(spear)

/obj/item/mod/module/energy_spear/proc/on_spear_delete()
	SIGNAL_HANDLER

	spear_ref = null
	deployed = FALSE

	icon_state = "module_energy_spear"
	update_icon_state()

/obj/item/mod/module/energy_spear/proc/on_spear_throw()
	SIGNAL_HANDLER

	var/obj/item/energy_spear/spear = spear_ref.resolve()
	if(!istype(spear))
		return

	UnregisterSignal(spear, COMSIG_MOVABLE_PRE_THROW)
	QDEL_IN(spear, 5)

/**
 * Модуль клинка
 */

/obj/item/mod/module/itemgive/mod_blade
	name = "MOD blade module"
	desc = "Massive MOD blade built into the arm. Possesses monstrous strength."
	complexity = 5
	icon_state = "module_mod_blade"
	items_to_give = list(/obj/item/melee/mod_blade)
	incompatible_modules = list(
		/obj/item/mod/module/itemgive/mod_blade,
		/obj/item/mod/module/itemgive/mod_blade/syndicate,
	)

/obj/item/mod/module/itemgive/mod_blade/on_install()
	. = ..()
	for(var/obj/item/melee/mod_blade/blade in items_to_give)
		balde.mod = mod


/obj/item/mod/module/itemgive/mod_blade/on_uninstall(deleting)
	. = ..()
	for(var/obj/item/melee/mod_blade/blade in items_to_give)
		balde.mod = null

/obj/item/mod/module/itemgive/mod_blade/syndicate
	name = "MOD armblade module"
	icon_state = "module_mod_armblade"
	items_to_give = list(/obj/item/melee/mod_blade/syndicate)

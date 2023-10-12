/obj/item/borg/upgrade/cyborghug
	name = "Cyborg hug module"
	desc = "A addictional soft paw plating."
	icon = 'icons/mob/silicon/robot_items.dmi'
	icon_state = "hugmodule"

/obj/item/borg/upgrade/cyborghug/action(mob/living/silicon/robot/R, user)
	. = ..()
	if(!.)
		return

	var/obj/item/borg/cyborghug/hug = new /obj/item/borg/cyborghug(R.model)
	R.model.add_module(hug, FALSE, TRUE)

/obj/item/borg/upgrade/cyborghug/deactivate(mob/living/silicon/robot/R, user)
	. = ..()
	for(var/obj/item/borg/cyborghug/hug in R.model)
		R.model.remove_module(hug, TRUE)

/obj/item/borg/upgrade/cyborg_electical_welding_tool
	name = "Cyborg electical welding tool"
	desc = "A simply electrical welding tool designed for cyborgs. Used internal cell charge."
	icon = 'modular_skyrat/modules/aesthetics/tools/tools.dmi'
	icon_state = "elwelder"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/engineering, /obj/item/robot_model/saboteur)
	model_flags = BORG_MODEL_ENGINEERING

/obj/item/borg/upgrade/cyborg_electical_welding_tool/action(mob/living/silicon/robot/R, user)
	. = ..()
	if(!.)
		return

	for(var/obj/item/weldingtool/largetank/cyborg/old_welding_tool in R.model)
		R.model.remove_module(old_welding_tool, TRUE)
	var/obj/item/weldingtool/borg_electrical/new_welding_tool = new /obj/item/weldingtool/borg_electrical(R.model, R)
	R.model.add_module(new_welding_tool, FALSE, TRUE)

/obj/item/borg/upgrade/cyborg_electical_welding_tool/deactivate(mob/living/silicon/robot/R, user)
	. = ..()
	if(!.)
		return

	for(var/obj/item/weldingtool/borg_electrical/old_welding_tool in R.model)
		R.model.remove_module(old_welding_tool, TRUE)
	var/obj/item/weldingtool/largetank/cyborg/new_welding_tool = new /obj/item/weldingtool/largetank/cyborg(R.model, R)
	R.model.add_module(new_welding_tool, FALSE, TRUE)

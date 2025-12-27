//An actual HUD
/datum/hud/necromorph
	ui_style = 'icons/hud/screen_midnight.dmi'
	var/atom/movable/screen/meter/background/background
	var/atom/movable/screen/meter/health/health
	var/atom/movable/screen/meter/health/shield/shield
	var/atom/movable/screen/meter/foreground/foreground

/datum/hud/necromorph/New(mob/living/carbon/human/necromorph/owner)
	..()

//healthbar
	background = new
	health = new
	health.add_filter("alpha_mask", 1, alpha_mask_filter(icon = icon('tff_modular/modules/deadspace/icons/hud/healthbar.dmi', "alpha_mask"), x = clamp(HUD_METER_PIXEL_WIDTH*(owner.health/owner.maxHealth), 0, HUD_METER_PIXEL_WIDTH), flags = MASK_INVERSE))
	foreground = new
	if(owner.dodge_shield > 0)
		foreground.maptext = MAPTEXT("[max(0, owner.health)]+[owner.dodge_shield]/[owner.maxHealth]")
	else
		foreground.maptext = MAPTEXT("[max(0, owner.health)]/[owner.maxHealth]")

	shield = new
	shield.add_filter("alpha_mask", 1, alpha_mask_filter(icon = icon('tff_modular/modules/deadspace/icons/hud/healthbar.dmi', "alpha_mask"), x = clamp(HUD_METER_PIXEL_WIDTH*(owner.dodge_shield/owner.maxHealth), 0, HUD_METER_PIXEL_WIDTH), flags = MASK_INVERSE))

	infodisplay += background
	infodisplay += health
	infodisplay += shield
	infodisplay += foreground

//begin buttons
	var/atom/movable/screen/using

	using = new /atom/movable/screen/language_menu(null, src)
	using.icon = ui_style
	static_inventory += using

	using = new /atom/movable/screen/navigate(null, src)
	using.icon = ui_style
	static_inventory += using

	using = new /atom/movable/screen/area_creator(null, src)
	using.icon = ui_style
	static_inventory += using

	action_intent = new /atom/movable/screen/combattoggle/flashy(null, src)
	action_intent.icon = ui_style
	action_intent.screen_loc = ui_combat_toggle
	static_inventory += action_intent

	floor_change = new /atom/movable/screen/floor_changer(null, src)
	floor_change.icon = ui_style
	floor_change.screen_loc = ui_human_floor_changer
	static_inventory += floor_change

	using = new /atom/movable/screen/mov_intent(null, src)
	using.icon = ui_style
	using.icon_state = (owner.move_intent == MOVE_INTENT_RUN ? "running" : "walking")
	using.screen_loc = ui_movi
	static_inventory += using

	using = new /atom/movable/screen/drop(null, src)
	using.icon = ui_style
	using.screen_loc = ui_drop_throw
	static_inventory += using

	build_hand_slots()

	using = new /atom/movable/screen/swap_hand(null, src)
	using.icon = ui_style
	using.icon_state = "swap_1"
	using.screen_loc = ui_swaphand_position(owner,1)
	static_inventory += using

	using = new /atom/movable/screen/swap_hand(null, src)
	using.icon = ui_style
	using.icon_state = "swap_2"
	using.screen_loc = ui_swaphand_position(owner,2)
	static_inventory += using

	using = new /atom/movable/screen/resist(null, src)
	using.icon = ui_style
	using.screen_loc = ui_above_intent
	hotkeybuttons += using

	throw_icon = new /atom/movable/screen/throw_catch(null, src)
	throw_icon.icon = ui_style
	throw_icon.screen_loc = ui_drop_throw
	hotkeybuttons += throw_icon

	rest_icon = new /atom/movable/screen/rest(null, src)
	rest_icon.icon = ui_style
	rest_icon.screen_loc = ui_above_movement
	rest_icon.update_appearance()
	static_inventory += rest_icon

	pull_icon = new /atom/movable/screen/pull(null, src)
	pull_icon.icon = ui_style
	pull_icon.screen_loc = ui_above_intent
	pull_icon.update_appearance()
	static_inventory += pull_icon

	zone_select = new /atom/movable/screen/zone_sel(null, src)
	zone_select.icon = ui_style
	zone_select.update_appearance()
	static_inventory += zone_select

	healths = new /atom/movable/screen/healths(null, src)
	infodisplay += healths

	healthdoll = new /atom/movable/screen/healthdoll/human(null, src)
	infodisplay += healthdoll

	stamina = new /atom/movable/screen/stamina(null, src)
	infodisplay += stamina

/datum/hud/necromorph/Destroy()
	//They are actually deleted in QDEL_LIST(infodisplay)
	background = null
	health = null
	foreground = null
	return ..()

/datum/hud/necromorph/persistent_inventory_update(mob/viewer)
	if(!mymob)
		return
	..()
	var/mob/living/carbon/human/H = mymob

	var/mob/screenmob = viewer || H

	if(hud_version != HUD_STYLE_NOHUD)
		for(var/obj/item/I in H.held_items)
			I.screen_loc = ui_hand_position(H.get_held_index_of_item(I))
			screenmob.client.screen += I
	else
		for(var/obj/item/I in H.held_items)
			I.screen_loc = null
			screenmob.client.screen -= I

/datum/hud/necromorph/proc/update_healthbar(mob/living/carbon/human/necromorph/necro)
	animate(health.get_filter("alpha_mask"), x = clamp(HUD_METER_PIXEL_WIDTH*(necro.health/necro.maxHealth), 0, HUD_METER_PIXEL_WIDTH), time = 0.5 SECONDS)
	if(necro.dodge_shield > 0)
		foreground.maptext = MAPTEXT("[max(0, necro.health)]+[necro.dodge_shield]/[necro.maxHealth]")
	else
		foreground.maptext = MAPTEXT("[max(0, necro.health)]/[necro.maxHealth]")

/datum/hud/necromorph/proc/update_shieldbar(mob/living/carbon/human/necromorph/necro)
	animate(shield.get_filter("alpha_mask"), x = clamp(HUD_METER_PIXEL_WIDTH*(necro.dodge_shield/necro.maxHealth), 0, HUD_METER_PIXEL_WIDTH), time = 0.5 SECONDS)
	if(necro.dodge_shield > 0)
		foreground.maptext = MAPTEXT("[max(0, necro.health)]+[necro.dodge_shield]/[necro.maxHealth]")
	else
		foreground.maptext = MAPTEXT("[max(0, necro.health)]/[necro.maxHealth]")

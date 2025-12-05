/obj/item/buckshot_game
	name = "buckshot game item"
	// Описание предмета для игры
	var/use_desc = "This item is used to manage a game of buckshot roulette."
	// Владелец предмета
	var/mob/living/carbon/human/owner_player = null
	// Пати к которой привязан предмет
	var/datum/buckshoot_roulette_party/party = null
	// Можно ли применить предмет к мертому игроку
	var/use_on_death = FALSE

	obj_flags = INDESTRUCTIBLE|BOMB_PROOF|LAVA_PROOF|FIRE_PROOF

/obj/item/buckshot_game/Initialize(mapload, mob/living/carbon/human/owner, datum/buckshoot_roulette_party/party_instance)
	. = ..()
	owner_player = owner
	party = party_instance


/obj/item/buckshot_game/examine(mob/user)
	. = ..()
	. += "\n" + span_notice(use_desc)


/obj/item/buckshot_game/attempt_pickup(mob/living/user, skip_grav)
	. = ..()
	if(!party)
		return FALSE
	if(party.game_started)
		return FALSE
	if(user != owner_player)
		to_chat(user, span_warning("Это не твой предмет!"))
		return FALSE


/obj/item/buckshot_game/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!ishuman(interacting_with) && !istype(interacting_with, /obj/item/gun/ballistic/shotgun/buckshot_game))
		return ..()

	if(!party.game_started)
		to_chat(user, span_warning("Игра еще не началась!"))
		return ITEM_INTERACT_SUCCESS
	if(user != owner_player)
		to_chat(user, span_warning("Это не твой предмет!"))
		return ITEM_INTERACT_SUCCESS
	if(party.current_turn_player != user)
		to_chat(user, span_warning("Сейчас не твой ход!"))
		return ITEM_INTERACT_SUCCESS
	if(istype(interacting_with, /obj/item/gun/ballistic/shotgun/buckshot_game))
		use_on_shotgun(interacting_with, user)
	if(istype(interacting_with, /mob/living/carbon/human))
		var/mob/living/carbon/human/player = interacting_with
		if(!party.is_participant(player))
			to_chat(user, span_warning("Этот игрок не участвует в игре!"))
			return ITEM_INTERACT_SUCCESS
		if(player.stat == DEAD && !use_on_death)
			to_chat(user, span_warning("Нельзя использовать предмет на мертвого игрока!"))
			return ITEM_INTERACT_SUCCESS
		if(player == user)
			use_on_self(player)
		else
			use_on_other(user, player)
	return ITEM_INTERACT_SUCCESS

/obj/item/buckshot_game/ranged_interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!ishuman(interacting_with) && !istype(interacting_with, /obj/item/gun/ballistic/shotgun/buckshot_game))
		return ..()
	if(!party.game_started)
		to_chat(user, span_warning("Игра еще не началась!"))
		return ITEM_INTERACT_SUCCESS
	if(ishuman(interacting_with))
		var/mob/living/carbon/human/player = interacting_with
		if(!party.is_participant(player))
			to_chat(user, span_warning("Этот игрок не участвует в игре!"))
			return ITEM_INTERACT_SUCCESS
		if(player == user)
			use_on_self(player)
		else
			use_on_other(user, player)

/obj/item/buckshot_game/proc/use_on_other(mob/living/carbon/human/player, mob/living/carbon/human/other_player)
	return


/obj/item/buckshot_game/proc/use_on_self(mob/living/carbon/human/player)
	return


/obj/item/buckshot_game/proc/use_on_shotgun(obj/item/gun/ballistic/shotgun/buckshot_game/gun, mob/living/carbon/human/player)
	return


/obj/item/buckshot_game/cigarettes
	name = "premium cigarettes"
	desc = "A pack of cigarettes."
	icon = 'icons/obj/cigarettes.dmi'
	icon_state = "robust"
	use_desc = "Восстанавливают один заряд CRT механизма."


/obj/item/buckshot_game/cigarettes/use_on_self(mob/living/carbon/human/player)
	player.balloon_alert_to_viewers("Выкуривает сигарету.")
	var/datum/component/buckshoot_roulette_participant/participant = player.GetComponent(/datum/component/buckshoot_roulette_participant)
	if(!participant)
		to_chat(player, span_warning("Вы не участвуете в игре!"))
		return
	if(participant.lives >= 3)
		to_chat(player, span_warning("У вас уже максимальное количество жизней!"))
		return
	playsound(src, 'tff_modular/modules/buckshoot/sounds/item_cigarettes.ogg', 50, 1)
	if(!do_after(player, 5 SECONDS))
		return
	participant.add_lives(1)
	qdel(src)


/obj/item/buckshot_game/glass
	name = "Magnifying glass"
	desc = "A Magnifying glass."
	use_desc = "Позволяет проверить какой патрон заряжен в пробовике."
	icon = 'modular_nova/modules/primitive_production/icons/prim_fun.dmi'
	icon_state = "magnifying_glass"

/obj/item/buckshot_game/glass/use_on_shotgun(obj/item/gun/ballistic/shotgun/buckshot_game/gun, mob/living/carbon/human/player)
	. = ..()
	if(!gun.chambered)
		to_chat(player, span_warning("В пробовике нет патрона!"))
		return
	player.balloon_alert_to_viewers("Использует лупу, чтобы проверить патрон в дробовике.")
	playsound(src, 'tff_modular/modules/buckshoot/sounds/item_magnifier.ogg', 50, 1)
	if(!do_after(player, 3 SECONDS))
		return
	var/obj/item/ammo_casing/shotgun/buckshoot/round = gun.chambered
	var/msg = "В дробовике заряжен "
	if(istype(round, /obj/item/ammo_casing/shotgun/buckshoot/live))
		msg += "боевой патрон."
	else if(istype(round, /obj/item/ammo_casing/shotgun/buckshoot/blank))
		msg += "холостой патрон."
	else
		msg += "неизвестный патрон."
	to_chat(player, span_notice(msg))
	qdel(src)


/obj/item/buckshot_game/beer
	name = "space beer"
	desc = "Canned beer. In space."
	icon = 'icons/obj/drinks/soda.dmi'
	icon_state = "space_beer"
	use_desc = "Позволяет передергнуть затвор дробовика."

/obj/item/buckshot_game/beer/use_on_shotgun(obj/item/gun/ballistic/shotgun/buckshot_game/gun, mob/living/carbon/human/player)
	. = ..()
	playsound(src, 'tff_modular/modules/buckshoot/sounds/item_beer.ogg', 50, 1)
	player.balloon_alert_to_viewers("Пьет пиво.")
	if(!do_after(player, 5 SECONDS))
		return
	gun.rack(player)
	qdel(src)


/obj/structure/chair/buckshot
	name = "buckshot chair"
	desc = "A sturdy chair with integrated system of blood transfer and defibrilators."
	icon_state = "echair1"
	obj_flags = INDESTRUCTIBLE|BOMB_PROOF|LAVA_PROOF|FIRE_PROOF

	var/datum/buckshoot_roulette_party/party = null

/obj/structure/chair/buckshot/buckle_mob(mob/living/M, force, check_loc)
	if(!party)
		return ..()
	if(party.game_started)
		to_chat(M, span_warning("Ты не можешь сесть на кресло после начала игры!"))
		return
	return ..()


/obj/structure/chair/buckshot/unbuckle_mob(mob/living/buckled_mob, force, can_fall)
	if(!party)
		return ..()
	if(party.game_started && !party.can_free_exit)
		to_chat(buckled_mob, span_warning("Ты не можешь покинуть игру после начала! Нужно было лучше читать отказ от ответственности."))
		return
	return ..()


/obj/structure/chair/buckshot/proc/register_player(datum/buckshoot_roulette_party/party_instance)
	var/mob/living/carbon/human/player = get_current_player()
	if(!player)
		return FALSE
	if(!party_instance)
		return FALSE
	var/obj/structure/crt_mechanims/ctr = party_instance.get_ctr_for_player(player)
	player.AddComponent(/datum/component/buckshoot_roulette_participant, party_instance, src, ctr)
	return player


/obj/structure/chair/buckshot/proc/get_current_player()
	if(!has_buckled_mobs())
		return null
	for(var/mob/living/buckled in buckled_mobs)
		if(!ishuman(buckled))
			return null
		return buckled
	return null



/obj/structure/crt_mechanims
	name = "crt"
	desc = "A device equipped with a defibrillator, a blood transfusion system, and medication. It has several charges."

	icon = 'tff_modular/modules/buckshoot/icons/crt.dmi'
	icon_state = "crt0"
	base_icon_state = "crt"
	obj_flags = INDESTRUCTIBLE|BOMB_PROOF|LAVA_PROOF|FIRE_PROOF

	// Ссылка на компонент участника пати
	var/datum/component/buckshoot_roulette_participant/participant_comp = null
	// ССылка на стол
	var/obj/structure/table/buckshot/main_table = null


/obj/structure/crt_mechanims/examine(mob/user)
	. = ..()
	if(participant_comp)
		var/charges = participant_comp.get_crt_charges()
		. += span_notice("This CRT has [charges] charge(s) remaining.")

/obj/structure/crt_mechanims/Initialize(mapload, obj/structure/table/main_table)
	. = ..()
	src.main_table = main_table

/obj/structure/crt_mechanims/proc/set_participant(datum/component/buckshoot_roulette_participant/comp)
	participant_comp = comp
	update_icon_state()

/obj/structure/crt_mechanims/update_icon_state()
	. = ..()
	if(!participant_comp)
		icon_state = base_icon_state + "0"
		return
	var/charges = participant_comp.get_crt_charges()
	icon_state = base_icon_state + "[charges]"

/obj/structure/crt_mechanims/proc/revive_player()
	if(!participant_comp)
		return
	var/mob/living/carbon/human/player = participant_comp.player
	if(!player)
		return
	if(!player.stat == DEAD)
		return
	playsound(src, 'tff_modular/modules/buckshoot/sounds/defib_discharge.ogg', 50, 1)
	sleep(1.5 SECONDS)
	player.notify_revival("Your heart is being defibrillated!")
	player.grab_ghost() // Возращаем призрака в тело

	player.revive(HEAL_DAMAGE | HEAL_ORGANS | HEAL_BLOOD)
	player.set_heartattack(FALSE)
	player.setOxyLoss(0)
	player.setToxLoss(0)
	player.remove_status_effect(/datum/status_effect/neck_slice)

	player.reagents.add_reagent(/datum/reagent/blood, 20, list(
		"blood_DNA" = player.dna.unique_enzymes,
		"blood_type" = player.dna.blood_type
	))

	player.emote("gasp")
	player.set_jitter_if_lower(10 SECONDS)
	player.flash_act()
	log_game("[key_name(player)] was forcibly revived by Buckshoot crt device.")
	to_chat(player, span_userdanger("Your heart explodes back to life! You're back in the game!"))
	SEND_SOUND(player, 'tff_modular/modules/buckshoot/sounds/heartbeat_effect.ogg')



/obj/structure/table/buckshot_table_part
	// icon_state - устанавливается динамически
	icon = null
	icon_state = ""
	base_icon_state = ""
	smoothing_flags = NONE
	smoothing_groups = null
	canSmoothWith = null
	icon = 'tff_modular/modules/buckshoot/icons/crt.dmi'
	obj_flags = INDESTRUCTIBLE|BOMB_PROOF|LAVA_PROOF|FIRE_PROOF

	var/obj/structure/table/buckshot/main_table = null


/obj/structure/table/buckshot_table_part/Initialize(mapload, obj/structure/table_frame/frame_used, obj/item/stack/stack_used)
	. = ..()
	RemoveElement(/datum/element/connect_loc)
	RemoveElement(/datum/element/contextual_screentip_bare_hands)

/obj/structure/table/buckshot_table_part/flip_table(new_dir)
	return

/obj/structure/table/buckshot_table_part/unflip_table()
	return

/obj/structure/table/buckshot_table_part/attack_hand_secondary(mob/user, list/modifiers)
	return main_table.attack_hand_secondary(user, modifiers)


/obj/structure/table/buckshot
	name = "buckshot table"
	desc = "A sturdy table used in the game of buckshot roulette."
	icon = 'tff_modular/modules/buckshoot/icons/buckshot_table.dmi'
	icon_state = "multi-main"
	base_icon_state = "multi"
	smoothing_flags = NONE
	smoothing_groups = null
	canSmoothWith = null


	obj_flags = INDESTRUCTIBLE|BOMB_PROOF|LAVA_PROOF|FIRE_PROOF
	// Пати что привязана к столу
	var/datum/buckshoot_roulette_party/party = null
	// Части стола, для большого стола 3 на 3
	var/list/parts

	var/list/crts_by_dirs = list()


/obj/structure/table/buckshot/Initialize(mapload, obj/structure/table_frame/frame_used, obj/item/stack/stack_used)
	. = ..()
	RemoveElement(/datum/element/connect_loc)
	RemoveElement(/datum/element/contextual_screentip_bare_hands)
	party = new(src)
	build_table()
	create_crts()

/obj/structure/table/buckshot/flip_table(new_dir)
	return

/obj/structure/table/buckshot/unflip_table()
	return

/obj/structure/table/buckshot/Destroy(force)
	. = ..()
	if(party)
		party.end_game(TRUE)
	for(var/obj/structure/table/buckshot_table_part/part in parts)
		if(!QDELETED(part))
			qdel(part)
	parts = null

/obj/structure/table/buckshot/proc/build_table()
	parts = list()
	for(var/i = -1; i <= 1; i++)
		for(var/j = -1; j <= 1; j++)
			if(i == 0 && j == 0)
				icon_state = base_icon_state + "-center"
				continue // пропускаем цетральную часть
			var/i_str = (i < 0 ? "n" + "[abs(i)]" : "[i]")
			var/j_str = (j < 0 ? "n" + "[abs(j)]" : "[j]")
			var/obj/structure/table/buckshot_table_part/part = new(src)
			part.icon = icon
			part.icon_state = base_icon_state + "-" + i_str + "_" + j_str
			parts += part
			part.main_table = src
			part.name = name
			part.desc = desc
			part.forceMove(get_turf(locate(src.x + i, src.y + j, src.z)))

/obj/structure/table/buckshot/proc/create_crts()
	crts_by_dirs["[NORTH]"] = create_crt(NORTH)
	crts_by_dirs["[EAST]"] = create_crt(EAST)
	crts_by_dirs["[SOUTH]"] = create_crt(SOUTH)
	crts_by_dirs["[WEST]"] = create_crt(WEST)



/obj/structure/table/buckshot/proc/create_crt(direction)
	var/turf/target_turf = get_turf_in_angle(dir2angle(direction), get_turf(src), 1)
	if(!target_turf)
		return null

	// var/opposite_dir = turn(direction, 180)
	var/obj/structure/crt_mechanims/crt = new(target_turf, src)
	crt.dir = turn(get_dir(target_turf, get_turf(src)), 180)
	return crt


/obj/structure/box_with_item
	name = "A box with items"
	icon = 'icons/obj/storage/box.dmi'
	icon_state = "hugbox_black"
	obj_flags = INDESTRUCTIBLE|BOMB_PROOF|LAVA_PROOF|FIRE_PROOF

	var/given_count = 0
	var/to_give = 0
	var/datum/buckshoot_roulette_party/party = null
	var/mob/living/carbon/human/player = null

/obj/structure/box_with_item/Initialize(mapload, count, mob/living/carbon/human/owner, datum/buckshoot_roulette_party/party_instance)
	. = ..()
	to_give = count
	player = owner
	party = party_instance

/obj/structure/box_with_item/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	if(!party.is_participant(user))
		to_chat(user, span_warning("Ты не участник игры!"))
		return
	if(user != player)
		to_chat(user, span_warning("Это неsтвой ящик с предметами!"))
		return
	if(given_count >= to_give)
		to_chat(user, span_notice("Ящик - пуст."))
		return
	var/obj_type = pick(GLOB.buckshot_game_items)
	var/obj/item/buckshot_game/item = new obj_type(src, user, party)
	user.put_in_hands(item)
	given_count += 1
	party.item_gived(item, user)
	visible_message(span_notice("[user.name] берет [item.name] из ящика."))
	playsound(src, 'tff_modular/modules/buckshoot/sounds/item_pickup.ogg', 50, 1)
	if(given_count >= to_give)
		to_chat(user, span_notice("Ты взял последний предмет из ящика."))
		qdel(src)

/obj/structure/table/buckshot/proc/create_item_boxes(itemps_per_player)
	for(var/mob/living/carbon/human/player in party.get_players())
		var/turf/target_turf = get_ranged_target_turf(src, get_dir(src, get_turf(player)), 1)
		new /obj/structure/box_with_item(target_turf, itemps_per_player, player, party)

/obj/structure/table/buckshot/proc/get_parts()
	return parts

/obj/structure/table/buckshot/attack_hand_secondary(mob/user, list/modifiers)
	INVOKE_ASYNC(src, PROC_REF(try_start_game), user)
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/structure/table/buckshot/proc/try_start_game(mob/user)
	if(!party)
		return
	if(party.game_started)
		to_chat(user, span_warning("Игра уже началась!"))
		balloon_alert(user, "Игра уже началась!")
		return
	if(!istype(user))
		return
	INVOKE_ASYNC(party, TYPE_PROC_REF(/datum/buckshoot_roulette_party, attempt_start_game), user)



/obj/structure/table/buckshot/proc/get_crt_by_direction(direction)
	return crts_by_dirs[num2text(direction)]

/obj/structure/table/buckshot/proc/get_all_crts()
	var/list/crts = list()
	for(var/dir in crts_by_dirs)
		var/crt = crts_by_dirs[dir]
		if(crt)
			crts += crt
	return crts

/obj/structure/table/buckshot/proc/get_ctr_for_player(mob/living/carbon/human/player)
	return get_crt_by_direction(get_dir(src, player))

/obj/structure/table/buckshot/proc/on_shotgun_begin_reload(obj/item/gun/ballistic/shotgun/buckshot_game/gun)


/obj/structure/table/buckshot/proc/on_shotgun_reloaded(obj/item/gun/ballistic/shotgun/buckshot_game/gun)


/obj/structure/table/buckshot/proc/on_shotgun_return_to_table(obj/item/gun/ballistic/shotgun/buckshot_game/gun)


/obj/structure/table/buckshot/proc/move_shotgun_to_player(obj/item/gun/ballistic/shotgun/buckshot_game/gun, mob/living/player)
	if(!gun)
		return
	gun.throw_at(player, 1, 3, src, FALSE)

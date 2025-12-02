#define TIME_TO_TURN (1 MINUTES)
#define SHOOT_RESULT_LIVE "live"
#define SHOOT_RESULT_BLANK "blank"

/datum/buckshoot_roulette_party
	// Уникальное айди этой партии
	var/id
	// Список всех текущих игроков партии
	VAR_PRIVATE/list/players
	// Все игровые места, что задействованны в партии (weakrefs)
	VAR_PRIVATE/list/chairs
	// weakref на дробовик
	VAR_FINAL/datum/weakref/shotgun_weakref
	// weakref на игровой стол
	VAR_FINAL/datum/weakref/table_weakref
	// На каком раунде происходит обрезание системы жизнеобеспечения
	VAR_FINAL/death_round_teshoold = 3
	// Стартовала ли игра
	var/game_started = FALSE
	// Может ли игрок свобдно выойти из игры
	var/can_free_exit = FALSE
	// Список игроков, ожидающих начала игры
	var/awaiting_players = list()
	// Должен ли стол озвучивать правила в начале игры
	var/should_say_rules = TRUE
	var/static/list/rules = list(
		"1. Каждый ход дробовик заряжается боевыми и холостыми патронами в случайном порядке.",
		"2. Участвующие по очереди стреляют либо в себя, либо в другого игрока.",
		"3. Если при выстреле в себя патрон был холостым - игрок продолжает ход.",
		"4. В случае смерти игрок будет воскрешён системой жизнеобеспечения, но только пока у игрока есть дополнительные заряды.",
		"5. Побеждает последний оставшийся в живых игрок.",
	)

	// Список игрок с ключами по именам
	var/list/player_by_names = list() // assoc list(mob/living/carbon/human => string)

	/* Переменные относящиеся к процессу игры*/

	// Текущий раунд игры
	var/round = 0
	// Является ли текущий раунд последним
	var/is_last_round = FALSE
	// Время начала текущего хода
	var/current_turn_start_time = 0
	// Текущий игрок, который делает ход
	var/current_turn_player = null
	// Время за которое игрок должен сделать ход
	var/turn_time = TIME_TO_TURN

	// Обьявлены ли типы патронов
	var/ammo_declared = FALSE

/datum/buckshoot_roulette_party/New(obj/structure/table/game_table)
	. = ..()
	table_weakref = WEAKREF(game_table)
	id = generate_uuid()
	detect_game_objects()

/datum/buckshoot_roulette_party/proc/detect_game_objects()
	chairs = list()
	var/obj/structure/table/table = table_weakref?.resolve()
	if(!table)
		return
	for(var/obj/structure/chair/buckshoot/chair_instance in orange(2, table))
		if(!chair_instance.party)
			var/datum/weakref/chair_weakref = WEAKREF(chair_instance)
			chairs += chair_weakref
			chair_instance.party = src

/datum/buckshoot_roulette_party/proc/generate_uuid()
	var/uuid = ""
	for(var/i = 0; i < 8; i++)
		uuid += "[num2hex(prob(16), 16)]"


/datum/buckshoot_roulette_party/proc/detect_candidates(mob/user)
	if(game_started)
		return
	if(!length(chairs))
		detect_game_objects()
		return
	if(user)
		var/ask = tgui_alert(user, "Начать партию Buckshoot Roulette?", "Начать партию?", list("Да", "Нет"))
		if(ask != "Да")
			return
	players = list()
	for(var/datum/weakref/chair_weakref in chairs)
		var/obj/structure/chair/buckshoot/chair_instance = chair_weakref?.resolve()
		if(!chair_instance)
			continue
		var/mob/living/carbon/human/player = chair_instance.register_player(src)
		if(!player)
			continue
		awaiting_players += player

/datum/buckshoot_roulette_party/proc/check_ready()
	if(game_started)
		return
	// Проверка, что все игроки зарегистрированы
	for(var/datum/weakref/chair_weakref in chairs)
		var/obj/structure/chair/buckshoot/chair_instance = chair_weakref?.resolve()
		if(!chair_instance)
			continue
		var/mob/living/carbon/human/player = chair_instance.get_current_player()
		if(!player)
			continue
		var/found = FALSE
		for(var/datum/weakref/player_ref in players)
			var/mob/living/carbon/human/existing_player = player_ref?.resolve()
			var/datum/component/buckshoot_roulette_participant/participant = existing_player?.GetComponent(/datum/component/buckshoot_roulette_participant)
			if(!participant)
				continue
			if(participant.player == player)
				found = TRUE
				break
		if(!found)
			return
	// Все игроки зарегистрированы, стартуем игру
	INVOKE_ASYNC(src, PROC_REF(start_game))

/datum/buckshoot_roulette_party/proc/register_player(mob/living/carbon/human/player, name)
	// Проверка на уникальность имени
	for(var/datum/weakref/player_ref in players)
		var/mob/living/carbon/human/existing_player = player_ref?.resolve()
		var/datum/component/buckshoot_roulette_participant/participant = existing_player?.GetComponent(/datum/component/buckshoot_roulette_participant)
		if(!participant)
			continue
		if(!participant.player)
			continue
		if(participant.player != player && participant.player_name == name)
			to_chat(player, span_warning("Игрок с таким именем уже в этой партии! Выбери другое имя."))
			return FALSE
	players += WEAKREF(player)
	player_by_names[player] = name
	to_chat(player, span_notice("Ты успешно зарегистрирован в партии!"))
	check_ready()
	return TRUE

/datum/buckshoot_roulette_party/proc/is_participant(mob/living/carbon/human/player)
	for(var/datum/weakref/player_ref in players)
		var/mob/living/carbon/human/existing_player = player_ref?.resolve()
		if(existing_player == player)
			return TRUE
	return FALSE

/datum/buckshoot_roulette_party/proc/start_game()
	if(game_started)
		return
	var/obj/structure/table/table = table_weakref?.resolve()
	if(!table)
		return
	playsound(table, 'tff_modular/modules/buckshoot/sounds/defib_bootup.ogg', 50, 1)
	if(should_say_rules)
		for(var/rule in rules)
			table.say(rule)
			sleep(3 SECONDS)
		sleep(7 SECONDS)
	next_round()
	game_started = TRUE
	SEND_SIGNAL(src, COMSIG_BUCKSHOOT_GAME_STARTED, rules)
	START_PROCESSING(SSobj, src)

/datum/buckshoot_roulette_party/proc/end_game()
	if(!game_started)
		return
	SEND_SIGNAL(src, COMSIG_BUCKSHOOT_GAME_ENDED)
	game_started = FALSE
	can_free_exit = TRUE
	return_shotgun_to_table()
	var/obj/structure/table/table = table_weakref?.resolve()
	if(table)
		table.say("Игра окончена!")
	player_by_names = list()
	players = list()
	current_turn_player = null
	current_turn_start_time = 0
	round = 0

/* ПРОЦЕСС ИГРЫ */

/datum/buckshoot_roulette_party/proc/create_shotgun()
	var/obj/structure/table/table = table_weakref?.resolve()
	if(!table)
		return null
	var/obj/item/gun/ballistic/shotgun/buckshoot_game/shotgun = new(get_turf(table), src)
	shotgun_weakref = WEAKREF(shotgun)
	return shotgun

/datum/buckshoot_roulette_party/proc/get_shotgun()
	if(!shotgun_weakref)
		return create_shotgun()
	return shotgun_weakref?.resolve()

/datum/buckshoot_roulette_party/proc/load_ammo()
	var/total_ammo = ((length(players) * 2) + round(round / 2))
	var/live_shell = 0
	var/blank_shell = 0

	if(total_ammo < 2)
		if(total_ammo == 1)
			live_shell = 1
	else
		live_shell = rand(1, total_ammo - 1)
		blank_shell = total_ammo - live_shell

	var/obj/item/gun/ballistic/shotgun/buckshoot_game/shotgun = get_shotgun()
	if(shotgun)
		shotgun.load_rounds(live_shell, blank_shell)
	var/obj/structure/table/table = table_weakref?.resolve()
	if(table)
		table.say("[live_shell] боев[live_shell != 1 ? "ых" : "ой"] и [blank_shell] холос[blank_shell != 1 ? "тых" : "той"].")
	ammo_declared = TRUE

/datum/buckshoot_roulette_party/proc/all_blank()
	var/obj/item/gun/ballistic/shotgun/buckshoot_game/shotgun = get_shotgun()
	if(!shotgun)
		return FALSE
	for(var/obj/item/ammo_casing/casing in shotgun.chambers)
		if(istype(casing, /obj/item/ammo_casing/shotgun/buckshoot/live))
			return FALSE
	return TRUE

/datum/buckshoot_roulette_party/proc/return_shotgun_to_table()
	var/obj/structure/table/table = table_weakref?.resolve()
	if(!table)
		return
	var/obj/item/gun/ballistic/shotgun/buckshoot_game/shotgun = get_shotgun()
	if(!shotgun)
		return
	if(istype(shotgun.loc, /mob/living/carbon/human))
		var/mob/living/carbon/human/holder = shotgun.loc
		holder.drop_all_held_items()
	shotgun.forceMove(get_turf(table))

/datum/buckshoot_roulette_party/proc/pick_next_player()
	var/next_player = null
	var/starting_index = 0
	if(current_turn_player)
		starting_index = players.Find(WEAKREF(current_turn_player)) + 1
	for(var/i = 0; i < length(players); i++)
		var/index = (starting_index + i) % length(players)
		if(index == 0)
			index = length(players)
		var/datum/weakref/player_ref = players[index]
		var/mob/living/carbon/human/player = player_ref?.resolve()
		var/datum/component/buckshoot_roulette_participant/participant = player?.GetComponent(/datum/component/buckshoot_roulette_participant)
		if(!participant)
			continue
		if(participant.has_died_in_party)
			continue
		next_player = player
		break
	return next_player

/datum/buckshoot_roulette_party/proc/start_next_turn()
	return_shotgun_to_table()
	current_turn_player = pick_next_player()
	if(!current_turn_player)
		return
	current_turn_start_time = world.time
	var/obj/structure/table/table = table_weakref?.resolve()
	if(table)
		table.say("Ходит [player_by_names[current_turn_player]]. У него есть [turn_time / 600] минут на выбор действия.")


/datum/buckshoot_roulette_party/proc/turn_timeout()
	if(!current_turn_player)
		return FALSE
	var/elapsed_time = world.time - current_turn_start_time
	if(elapsed_time >= turn_time)
		var/obj/structure/table/table = table_weakref?.resolve()
		if(table)
			table.say("[player_by_names[current_turn_player]] не сделал выбор вовремя и пропускает ход!")
		return TRUE
	return FALSE

/datum/buckshoot_roulette_party/proc/after_player_shoot(mob/living/carbon/human/player, target_player, shot_result)
	var/datum/component/buckshoot_roulette_participant/participant = player.GetComponent(/datum/component/buckshoot_roulette_participant)
	if(!participant)
		return
	if(shot_result == SHOOT_RESULT_BLANK)
		handle_blank_shot(player, target_player)
	else if(shot_result == SHOOT_RESULT_LIVE)
		handle_live_shot(player, target_player)
	var/obj/item/gun/ballistic/shotgun/buckshoot_game/shotgun = get_shotgun()
	shotgun.rack(player)

/datum/buckshoot_roulette_party/proc/handle_blank_shot(mob/living/carbon/human/player, mob/living/carbon/human/target_player)
	if(target_player == player)
		to_chat(player, "Холостой выстрел в себя! Ты остаёшься в игре и продолжаешь ход.")
		return
	else
		start_next_turn()

/datum/buckshoot_roulette_party/proc/handle_live_shot(mob/living/carbon/human/player, mob/living/carbon/human/target_player)
	var/datum/component/buckshoot_roulette_participant/target_participant = target_player.GetComponent(/datum/component/buckshoot_roulette_participant)
	if(!target_participant)
		return
	var/obj/structure/table/table = table_weakref?.resolve()
	if(table)
		table.say("[player_by_names[target_player]] был убит [player_by_names[player]]!")
	return_shotgun_to_table()
	if(check_round_end())
		return
	start_next_turn()


/datum/buckshoot_roulette_party/proc/check_round_end()
	var/players_alive = 0
	for(var/datum/weakref/player_ref in players)
		var/mob/living/carbon/human/player = player_ref?.resolve()
		var/datum/component/buckshoot_roulette_participant/participant = player?.GetComponent(/datum/component/buckshoot_roulette_participant)
		if(!participant)
			continue
		if(!participant.player_completely_dead())
			players_alive += 1
	if(players_alive <= 1)
		return TRUE
	return FALSE

/datum/buckshoot_roulette_party/proc/next_round()
	round += 1
	ammo_declared = FALSE
	var/obj/structure/table/table = table_weakref?.resolve()
	if(table)
		table.say("Раунд [round] начинается!")
	playsound(table, 'tff_modular/modules/buckshoot/sounds/new_round.ogg', 50, 1)
	start_next_turn()


/datum/buckshoot_roulette_party/process(seconds_per_tick)
	if(!shotgun_weakref)
		create_shotgun()
	if(!game_started)
		return

	if(check_round_end())
		var/obj/structure/table/table = table_weakref?.resolve()
		if(is_last_round)
			end_game()
			return
		if(table)
			table.say("Раунд [round] окончен!")
		if(round >= death_round_teshoold)
			for(var/datum/weakref/player_ref in players)
				var/mob/living/carbon/human/player = player_ref?.resolve()
				var/datum/component/buckshoot_roulette_participant/participant = player?.GetComponent(/datum/component/buckshoot_roulette_participant)
				if(!participant)
					continue
				participant.lives = 0
			if(table)
				playsound(table, 'tff_modular/modules/buckshoot/sounds/crt_turn_off.ogg', 50, 1)
				table.say("Последний раунд - система реанимации отключена!")
			is_last_round = TRUE
		sleep(5 SECONDS)
		next_round()
		return
	if(!ammo_declared || all_blank())
		sleep(2 SECONDS)
		load_ammo()
	if(!current_turn_player || turn_timeout())
		sleep(1 SECONDS)
		start_next_turn()


/datum/component/buckshoot_roulette_participant
	// weakref на партию, в которой участвует этот игрок
	VAR_PRIVATE/datum/weakref/party_weakref
	// Ссылка на игровое кресло этого игрока
	VAR_PRIVATE/datum/weakref/chair_werkref
	// Был ли этот игрок уже убит в текущей партии
	var/has_died_in_party = FALSE
	// Ссылка на текущего игрока
	var/mob/living/carbon/human/player
	// Имя текущего игрока
	var/player_name = ""
	// Количество очков за победу игрокв раунде
	var/srcore = 0
	// Количество жизней игрока
	var/lives = 3

	var/static/list/forbiden_names = list(
		"Ведущий",
		"Администратор",
		"Модератор",
		"Система",
		"Бот",
		"Игрок",
		"Гость",
		"low3",
		"god",
		"бог",
	)
	var/static/list/dealer_names = list(
		"Дилер",
		"Крупье",
		"Dealer",
	)


/datum/component/buckshoot_roulette_participant/Initialize(datum/buckshoot_roulette_party/party, obj/structure/chair/buckshoot/chair_instance)
	if(!party || !chair_instance)
		return COMPONENT_INCOMPATIBLE
	if(!ishuman(parent))
		return COMPONENT_INCOMPATIBLE
	player = parent
	party_weakref = WEAKREF(party)
	chair_werkref = WEAKREF(chair_instance)
	INVOKE_ASYNC(src, PROC_REF(register_player))

/datum/component/buckshoot_roulette_participant/Destroy()
	UnregisterFromParent()
	. = ..()


/datum/component/buckshoot_roulette_participant/RegisterWithParent()
	. = ..()
	var/datum/buckshoot_roulette_party/party_instance = party_weakref?.resolve()
	RegisterSignal(player, COMSIG_LIVING_DEATH, PROC_REF(on_player_death), TRUE)
	RegisterSignal(party_instance, COMSIG_BUCKSHOOT_GAME_STARTED, PROC_REF(on_game_start), TRUE)
	RegisterSignal(party_instance, COMSIG_BUCKSHOOT_GAME_ENDED, PROC_REF(on_game_end), TRUE)

/datum/component/buckshoot_roulette_participant/UnregisterFromParent()
	. = ..()
	var/datum/buckshoot_roulette_party/party_instance = party_weakref?.resolve()
	UnregisterSignal(player, list(COMSIG_LIVING_DEATH))
	UnregisterSignal(party_instance, list(COMSIG_BUCKSHOOT_GAME_STARTED, COMSIG_BUCKSHOOT_GAME_ENDED))


/datum/component/buckshoot_roulette_participant/proc/generate_random_name()
	var/chars = GLOB.alphabet.Copy()
	var/base = "Игрок_"
	for(var/i = 0; i < 6; i++)
		base += chars[prob(1.0 / length(chars)) * length(chars)]
	return trimtext(base)

/datum/component/buckshoot_roulette_participant/proc/register_player()
	var/datum/buckshoot_roulette_party/party_instance = party_weakref?.resolve()
	if(!party_instance)
		return
	var/player_name = tgui_input_text(player, "Введи имя игрока", "Регистрация", max_length = 32)
	if(!player_name)
		player_name = generate_random_name()
	if(player_name in forbiden_names)
		to_chat(player, span_warning("Это имя запрещено! Тебе будет сгенерировано случайное имя."))
		return register_player()
	if(player_name in dealer_names && !HAS_TRAIT(player, TRAIT_BUCKSHOOT_DEALER))
		to_chat(player, span_warning("Это имя запрещено! Тебе будет сгенерировано случайное имя."))
		return register_player()
	if(!party_instance.register_player(player, player_name))
		CHECK_TICK
		sleep(1)
		register_player()
	else
		RegisterWithParent()


/datum/component/buckshoot_roulette_participant/proc/player_completely_dead()
	var/datum/buckshoot_roulette_party/party = party_weakref?.resolve()
	if(!party)
		return TRUE
	return lives <= 0


/datum/component/buckshoot_roulette_participant/proc/on_player_death(mob/living/player, gibbed)
	SIGNAL_HANDLER
	var/datum/buckshoot_roulette_party/party = party_weakref?.resolve()
	if(!party)
		return
	if(lives <= 0)
		has_died_in_party = TRUE
		return
	lives -= 1
	var/obj/structure/chair/buckshoot/chair_instance = chair_werkref.resolve()
	if(!chair_instance)
		return
	chair_instance.say(span_notice("Осталось жизней: [lives]."))
	playsound(chair_instance, 'tff_modular/modules/buckshoot/sounds/defib_reduce_health.ogg', 50, 1)
	addtimer(CALLBACK(chair_instance, TYPE_PROC_REF(/obj/structure/chair/buckshoot, revive_player)), 1 SECONDS)


/datum/component/buckshoot_roulette_participant/proc/on_game_start(/datum/buckshoot_roulette_party/party, rules)
	SIGNAL_HANDLER
	var/msg = span_notice("Игра началась! Твои жизни: [lives].")
	to_chat(player, msg)
	ADD_TRAIT(src, TRAIT_BUCKSHOOT_PLAYER, INNATE_TRAIT)
	SEND_SOUND(player, 'tff_modular/modules/buckshoot/sounds/crt_display_health.ogg')

/datum/component/buckshoot_roulette_participant/proc/on_game_end()
	SIGNAL_HANDLER
	Destroy()

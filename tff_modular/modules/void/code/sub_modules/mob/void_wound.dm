#define WOUND_VOID_STAGE_FALSE_RECOVERY 0
#define WOUND_VOID_STAGE_INFECTION 1
#define WOUND_VOID_STAGE_EXPANSION 2
#define WOUND_VOID_STAGE_DEEPENING 3
#define WOUND_VOID_STAGE_PENETRATION 4

#define WOUND_VOID_MESSAGE_COOLDOWN 25 SECONDS
#define WOUND_VOID_ITEM_DROP_COOLDOWN 12 SECONDS
#define WOUND_VOID_COUGH_COOLDOWN 2 MINUTES

/**
 * ВНУТРЕННЯ ПУСТОТА - УЗНАЙ ЧТО ТАКОЕ СТРАДАНИЕ.
 * Прогресирующий ваунд, в пяти стадиях. Что постепенно уничтожает зараженного.
 */

/datum/wound/inner_void
	name = "Void Decay"
	desc = "Inener void consume you."
	treat_text = "Threatment impossible. Using of painkillers highly recommended. \n Patient death is irreversible."
	severity = WOUND_SEVERITY_TRIVIAL
	viable_zones = list(BODY_ZONE_CHEST)
	no_bleeding = TRUE
	processes = TRUE
	wound_flags = null

	//Текущая стадия на которой мы находимся.
	var/current_stage
	//Нужно ли нам, что-либо писать нашей цели.
	var/message_victim = TRUE
	//Сообщения, что будет видить больно с разной переодичностью.
	var/list/message_to_victim = list()
	//Время перехода на следующую стадию.
	var/stage_pass_time = 8 MINUTES
	//Следующая стадия.
	var/next_stage = /datum/wound/inner_void/false_recovery

	//Эффект на настроение.
	var/datum/mood_event/mood_effect
	//Эффект на скорость передвижения.
	var/datum/movespeed_modifier/stage_slowdown

	var/lose_stage = FALSE

	COOLDOWN_DECLARE(message_coodown)
	COOLDOWN_DECLARE(item_drop_cooldown)
	COOLDOWN_DECLARE(void_cough_cooldown)

/datum/wound/inner_void/apply_wound(obj/item/bodypart/L, silent = FALSE, datum/wound/old_wound = null, smited = FALSE, attack_direction = null, wound_source = "Unknown")
	. = ..()
	victim.add_mood_event("Void infection", mood_effect)
	if(stage_slowdown)
		victim.add_movespeed_modifier(stage_slowdown)

	if(current_stage >= WOUND_VOID_STAGE_PENETRATION)
		return

	GLOB.void_infected_peoples += victim
	addtimer(CALLBACK(src, PROC_REF(pass_stage)), stage_pass_time)

/datum/wound/inner_void/proc/pass_stage()
	for(var/category in victim.mob_mood.mood_events)
		if(category == "Void infection")
			var/datum/mood_event/event = victim.mob_mood.mood_events[category]
			event.Destroy()
	if(stage_slowdown)
		victim.remove_movespeed_modifier(stage_slowdown)

	GLOB.void_infected_peoples -= victim
	//Заменяем ваунд не следующий!
	var/datum/wound/new_stage = new next_stage
	remove_wound(replaced=TRUE)
	new_stage.apply_wound(limb)
	lose_stage = TRUE
	qdel(src)

/datum/wound/inner_void/remove_wound(replaced)
	if(!replaced && !lose_stage)
		victim_dead()
	return ..()

/datum/wound/inner_void/proc/victim_dead()
	var/mob/living/carbon/human/to_convet = victim
	GLOB.void_infected_peoples -= to_convet
	convert_to_void(to_convet, do_animation = TRUE, message = TRUE, puddle = TRUE)

// Актуально обрабатывает эффекты повреждений.
/datum/wound/inner_void/handle_process(seconds_per_tick, times_fired)
	. = ..()
	if(!victim)
		return
	if(victim.stat & DEAD)
		victim_dead()
		STOP_PROCESSING(SSprocessing, src)
		return
	//Не обрабатывает никакие эффекты, если мы на стадии ложного выздоровления.
	if(current_stage == WOUND_VOID_STAGE_FALSE_RECOVERY)
		return
	var/mob/living/carbon/human/infected = victim

	//Эффекты первой стадии.
	if(current_stage >= WOUND_VOID_STAGE_INFECTION)

		if(COOLDOWN_FINISHED(src, message_coodown) && message_victim && prob(40))
			var/message_to_show = pick(message_to_victim)
			to_chat(infected, span_warning(message_to_show))
			COOLDOWN_START(src, message_coodown, WOUND_VOID_MESSAGE_COOLDOWN)

	//Эффекты второй стадии.
	if(current_stage >= WOUND_VOID_STAGE_EXPANSION)
		if(prob(5))
			to_chat(infected, span_black("Inside you.."))

	//О да детка, мы начинаем погружаться в ебаный ад.
	if(current_stage >= WOUND_VOID_STAGE_DEEPENING)
		if(COOLDOWN_FINISHED(src, item_drop_cooldown))

			var/I = infected.get_active_held_item()
			infected.dropItemToGround(I)
			COOLDOWN_START(src, item_drop_cooldown, WOUND_VOID_ITEM_DROP_COOLDOWN)

		if(prob(5))
			to_chat(infected, span_black("Painful..."))

		if(prob(5))
			infected.visible_message(span_warning("[infected.name] coughs up dark liquid on the floor!"))
			infected.emote("cough", intentional = TRUE)

			new /obj/effect/temp_visual/void_step/simple(get_turf(infected), infected)

	//Ты - выплелвываешь свои легкие сынок.
	if(current_stage >= WOUND_VOID_STAGE_PENETRATION)
		if(COOLDOWN_FINISHED(src, void_cough_cooldown))
			playsound(get_turf(infected), 'sound/effects/splat.ogg', 50, TRUE)

			var/turf/target_turf = get_ranged_target_turf(infected, infected.dir, 1)
			infected.visible_message(span_warning("[infected.name] vomits dark liquid on the floor."))

			//Если мы не можем сделать кашель на клетку перед собой, делаем его на свою клетку.
			if(target_turf.is_blocked_turf())
				target_turf = get_turf(infected)
			new /obj/structure/void_puddle(target_turf)
			COOLDOWN_START(src, void_cough_cooldown, WOUND_VOID_COUGH_COOLDOWN)

		//Добавляем постоянный эффект на экран.
		infected.add_screeen_temporary_effect(/atom/movable/screen/fullscreen/void_brightless)

// СТАДИИ

/datum/wound/inner_void/infected
	current_stage = WOUND_VOID_STAGE_INFECTION
	message_to_victim = list("Wound on my chest hurts badly...", "I feel nauseous from the pain...")
	examine_desc = "is corrupted with void. Pretty bad puncture wound, soaking with dark liquid. Looks like it'll heal soon."
	next_stage = /datum/wound/inner_void/false_recovery
	mood_effect = /datum/mood_event/void_infection/infected

/datum/wound/inner_void/false_recovery
	current_stage = WOUND_VOID_STAGE_FALSE_RECOVERY
	message_victim = FALSE
	next_stage = /datum/wound/inner_void/expansion
	mood_effect = /datum/mood_event/void_infection/false_recovery

/datum/wound/inner_void/expansion
	current_stage = WOUND_VOID_STAGE_EXPANSION
	severity = WOUND_SEVERITY_MODERATE
	message_to_victim = list("I have a strange feeling inside me...", "My head is spinning...", "I feel really tired...", "My eyelids feels heavy... Should i rest for a bit?..")
	examine_desc = "is corrupted with void. Some of soft tissues on the chest and the back was covered with pitch black mess. It's not looking good"
	occur_text = "is covered in void"
	next_stage = /datum/wound/inner_void/deeping
	mood_effect = /datum/mood_event/void_infection/expansion
	stage_slowdown = /datum/movespeed_modifier/void_infection/expansion

/datum/wound/inner_void/deeping
	current_stage = WOUND_VOID_STAGE_DEEPENING
	severity = WOUND_SEVERITY_SEVERE
	message_to_victim = list("I can't concentrate on anything... My eyes...", "All my body feels numb...", "My chest hurts really badly...")
	examine_desc = "is corrupted with void.. Even more of soft tissues on the chest and the back was covered in black substance. It's pulsating slightly."
	occur_text = "is covered in void"
	next_stage = /datum/wound/inner_void/penetration
	mood_effect = /datum/mood_event/void_infection/deeping
	stage_slowdown = /datum/movespeed_modifier/void_infection/deeping

/datum/wound/inner_void/penetration
	current_stage = WOUND_VOID_STAGE_PENETRATION
	severity = WOUND_SEVERITY_CRITICAL
	message_to_victim = list("I feel void inside my guts...", "Something is terribly wrong with me...", "Perhaps, this is hell...", "I just want to return home...")
	examine_desc = "is corrupted with void.. All upper body was replaced with pitch black warm pulsating mass. Clearly agonizing"
	occur_text = "is covered in void"
	mood_effect = /datum/mood_event/void_infection/penetration
	stage_slowdown = /datum/movespeed_modifier/void_infection/penetration

// НАСТРОЕНИЕ

/datum/mood_event/void_infection
	timeout = 8 MINUTES

/datum/mood_event/void_infection/infected
	description = "I'm in terrible pain. This thing did hurt me really badly."
	mood_change = -4

/datum/mood_event/void_infection/false_recovery
	description = "I feel better now."
	mood_change = 8

/datum/mood_event/void_infection/expansion
	description = "I feel sick..."
	mood_change = -8

/datum/mood_event/void_infection/deeping
	description = "I start to feel even worse... My god..."
	mood_change = -16

/datum/mood_event/void_infection/penetration
	description = "Why can't I die already?"
	mood_change = -32
	timeout = 8 HOURS

// ЗАМЕДЛЕНИЕ

/datum/movespeed_modifier/void_infection
	blacklisted_movetypes = FLYING

/datum/movespeed_modifier/void_infection/expansion
	multiplicative_slowdown = 0.2

/datum/movespeed_modifier/void_infection/deeping
	multiplicative_slowdown = 0.4

/datum/movespeed_modifier/void_infection/penetration
	multiplicative_slowdown = 0.8

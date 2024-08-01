GLOBAL_LIST_INIT(nt_police_responder_info, list(
	"nt_police_agent" = list(
		NT_POLICE_AMT = 0,
		NT_POLICE_DECLARED = FALSE
	),
	"nt_police_swat" = list(
		NT_POLICE_AMT = 0,
		NT_POLICE_DECLARED = FALSE
	),
	"nt_police_trooper" = list(
		NT_POLICE_AMT = 0,
		NT_POLICE_DECLARED = FALSE
	)
))

GLOBAL_VAR(caller_of_NTIS)
GLOBAL_VAR(call_NTIS_msg)

/proc/check_dead_ntis(mob/living/whodead)
	SIGNAL_HANDLER
	var/datum/antagonist/ert/nt_police/A = whodead.mind.has_antag_datum(/datum/antagonist/ert/nt_police)

	//Цикл определения мёртвые ли челики.
	if(A)
		var/datum/team/deadteam = A.get_team()
		var/list/killed = deadteam.members
		for(var/datum/mind/chell in killed)
			if(chell.current.stat == DEAD)
				continue
			else
				return FALSE

	GLOB.nt_police_responder_info[A.type_of_police][NT_POLICE_AMT] = 0 // СПИСАНЫ
	GLOB.nt_police_responder_info[A.type_of_police][NT_POLICE_DECLARED] = FALSE
	var/who_we_call = "swat"
	if(A.owner.has_antag_datum(/datum/antagonist/ert/nt_police/swat))
		who_we_call = "troopers"
	// До сюда мы дойдём лишь в том случае, если командаа полностью мертва. Тогда мы и вызываем следующее подкрепление.
	// Это SWAT и Troopers. Сейчас будем пытаться узнать кто именно.
	// Так же существует проблема. Последний умирающий чел не спавнится. Нужна задержка при вызове.
	INVOKE_ASYNC(GLOBAL_PROC, GLOBAL_PROC_REF(call_NTIS), who_we_call)

/// "agents" "swat" "troopers"
/proc/call_NTIS(called_team)
	if(!called_team)
		return
	// Инициализация спавнящейся группы!
	var/ghost_poll_msg = "The NTIS have requested a S.W.A.T. backup. Do you wish to become a S.W.A.T. member?"
	var/amount_to_summon = 5
	var/announcement_source = "NanoTrasen Internal Security"
	var/jobban_to_check = ROLE_DEATHSQUAD
	var/type_to_summon = /datum/antagonist/ert/nt_police/swat
	var/leader_to_summon = /datum/antagonist/ert/nt_police/swat/leader
	var/summoned_type = "nt_police_swat"
	var/sound_nt = 'tff_modular/modules/police_nt/sound/nt_police_second.ogg'
	var/announcement_message = "NanoTesharistan"
	var/missions = list(
			"Найти тешарю НТРа.",
			"Найти грустного человека по имени Хоув с фамилией Грейсон.",
			"Посадить пернатую к нему на коленочки в объятия!")
	switch(called_team)
		if("agents")
			ghost_poll_msg = "The station has called for the NT Internal Security. Will you respond?"
			amount_to_summon = 3
			announcement_source = "NanoTrasen Internal Security"
			jobban_to_check = ROLE_DEATHSQUAD
			type_to_summon = /datum/antagonist/ert/nt_police/agent
			leader_to_summon = /datum/antagonist/ert/nt_police/agent/leader
			summoned_type = "nt_police_agent"
			sound_nt = 'tff_modular/modules/police_nt/sound/nt_police_first.ogg'
			announcement_message = "Attention, personnel of [station_name()]. \nNT Internal Security on the line. We've received a request from your corporate consultant, and we're sending a unit shortly. \nIn case of any kind of escalation or injury to an Internal Security officers, a tactical squad will be dispatched to handle this issue. \n\n Stay safe, Glory to Nanotrasen."
			missions = list(
			"Содействовать представителю Нанотрейзен [GLOB.caller_of_NTIS] в работе и исследовать запрос сотрудника: [GLOB.call_NTIS_msg]",
			"\"Эвакуировать\" представителя при ложном вызове или при борьбе службы безопасности с действующей революцией против глав и сотрудников безопасности.",
			"Вызвать SWAT в том случае, если СБ предпринимает попытки свергнуть действующего легетимного капитана, а дипломатия не работает!")
		if("swat")
			ghost_poll_msg = "The NTIS have requested a S.W.A.T. backup. Do you wish to become a S.W.A.T. member?"
			amount_to_summon = 5
			type_to_summon = /datum/antagonist/ert/nt_police/swat
			leader_to_summon = /datum/antagonist/ert/nt_police/swat/leader
			summoned_type = "nt_police_swat"
			sound_nt = 'tff_modular/modules/police_nt/sound/nt_police_second.ogg'
			announcement_message = "Attention, crew.\nNTIS Police have requested S.W.A.T. backup. Please comply with all requests by special squad members."
			missions = list(
			"Содействовать представителю Нанотрейзен [GLOB.caller_of_NTIS] и первому отряду агентов NTIS!",
			"Обеспечьте безопасность представителей корпорации на станции.",
			"Эвакуируйте агентов и представителя/командования, если станция не признаёт в вас власти; активно используя офицеров и взбунтовавшихся представителей власти против корпорации!")
		if("troopers")
			ghost_poll_msg = "The station has decided to engage in treason. Do you wish to join the NanoTrasen Military?"
			amount_to_summon = 8
			type_to_summon = /datum/antagonist/ert/nt_police/trooper
			leader_to_summon = /datum/antagonist/ert/nt_police/trooper/leader
			summoned_type = "nt_police_trooper"
			sound_nt = 'tff_modular/modules/police_nt/sound/nt_police_third.ogg'
			announcement_message = "Attention, crew.\nYou are accused of corporate treason. Lay down your weapons and surrender. Follow all the orders of the NanoTrasen response team. The perpetrators of corporate betrayal will be punished at the greatest extent."
			missions = list(
			"Уничтожьте атакующие вас враждебных элементы на станции!",
			"Избавьтесь от трупов дефектных сотрудников, захватив те на ЦК.",
			"Проведите окончание смены вызовом челнока эвакуации. Верный экипаж должен быть доставлен в целостности и сохранности!")
	if(!GLOB.nt_police_responder_info[summoned_type][NT_POLICE_DECLARED])
		GLOB.nt_police_responder_info[summoned_type][NT_POLICE_DECLARED] = TRUE

		priority_announce(announcement_message, announcement_source, sound_nt, has_important_message = TRUE, color_override = "yellow")
		var/list/candidates = SSpolling.poll_ghost_candidates(
			ghost_poll_msg,
			check_jobban = jobban_to_check,
			alert_pic = /obj/item/nt_reporter,
			role_name_text = summoned_type,
		)

		// БЛОК КОДА ДЛЯ ВЫБОРА ЛИДЕРА!!!
		var/mob/dead/observer/earmarked_leader
		var/leader_spawned = FALSE // Там нужно будет пропускать проверку дальше, иначе все будут лидерами!

		var/list/candidate_living_exps = list()
		for(var/i in candidates)
			var/mob/dead/observer/potential_leader = i
			candidate_living_exps[potential_leader] = potential_leader.client?.get_exp_living(TRUE)
		candidate_living_exps = sort_list(candidate_living_exps, cmp=/proc/cmp_numeric_dsc)
		if(candidate_living_exps.len > 2) // Формируется лист из 3 топеров по времени. Я сделаю выбор из 2 людей.
			candidate_living_exps = candidate_living_exps.Cut(3) // pick from the top ERT_EXPERIENCED_LEADER_CHOOSE_TOP contenders in playtime
		earmarked_leader = pick(candidate_living_exps)
		// БЛОК КОДА ДЛЯ ВЫБОРА ЛИДЕРА!!!

		// СОЗДАДИМ КОМАНДУ!
		var/datum/team/ert/agents_team = new ()
		agents_team.name = summoned_type + " group"
		agents_team.member_name = "member"
		agents_team.show_roundend_report = TRUE

		// ОБЖЕКТИВЫ!
		for(var/explanation in missions)
			var/datum/objective/missionobj = new ()
			missionobj.team = agents_team
			missionobj.completed = TRUE
			missionobj.explanation_text = explanation
			agents_team.objectives += missionobj

		if(length(candidates))
			var/agents_number = min(amount_to_summon, candidates.len)
			GLOB.nt_police_responder_info[summoned_type][NT_POLICE_AMT] = agents_number

			var/list/spawnpoints = GLOB.emergencyresponseteamspawn
			var/index = 0

			while(agents_number && candidates.len)
				var/spawn_loc = spawnpoints[index + 1]
				index = (index + 1) % spawnpoints.len
				var/mob/dead/observer/chosen_candidate = pick(candidates)
				candidates -= chosen_candidate
				if(!chosen_candidate.key)
					continue

				var/mob/living/carbon/human/cop = new(spawn_loc)
				chosen_candidate.client.prefs.safe_transfer_prefs_to(cop, is_antag = TRUE)
				cop.key = chosen_candidate.key

				var/datum/antagonist/ert/nt_police/ert_antag = type_to_summon

				// РЕАЛИЗАЦИЯ ЛИДЕРА!!!
				if((chosen_candidate == earmarked_leader) || (agents_number == 1) && !leader_spawned)
					ert_antag = new leader_to_summon
					earmarked_leader = null
					leader_spawned = TRUE
				else
					ert_antag = new type_to_summon
				// ИЛИ СПАВН ЧУВАКОВ!!!

				cop.mind.add_antag_datum(ert_antag, agents_team)
				cop.mind.set_assigned_role(SSjob.GetJobType(ert_antag.ert_job_path))
				cop.grant_language(/datum/language/common, source = LANGUAGE_SPAWNER)
				log_game("[key_name(cop)] has been selected as an [ert_antag.name]")
				agents_number--

/datum/antagonist/ert/nt_police
	name = "NTIS Unit"
	antag_hud_name = "hud_spacecop"
	suicide_cry = "FOR THE TRASEN!!"
	leader = TRUE
	var/type_of_police = "nt_police_agent"

/datum/ert/nt_police
	code = "Blue"
	teamsize = 3
	opendoors = FALSE
	leader_role = /datum/antagonist/ert/nt_police/agent/leader
	roles = list(/datum/antagonist/ert/nt_police/agent)
	rename_team = "NTIS Agents"
	random_names = TRUE
	leader_experience = TRUE

/datum/ert/nt_police/swat
	code = "Amber"
	teamsize = 5
	opendoors = TRUE
	leader_role = /datum/antagonist/ert/nt_police/swat/leader
	roles = list(/datum/antagonist/ert/nt_police/swat)
	rename_team = "NTIS S.W.A.T."
	random_names = TRUE
	leader_experience = TRUE

/datum/ert/nt_police/troopers
	code = "Red"
	teamsize = 8
	opendoors = TRUE
	leader_role = /datum/antagonist/ert/nt_police/trooper/leader
	roles = list(/datum/antagonist/ert/nt_police/trooper)
	rename_team = "NTIS Troopers"
	random_names = TRUE
	leader_experience = TRUE

/datum/antagonist/ert/nt_police/apply_innate_effects(mob/living/mob_override)
	..()
	var/mob/living/M = mob_override || owner.current
	if(M.hud_used)
		var/datum/hud/H = M.hud_used
		var/atom/movable/screen/wanted/giving_wanted_lvl = new /atom/movable/screen/wanted(null, H)
		H.wanted_lvl = giving_wanted_lvl
		H.infodisplay += giving_wanted_lvl
		H.mymob.client.screen += giving_wanted_lvl

/datum/antagonist/ert/nt_police/remove_innate_effects(mob/living/mob_override)
	var/mob/living/M = mob_override || owner.current
	if(M.hud_used)
		var/datum/hud/H = M.hud_used
		H.infodisplay -= H.wanted_lvl
		QDEL_NULL(H.wanted_lvl)
	..()
/*
*	POLICE
*/
/datum/antagonist/ert/nt_police/agent
	name = "NTIS Agent"
	role = "Internal Security Agent"
	type_of_police = "nt_police_agent"
	outfit = /datum/outfit/nt_police/agent

/datum/antagonist/ert/nt_police/agent/leader
	name = "NTIS Agent-Commander"
	role = "NTIS Agent-Commander"
	outfit = /datum/outfit/nt_police/agent/leader

/datum/antagonist/ert/nt_police/swat
	name = "NTIS S.W.A.T. Officer"
	role = "NTIS S.W.A.T. Officer"
	type_of_police = "nt_police_swat"
	outfit = /datum/outfit/nt_police/swat

/datum/antagonist/ert/nt_police/swat/leader
	name = "NTIS S.W.A.T. Commander"
	role = "NTIS S.W.A.T. Commander"
	outfit = /datum/outfit/nt_police/swat/leader

/datum/antagonist/ert/nt_police/trooper
	name = "NTIS Trooper"
	role = "NTIS Trooper"
	type_of_police = "nt_police_trooper"
	outfit = /datum/outfit/nt_police/trooper

/datum/antagonist/ert/nt_police/trooper/leader
	name = "NTIS Trooper Commander"
	role = "NTIS Trooper Commander"
	outfit = /datum/outfit/nt_police/trooper/leader

/datum/antagonist/ert/nt_police/greet()
	var/missiondesc =  ""
	missiondesc += "<B><font size=5 color=red>You are a Nanotrasen Employee. You work for the Nanotrasen as a [role].</font></B>"
	missiondesc += "<BR>You are responding to emergency calls from the station consultants!\n"
	missiondesc += "<BR><B>NTIS Transcript is as follows</B>:"
	missiondesc += "<BR> [GLOB.call_NTIS_msg]"
	to_chat(owner, missiondesc)

/datum/antagonist/ert/nt_police/swat/greet()
	var/missiondesc =  ""
	missiondesc += "<B><font size=5 color=red>You are a Nanotrasen Employee. You work for the Nanotrasen as a [role].</font></B>"
	missiondesc += "<BR>You are here to backup the NTIS police, as they have reported for your assistance.\n"
	to_chat(owner, missiondesc)

/datum/antagonist/ert/nt_police/trooper/greet()
	var/missiondesc =  ""
	missiondesc += "<B><font size=5 color=red>You are a Nanotrasen Employee. You work for the Nanotrasen as a [role].</font></B>"
	missiondesc += "<BR>You are here to assume control of [station_name()] due to the occupants engaging in Treason as reported by our SWAT team.\n"
	to_chat(owner, missiondesc)

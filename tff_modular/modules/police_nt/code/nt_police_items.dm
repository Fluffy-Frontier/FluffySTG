/*
		HEAD AND MASKS
*/

/datum/armor/armor_sf_nt_police
	melee = 50
	bullet = 90
	laser = 60
	energy = 60
	bomb = 70
	fire = 70
	acid = 70
	wound = 50

/obj/item/clothing/head/helmet/sf_sacrificial/nt_police
	armor_type = /datum/armor/armor_sf_nt_police
	max_integrity = 700
	limb_integrity = 700

/obj/item/clothing/mask/gas/nt_police
	name = "NT police mask"
	desc = "A close-fitting tactical mask."
	icon = 'tff_modular/modules/police_nt/icons/mask.dmi'
	worn_icon = 'tff_modular/modules/police_nt/icons/wornmask.dmi'
	worn_icon_digi = 'tff_modular/modules/police_nt/icons/wornmask_digi.dmi'
	icon_state = "nt_police"
	inhand_icon_state = "swat"
	flags_inv = HIDEFACIALHAIR | HIDEFACE | HIDESNOUT
	visor_flags_inv = 0
	flags_cover = MASKCOVERSMOUTH | MASKCOVERSEYES | PEPPERPROOF
	visor_flags_cover = MASKCOVERSMOUTH | MASKCOVERSEYES | PEPPERPROOF

/*
		ARMOR AND SUITS
*/

/obj/item/clothing/suit/armor/sf_sacrificial/nt_police
	armor_type = /datum/armor/armor_sf_nt_police
	max_integrity = 700
	limb_integrity = 700
	clothing_flags = STOPSPRESSUREDAMAGE | THICKMATERIAL
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	cold_protection = CHEST | GROIN | LEGS | FEET | ARMS | HANDS
	min_cold_protection_temperature = SPACE_SUIT_MIN_TEMP_PROTECT_OFF
	heat_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	resistance_flags = FIRE_PROOF | ACID_PROOF

/obj/item/clothing/under/nt_peacekeeper
	name = "NT peacekeeper uniform"
	desc = "A military-grade uniform with military grade comfort (none at all), often seen on \
		NTIS's various peacekeeping forces, and usually alongside a blue helmet."
	icon = 'modular_nova/modules/goofsec/icons/uniforms.dmi'
	icon_state = "peacekeeper"
	worn_icon = 'modular_nova/modules/goofsec/icons/uniforms_worn.dmi'
	worn_icon_digi = 'modular_nova/modules/goofsec/icons/uniforms_worn_digi.dmi'
	worn_icon_state = "peacekeeper"
	armor_type = /datum/armor/clothing_under/rank_security
	inhand_icon_state = null
	has_sensor = SENSOR_COORDS
	random_sensor = FALSE

/obj/item/clothing/suit/armor/vest/nt_police
	icon = 'tff_modular/modules/police_nt/icons/armor.dmi'
	worn_icon = 'tff_modular/modules/police_nt/icons/armor_mob.dmi'
	name = "tactical armor vest"
	desc = "A set of the finest mass produced, stamped plasteel armor plates, containing an environmental protection unit for all-condition door kicking."
	icon_state = "marine_command"
	inhand_icon_state = "armor"
	clothing_flags = STOPSPRESSUREDAMAGE | THICKMATERIAL
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	armor_type = /datum/armor/nt_agent
	cold_protection = CHEST | GROIN | LEGS | FEET | ARMS | HANDS
	min_cold_protection_temperature = SPACE_SUIT_MIN_TEMP_PROTECT_OFF
	heat_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	resistance_flags = FIRE_PROOF | ACID_PROOF

/obj/item/clothing/suit/armor/vest/nt_police/swat
	name = "large tactical armor vest"
	icon_state = "marine_security"
	armor_type = /datum/armor/nt_swat

/datum/armor/nt_agent
	melee = 40
	bullet = 35
	laser = 40
	energy = 30
	bomb = 20
	bio = 40
	fire = 40
	acid = 30
	wound = 15

/datum/armor/nt_swat
	melee = 50
	bullet = 55
	laser = 50
	energy = 50
	bomb = 50
	bio = 80
	fire = 80
	acid = 90
	wound = 25

/*
		CALLERS AND BEAMOUT TOOL
*/

/obj/item/nt_reporter
	name = "NanoTrasen reporter"
	desc = "Use this in-hand to vote to call NanoTrasen backup. If half your team votes for it, SWAT will be dispatched."
	icon = 'tff_modular/modules/police_nt/icons/reporter.dmi'
	icon_state = "reporter_off"
	w_class = WEIGHT_CLASS_SMALL
	var/activated = FALSE
	var/type_to_check = /datum/antagonist/ert/NT_police/agent
	var/type_of_callers = "NT_police_agent"
	var/announcement_source = "NanoTrasen Internal Security"
	var/ghost_poll_msg = "example crap"
	var/amount_to_summon = 5
	var/type_to_summon = /datum/antagonist/ert/NT_police/swat
	var/summoned_type = "NTIS S.W.A.T."
	var/jobban_to_check = ROLE_DEATHSQUAD
	var/announcement_message = "Well..."
	var/sound_nt = 'tff_modular/modules/police_nt/sound/nt_police_second.ogg'

/obj/item/nt_reporter/proc/pre_checks(mob/user)
	if(!user.mind.has_antag_datum(type_to_check))
		to_chat(user, span_warning("You don't know how to use this!"))
		return FALSE
	return TRUE

/obj/item/nt_reporter/proc/questions(mob/user)
	return TRUE

/obj/item/nt_reporter/attack_self(mob/user, modifiers)
	. = ..()
	if(!pre_checks(user))
		return
	if(!activated && !GLOB.NT_police_responder_info[type_of_callers][NT_POLICE_DECLARED])
		if(!questions(user))
			return
		activated = TRUE
		icon_state = "reporter_on"
		GLOB.NT_police_responder_info[type_of_callers][NT_POLICE_VOTES]++
		var/current_votes = GLOB.NT_police_responder_info[type_of_callers][NT_POLICE_VOTES]
		var/amount_of_responders = GLOB.NT_police_responder_info[type_of_callers][NT_POLICE_AMT]
		to_chat(user, span_warning("You have activated the device. \
		Current Votes: [current_votes]/[amount_of_responders] votes."))
		if(current_votes >= amount_of_responders * 0.5)
			GLOB.NT_police_responder_info[type_of_callers][NT_POLICE_DECLARED] = TRUE

			priority_announce(announcement_message, announcement_source, sound_nt, has_important_message = TRUE, color_override = "yellow")
			var/list/candidates = SSpolling.poll_ghost_candidates(
				ghost_poll_msg,
				check_jobban = jobban_to_check,
				alert_pic = /obj/item/nt_reporter,
				role_name_text = summoned_type,
			)

			if(length(candidates))
				var/agents_number = min(amount_to_summon, candidates.len)
				GLOB.NT_police_responder_info[summoned_type][NT_POLICE_AMT] = agents_number

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

					var/datum/antagonist/ert/NT_police/ert_antag = type_to_summon
					cop.mind.add_antag_datum(ert_antag)
					cop.mind.set_assigned_role(SSjob.GetJobType(ert_antag.ert_job_path))
					cop.grant_language(/datum/language/common, source = LANGUAGE_SPAWNER)
					log_game("[key_name(cop)] has been selected as an [ert_antag.name]")
					agents_number--

/obj/item/nt_reporter/swat_caller
	name = "S.W.A.T. backup caller"
	desc = "Use this in-hand to vote to call NanoTrasen S.W.A.T. backup. If half your team votes for it, SWAT will be dispatched."
	type_to_check = /datum/antagonist/ert/NT_police/agent
	type_of_callers = "NT_police_agent"
	ghost_poll_msg = "The NTIS have requested a S.W.A.T. backup. Do you wish to become a S.W.A.T. member?"
	amount_to_summon = 5
	type_to_summon = /datum/antagonist/ert/NT_police/swat
	summoned_type = "NT_police_swat"
	sound_nt = 'tff_modular/modules/police_nt/sound/nt_police_second.ogg'
	announcement_message = "Attention, crew.\nNTIS Police have requested S.W.A.T. backup. Please comply with all requests by special squad members."

/obj/item/nt_reporter/swat_caller/questions(mob/user)
	var/question = "Does the situation require additional S.W.A.T. backup, involve the station impeding you from doing your job, \
		or involve the station making a fraudulent NTIS call and needing an arrest made on the caller?"
	if(tgui_input_list(user, question, "S.W.A.T. Backup Caller", list("Yes", "No")) != "Yes")
		to_chat(user, "You decide not to request S.W.A.T. backup.")
		return FALSE
	message_admins("[ADMIN_LOOKUPFLW(user)] has voted to summon S.W.A.T backup.")
	return TRUE

/obj/item/nt_reporter/trooper_caller
	name = "Guard backup caller"
	desc = "Use this in-hand to vote that the station is engaging in Treason. If half your team votes for it, the Military will handle the situation."
	type_to_check = /datum/antagonist/ert/NT_police/swat
	type_of_callers = "NT_police_swat"
	ghost_poll_msg = "The station has decided to engage in treason. Do you wish to join the NanoTrasen Military?"
	amount_to_summon = 8
	type_to_summon = /datum/antagonist/ert/NT_police/trooper
	summoned_type = "NT_police_trooper"
	sound_nt = 'tff_modular/modules/police_nt/sound/nt_police_third.ogg'
	announcement_message = "Attention, crew.\nYou are accused of corporate treason. Lay down your weapons and surrender. Follow all the orders of the NanoTrasen response team. The perpetrators of corporate betrayal will be punished at the greatest extent."

/obj/item/nt_reporter/trooper_caller/questions(mob/user)
	var/list/list_of_questions = list(
		"Treason is the crime of attacking a state authority. Did the station engage in this today?",
		"Did station crewmembers assault you or the SWAT team at the direction of Security and/or Command?",
		"Did station crewmembers actively prevent you and the SWAT team from accomplishing your objectives at the direction of Security and/or Command?",
		"Were you and your fellow SWAT members unable to handle the issue on your own?",
		"Are you absolutely sure you wish to declare the station as engaging in Treason? Misuse of this can and will result in \
			administrative action against your account."
	)
	for(var/question in list_of_questions)
		if(tgui_input_list(user, question, "Treason Reporter", list("Yes", "No")) != "Yes")
			to_chat(user, "You decide not to declare the station as treasonous.")
			return FALSE
	message_admins("[ADMIN_LOOKUPFLW(user)] has acknowledged the consequences of a false claim of Treason administratively, \
		and has voted that the station is engaging in Treason.")
	return TRUE

/obj/item/beamout_tool_nt
	name = "beam-out tool"
	desc = "Use this to begin the lengthy beam-out process to return to NTIS office. It will bring anyone you are pulling with you."
	icon = 'tff_modular/modules/police_nt/icons/reporter.dmi'
	icon_state = "beam_me_up_scotty"
	w_class = WEIGHT_CLASS_SMALL

/obj/item/beamout_tool_nt/attack_self(mob/user, modifiers)
	. = ..()
	if(!user.mind.has_antag_datum(/datum/antagonist/ert))
		to_chat(user, span_warning("You don't understand how to use this device."))
		return
	message_admins("[ADMIN_LOOKUPFLW(user)] has begun to beam-out using their beam-out tool.")
	to_chat(user, "You have begun the beam-out process. Please wait for the beam to reach the station.")
	user.balloon_alert(user, "begun beam-out")
	if(do_after(user, 15 SECONDS))
		to_chat(user, "You have completed the beam-out process and are returning to the NTIS office.")
		message_admins("[ADMIN_LOOKUPFLW(user)] has beamed themselves out.")
		if(isliving(user))
			var/mob/living/living_user = user
			if(living_user.pulling)
				if(ishuman(living_user.pulling))
					var/mob/living/carbon/human/beamed_human = living_user.pulling
					message_admins("[ADMIN_LOOKUPFLW(user)] has beamed out [ADMIN_LOOKUPFLW(beamed_human)] alongside them.")
				else
					message_admins("[ADMIN_LOOKUPFLW(user)] has beamed out [living_user.pulling] alongside them.")
				var/turf/pulling_turf = get_turf(living_user.pulling)
				playsound(pulling_turf, 'sound/magic/Repulse.ogg', 100, 1)
				var/datum/effect_system/spark_spread/quantum/sparks = new
				sparks.set_up(10, 1, pulling_turf)
				sparks.attach(pulling_turf)
				sparks.start()
				qdel(living_user.pulling)
			var/turf/user_turf = get_turf(living_user)
			playsound(user_turf, 'sound/magic/Repulse.ogg', 100, 1)
			var/datum/effect_system/spark_spread/quantum/sparks = new
			sparks.set_up(10, 1, user_turf)
			sparks.attach(user_turf)
			sparks.start()
			qdel(user)
	else
		user.balloon_alert(user, "beam-out cancelled")

/*
		Ammunition
*/

/*
	NTIS AGENTS WEAPONRY
*/

/obj/item/choice_beacon/nt_police
	name = "NTIS self-defence weapon delivery beacon"
	desc = "Weapon delivery beacon designed for picky NTIS agents."
	icon_state = "gangtool-white"
	w_class = WEIGHT_CLASS_SMALL

/obj/item/choice_beacon/nt_police/generate_display_names()
	var/static/list/weapon_kits
	if(!weapon_kits)
		weapon_kits = list()
		var/list/possible_kits = list(
			/obj/item/gun/energy/disabler,
			/obj/item/gun/energy/disabler/smg,
		)
		for(var/obj/item/kit as anything in possible_kits)
			weapon_kits[initial(kit.name)] = kit

	return weapon_kits

/obj/item/storage/box/nt_police
	// спрайтик коробки и спрайтик изображения на коробке
	// вы можете сами изменить в случае необходимости
	icon_state = "syndiebox"
	illustration = "glasses"
	desc = "Somewhat robust box for special gear."

/obj/item/storage/box/nt_police/Initialize(mapload)
	. = ..()
	atom_storage.max_specific_storage = WEIGHT_CLASS_NORMAL

/*
    NTIS-SWAT WEAPONRY

	ВАЖНО!

	Билд меняется, так что при изменениях связанных с вооружением - обновляйте вооружение SWAT-овцам так,
	чтобы оно было аналогичным или схожим станционному (тому что есть/можно раздобыть на станции)!
*/

/obj/item/choice_beacon/nt_police/swat
	name = "NTIS-SWAT weapon delivery beacon"
	desc = "Weapon delivery beacon designed for NTIS-SWAT units."

/obj/item/choice_beacon/nt_police/swat/generate_display_names()
	var/static/list/weapon_kits
	if(!weapon_kits)
		weapon_kits = list()
		var/list/possible_kits = list(
			/obj/item/storage/box/nt_police/swat/energy,
			/obj/item/storage/box/nt_police/swat/smg,
			/obj/item/storage/box/nt_police/swat/rifle,
			/obj/item/storage/box/nt_police/swat/shotgun,
		)
		for(var/obj/item/kit as anything in possible_kits)
			weapon_kits[initial(kit.name)] = kit

	return weapon_kits

/obj/item/storage/box/nt_police/swat
	illustration = "handcuff"

/obj/item/storage/box/nt_police/swat/energy
	name = "Energy weapon kit"

/obj/item/storage/box/nt_police/swat/energy/PopulateContents()
	new /obj/item/gun/energy/modular_laser_rifle(src)
	new /obj/item/gun/energy/e_gun/mini(src)

/obj/item/storage/box/nt_police/swat/smg
	name = "SMG kit"

/obj/item/storage/box/nt_police/swat/smg/PopulateContents()
	new /obj/item/gun/ballistic/automatic/sol_smg(src)
	new /obj/item/ammo_box/magazine/c35sol_pistol/stendo(src)
	new /obj/item/ammo_box/magazine/c35sol_pistol/stendo(src)
	new /obj/item/ammo_box/magazine/c35sol_pistol/stendo(src)
	new /obj/item/gun/ballistic/automatic/pistol/sol(src)
	new /obj/item/ammo_box/magazine/c35sol_pistol(src)
	new /obj/item/suppressor/standard(src)
	new /obj/item/storage/pouch/ammo(src)

/obj/item/storage/box/nt_police/swat/rifle
	name = "Rifle kit"

/obj/item/storage/box/nt_police/swat/rifle/PopulateContents()
	new /obj/item/gun/ballistic/automatic/sol_rifle/marksman(src)
	new /obj/item/ammo_box/magazine/c40sol_rifle/standard(src)
	new /obj/item/ammo_box/magazine/c40sol_rifle/standard(src)
	new /obj/item/ammo_box/magazine/c40sol_rifle/standard(src)
	new /obj/item/gun/ballistic/revolver/sol(src)
	new /obj/item/ammo_box/c35sol(src)
	new /obj/item/storage/pouch/ammo(src)

/obj/item/storage/box/nt_police/swat/shotgun
	name = "Shotgun kit"

/obj/item/storage/box/nt_police/swat/shotgun/PopulateContents()
	new /obj/item/gun/ballistic/shotgun/riot/sol(src)
	new /obj/item/ammo_box/advanced/s12gauge(src)
	new /obj/item/ammo_box/advanced/s12gauge/flechette(src)
	new /obj/item/gun/ballistic/revolver/takbok(src)
	new /obj/item/ammo_box/c585trappiste(src)
	new /obj/item/storage/pouch/ammo(src)

/*
    NTIS TROOPERS WEAPONRY
*/

/obj/item/choice_beacon/nt_police/trooper
	name = "NTIS trooper weapon delivery beacon"
	desc = "Weapon delivery beacon designed for NTIS troopers."

/obj/item/choice_beacon/nt_police/trooper/generate_display_names()
	var/static/list/weapon_kits
	if(!weapon_kits)
		weapon_kits = list()
		var/list/possible_kits = list(
			/obj/item/storage/box/nt_police/trooper/ar,
		)
		for(var/obj/item/kit as anything in possible_kits)
			weapon_kits[initial(kit.name)] = kit

	return weapon_kits

/obj/item/storage/box/nt_police/trooper
	illustration = "bodybags"

/obj/item/storage/box/nt_police/trooper/ar
	name = "NTIS trooper assault rifle kit"

/obj/item/storage/box/nt_police/trooper/ar/PopulateContents()
	new /obj/item/gun/ballistic/automatic/ar(src)
	new /obj/item/ammo_box/magazine/m223(src)
	new /obj/item/ammo_box/magazine/m223(src)
	new /obj/item/ammo_box/magazine/m223(src)
	new /obj/item/ammo_box/magazine/m223(src)
	new /obj/item/gun/ballistic/revolver/mateba(src)
	new /obj/item/ammo_box/a357(src)
	new /obj/item/ammo_box/a357(src)
	new /obj/item/storage/pouch/ammo(src)


/*

			Снаряжение для классовости SWAT и Troopers

*/

/obj/item/choice_beacon/nt_police/swat_class
	name = "NTIS-SWAT tools delivery beacon"
	desc = "Tools delivery beacon designed for NTIS-SWAT units."

/obj/item/choice_beacon/nt_police/swat_class/generate_display_names()
	var/static/list/weapon_kits
	if(!weapon_kits)
		weapon_kits = list()
		var/list/possible_kits = list(
			/obj/item/storage/box/nt_police/swat_class/emp,
			/obj/item/storage/box/nt_police/swat_class/medic,
			/obj/item/storage/box/nt_police/swat_class/explosion,
			/obj/item/storage/box/nt_police/swat_class/enginer,
		)
		for(var/obj/item/kit as anything in possible_kits)
			weapon_kits[initial(kit.name)] = kit

	return weapon_kits

/obj/item/storage/box/nt_police/swat_class
	illustration = "handcuff"

/obj/item/storage/box/nt_police/swat_class/emp
	name = "Energy weapon kit"

/obj/item/storage/box/nt_police/swat_class/emp/PopulateContents()
	for(var/i in 1 to 5)
		new /obj/item/grenade/empgrenade(src)
	new /obj/item/implanter/emp(src)

/obj/item/storage/box/nt_police/swat_class/medic
	name = "Medical kit"

/obj/item/storage/box/nt_police/swat_class/medic/PopulateContents()
	new /obj/item/autosurgeon/medical_hud(src)
	new /obj/item/storage/medkit/tactical(src)
	new /obj/item/reagent_containers/hypospray/combat(src)
	new /obj/item/reagent_containers/hypospray/combat(src)

/obj/item/storage/box/nt_police/swat_class/explosion
	name = "Explosive kit"

/obj/item/storage/box/nt_police/swat_class/explosion/PopulateContents()
	for(var/i in 1 to 8)
		new /obj/item/grenade/c4(src)

/obj/item/storage/box/nt_police/swat_class/enginer
	name = "Enginer kit"

/obj/item/storage/box/nt_police/swat_class/enginer/PopulateContents()
	new /obj/item/autosurgeon/toolset(src)
	new /obj/item/storage/barricade(src)
	new /obj/item/holosign_creator/atmos(src)

/obj/item/choice_beacon/nt_police/trooper_class
	name = "NTIS-Trooper tools delivery beacon"
	desc = "Tools delivery beacon designed for NTIS-SWAT units."

/obj/item/choice_beacon/nt_police/trooper_class/generate_display_names()
	var/static/list/weapon_kits
	if(!weapon_kits)
		weapon_kits = list()
		var/list/possible_kits = list(
			/obj/item/storage/box/nt_police/trooper_class/medic,
			/obj/item/storage/box/nt_police/trooper_class/explosion,
			/obj/item/storage/box/nt_police/trooper_class/enginer,
		)
		for(var/obj/item/kit as anything in possible_kits)
			weapon_kits[initial(kit.name)] = kit

	return weapon_kits

/obj/item/storage/box/nt_police/trooper_class/medic
	name = "Medical kit"

/obj/item/storage/box/nt_police/trooper_class/medic/PopulateContents()
	new /obj/item/autosurgeon/medical_hud(src)
	new /obj/item/storage/medkit/tactical/premium(src)
	new /obj/item/reagent_containers/hypospray/combat(src)
	new /obj/item/reagent_containers/hypospray/combat/nanites(src)

/obj/item/storage/box/nt_police/trooper_class/explosion
	name = "Explosive kit"

/obj/item/storage/box/nt_police/trooper_class/explosion/PopulateContents()
	new /obj/item/storage/belt/grenade/full(src)

/obj/item/storage/box/nt_police/trooper_class/enginer
	name = "Enginer kit"

/obj/item/storage/box/nt_police/trooper_class/enginer/PopulateContents()
	new /obj/item/autosurgeon/toolset(src)
	new /obj/item/storage/barricade(src)
	for(var/i in 1 to 8)
		new /obj/item/grenade/barrier(src)
	new /obj/item/construction/rcd/arcd/mattermanipulator(src)
	new /obj/item/holosign_creator/atmos(src)



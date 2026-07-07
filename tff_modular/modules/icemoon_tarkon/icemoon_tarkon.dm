/datum/map_template/ruin/icemoon/underground/icetarkon
	name = "Tarkon ICV-7 Horizon"
	id = "ice-tarkon-ship"
	description = "A Tarkon ICV-7 Horizon."
	prefix = "_maps/RandomRuins/IceRuins/fluffy/"
	suffix = "icemoon_tarkon_ship_ff.dmm"
	allow_duplicates = FALSE
	always_place = TRUE

//areas horizon
/area/ruin/tarkon_ship/atmos
	name = "Horizon Atmospheric Center"
	icon_state = "atmos"

/area/ruin/tarkon_ship/mainhall
	name = "Horizon Main Hall"
	icon_state = "atmos"

/area/ruin/tarkon_ship/mainhall/capdorm
	name = "Horizon Captain Quarters"
	icon_state = "atmos"

/area/ruin/tarkon_ship/mainhall/dorm
	name = "Horizon Dorms"
	icon_state = "atmos"

/area/ruin/tarkon_ship/medbay
	name = "Horizon Medbay"
	icon_state = "atmos"

/area/ruin/tarkon_ship/xeno
	name = "Horizon Xenobiology"
	icon_state = "atmos"

/area/ruin/tarkon_ship/rnd
	name = "Horizon R&D"
	icon_state = "atmos"

/area/ruin/tarkon_ship/bridge
	name = "Horizon Bridge"
	icon_state = "atmos"

//id cards
/datum/id_trim/away/shiptarkon
	assignment = "Tarkon Ship Worker"
	access = list(ACCESS_AWAY_GENERAL, ACCESS_WEAPONS, ACCESS_TARKON)
	department_color = COLOR_WHITE
	department_state = "department"
	subdepartment_color = COLOR_DARK_CYAN
	sechud_icon_state = SECHUD_UNKNOWN
	trim_state = "trim_unknown"

/obj/item/card/id/advanced/shiptarkon
	name = "Tarkon deck access pass"
	desc = "A dust-collected visitors pass, A small tagline reading \"Port Tarkon, The first step to Civilian Partnership in Space Homesteading\"."
	icon = 'modular_nova/modules/tarkon/icons/misc/card.dmi'
	icon_state = "tarkon"
	trim = /datum/id_trim/away/shiptarkon
	assigned_icon_state = "assigned_tarkon"

/datum/id_trim/away/shiptarkon/cargo
	assignment = "Tarkon Ship Cargo Personnel"
	access = list(ACCESS_AWAY_GENERAL, ACCESS_WEAPONS, ACCESS_TARKON)
	department_color = COLOR_DARK_BROWN
	department_state = "department"
	sechud_icon_state = SECHUD_CARGO_TECHNICIAN
	trim_state = "trim_cargotechnician"

/obj/item/card/id/advanced/shiptarkon/cargo
	name = "Tarkon cargo hauler's access card"
	desc = "An access card designated for \"cargo's finest\". You're also a part time space miner, when cargonia is quiet."
	trim = /datum/id_trim/away/shiptarkon/cargo

/datum/id_trim/away/shiptarkon/sec
	assignment = "Tarkon Mercenary"
	access = list(ACCESS_AWAY_GENERAL, ACCESS_WEAPONS, ACCESS_TARKON)
	department_color = COLOR_DARK_RED
	sechud_icon_state = SECHUD_SECURITY_OFFICER
	trim_state = "trim_securityofficer"

/datum/id_trim/away/shiptarkon/med
	assignment = "Tarkon Trauma Medic"
	access = list(ACCESS_MEDICAL, ACCESS_AWAY_GENERAL, ACCESS_WEAPONS, ACCESS_TARKON)
	department_color = COLOR_MEDICAL_BLUE
	sechud_icon_state = SECHUD_MEDICAL_DOCTOR
	trim_state = "trim_medicaldoctor"

/obj/item/card/id/advanced/shiptarkon/med
	name = "P-T trauma medic's access card"
	desc = "An access card designated for \"medical staff\". You provide the medic bags."
	trim = /datum/id_trim/away/shiptarkon/med

/datum/id_trim/away/shiptarkon/eng
	assignment = "Tarkon Maintenance Crew"
	department_color = COLOR_ENGINEERING_ORANGE
	sechud_icon_state = SECHUD_STATION_ENGINEER
	trim_state = "trim_stationengineer"

/obj/item/card/id/advanced/shiptarkon/engi
	name = "P-T maintenance engineer's access card"
	desc = "An access card designated for \"engineering staff\". You're going to be the one everyone points at to fix stuff, let's be honest."
	trim = /datum/id_trim/away/shiptarkon/eng

/datum/id_trim/away/shiptarkon/sci
	assignment = "Tarkon Field Researcher"
	access = list(ACCESS_AWAY_GENERAL, ACCESS_WEAPONS, ACCESS_TARKON)
	department_color = COLOR_SCIENCE_PINK
	sechud_icon_state = SECHUD_SCIENTIST
	trim_state = "trim_scientist"

/obj/item/card/id/advanced/shiptarkon/sci
	name = "Tarkon field researcher's access card"
	desc = "An access card designated for \"the science team\". You are forgotten basically immediately when it comes to the lab."
	trim = /datum/id_trim/away/shiptarkon/sci

/datum/id_trim/away/shiptarkon/frstoff
	assignment = "Tarkon First Officer"
	access = list(ACCESS_MEDICAL, ACCESS_ROBOTICS, ACCESS_AWAY_GENERAL, ACCESS_TARKON, ACCESS_WEAPONS)
	department_color = COLOR_COMMAND_BLUE
	sechud_icon_state = SECHUD_BLUESHIELD
	trim_icon = 'modular_nova/master_files/icons/obj/card.dmi'
	trim_state = "trim_blueshield"

/obj/item/card/id/advanced/shiptarkon/sec
	name = "Tarkon resident deputy's access card"
	desc = "An access card designated for \"security members\". Everyone wants your guns, partner. Yee-haw."
	trim = /datum/id_trim/away/shiptarkon/sec

/obj/item/card/id/advanced/shiptarkon/frstoff
	name = "Tarkon first officer's access card"
	desc = "An access card designated for \"Tarkon First Officer\". No one has to listen to you... But you're the closest thing there is to command around here."
	trim = /datum/id_trim/away/shiptarkon/frstoff

/datum/id_trim/away/shiptarkon/captain
	assignment = "Tarkon Ship Captain"
	access = list(ACCESS_MEDICAL, ACCESS_ROBOTICS, ACCESS_AWAY_GENERAL, ACCESS_TARKON, ACCESS_WEAPONS)
	department_color = COLOR_COMMAND_BLUE
	sechud_icon_state = SECHUD_BLUESHIELD
	trim_state = "trim_captain"

/obj/item/card/id/advanced/shiptarkon/captain
	name = "Tarkon ship captain's access card"
	desc = "An access card designated for \"Tarkon Ship Captain\". It's no longer hesitation, only consideration."
	trim = /datum/id_trim/away/shiptarkon/captain

/datum/id_trim/away/shiptarkon/robo
	access = list(ACCESS_ROBOTICS)

/obj/item/card/id/away/shiptarkonrobo
	name = "Tarkon Robotics Card"
	desc = "An access card designed to access robot's access ports, provided by Tarkon Industries."
	icon = 'modular_nova/modules/tarkon/icons/misc/card.dmi'
	icon_state = "robotics"
	trim = /datum/id_trim/away/shiptarkon/robo
//job datums
/datum/job/shiptarkon
	title = ROLE_PORT_TARKON
	policy_index = ROLE_PORT_TARKON
	paycheck = PAYCHECK_ZERO
	bounty_types = TARKON_JOB_CREW
	paycheck_department = ACCOUNT_TI

/datum/job/shiptarkon/command
	head_announce = list(RADIO_CHANNEL_TARKON)
	bounty_types = TARKON_JOB_COMMAND

//spawners
/obj/effect/mob_spawn/ghost_role/human/shiptarkon
	name = "Tarkon Ship Crew Member"
	prompt_name = "a ship deck worker"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	you_are_text = "You are a member of Tarkon Industries, recently assigned to a recently recovered asset known as ICV-7 Horizon. Your supervisors are the First Officer and Ship Captain."
	flavour_text = "On the recently reclaimed Tarkon, You are tasked to help finish construction and carry on any tasks given by the ship captain. It may be best to look at your departmental noteboard."
	important_text = "You are not to abandon ICV-7 Horizon. Check other sleepers for alternative jobs. Listen to the First Officer and Ship Captain."
	outfit = /datum/outfit/tarkon
	faction = list(FACTION_TARKON)
	spawner_job_path = /datum/job/shiptarkon
	loadout_enabled = TRUE
	quirks_enabled = TRUE
	random_appearance = FALSE

/datum/outfit/shiptarkon
	name = "default port tarkon outfit"
	uniform = /obj/item/clothing/under/tarkon/general
	head = /obj/item/clothing/head/utility/welding/hat
	shoes = /obj/item/clothing/shoes/winterboots
	gloves = /obj/item/clothing/gloves/combat
	back = /obj/item/storage/backpack
	id = /obj/item/card/id/advanced/shiptarkon
	id_trim = /datum/id_trim/away/shiptarkon
	ears = /obj/item/radio/headset/tarkon
	backpack_contents = list(
		/obj/item/crowbar = 1,
		/obj/item/storage/box/survival=1,
		/obj/item/storage/box/nif_ghost_box/ghost_role=1
		)
	var/backpack = /obj/item/storage/backpack/tarkon //Replaces "back" item with provided backpack based on preference on role spawn. Will be used further in project Colony Echo
	/// Replaces "back" item with provided satchel
	var/satchel = /obj/item/storage/backpack/satchel/tarkon
	/// Replaces "back" item with provided duffelbag
	var/duffelbag = /obj/item/storage/backpack/duffelbag/tarkon
	/// Replaces "back" item with provided messenger bag.
	var/messenger = /obj/item/storage/backpack/messenger/tarkon

/datum/outfit/shiptarkon/pre_equip(mob/living/carbon/human/shiptarkon, visuals_only = FALSE)
	if(ispath(back, /obj/item/storage/backpack)) //we just steal this from the job outfit datum.
		switch(shiptarkon.backpack)
			if(GBACKPACK)
				back = /obj/item/storage/backpack //Grey backpack
			if(GSATCHEL)
				back = /obj/item/storage/backpack/satchel //Grey satchel
			if(GDUFFELBAG)
				back = /obj/item/storage/backpack/duffelbag //Grey Duffel bag
			if(LSATCHEL)
				back = /obj/item/storage/backpack/satchel/leather //Leather Satchel
			if(GMESSENGER)
				back = /obj/item/storage/backpack/messenger //Grey messenger bag
			if(DBACKPACK)
				back = backpack //faction backpack
			if(DSATCHEL)
				back = satchel //faction satchel
			if(DMESSENGER)
				back = messenger //faction messenger bag
			if(DDUFFELBAG)
				back = duffelbag //faction duffel bag
			if(TPACKB)
				back = /obj/item/storage/backpack/tinypakb //tiny packs, because they kinda drippin
			if(TPACKA)
				back = /obj/item/storage/backpack/tinypaka
			if(TPACKC)
				back = /obj/item/storage/backpack/tinypakc
			if(UDCPACK)
				back = /obj/item/storage/backpack/udc //No guncase option as of yet.
			else
				back = backpack //faction backpack fallback incase bag pref shits bed

	var/client/client = GLOB.directory[ckey(shiptarkon.mind?.key)]

	if(isplasmaman(shiptarkon))
		uniform = /obj/item/clothing/under/plasmaman
		gloves = /obj/item/clothing/gloves/color/plasmaman
		head = /obj/item/clothing/head/helmet/space/plasmaman
		r_hand = /obj/item/tank/internals/plasmaman/belt/full
		internals_slot = ITEM_SLOT_HANDS
	if(isvox(shiptarkon) || isvoxprimalis(shiptarkon))
		r_hand = /obj/item/tank/internals/nitrogen/belt/full
		mask = /obj/item/clothing/mask/breath/vox
		internals_slot = ITEM_SLOT_HANDS

	if(client?.is_veteran() && client?.prefs.read_preference(/datum/preference/toggle/playtime_reward_cloak))
		neck = /obj/item/clothing/neck/cloak/skill_reward/playing

/datum/outfit/shiptarkon/post_equip(mob/living/carbon/human/tarkon, visualsOnly = FALSE)
	var/obj/item/card/id/id_card = tarkon.wear_id
	if(istype(id_card))
		id_card.registered_name = tarkon.real_name
		id_card.update_label()
		id_card.update_icon()
	var/obj/item/radio/target_radio = tarkon.ears
	target_radio.set_frequency(FREQ_TARKON)
	target_radio.recalculateChannels()

	handlebank(tarkon)
	return ..()

/obj/effect/mob_spawn/ghost_role/human/shiptarkon/cargo
	prompt_name = "a port salvage tech"
	outfit = /datum/outfit/tarkon/cargo

/datum/outfit/shiptarkon/cargo
	name = "Tarkon Ship Cargo Outfit"
	uniform = /obj/item/clothing/under/tarkon
	glasses = /obj/item/clothing/glasses/sunglasses
	id = /obj/item/card/id/advanced/shiptarkon/cargo
	id_trim = /datum/id_trim/away/shiptarkon/cargo
	l_pocket = /obj/item/mining_voucher

/obj/effect/mob_spawn/ghost_role/human/shiptarkon/sci
	prompt_name = "a port researcher"
	outfit = /datum/outfit/tarkon/sci

/datum/outfit/shiptarkon/sci
	name = "Tarkon Ship Science Outfit"
	uniform = /obj/item/clothing/under/tarkon/sci
	glasses = /obj/item/clothing/glasses/hud/diagnostic
	id = /obj/item/card/id/advanced/shiptarkon/sci
	id_trim = /datum/id_trim/away/shiptarkon/sci
	r_pocket = /obj/item/stock_parts/power_store/cell/high
	l_pocket = /obj/item/card/id/away/shiptarkonrobo

/obj/effect/mob_spawn/ghost_role/human/shiptarkon/med
	prompt_name = "a port trauma medic"
	outfit = /datum/outfit/tarkon/med

/datum/outfit/shiptarkon/med
	name = "Tarkon Ship Medical Outfit"
	uniform = /obj/item/clothing/under/tarkon/med
	glasses = /obj/item/clothing/glasses/hud/health
	id = /obj/item/card/id/advanced/shiptarkon/med
	id_trim = /datum/id_trim/away/shiptarkon/med
	neck = /obj/item/clothing/neck/stethoscope
	l_pocket = /obj/item/healthanalyzer
	r_pocket = /obj/item/stack/medical/suture/medicated

/obj/effect/mob_spawn/ghost_role/human/shiptarkon/engi
	prompt_name = "a port maintenance engineer"
	outfit = /datum/outfit/tarkon/engi

/datum/outfit/shiptarkon/engi
	name = "Tarkon Ship Engineering Outfit"
	uniform = /obj/item/clothing/under/tarkon/eng
	glasses = /obj/item/clothing/glasses/meson/engine/tray
	id = /obj/item/card/id/advanced/shiptarkon/engi
	id_trim = /datum/id_trim/away/shiptarkon/eng
	neck = /obj/item/clothing/neck/security_cape/tarkon
	l_pocket = /obj/item/tank/internals/emergency_oxygen/engi
	r_pocket = /obj/item/stack/cable_coil
	backpack_contents = list(
		/obj/item/storage/box/survival=1,
		/obj/item/storage/box/nif_ghost_box/ghost_role=1,
		/obj/item/crowbar = 1,
		/obj/item/inducer = 1
		)

/obj/effect/mob_spawn/ghost_role/human/shiptarkon/sec
	prompt_name = "a port security member"
	outfit = /datum/outfit/tarkon/sec

/datum/outfit/shiptarkon/sec
	name = "Tarkon Ship Security Outfit"
	uniform = /obj/item/clothing/under/tarkon/sec
	glasses = /obj/item/clothing/glasses/hud/security
	gloves = /obj/item/clothing/gloves/tackler/combat
	neck = /obj/item/clothing/neck/security_cape/tarkon
	id = /obj/item/card/id/advanced/shiptarkon/sec
	id_trim = /datum/id_trim/away/shiptarkon/sec
	l_pocket = /obj/item/melee/baton/telescopic
	r_pocket = /obj/item/grenade/barrier

/obj/effect/mob_spawn/ghost_role/human/shiptarkon/frstoff
	name = "Tarkon Ship First Officer"
	prompt_name = "an abandoned first officer"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper-o"
	you_are_text = "You were tasked by Tarkon Industries to ICV-7 Horizon as a low-level command member. Your superior is the Ship Captain."
	flavour_text = "Second in command, you are usually tasked with outward missions with other Tarkon members while the captain stays at the ship. "
	important_text = "This is Not a job ment for Non-Tarkon specific Characters. You are not to abandon ICV-7 Horizon without reason. You are allowed to travel within available Z-levels and to the station, and are allowed to hold exploration parties."
	outfit = /datum/outfit/shiptarkon/frstoff
	spawner_job_path = /datum/job/shiptarkon

/datum/outfit/shiptarkon/frstoff //jack of all trades, master of none, spent all his credits, every last one
	name = "Tarkon Ship First Officer Outfit"
	uniform = /obj/item/clothing/under/tarkon/com
	ears = /obj/item/radio/headset/tarkon/command
	id = /obj/item/card/id/advanced/shiptarkon/frstoff
	id_trim = /datum/id_trim/away/shiptarkon/frstoff
	neck = /obj/item/clothing/neck/security_cape/tarkon

/obj/effect/mob_spawn/ghost_role/human/shiptarkon/captain
	name = "Tarkon Ship Captain"
	prompt_name = "a ship captain"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	you_are_text = "You are a newly assigned Tarkon Ship Captain for ICV-7 Horizon. Your superiors are none except the will of yourself and Tarkon Industries."
	flavour_text = "On the recently reclaimed Port Tarkon, You are tasked with overlooking your crew and keeping the ship up and running."
	important_text = "This is Not a job ment for Non-Tarkon specific Characters. You are not to abandon ICV-7 Horizon. Check other sleepers for alternative jobs."
	outfit = /datum/outfit/shiptarkon/captain
	spawner_job_path = /datum/job/shiptarkon/command
	loadout_enabled = TRUE
	quirks_enabled = TRUE
	random_appearance = FALSE

/datum/outfit/shiptarkon/captain
	name = "Tarkon Ship Captain Outfit"
	uniform = /obj/item/clothing/under/tarkon/com
	ears = /obj/item/radio/headset/tarkon/command
	id = /obj/item/card/id/advanced/shiptarkon/captain
	id_trim = /datum/id_trim/away/shiptarkon/captain
	neck = /obj/item/clothing/neck/security_cape/tarkon
	r_pocket = /obj/item/card/id/away/shiptarkonrobo

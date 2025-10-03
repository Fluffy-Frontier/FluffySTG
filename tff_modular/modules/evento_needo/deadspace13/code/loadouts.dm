/*
*
*					GLOVES
*
*/

/datum/loadout_item/gloves/deadspace
	restricted_roles = list(JOB_SECURITY_OFFICER, JOB_DETECTIVE, JOB_WARDEN, JOB_HEAD_OF_SECURITY)
	name = "armored gloves"
	item_path = /obj/item/clothing/gloves/combat/pcsi




/*
*
*					HEAD
*
*/

/datum/loadout_item/head/deadspace
	restricted_roles = list(JOB_SECURITY_OFFICER, JOB_DETECTIVE, JOB_WARDEN, JOB_HEAD_OF_SECURITY)
	name = "P.C.S.I helmet"
	item_path = /obj/item/clothing/head/helmet/pcsi

/datum/loadout_item/head/deadspace/pcsi_hood
	name = "P.C.S.I hood"
	item_path = /obj/item/clothing/head/helmet/pcsi_hood

/datum/loadout_item/head/deadspace/cseco
	name = "PCSI beret"
	item_path = /obj/item/clothing/head/helmet/cseco

/datum/loadout_item/head/deadspace/caphat
	restricted_roles = list(JOB_CAPTAIN)
	name = "captain's cap"
	item_path = /obj/item/clothing/head/caphat/cec

/datum/loadout_item/head/deadspace/caphat/retro
	name = "command beret"
	item_path = /obj/item/clothing/head/helmet/retro_command

/datum/loadout_item/head/deadspace/beret
	name = "improper P.C.S.I officer's cap"
	item_path = /obj/item/clothing/head/soft/pcsi

/datum/loadout_item/head/deadspace/hophat
	restricted_roles = list(JOB_HEAD_OF_PERSONNEL)
	name = "first lieutenant's cap"
	item_path = /obj/item/clothing/head/hopcap/cec

/*
*
*					BOOTS
*
*/

/datum/loadout_item/shoes/deadspace
	name = "Flight deck boots"
	item_path = /obj/item/clothing/shoes/workboots/flightdeck

/datum/loadout_item/shoes/deadspace/engi
	restricted_roles = list(JOB_ENGINEERING_GUARD, JOB_CHIEF_ENGINEER, JOB_ATMOSPHERIC_TECHNICIAN, JOB_STATION_ENGINEER)
	name = "Engineer boots"
	item_path = /obj/item/clothing/shoes/workboots/engineer

/datum/loadout_item/shoes/deadspace/sec
	restricted_roles = list(JOB_SECURITY_OFFICER, JOB_DETECTIVE, JOB_WARDEN, JOB_HEAD_OF_SECURITY)
	name = "combat boots"
	item_path = /obj/item/clothing/shoes/combat/pcsi

/*
*
*					SUITS
*
*/

/datum/loadout_item/suit/deadspace
	name = "bio suit"
	item_path = /obj/item/clothing/suit/bio_suit/ds

/datum/loadout_item/suit/deadspace/sec
	restricted_roles = list(JOB_SECURITY_OFFICER, JOB_DETECTIVE, JOB_WARDEN, JOB_HEAD_OF_SECURITY)
	name = "P.C.S.I officer's vest"
	item_path = /obj/item/clothing/suit/armor/pcsi

/datum/loadout_item/suit/deadspace/sec/cec
	name = "CEC standard vest"
	item_path = /obj/item/clothing/suit/armor/pcsi/cec

/datum/loadout_item/suit/deadspace/sec/cseco
	name = "armored security jacket"
	item_path = /obj/item/clothing/suit/armor/vest/cseco

/datum/loadout_item/suit/deadspace/sec/bio
	name = "Earthgov black bio suit"
	item_path = /obj/item/clothing/suit/bio_suit/eg

/datum/loadout_item/suit/deadspace/sec/biowhite
	name = "Earthgov bio hood"
	item_path = /obj/item/clothing/suit/bio_suit/eg/white

/datum/loadout_item/suit/deadspace/chap
	restricted_roles = list(JOB_CHAPLAIN)
	name = "clergy robe"
	item_path = /obj/item/clothing/suit/hooded/chaplainsuit/clergy

/datum/loadout_item/suit/deadspace/cargo
	restricted_roles = list(JOB_CARGO_TECHNICIAN, JOB_QUARTERMASTER, JOB_CUSTOMS_AGENT, JOB_BITRUNNER)
	name = "fur-lined coat"
	item_path = /obj/item/clothing/suit/toggle/ds_cargo_jacket

/*
*
*					UNIFORMS
*
*/

//CIV
/datum/loadout_item/under/deadspace
	name = "plain uniform"
	item_path = /obj/item/clothing/under/rank/civilian/ds_whitegrey

/datum/loadout_item/under/deadspace/botanist
	restricted_roles = list(JOB_BOTANIST)
	name = "botanist uniform"
	item_path = /obj/item/clothing/under/rank/civilian/hydroponics/ds_bot

/datum/loadout_item/under/deadspace/chap
	restricted_roles = list(JOB_CHAPLAIN)
	name = "clergy uniform"
	item_path = /obj/item/clothing/under/rank/civilian/ds_clergy


//COM
/datum/loadout_item/under/deadspace/captain
	restricted_roles = list(JOB_CAPTAIN)
	name = "captain's uniform"
	item_path = /obj/item/clothing/under/rank/captain/ds_captain

/datum/loadout_item/under/deadspace/captain/retro
	name = "captain's uniform"
	item_path = /obj/item/clothing/under/rank/captain/ds_captain_retro

/datum/loadout_item/under/deadspace/rd
	restricted_roles = list(JOB_RESEARCH_DIRECTOR)
	name = "director's uniform"
	item_path = /obj/item/clothing/under/rank/captain/ds_director

/datum/loadout_item/under/deadspace/hop
	restricted_roles = list(JOB_HEAD_OF_PERSONNEL)
	name = "first lieutenant's uniform"
	item_path = /obj/item/clothing/under/rank/civilian/ds_firstlieutenant

/datum/loadout_item/under/deadspace/hop/retro
	name = "first lieutenant's uniform"
	item_path = /obj/item/clothing/under/rank/civilian/ds_firstlieutenant_retro

/datum/loadout_item/under/deadspace/hos
	restricted_roles = list(JOB_HEAD_OF_SECURITY)
	name = "ensign's uniform"
	item_path = /obj/item/clothing/under/rank/civilian/ds_bridgeensign

//ENGI
/datum/loadout_item/under/deadspace/engi
	restricted_roles = list(JOB_ENGINEERING_GUARD, JOB_CHIEF_ENGINEER, JOB_ATMOSPHERIC_TECHNICIAN, JOB_STATION_ENGINEER)
	name = "engineer's uniform"
	item_path = /obj/item/clothing/under/rank/engineering/ds_engineer

/datum/loadout_item/under/deadspace/engi/rig
	name = "RIG undersuit"
	item_path = /obj/item/clothing/under/rank/engineering/ds_rigsuit

//MEDSCI

/datum/loadout_item/under/deadspace/medical
	restricted_roles = list(JOB_MEDICAL_DOCTOR, JOB_CHIEF_MEDICAL_OFFICER, JOB_CORONER, JOB_PARAMEDIC)
	name = "medical doctor's uniform"
	item_path = /obj/item/clothing/under/rank/medical/ds_med

/datum/loadout_item/under/deadspace/chemist
	restricted_roles = list(JOB_CHEMIST)
	name = "chemist's uniform"
	item_path = /obj/item/clothing/under/rank/medical/ds_chemist

/datum/loadout_item/under/deadspace/medical/plain
	name = "plain medic uniform"
	item_path = /obj/item/clothing/under/rank/medical/whitegrey/ds_medic

/datum/loadout_item/under/deadspace/medical/cmo
	restricted_roles = list(JOB_CHIEF_MEDICAL_OFFICER)
	name = "senior medical officer's uniform"
	item_path = /obj/item/clothing/under/rank/medical/chief_medical_officer/ds_senior_med


/datum/loadout_item/under/deadspace/rnd
	restricted_roles = list(JOB_SCIENTIST, JOB_GENETICIST)
	name = "research assistant's uniform"
	item_path = /obj/item/clothing/under/rank/rnd/ds_research

/datum/loadout_item/under/deadspace/rnd/mechanic
	restricted_roles = list(JOB_ROBOTICIST)
	name = "mechanic's uniform"
	item_path = /obj/item/clothing/under/rank/rnd/roboticist/ds_mechanic

/datum/loadout_item/under/deadspace/rd/rnd
	name = "chief science officer's uniform"
	item_path = /obj/item/clothing/under/rank/rnd/research_director/ds_chief_sci



//CARGO
/datum/loadout_item/under/deadspace/cargo
	restricted_roles = list(JOB_CARGO_TECHNICIAN, JOB_QUARTERMASTER, JOB_SHAFT_MINER)
	name = "quartermaster's work clothes"
	item_path = /obj/item/clothing/under/rank/cargo/ds_rdalt

/datum/loadout_item/under/deadspace/cargo/miner
	name = "miner's overalls"
	item_path = /obj/item/clothing/under/rank/cargo/miner/ds_miner

/datum/loadout_item/under/deadspace/cargo/uni
	name = "cargo uniform"
	item_path = /obj/item/clothing/under/rank/cargo/ds_cargo_jumpsuit

/datum/loadout_item/under/deadspace/cargo/flight
	name = "flight deck uniform"
	item_path = /obj/item/clothing/under/rank/cargo/ds_flightdeck

//SEC

/datum/loadout_item/under/deadspace/sec
	restricted_roles = list(JOB_SECURITY_OFFICER, JOB_DETECTIVE, JOB_WARDEN, JOB_HEAD_OF_SECURITY)
	name = "security officer's jumpsuit"
	item_path = /obj/item/clothing/under/rank/security/ds_pcsi

/datum/loadout_item/under/deadspace/sec/cseco
	name = "chief security officer's jumpsuit"
	item_path = /obj/item/clothing/under/rank/security/ds_cseco

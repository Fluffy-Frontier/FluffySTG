/**
 * Блэклист профеcсий... Переопределяя новые датумы старайтесь их держать в том порядке, что работы в меню лейтджойна.
 */

//Командный
/datum/job/captain
	species_blacklist = list(SPECIES_NABBER = TRUE)
	banned_quirks = list(HEAD_RESTRICTED_QUIRKS, "Visitor ID" = TRUE)

/datum/job/nanotrasen_consultant
	species_blacklist = list(SPECIES_NABBER = TRUE)
	banned_quirks = list(HEAD_RESTRICTED_QUIRKS, "Visitor ID" = TRUE)

/datum/job/blueshield
	species_blacklist = list(SPECIES_NABBER = TRUE, SPECIES_TESHARI = TRUE)
	banned_quirks = list(SEC_RESTRICTED_QUIRKS, "Visitor ID" = TRUE)

//Служба безопасности
/datum/job/head_of_security
	species_blacklist = list(SPECIES_NABBER = TRUE, SPECIES_TESHARI = TRUE)
	banned_quirks = list(SEC_RESTRICTED_QUIRKS, HEAD_RESTRICTED_QUIRKS, "Visitor ID" = TRUE)

/datum/job/warden
	species_blacklist = list(SPECIES_NABBER = TRUE, SPECIES_TESHARI = TRUE)
	banned_quirks = list(SEC_RESTRICTED_QUIRKS, "Visitor ID" = TRUE)

/datum/job/detective
	species_blacklist = list(SPECIES_NABBER = TRUE)
	banned_quirks = list(SEC_RESTRICTED_QUIRKS, "Visitor ID" = TRUE)

/datum/job/security_officer
	species_blacklist = list(SPECIES_NABBER = TRUE, SPECIES_TESHARI = TRUE)
	banned_quirks = list(SEC_RESTRICTED_QUIRKS, "Visitor ID" = TRUE)

/datum/job/corrections_officer
	species_blacklist = list(SPECIES_NABBER = TRUE)
	banned_quirks = list(SEC_RESTRICTED_QUIRKS, "Visitor ID" = TRUE)

//Инженерный
/datum/job/chief_engineer
	species_blacklist = list(SPECIES_NABBER = TRUE)
	banned_quirks = list(HEAD_RESTRICTED_QUIRKS, "Paraplegic" = TRUE, "Visitor ID" = TRUE)

/datum/job/station_engineer
	banned_quirks = list("Visitor ID" = TRUE)

/datum/job/atmospheric_technician
	species_blacklist = list(SPECIES_NABBER = TRUE)
	banned_quirks = list("Visitor ID" = TRUE)

/datum/job/engineering_guard
	species_blacklist = list(SPECIES_NABBER = TRUE)
	banned_quirks = list(GUARD_RESTRICTED_QUIRKS, "Visitor ID" = TRUE)

/datum/job/telecomms_specialist
	species_blacklist = list(SPECIES_NABBER = TRUE)
	banned_quirks = list("Visitor ID" = TRUE)

//Медбэй
/datum/job/chief_medical_officer
	species_blacklist = list(SPECIES_NABBER = TRUE)
	banned_quirks = list(HEAD_RESTRICTED_QUIRKS, "Visitor ID" = TRUE)

/datum/job/doctor
	species_blacklist = list(SPECIES_NABBER = TRUE)
	banned_quirks = list("Visitor ID" = TRUE)

/datum/job/chemist
	banned_quirks = list("Visitor ID" = TRUE)

/datum/job/paramedic
	banned_quirks = list("Visitor ID" = TRUE)

/datum/job/coroner
	banned_quirks = list("Visitor ID" = TRUE)

/datum/job/virologist
	species_blacklist = list(SPECIES_NABBER = TRUE)
	banned_quirks = list("Visitor ID" = TRUE)

/datum/job/orderly
	species_blacklist = list(SPECIES_NABBER = TRUE)
	banned_quirks = list(GUARD_RESTRICTED_QUIRKS, "Visitor ID" = TRUE)

//РнД
/datum/job/research_director
	species_blacklist = list(SPECIES_NABBER = TRUE)
	banned_quirks = list(HEAD_RESTRICTED_QUIRKS, "Visitor ID" = TRUE)

/datum/job/scientist
	species_blacklist = list(SPECIES_NABBER = TRUE)
	banned_quirks = list("Visitor ID" = TRUE)

/datum/job/roboticist
	banned_quirks = list("Visitor ID" = TRUE)

/datum/job/geneticist
	species_blacklist = list(SPECIES_NABBER = TRUE)
	banned_quirks = list("Visitor ID" = TRUE)

/datum/job/science_guard
	species_blacklist = list(SPECIES_NABBER = TRUE)
	banned_quirks = list(GUARD_RESTRICTED_QUIRKS, "Visitor ID" = TRUE)

//Карго
/datum/job/quartermaster
	species_blacklist = list(SPECIES_NABBER = TRUE)
	banned_quirks = list(HEAD_RESTRICTED_QUIRKS_QM, "Visitor ID" = TRUE)

/datum/job/cargo_technician
	banned_quirks = list("Visitor ID" = TRUE)

/datum/job/shaft_miner
	species_blacklist = list(SPECIES_NABBER = TRUE)
	banned_quirks = list("Visitor ID" = TRUE)

/datum/job/customs_agent
	species_blacklist = list(SPECIES_NABBER = TRUE)
	banned_quirks = list(GUARD_RESTRICTED_QUIRKS, "Visitor ID" = TRUE)

/datum/job/bitrunner
	species_blacklist = list(SPECIES_NABBER = TRUE)
	banned_quirks = list("Visitor ID" = TRUE)

//Сервис
/datum/job/head_of_personnel
	species_blacklist = list(SPECIES_NABBER = TRUE)
	banned_quirks = list(HEAD_RESTRICTED_QUIRKS, "Visitor ID" = TRUE)

/datum/job/clown
	species_blacklist = list(SPECIES_NABBER = TRUE)
	banned_quirks = list("Visitor ID" = TRUE)

/datum/job/mime
	species_blacklist = list(SPECIES_NABBER = TRUE)
	banned_quirks = list("Visitor ID" = TRUE)

/datum/job/chaplain
	species_blacklist = list(SPECIES_NABBER = TRUE)
	banned_quirks = list("Visitor ID" = TRUE)

/datum/job/psychologist
	species_blacklist = list(SPECIES_NABBER = TRUE)
	banned_quirks = list("Visitor ID" = TRUE)

/datum/job/lawyer
	species_blacklist = list(SPECIES_NABBER = TRUE)
	banned_quirks = list("Visitor ID" = TRUE)

/datum/job/bouncer
	species_blacklist = list(SPECIES_NABBER = TRUE)
	banned_quirks = list(GUARD_RESTRICTED_QUIRKS, "Visitor ID" = TRUE)

/datum/job/bartender
	banned_quirks = list("Visitor ID" = TRUE)

/datum/job/cook
	banned_quirks = list("Visitor ID" = TRUE)

/datum/job/botanist
	banned_quirks = list("Visitor ID" = TRUE)

/datum/job/janitor
	banned_quirks = list("Visitor ID" = TRUE)

/datum/job/curator
	banned_quirks = list("Visitor ID" = TRUE)

/datum/job/barber
	banned_quirks = list("Visitor ID" = TRUE)

//Особые должности
/datum/job/veteran_advisor
	species_blacklist = list(SPECIES_NABBER = TRUE)
	banned_quirks = list("Visitor ID" = TRUE)

/datum/job/bridge_assistant
	species_blacklist = list(SPECIES_NABBER = TRUE)
	banned_quirks = list("Visitor ID" = TRUE)

/datum/job/assistant
	species_blacklist = list(SPECIES_NABBER = TRUE)

/datum/job/prisoner
	species_blacklist = list(SPECIES_NABBER = TRUE)
	banned_quirks = list(PRISONER_RESTRICTED_QUIRKS, "Visitor ID" = TRUE)

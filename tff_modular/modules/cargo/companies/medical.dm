// Этот файл содержит переопределения для медицинских пакетов из Nova modular.
// Соответствующий файл Nova: modular_nova/master_files/code/modules/cargo/packs/companies/medical.dm

/datum/supply_pack/companies/medical/first_aid_kit

/datum/supply_pack/companies/medical/first_aid_kit/comfort

/datum/supply_pack/companies/medical/first_aid_kit/civil_defense
        cost = PAYCHECK_COMMAND * 4

/datum/supply_pack/companies/medical/first_aid_kit/frontier
        cost = PAYCHECK_COMMAND * 4

/datum/supply_pack/companies/medical/first_aid_kit/combat_surgeon
        cost = PAYCHECK_COMMAND * 4

/datum/supply_pack/companies/medical/first_aid_kit/robo_repair
        cost = PAYCHECK_COMMAND * 4

/datum/supply_pack/companies/medical/first_aid_kit/robo_repair_super

/*
/datum/supply_pack/companies/medical/first_aid_kit/first_responder

/datum/supply_pack/companies/medical/first_aid_kit/orange_satchel
	cost = PAYCHECK_COMMAND * 10.5

/datum/supply_pack/companies/medical/first_aid_kit/technician_satchel
	cost = PAYCHECK_COMMAND * 15.5
*/


// Basic first aid supplies like gauze, sutures, mesh, so on

/datum/supply_pack/companies/medical/first_aid
	cost = PAYCHECK_LOWER * 2

/datum/supply_pack/companies/medical/first_aid/coagulant
	cost = PAYCHECK_LOWER * 2

/datum/supply_pack/companies/medical/first_aid/suture
	cost = PAYCHECK_LOWER * 3

/*
/datum/supply_pack/companies/medical/first_aid/medicated_sutures
	cost = PAYCHECK_LOWER * 7
*/

/datum/supply_pack/companies/medical/first_aid/red_sun
	cost = PAYCHECK_LOWER * 2

/datum/supply_pack/companies/medical/first_aid/ointment
	cost = PAYCHECK_LOWER * 2

/datum/supply_pack/companies/medical/first_aid/mesh
	cost = PAYCHECK_LOWER * 3

/*
/datum/supply_pack/companies/medical/first_aid/advanced_mesh
	cost = PAYCHECK_LOWER * 7
*/

/datum/supply_pack/companies/medical/first_aid/sterile_gauze
	cost = PAYCHECK_LOWER * 2

/datum/supply_pack/companies/medical/first_aid/amollin

/datum/supply_pack/companies/medical/first_aid/robo_patch

/datum/supply_pack/companies/medical/first_aid/bandaid
	cost = PAYCHECK_CREW * 3

/datum/supply_pack/companies/medical/first_aid/subdermal_splint

/datum/supply_pack/companies/medical/first_aid/rapid_coagulant

/datum/supply_pack/companies/medical/first_aid/robofoam

/datum/supply_pack/companies/medical/first_aid/super_robofoam

/datum/supply_pack/companies/medical/first_aid/mannitol

// Autoinjectors for healing

/datum/supply_pack/companies/medical/medpens
	cost = PAYCHECK_LOWER * 5

/datum/supply_pack/companies/medical/medpens/occuisate

/datum/supply_pack/companies/medical/medpens/morpital

/datum/supply_pack/companies/medical/medpens/lipital
	cost = PAYCHECK_LOWER * 7

/datum/supply_pack/companies/medical/medpens/meridine

/datum/supply_pack/companies/medical/medpens/calopine
	cost = PAYCHECK_LOWER * 6

/datum/supply_pack/companies/medical/medpens/coagulants
	cost = PAYCHECK_LOWER * 7

/datum/supply_pack/companies/medical/medpens/lepoturi
	cost = PAYCHECK_LOWER * 7

/*
/datum/supply_pack/companies/medical/medpens/psifinil
*/

/datum/supply_pack/companies/medical/medpens/halobinin

/datum/supply_pack/companies/medical/medpens/robo_solder

/datum/supply_pack/companies/medical/medpens/robo_cleaner

/datum/supply_pack/companies/medical/medpens/pentibinin
	cost = PAYCHECK_COMMAND * 2


// Autoinjectors for fighting

/datum/supply_pack/companies/medical/medpens_stim
	cost = PAYCHECK_COMMAND * 4

/datum/supply_pack/companies/medical/medpens_stim/adrenaline

/datum/supply_pack/companies/medical/medpens_stim/synephrine
	cost = PAYCHECK_COMMAND  * 2

/datum/supply_pack/companies/medical/medpens_stim/krotozine

/datum/supply_pack/companies/medical/medpens_stim/aranepaine
	cost = PAYCHECK_COMMAND * 6

/datum/supply_pack/companies/medical/medpens_stim/synalvipitol
	cost = PAYCHECK_COMMAND * 6

/datum/supply_pack/companies/medical/medpens_stim/twitch
	cost = PAYCHECK_COMMAND * 6

/datum/supply_pack/companies/medical/medpens_stim/demoneye
	cost = PAYCHECK_COMMAND * 6

/datum/supply_pack/companies/medical/medpens/pentibinin
	contraband = TRUE

/datum/supply_pack/companies/medical/medpens_stim/aranepaine
	contraband = TRUE

/datum/supply_pack/companies/medical/medpens_stim/synalvipitol
	contraband = TRUE

/datum/supply_pack/companies/medical/medpens_stim/twitch
	contraband = TRUE

/datum/supply_pack/companies/medical/medpens_stim/demoneye
	contraband = TRUE

//Cyberpunk implants can be bought only from restricted consoles
/datum/supply_pack/medical/arm_implants
	access_view = ACCESS_MEDICAL
	access = ACCESS_MEDICAL

/datum/design/cyberimp_hackerman
	category = list(
		RND_CATEGORY_SYNDICATE
	)

// Изменение цен для заказов карго вот этих вот -> 'modular_nova\modules\deforest_medical_items\code\cargo_packs.dm'

/datum/supply_pack/medical/civil_defense

/datum/supply_pack/medical/civil_defense/comfort

/datum/supply_pack/medical/frontier_first_aid

/datum/supply_pack/medical/kit_technician
	cost = CARGO_CRATE_VALUE * 8

/datum/supply_pack/medical/kit_surgical

/datum/supply_pack/medical/kit_medical
	cost = CARGO_CRATE_VALUE * 5.5

/datum/supply_pack/medical/deforest_vendor_refill

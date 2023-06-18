
// Хирургические инструменты
/obj/item/borg/upgrade/alien_surgerytools
	name = "medical cyborg alien surgery tools"
	desc = "An upgrade to the Medical model cyborg's surgery loadout, replacing non-advanced and advanced tools with their alien counterpart."
	icon_state = "cyborg_upgrade3"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/medical)
	model_flags = BORG_MODEL_MEDICAL

/obj/item/borg/upgrade/alien_surgerytools/action(mob/living/silicon/robot/borg)
	. = ..()
	if(.)
		for(var/obj/item/retractor/RT in borg.model.modules)
			borg.model.remove_module(RT, TRUE)
		for(var/obj/item/hemostat/HS in borg.model.modules)
			borg.model.remove_module(HS, TRUE)
		for(var/obj/item/cautery/CT in borg.model.modules)
			borg.model.remove_module(CT, TRUE)
		for(var/obj/item/surgicaldrill/SD in borg.model.modules)
			borg.model.remove_module(SD, TRUE)
		for(var/obj/item/scalpel/SP in borg.model.modules)
			borg.model.remove_module(SP, TRUE)
		for(var/obj/item/circular_saw/CS in borg.model.modules)
			borg.model.remove_module(CS, TRUE)
		for(var/obj/item/healthanalyzer/HA in borg.model.modules)
			borg.model.remove_module(HA, TRUE)
		for(var/obj/item/scalpel/advanced/AS in borg.model.modules)
			borg.model.remove_module(AS, TRUE)
		for(var/obj/item/retractor/advanced/AR in borg.model.modules)
			borg.model.remove_module(AR, TRUE)
		for(var/obj/item/cautery/advanced/AC in borg.model.modules)
			borg.model.remove_module(AC, TRUE)
		for(var/obj/item/healthanalyzer/advanced/AHA in borg.model.modules)
			borg.model.remove_module(AHA, TRUE)

		var/obj/item/scalpel/alien/AS = new /obj/item/scalpel/alien(borg.model)
		borg.model.basic_modules += AS
		borg.model.add_module(AS, FALSE, TRUE)
		var/obj/item/retractor/alien/AR = new /obj/item/retractor/alien(borg.model)
		borg.model.basic_modules += AR
		borg.model.add_module(AR, FALSE, TRUE)
		var/obj/item/cautery/alien/AC = new /obj/item/cautery/alien(borg.model)
		borg.model.basic_modules += AC
		borg.model.add_module(AC, FALSE, TRUE)
		var/obj/item/hemostat/alien/HS = new/obj/item/hemostat/alien(borg.model)
		borg.model.basic_modules += HS
		borg.model.add_module(HS, FALSE, TRUE)
		var/obj/item/circular_saw/alien/CS = new/obj/item/circular_saw/alien(borg.model)
		borg.model.basic_modules += CS
		borg.model.add_module(CS, FALSE, TRUE)
		var/obj/item/surgicaldrill/alien/SD = new/obj/item/surgicaldrill/alien(borg.model)
		borg.model.basic_modules += SD
		borg.model.add_module(SD, FALSE, TRUE)
		var/obj/item/healthanalyzer/advanced/AHA = new /obj/item/healthanalyzer/advanced(borg.model)
		borg.model.basic_modules += AHA
		borg.model.add_module(AHA, FALSE, TRUE)

/obj/item/borg/upgrade/alien_surgerytools/deactivate(mob/living/silicon/robot/borg, user = usr)
	. = ..()
	if(.)
		for(var/obj/item/scalpel/advanced/AS in borg.model.modules)
			borg.model.remove_module(AS, TRUE)
		for(var/obj/item/retractor/advanced/AR in borg.model.modules)
			borg.model.remove_module(AR, TRUE)
		for(var/obj/item/cautery/alien/AC in borg.model.modules)
			borg.model.remove_module(AC, TRUE)
		for(var/obj/item/hemostat/alien/HS in borg.model.modules)
			borg.model.remove_module(HS, TRUE)
		for(var/obj/item/circular_saw/alien/CS in borg.model.modules)
			borg.model.remove_module(CS, TRUE)
		for(var/obj/item/surgicaldrill/alien/SD in borg.model.modules)
			borg.model.remove_module(SD, TRUE)
		for(var/obj/item/healthanalyzer/advanced/AHA in borg.model.modules)
			borg.model.remove_module(AHA, TRUE)


	var/obj/item/retractor/RT = new (borg.model)
	borg.model.basic_modules += RT
	borg.model.add_module(RT, FALSE, TRUE)
	var/obj/item/hemostat/HS = new (borg.model)
	borg.model.basic_modules += HS
	borg.model.add_module(HS, FALSE, TRUE)
	var/obj/item/cautery/CT = new (borg.model)
	borg.model.basic_modules += CT
	borg.model.add_module(CT, FALSE, TRUE)
	var/obj/item/surgicaldrill/SD = new (borg.model)
	borg.model.basic_modules += SD
	borg.model.add_module(SD, FALSE, TRUE)
	var/obj/item/scalpel/SP = new (borg.model)
	borg.model.basic_modules += SP
	borg.model.add_module(SP, FALSE, TRUE)
	var/obj/item/circular_saw/CS = new (borg.model)
	borg.model.basic_modules += CS
	borg.model.add_module(CS, FALSE, TRUE)
	var/obj/item/healthanalyzer/HA = new (borg.model)
	borg.model.basic_modules += HA
	borg.model.add_module(HA, FALSE, TRUE)

//Инженерные инструменты
/obj/item/borg/upgrade/alien_engitools
	name = "engineering alien tools upgrade"
	desc = "An upgrade to the Engineering model cyborg's tool loadout, replacing non-advanced tools with their alien counterpart."
	icon_state = "cyborg_upgrade3"
	model_type = list(/obj/item/robot_model/engineering)
	model_flags = BORG_MODEL_ENGINEERING

/obj/item/borg/upgrade/alien_engitools/action(mob/living/silicon/robot/borg, user)
	. = ..()
	if(.)
		for(var/obj/item/weldingtool/largetank/cyborg/WT in borg.model.modules)
			borg.model.remove_module(WT, TRUE)
		for(var/obj/item/screwdriver/cyborg/power/SD in borg.model.modules)
			borg.model.remove_module(SD, TRUE)
		for(var/obj/item/crowbar/cyborg/power/CB in borg.model.modules)
			borg.model.remove_module(CB, TRUE)
		for(var/obj/item/multitool/cyborg/MT in borg.model.modules)
			borg.model.remove_module(MT, TRUE)

		var/obj/item/crowbar/abductor/CB = new /obj/item/crowbar/abductor(borg.model)
		borg.model.basic_modules += CB
		borg.model.add_module(CB, FALSE, TRUE)
		var/obj/item/screwdriver/abductor/SD = new /obj/item/screwdriver/abductor(borg.model)
		borg.model.basic_modules += SD
		borg.model.add_module(SD, FALSE, TRUE)
		var/obj/item/weldingtool/abductor/WT = new /obj/item/weldingtool/abductor(borg.model)
		borg.model.basic_modules += WT
		borg.model.add_module(WT, FALSE, TRUE)
		var/obj/item/wirecutters/abductor/WC = new /obj/item/wirecutters/abductor(borg.model)
		borg.model.basic_modules += WC
		borg.model.add_module(WC, FALSE, TRUE)
		var/obj/item/wrench/abductor/WR = new /obj/item/wrench/abductor(borg.model)
		borg.model.basic_modules += WR
		borg.model.add_module(WR, FALSE, TRUE)
		var/obj/item/multitool/abductor/MT = new /obj/item/multitool/abductor(borg.model)
		borg.model.basic_modules += MT
		borg.model.add_module(MT, FALSE, TRUE)

/obj/item/borg/upgrade/alien_engitools/deactivate(mob/living/silicon/robot/borg, user)
	. = ..()
	if(.)
		for(var/obj/item/crowbar/abductor/CB in borg.model.modules)
			borg.model.remove_module(CB, TRUE)
		for(var/obj/item/screwdriver/abductor/SD in borg.model.modules)
			borg.model.remove_module(SD, TRUE)
		for(var/obj/item/weldingtool/abductor/WT in borg.model.modules)
			borg.model.remove_module(WT, TRUE)
		for(var/obj/item/wrench/abductor/WR in borg.model.modules)
			borg.model.remove_module(WR, TRUE)
		for(var/obj/item/wirecutters/abductor/WC in borg.model.modules)
			borg.model.remove_module(WC, TRUE)
		for(var/obj/item/multitool/abductor/MT in borg.model.modules)
			borg.model.remove_module(MT, TRUE)

		var/obj/item/weldingtool/largetank/cyborg/WT = new /obj/item/weldingtool/largetank/cyborg(borg.model)
		borg.model.basic_modules += WT
		borg.model.add_module(WT, FALSE, TRUE)
		var/obj/item/screwdriver/cyborg/power/SD = new /obj/item/screwdriver/cyborg/power(borg.model)
		borg.model.basic_modules += SD
		borg.model.add_module(SD, FALSE, TRUE)
		var/obj/item/crowbar/cyborg/power/CB = new /obj/item/crowbar/cyborg/power(borg.model)
		borg.model.basic_modules += CB
		borg.model.add_module(CB, FALSE, TRUE)
		var/obj/item/multitool/cyborg/MT = new /obj/item/multitool/cyborg(borg.model)
		borg.model.basic_modules += MT
		borg.model.add_module(MT, FALSE, TRUE)

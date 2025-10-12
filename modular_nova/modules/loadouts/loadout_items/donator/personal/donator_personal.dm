/datum/loadout_item/pocket_items/drawingtablet
	name = "Drawing Tablet"
	item_path = /obj/item/canvas/drawingtablet
	donator_only = TRUE

/datum/loadout_item/suit/jacket
	abstract_type = /datum/loadout_item/suit/jacket

/datum/loadout_item/mask/nightlight_mask
	name = "FIR-36 Rebreather"
	item_path = /obj/item/clothing/mask/gas/nightlight

/datum/loadout_item/mask/fir22
	name = "FIR-22 Full-Face Rebreather"
	item_path = /obj/item/clothing/mask/gas/nightlight/fir22

/datum/loadout_item/head/caligram_cap_tan
	name = "Caligram Tan Softcap"
	item_path = /obj/item/clothing/head/caligram_cap

/datum/loadout_item/under/jumpsuit/caligram_fatigues_tan
	name = "Caligram Tan Fatigues"
	item_path = /obj/item/clothing/under/jumpsuit/caligram_fatigues

/datum/loadout_item/suit/caligram_parka_tan
	name = "Caligram Tan Parka"
	item_path = /obj/item/clothing/suit/jacket/caligram_parka

/datum/loadout_item/suit/caligram_parka_vest_tan
	name = "Caligram Armored Tan Parka"
	item_path = /obj/item/clothing/suit/armor/vest/caligram_parka_vest
	restricted_roles = list(
		JOB_BLUESHIELD,
		JOB_HEAD_OF_SECURITY,
		JOB_SECURITY_OFFICER,
		JOB_WARDEN,
		JOB_DETECTIVE,
		JOB_CORRECTIONS_OFFICER,
		JOB_VETERAN_ADVISOR,
		JOB_QUARTERMASTER,
		JOB_CAPTAIN,
		JOB_BRIDGE_ASSISTANT,
		JOB_ORDERLY,
		JOB_ENGINEERING_GUARD,
		JOB_CUSTOMS_AGENT,
		JOB_SCIENCE_GUARD,
		JOB_BOUNCER,
	)

/datum/loadout_item/toys/zappplush
	name = "Lil' Zapp Plushie"
	item_path = /obj/item/toy/plush/nova/donator/zapp
	donator_only = TRUE

/datum/loadout_item/toys/plushe_winrow
	name = "Dark and Brooding Lizard Plushie"
	item_path = /obj/item/toy/plush/nova/donator/plushie_winrow

/datum/loadout_item/toys/plush/plushie_star
	name = "Star Angel Plushie"
	item_path = /obj/item/toy/plush/nova/donator/plushie_star

//Chunko Fops were donated by SlippyJoe, who requested they are usable by everyone

/datum/loadout_item/toys/plush/CFBonnie
	name = "Chunko Fop: Blue Bunny Plushie"
	item_path = /obj/item/toy/plush/nova/donator/chunko/bonnie
	donator_only = TRUE

/datum/loadout_item/toys/plush/CFAndrew
	name = "Chunko Fop: Green Bunny Plushie"
	item_path = /obj/item/toy/plush/nova/donator/chunko/andrew
	donator_only = TRUE

/datum/loadout_item/toys/plush/CFInessa
	name = "Chunko Fop: Medical Bear Plushie"
	item_path = /obj/item/toy/plush/nova/donator/chunko/inessa
	donator_only = TRUE

/datum/loadout_item/toys/plushie_jeanne
	name = "Masked Roboticist Plushie"
	item_path = /obj/item/toy/plush/nova/donator/plushie_jeanne
	// Asked it to be public.

/datum/loadout_item/toys/plush/plushie_elofy
	name = "Bumbling Wolfgirl Plushie"
	item_path = /obj/item/toy/plush/nova/donator/plushie_elofy
	// Asked it to be public.

/datum/loadout_item/pocket_items/masvedishcigar
	name = "Holocigar"
	item_path = /obj/item/holocigarette/masvedishcigar
	// Asked it to be public, and as such has no whitelist.

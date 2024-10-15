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

/datum/loadout_item/toys/plushie_star
	name = "Star Angel Plushie"
	item_path = /obj/item/toy/plush/nova/donator/plushie_star

//Chunko Fops were donated by SlippyJoe, who requested they are usable by everyone

/datum/loadout_item/toys/CFBonnie
	name = "Chunko Fop: Blue Bunny Plushie"
	item_path = /obj/item/toy/plush/nova/donator/chunko/bonnie
	donator_only = TRUE

/datum/loadout_item/toys/CFAndrew
	name = "Chunko Fop: Green Bunny Plushie"
	item_path = /obj/item/toy/plush/nova/donator/chunko/andrew
	donator_only = TRUE

/datum/loadout_item/toys/CFInessa
	name = "Chunko Fop: Medical Bear Plushie"
	item_path = /obj/item/toy/plush/nova/donator/chunko/inessa
	donator_only = TRUE

/datum/loadout_item/toys/plushie_jeanne
	name = "Masked Roboticist Plushie"
	item_path = /obj/item/toy/plush/nova/donator/plushie_jeanne
	// Asked it to be public.

/datum/loadout_item/toys/plushie_elofy
	name = "Bumbling Wolfgirl Plushie"
	item_path = /obj/item/toy/plush/nova/donator/plushie_elofy
	// Asked it to be public.

/datum/loadout_item/pocket_items/masvedishcigar
	name = "Holocigar"
	item_path = /obj/item/holocigarette/masvedishcigar
	// Asked it to be public, and as such has no whitelist.
<<<<<<< HEAD
=======

/datum/loadout_item/suit/lt3_armor
	name = "Silver Jacket Mk II"
	item_path = /obj/item/clothing/suit/armor/skyy
	ckeywhitelist = list("lt3")
	restricted_roles = list(JOB_HEAD_OF_PERSONNEL, JOB_NT_REP)

/datum/loadout_item/suit/lt3_jacket
	name = "Silver Jacket"
	item_path = /obj/item/clothing/suit/jacket/skyy
	ckeywhitelist = list("lt3")

/datum/loadout_item/under/miscellaneous/lt3_jeans
	name = "Silver Jeans"
	item_path = /obj/item/clothing/under/pants/skyy
	ckeywhitelist = list("lt3")

/datum/loadout_item/gloves/lt3_gloves
	name = "Charcoal Fingerless Gloves"
	item_path = /obj/item/clothing/gloves/skyy
	ckeywhitelist = list("lt3")

/datum/loadout_item/toys/switchcomb
	name = "Switchblade Comb"
	item_path = /obj/item/hairbrush/switchblade
	ckeywhitelist = list("stonetear")

/datum/loadout_item/suit/colorblockhoodie
	name = "Color-Block Hoodie"
	item_path = /obj/item/clothing/suit/hooded/colorblockhoodie
	ckeywhitelist = list("lolpopomg101")

/datum/loadout_item/inhand/officialcat
	name = "Official Cat Stamp"
	item_path = /obj/item/stamp/cat
	ckeywhitelist = list("kathrinbailey")

/datum/loadout_item/inhand/sqn_box
	name = "A curious box of things."
	item_path = /obj/item/storage/box/donator/sqn
	ckeywhitelist = list("sqnztb")

/datum/loadout_item/under/jumpsuit/noble_gambeson
	name = "Noble Gambeson"
	item_path = /obj/item/clothing/under/rank/civilian/chaplain/divine_archer/noble
	ckeywhitelist = list("grasshand")

/datum/loadout_item/shoes/noble_boots
	name = "Noble Boots"
	item_path = /obj/item/clothing/shoes/jackboots/noble
	ckeywhitelist = list("grasshand")

/datum/loadout_item/suit/nobility_dresscoat
	name = "Nobility Dresscoat"
	item_path = /obj/item/clothing/suit/toggle/labcoat/vic_dresscoat_donator
	ckeywhitelist = list("nikotheguydude")

/datum/loadout_item/suit/anubite_headpiece
	name = "Anubite Headpiece"
	item_path = /obj/item/clothing/head/anubite
	ckeywhitelist = list("vexcint")

/datum/loadout_item/under/formal/dragon_maid
	name = "Dragon Maid Uniform"
	item_path = /obj/item/clothing/under/costume/dragon_maid
	ckeywhitelist = list("sigmaralkahest")

/datum/loadout_item/head/catear_headphone
	name = "Cat-Ear Headphones"
	item_path = /obj/item/instrument/piano_synth/headphones/catear_headphone
	ckeywhitelist = list("dtfe")

/datum/loadout_item/neck/trenchcoat
	name = "Secure Trenchcoat"
	item_path = /obj/item/clothing/neck/trenchcoat
	ckeywhitelist = list("Smol42")

/datum/loadout_item/under/jumpsuit/old_qm_jumpskirt
	name = "Old Quartermaster's Jumpskirt"
	item_path = /obj/item/clothing/under/rank/cargo/qm/skirt/old
	ckeywhitelist = list("jasohavents")

/datum/loadout_item/pocket_items/toaster_implant
	name = "Toaster Implant"
	item_path = /obj/item/implanter/toaster
	ckeywhitelist = list("jasohavents")

/datum/loadout_item/under/miscellaneous/rem
	name = "M.I.A. Limiter"
	item_path = /obj/item/clothing/under/rem
	ckeywhitelist = list("ignari")

/datum/loadout_item/shoes/rem
	name = "M.I.A. Heels"
	item_path = /obj/item/clothing/shoes/rem_shoes
	ckeywhitelist = list("ignari")

/datum/loadout_item/under/miscellaneous/bwake
	name = "Compression Bodysuit"
	item_path = /obj/item/clothing/under/bwake
	ckeywhitelist = list("ignari")

/datum/loadout_item/inhand/pet/mrfluff_mothroach
	name = "Mr. Fluff"
	item_path = /obj/item/clothing/head/mob_holder/pet/donator/centralsmith
	ckeywhitelist = list("centralsmith")

/datum/loadout_item/under/jumpsuit/techpants
    name = "Techwear Pants"
    item_path = /obj/item/clothing/under/techpants
    ckeywhitelist = list("alvcyktor", "snakebittenn")

/datum/loadout_item/inhand/drop_pouch
    name = "Drop Pouch"
    item_path = /obj/item/storage/backpack/satchel/drop_pouch
    ckeywhitelist = list("alvcyktor", "snakebittenn")

/datum/loadout_item/inhand/melonseva
	name = "Sundowner SEVA"
	item_path = /obj/item/clothing/suit/hooded/seva/melon
	ckeywhitelist = list("deadmonwonderland")
	restricted_roles = list(JOB_SHAFT_MINER)


/datum/loadout_item/suit/desminus
	name = "Jómsvíking Coat"
	item_path = /obj/item/clothing/suit/toggle/desminus
	ckeywhitelist = list("desminus", "junglerat", "deadmonwonderland")

/datum/loadout_item/suit/desminus2
	name = "Elderwood Garment"
	item_path = /obj/item/clothing/suit/toggle/desminus2
	ckeywhitelist = list("desminus", "junglerat", "deadmonwonderland")

/datum/loadout_item/pocket_items/akarimod
	name = "Akari's MOD Refitter"
	item_path = /obj/item/mod/skin_applier/akari
	ckeywhitelist = list("samman166", "cainedclxvi")

/datum/loadout_item/pocket_items/mrsanderp_cookbook
	name = "Riva Family Cookbook"
	item_path = /obj/item/book/granter/crafting_recipe/mrsanderp_donator_cookbook
	ckeywhitelist = list("mrsanderp")

/datum/loadout_item/under/jumpsuit/half_leotard
	name = "One-Sleeved Leotard"
	item_path = /obj/item/clothing/under/pants/half_leotard_cosmiclaer
	ckeywhitelist = list("cosmiclaer")

/datum/loadout_item/under/jumpsuit/shendyt
	name = "Shendyt"
	item_path = /obj/item/clothing/under/costume/shendyt
	ckeywhitelist = list("hyperhazel")

/datum/loadout_item/pocket_items/jumperbox
	name = "Jumper Conversation Kit Box"
	item_path = /obj/item/mod/skin_applier/jumper
	ckeywhitelist = list("bonkaitheroris")
>>>>>>> c1aaf0dc507 (Adds donator item for BonkaiTheRoris (#4471))

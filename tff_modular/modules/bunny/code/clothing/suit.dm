/obj/item/clothing/suit/jacket/tailcoat //parent type
	name = "tailcoat"
	desc = "A coat usually worn by bunny themed waiters and the like."
	worn_icon = 'tff_modular/modules/bunny/icons/mob/suit.dmi'
	worn_icon_digi = 'tff_modular/modules/bunny/icons/mob/suit_digi.dmi'
	icon = 'tff_modular/modules/bunny/icons/obj/suit.dmi'
	icon_state = "tailcoat"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/suit/wizrobe/magician //Not really a robe but it's MAGIC
	name = "magician's tailcoat"
	desc = "A magnificent, gold-lined tailcoat that seems to radiate power."
	worn_icon = 'tff_modular/modules/bunny/icons/mob/suit.dmi'
	worn_icon_digi = 'tff_modular/modules/bunny/icons/mob/suit_digi.dmi'
	icon = 'tff_modular/modules/bunny/icons/obj/suit.dmi'
	icon_state = "tailcoat_wiz"
	inhand_icon_state = null
	flags_inv = null


//CAPTAIN

/obj/item/clothing/suit/armor/vest/capcarapace/tailcoat_captain
	name = "captain's tailcoat"
	desc = "A nautical coat usually worn by bunny themed captains. It’s reinforced with genetically modified armored blue rabbit fluff."
	icon_state = "captain"
	inhand_icon_state = null
	worn_icon = 'tff_modular/modules/bunny/icons/mob/suit.dmi'
	icon = 'tff_modular/modules/bunny/icons/obj/suit.dmi'
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS
	dog_fashion = null

//CARGO

/obj/item/clothing/suit/jacket/tailcoat/quartermaster
	name = "quartermaster's tailcoat"
	desc = "A fancy brown coat worn by bunny themed quartermasters. The gold accents show everyone who's in charge."
	icon_state = "qm"

/obj/item/clothing/suit/jacket/tailcoat/cargo
	name = "cargo tailcoat"
	desc = "A simple brown coat worn by bunny themed cargo technicians. Significantly less stripy than the quartermasters."
	icon_state = "cargo_tech"

/obj/item/clothing/suit/jacket/tailcoat/miner
	name = "explorer tailcoat"
	desc = "An adapted explorer suit worn by bunny themed shaft miners. It has attachment points for goliath plates but comparatively little armor."
	icon_state = "explorer"
	cold_protection = CHEST|GROIN|ARMS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	heat_protection = CHEST|GROIN|ARMS
	max_heat_protection_temperature = SPACE_SUIT_MAX_TEMP_PROTECT
	armor_type = /datum/armor/hooded_explorer
	allowed = list(
		/obj/item/flashlight,
		/obj/item/gun/energy/recharge/kinetic_accelerator,
		/obj/item/mining_scanner,
		/obj/item/pickaxe,
		/obj/item/resonator,
		/obj/item/storage/bag/ore,
		/obj/item/t_scanner/adv_mining_scanner,
		/obj/item/tank/internals,
		)
	resistance_flags = FIRE_PROOF
	clothing_traits = list(TRAIT_SNOWSTORM_IMMUNE)

/obj/item/clothing/suit/jacket/tailcoat/miner/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/armor_plate)


/obj/item/clothing/suit/jacket/tailcoat/bitrunner
	name = "bitrunner tailcoat"
	desc = "A black and gold coat worn by bunny themed cargo technicians. Open your Space Colas and let's fuckin' game!"
	icon_state = "bitrunner"

//ENGI

/obj/item/clothing/suit/jacket/tailcoat/engineer
	name = "engineering tailcoat"
	desc = "A high visibility tailcoat worn by bunny themed engineers. Great for working in low-light conditions."
	icon_state = "engi"
	allowed = list(
		/obj/item/fireaxe/metal_h2_axe,
		/obj/item/flashlight,
		/obj/item/radio,
		/obj/item/storage/bag/construction,
		/obj/item/tank/internals/emergency_oxygen,
		/obj/item/tank/internals/plasmaman,
		/obj/item/t_scanner,
		/obj/item/gun/ballistic/rifle/boltaction/pipegun/prime,
	)

/obj/item/clothing/suit/jacket/tailcoat/engineer/worn_overlays(mutable_appearance/standing, isinhands, icon_file)
	. = ..()
	if(!isinhands)
		. += emissive_appearance(icon_file, "[icon_state]-emissive", src, alpha = src.alpha)

/obj/item/clothing/suit/utility/fire/atmos_tech_tailcoat
	name = "atmospheric technician's tailcoat"
	desc = "A heavy duty fire-tailcoat worn by bunny themed atmospheric technicians. Reinforced with asbestos weave that makes this both stylish and lung-cancer inducing."
	icon_state = "atmos"
	worn_icon = 'tff_modular/modules/bunny/icons/mob/suit.dmi'
	icon = 'tff_modular/modules/bunny/icons/obj/suit.dmi'
	w_class = WEIGHT_CLASS_NORMAL
	body_parts_covered = CHEST|GROIN|ARMS
	slowdown = 1
	armor_type = /datum/armor/atmos_tech_tailcoat
	flags_inv = null
	clothing_flags = null
	min_cold_protection_temperature = null
	max_heat_protection_temperature = null
	strip_delay = 30
	equip_delay_other = 30

/datum/armor/atmos_tech_tailcoat
	melee = 10
	bullet = 5
	laser = 10
	energy = 10
	bomb = 20
	bio = 50
	fire = 100
	acid = 50

/obj/item/clothing/suit/utility/fire/ce_tailcoat
	name = "chief engineer's tailcoat"
	desc = "A heavy duty green and white coat worn by bunny themed chief engineers. Made of a three layered composite fabric that is both insulating and fireproof, it also has an open face rendering all this useless."
	icon_state = "ce"
	worn_icon = 'tff_modular/modules/bunny/icons/mob/suit.dmi'
	icon = 'tff_modular/modules/bunny/icons/obj/suit.dmi'
	w_class = WEIGHT_CLASS_NORMAL
	body_parts_covered = CHEST|GROIN|ARMS
	slowdown = 1
	armor_type = /datum/armor/ce_tailcoat
	flags_inv = null
	clothing_flags = null
	min_cold_protection_temperature = null
	max_heat_protection_temperature = null
	strip_delay = 30
	equip_delay_other = 30

/datum/armor/ce_tailcoat
	melee = 10
	bullet = 5
	laser = 10
	energy = 10
	bomb = 20
	bio = 50
	fire = 100
	acid = 50

//MEDICAL

/obj/item/clothing/suit/toggle/labcoat/doctor_tailcoat
	name = "medical tailcoat"
	desc = "A sterile white and blue coat worn by bunny themed doctors. Great for keeping the blood off."
	icon_state = "doctor"
	worn_icon = 'tff_modular/modules/bunny/icons/mob/suit.dmi'
	icon = 'tff_modular/modules/bunny/icons/obj/suit.dmi'

/obj/item/clothing/suit/toggle/labcoat/doctor_tailcoat/paramedic
	name = "paramedic's tailcoat"
	desc = "A heavy duty coat worn by bunny themed paramedics. Marked with high visibility lines for emergency operations in the dark."
	icon_state = "paramedic"

/obj/item/clothing/suit/toggle/labcoat/doctor_tailcoat/chemist
	name = "chemist's tailcoat"
	desc = "A sterile white and orange coat worn by bunny themed chemists. The open chest isn't the greatest when working with dangerous substances."
	icon_state = "chem"

/obj/item/clothing/suit/toggle/labcoat/doctor_tailcoat/pathologist
	name = "pathologist's tailcoat"
	desc = "A sterile white and green coat worn by bunny themed pathologists. The more stylish and ineffective alternative to a biosuit."
	icon_state = "virologist"

/obj/item/clothing/suit/toggle/labcoat/doctor_tailcoat/coroner
	name = "pathologist's tailcoat"
	desc = "A sterile black and white coat worn by bunny themed coroners. Adorned with a skull on the back."
	icon_state = "coroner"

/obj/item/clothing/suit/toggle/labcoat/doctor_tailcoat/cmo
	name = "chief medical officer's tailcoat"
	desc = "A sterile blue coat worn by bunny themed chief medical officers. The blue helps both the wearer and bloodstains stand out from other, lower ranked, and cleaner doctors."
	icon_state = "cmo"

//SCIENCE

/obj/item/clothing/suit/toggle/labcoat/doctor_tailcoat/science
	name = "scientist's tailcoat"
	desc = "A smart white coat worn by bunny themed scientists. Decent protection against slimes."
	icon_state = "science"

/obj/item/clothing/suit/toggle/labcoat/doctor_tailcoat/science/robotics
	name = "roboticist's tailcoat"
	desc = "A smart white coat with red pauldrons worn by bunny themed roboticists. Looks surprisingly good with oil stains on it."
	icon_state = "roboticist"


/obj/item/clothing/suit/toggle/labcoat/doctor_tailcoat/science/genetics
	name = "geneticist's tailcoat"
	desc = "A smart white and blue coat worn by bunny themed geneticists. Nearly looks like a real doctor's lab coat."
	icon_state = "genetics"

/obj/item/clothing/suit/jacket/research_director/tailcoat
	name = "research director's tailcoat"
	desc = "A smart purple coat worn by bunny themed head researchers. Created from captured abductor technology, what looks like a coat is actually an advanced hologram emitted from the pauldrons. Feels exactly like the real thing, too."
	icon_state = "rd"
	worn_icon = 'tff_modular/modules/bunny/icons/mob/suit.dmi'
	icon = 'tff_modular/modules/bunny/icons/obj/suit.dmi'
	body_parts_covered = CHEST|ARMS|GROIN

//SECURITY

/obj/item/clothing/suit/armor/security_tailcoat
	name = "security tailcoat"
	desc = "A reinforced tailcoat worn by bunny themed security officers. Uses the same lightweight armor as the MK 1 vest, though obviously has lighter protection in the chest area."
	icon_state = "sec"
	inhand_icon_state = "armor"
	worn_icon = 'tff_modular/modules/bunny/icons/mob/suit.dmi'
	icon = 'tff_modular/modules/bunny/icons/obj/suit.dmi'
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS
	dog_fashion = null
	armor_type = /datum/armor/suit_armor

/obj/item/clothing/suit/armor/security_tailcoat/assistant
	name = "security assistant's tailcoat"
	desc = "A reinforced tailcoat worn by bunny themed security assistants. The duller color scheme denotes a lower rank on the chain of bunny command."
	icon_state = "sec_assistant"

/obj/item/clothing/suit/armor/security_tailcoat/warden
	name = "warden's tailcoat"
	desc = "A reinforced tailcoat worn by bunny themed wardens. Stylishly holds hidden flak plates."
	icon_state = "warden"

/obj/item/clothing/suit/toggle/labcoat/doctor_tailcoat/sec
	name = "brig physician's tailcoat"
	desc = "A mostly sterile red and grey coat worn by bunny themed brig physicians. It lacks the padding of the \"standard\" security tailcoat."
	icon_state = "brig_phys"

/obj/item/clothing/suit/jacket/det_suit/tailcoat
	name = "detective's tailcoat"
	desc = "A reinforced tailcoat worn by bunny themed detectives. Perfect for a hard boiled no-nonsense type of gal."
	icon_state = "detective"
	worn_icon = 'tff_modular/modules/bunny/icons/mob/suit.dmi'
	icon = 'tff_modular/modules/bunny/icons/obj/suit.dmi'

/obj/item/clothing/suit/jacket/det_suit/tailcoat/noir
	name = "noir detective's tailcoat"
	desc = "A reinforced tailcoat worn by noir bunny themed detectives. Perfect for a hard boiled no-nonsense type of gal."
	icon_state = "detective_noir"

/obj/item/clothing/suit/armor/hos_tailcoat
	name = "head of security's tailcoat"
	desc = "A reinforced tailcoat worn by bunny themed security commanders. Enhanced with a special alloy for some extra protection and style."
	icon_state = "hos"
	inhand_icon_state = "armor"
	worn_icon = 'tff_modular/modules/bunny/icons/mob/suit.dmi'
	icon = 'tff_modular/modules/bunny/icons/obj/suit.dmi'
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS
	dog_fashion = null
	armor_type = /datum/armor/armor_hos
	strip_delay = 80
//SERVICE

/obj/item/clothing/suit/armor/hop_tailcoat
	name = "head of personnel's tailcoat"
	desc = "A strict looking coat usually worn by bunny themed bureaucrats. The pauldrons are sure to make people finally take you seriously."
	icon_state = "hop"
	inhand_icon_state = "armor"
	worn_icon = 'tff_modular/modules/bunny/icons/mob/suit.dmi'
	icon = 'tff_modular/modules/bunny/icons/obj/suit.dmi'
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS
	dog_fashion = null

/obj/item/clothing/suit/jacket/tailcoat/janitor
	name = "janitor's tailcoat"
	desc = "A clean looking coat usually worn by bunny themed janitors. The purple sleeves are a late 24th century style."
	icon_state = "janitor"

/obj/item/clothing/suit/jacket/tailcoat/cook
	name = "cook's tailcoat"
	desc = "A professional white coat worn by bunny themed chefs. The red accents pair nicely with the monkey blood that often stains this."
	icon_state = "chef"
	allowed = list(
		/obj/item/kitchen,
		/obj/item/knife/kitchen,
		/obj/item/storage/bag/tray,
	)

/obj/item/clothing/suit/jacket/tailcoat/botanist
	name = "botanist's tailcoat"
	desc = "A green leather coat worn by bunny themed botanists. Great for keeping the sun off your back."
	icon_state = "botany"
	allowed = list(
		/obj/item/cultivator,
		/obj/item/geneshears,
		/obj/item/graft,
		/obj/item/hatchet,
		/obj/item/plant_analyzer,
		/obj/item/reagent_containers/cup/beaker,
		/obj/item/reagent_containers/cup/bottle,
		/obj/item/reagent_containers/spray/pestspray,
		/obj/item/reagent_containers/spray/plantbgone,
		/obj/item/secateurs,
		/obj/item/seeds,
		/obj/item/storage/bag/plants,
	)

/obj/item/clothing/suit/jacket/tailcoat/clown
	name = "clown's tailcoat"
	desc = "An orange polkadot coat worn by bunny themed clowns. Shows everyone who the real ringmaster is."
	icon_state = "clown"

/obj/item/clothing/suit/jacket/tailcoat/mime
	name = "mime's tailcoat"
	desc = "A stripy sleeved black coat worn by bunny themed mimes. The red accents mimic the suspenders seen in more standard mime outfits."
	icon_state = "mime"

/obj/item/clothing/suit/jacket/tailcoat/chaplain
	name = "chaplain's tailcoat"
	desc = "A gilded black coat worn by bunny themed chaplains. Traditional vestments of the lagomorphic cults of Cairead."
	icon_state = "chaplain"
	allowed = list(
		/obj/item/nullrod,
		/obj/item/reagent_containers/cup/glass/bottle/holywater,
		/obj/item/storage/fancy/candle_box,
		/obj/item/flashlight/flare/candle,
		/obj/item/tank/internals/emergency_oxygen,
		/obj/item/tank/internals/plasmaman
	)

/obj/item/clothing/suit/jacket/tailcoat/curator_red
	name = "curator's red tailcoat"
	desc = "A red linen coat worn by bunny themed librarians. Keeps the dust off your shoulders during long shifts in the archives."
	icon_state = "curator_red"

/obj/item/clothing/suit/jacket/tailcoat/curator_green
	name = "curator's green tailcoat"
	desc = "A green linen coat worn by bunny themed librarians. Keeps the dust off your shoulders during long shifts in the archives."
	icon_state = "curator_green"

/obj/item/clothing/suit/jacket/tailcoat/curator_teal
	name = "curator's teal tailcoat"
	desc = "A teal linen coat worn by bunny themed librarians. Keeps the dust off your shoulders during long shifts in the archives."
	icon_state = "curator_teal"

/obj/item/clothing/suit/jacket/tailcoat/lawyer_black
	name = "lawyer's black tailcoat"
	desc = "The staple of any bunny themed lawyers. EXTREMELY professional."
	icon_state = "lawyer_black"

/obj/item/clothing/suit/jacket/tailcoat/lawyer_blue
	name = "lawyer's blue tailcoat"
	desc = "A blue linen coat worn by bunny themed lawyers. May or may not contain souls of the damned in suit pockets."
	icon_state = "lawyer_blue"

/obj/item/clothing/suit/jacket/tailcoat/lawyer_red
	name = "lawyer's red tailcoat"
	desc = "A red linen coat worn by bunny themed lawyers. May or may not contain souls of the damned in suit pockets."
	icon_state = "lawyer_red"

/obj/item/clothing/suit/jacket/tailcoat/lawyer_good
	name = "good lawyer's tailcoat"
	desc = "A beige linen coat worn by bunny themed lawyers. May or may not contain souls of the damned in suit pockets."
	icon_state = "lawyer_good"

/obj/item/clothing/suit/jacket/tailcoat/psychologist
	name = "psychologist's tailcoat"
	desc = "A black linen coat worn by bunny themed psychologists. A casual open coat for making you seem approachable, maybe too casual."
	icon_state = "psychologist"

/obj/item/clothing/suit/armor/security_tailcoat/centcom
	name = "centcom tailcoat"
	desc = "A reinforced tailcoat worn by bunny themed centcom officers."
	icon_state = "tailcoat_centcom"

/obj/item/clothing/suit/armor/security_tailcoat/syndi
	name = "syndie's tailcoat"
	desc = "A reinforced tailcoat worn by illegal bunnies. Stylishly holds hidden flak plates."
	icon_state = "tailcoat_syndi"

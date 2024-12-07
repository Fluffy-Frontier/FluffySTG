/obj/item/clothing/neck/bunny
	var/tie_type = "tie_greyscale"
	var/tie_timer = 8 SECONDS
	worn_icon = 'tff_modular/modules/bunny/icons/mob/neck.dmi'
	icon = 'tff_modular/modules/bunny/icons/obj/neck.dmi'

/obj/item/clothing/neck/bunny/bunnytie
	name = "bowtie collar"
	desc = "A fancy tie that includes a collar. Looking snazzy!"
	worn_icon = 'tff_modular/modules/bunny/icons/mob/neck.dmi'
	icon = 'tff_modular/modules/bunny/icons/obj/neck.dmi'
	icon_state = "bowtie_collar_base_tied"
	tie_type = "bowtie_collar"
	flags_1 = IS_PLAYER_COLORABLE_1
	alternate_worn_layer = UNDER_SUIT_LAYER

/obj/item/clothing/neck/bunny/bunnytie/syndicate
	name = "blood-red bowtie collar"
	desc = "A fancy tie that includes a red collar. Looking sinister..."
	icon_state = "bowtie_collar_syndi_tied"
	tie_type = "bowtie_collar_syndi"
	armor_type = /datum/armor/large_scarf_syndie
	tie_timer = 2 SECONDS //Tactical tie

/obj/item/clothing/neck/bunny/bunnytie/magician
	name = "magician's bowtie collar"
	desc = "A fancy gold tie that includes a collar. Looking magical!"
	icon_state = "bowtie_collar_wiz_tied"
	custom_price = null
	tie_type = "bowtie_collar_wiz"

/obj/item/clothing/neck/bunny/bunnytie/centcom
	name = "centcom bowtie collar"
	desc = "A fancy gold tie that includes a collar. Looking in charge!"
	icon_state = "bowtie_collar_centcom_tied"
	tie_type = "bowtie_collar_centcom"

/obj/item/clothing/neck/bunny/bunnytie/communist
	name = "really red bowtie collar"
	desc = "A simple red tie that includes a collar. Looking egalitarian!"
	icon_state = "bowtie_collar_communist_tied"
	tie_type = "bowtie_collar_communist"

/obj/item/clothing/neck/bunny/bunnytie/blue
	name = "blue bowtie collar"
	desc = "A simple blue tie that includes a collar. Looking imperialist!"
	icon_state = "bowtie_collar_blue_tied"
	tie_type = "bowtie_collar_blue"

//CAPTAIN

/obj/item/clothing/neck/bunny/bunnytie/captain
	name = "captain's bowtie"
	desc = "A blue tie that includes a collar. Looking commanding!"
	icon_state = "bowtie_collar_captain_tied"
	flags_1 = null
	tie_type = "bowtie_collar_captain"

//CARGO

/obj/item/clothing/neck/bunny/bunnytie/cargo
	name = "cargo bowtie"
	desc = "A brown tie that includes a collar. Looking unionized!"
	icon_state = "bowtie_collar_cargo_tied"
	flags_1 = null
	tie_type = "bowtie_collar_cargo"

/obj/item/clothing/neck/bunny/bunnytie/miner
	name = "shaft miner's bowtie"
	desc = "A purple tie that includes a collar. Looking hardy!"
	icon_state = "bowtie_collar_explorer_tied"
	flags_1 = null
	tie_type = "bowtie_collar_explorer"

/obj/item/clothing/neck/bunny/bunnytie/mailman
	name = "mailman's bowtie"
	desc = "A red tie that includes a collar. Looking unstoppable!"
	icon_state = "bowtie_collar_mail_tied"
	flags_1 = null
	tie_type = "bowtie_collar_mail"

/obj/item/clothing/neck/bunny/bunnytie/bitrunner
	name = "bitrunner's bowtie"
	desc = "Bitrunners were told that wearing a novelty shirt with a printed bow tie wasn't enough for formal events."
	icon_state = "bowtie_collar_bitrunner_tied"
	flags_1 = null
	tie_type = "bowtie_collar_bitrunner"

//ENGI

/obj/item/clothing/neck/bunny/bunnytie/engineer
	name = "engineering bowtie"
	desc = "An orange tie that includes a collar. Looking industrious!"
	icon_state = "bowtie_collar_engi_tied"
	flags_1 = null
	tie_type = "bowtie_collar_engi"

/obj/item/clothing/neck/bunny/bunnytie/atmos_tech
	name = "atmospheric technician's bowtie"
	desc = "A blue tie that includes a collar. Looking inflammable!"
	icon_state = "bowtie_collar_atmos_tied"
	flags_1 = null
	tie_type = "bowtie_collar_atmos"

/obj/item/clothing/neck/bunny/bunnytie/ce
	name = "chief engineer's bowtie"
	desc = "A green tie that includes a collar. Looking managerial!"
	icon_state = "bowtie_collar_ce_tied"
	flags_1 = null
	tie_type = "bowtie_collar_ce"

//MEDICAL

/obj/item/clothing/neck/bunny/bunnytie/doctor
	name = "medical bowtie"
	desc = "A light blue tie that includes a collar. Looking helpful!"
	icon_state = "bowtie_collar_doctor_tied"
	flags_1 = null
	tie_type = "bowtie_collar_doctor"

/obj/item/clothing/neck/bunny/bunnytie/paramedic
	name = "paramedic's bowtie"
	desc = "A white tie that includes a collar. Looking selfless!"
	icon_state = "bowtie_collar_paramedic_tied"
	flags_1 = null
	tie_type = "bowtie_collar_paramedic"

/obj/item/clothing/neck/bunny/bunnytie/chemist
	name = "chemist's bowtie"
	desc = "An orange tie that includes a collar. Looking explosive!"
	icon_state = "bowtie_collar_chem_tied"
	flags_1 = null
	tie_type = "bowtie_collar_chem"

/obj/item/clothing/neck/bunny/bunnytie/pathologist
	name = "pathologist's bowtie"
	desc = "A green tie that includes a collar. Looking infectious!"
	icon_state = "bowtie_collar_virologist_tied"
	flags_1 = null
	tie_type = "bowtie_collar_virologist"

/obj/item/clothing/neck/bunny/bunnytie/coroner
	name = "coroner's bowtie"
	desc = "A black tie that includes a collar. Looking dead...Dead good!"
	icon_state = "bowtie_collar_virologist_tied"
	flags_1 = null
	tie_type = "bowtie_collar_virologist"

/obj/item/clothing/neck/bunny/bunnytie/cmo
	name = "chief medical officer's bowtie"
	desc = "A blue tie that includes a collar. Looking responsible!"
	icon_state = "bowtie_collar_cmo_tied"
	flags_1 = null
	tie_type = "bowtie_collar_cmo"

//SCIENCE

/obj/item/clothing/neck/bunny/bunnytie/scientist
	name = "scientist's bowtie"
	desc = "A purple tie that includes a collar. Looking intelligent!"
	icon_state = "bowtie_collar_science_tied"
	flags_1 = null
	tie_type = "bowtie_collar_science"

/obj/item/clothing/neck/bunny/bunnytie/roboticist
	name = "roboticist's bowtie"
	desc = "A red tie that includes a collar. Looking transhumanist!"
	icon_state = "bowtie_collar_roboticist_tied"
	flags_1 = null
	tie_type = "bowtie_collar_roboticist"

/obj/item/clothing/neck/bunny/bunnytie/geneticist
	name = "geneticist's bowtie"
	desc = "A blue tie that includes a collar. Looking aberrant!"
	icon_state = "bowtie_collar_genetics_tied"
	flags_1 = null
	tie_type = "bowtie_collar_genetics"

/obj/item/clothing/neck/bunny/bunnytie/rd
	name = "research director's bowtie"
	desc = "A purple tie that includes a collar. Looking inventive!"
	icon_state = "bowtie_collar_science_tied"
	flags_1 = null
	tie_type = "bowtie_collar_science"

//SECURITY

/obj/item/clothing/neck/bunny/bunnytie/security
	name = "security bowtie"
	desc = "A red tie that includes a collar. Looking tough!"
	icon_state = "bowtie_collar_sec_tied"
	flags_1 = null
	tie_type = "bowtie_collar_sec"

/obj/item/clothing/neck/bunny/bunnytie/security_assistant
	name = "security assistant's bowtie"
	desc = "A grey tie that includes a collar. Looking \"helpful\"."
	icon_state = "bowtie_collar_sec_assistant_tied"
	flags_1 = null
	tie_type = "bowtie_collar_sec_assistant"

/obj/item/clothing/neck/bunny/bunnytie/brig_phys
	name = "brig physician's bowtie"
	desc = "A red tie that includes a collar. Looking underappreciated!"
	icon_state = "bowtie_collar_brig_phys_tied"
	flags_1 = null
	tie_type = "bowtie_collar_brig_phys"

/obj/item/clothing/neck/bunny/bunnytie/detective
	name = "detective's tie collar"
	desc = "A brown tie that includes a collar. Looking inquisitive!"
	icon_state = "tie_collar_det_tied"
	flags_1 = null
	tie_type = "tie_collar_det"

/obj/item/clothing/neck/bunny/bunnytie/prisoner
	name = "prisoner's bowtie"
	desc = "A black tie that includes a collar. Looking criminal!"
	icon_state = "bowtie_collar_prisoner_tied"
	flags_1 = null
	tie_type = "bowtie_collar_prisoner"

//SERVICE

/obj/item/clothing/neck/bunny/bunnytie/hop
	name = "head of personnel's bowtie"
	desc = "A dull red tie that includes a collar. Looking bogged down."
	icon_state = "bowtie_collar_hop_tied"
	flags_1 = null
	tie_type = "bowtie_collar_hop"

/obj/item/clothing/neck/bunny/bunnytie/janitor
	name = "janitor's bowtie"
	desc = "A purple tie that includes a collar. Looking tidy!"
	icon_state = "bowtie_collar_janitor_tied"
	flags_1 = null
	tie_type = "bowtie_collar_janitor"

/obj/item/clothing/neck/bunny/bunnytie/bartender
	name = "bartender's bowtie"
	desc = "A black tie that includes a collar. Looking fancy!"
	flags_1 = null
	custom_price = PAYCHECK_CREW

/obj/item/clothing/neck/bunny/bunnytie/cook
	name = "cook's bowtie"
	desc = "A red tie that includes a collar. Looking culinary!"
	icon_state = "bowtie_collar_chef_tied"
	flags_1 = null
	tie_type = "bowtie_collar_chef"

/obj/item/clothing/neck/bunny/bunnytie/botanist
	name = "botanist's bowtie"
	desc = "A blue tie that includes a collar. Looking green-thumbed!"
	icon_state = "bowtie_collar_botany_tied"
	flags_1 = null
	tie_type = "bowtie_collar_botany"

/obj/item/clothing/neck/bunny/clown
	name = "clown's bowtie"
	desc = "An outrageously large blue bowtie. Looking funny!"
	worn_icon = 'tff_modular/modules/bunny/icons/mob/neck.dmi'
	icon = 'tff_modular/modules/bunny/icons/obj/neck.dmi'
	icon_state = "bowtie_clown_tied"
	flags_1 = null
	tie_timer = 8 SECONDS //It's a BIG bowtie
	tie_type = "bowtie_clown"

/obj/item/clothing/neck/bunny_pendant
	name = "bunny pendant"
	desc = "A golden pendant depicting a holy rabbit."
	icon_state = "chaplain_pendant"
	worn_icon = 'tff_modular/modules/bunny/icons/mob/neck.dmi'
	icon = 'tff_modular/modules/bunny/icons/obj/neck.dmi'

/obj/item/clothing/neck/bunny/bunnytie/lawyer_black
	name = "lawyer's black tie collar"
	desc = "A black tie that includes a collar. Looking legal!"
	icon_state = "tie_collar_lawyer_black_tied"
	flags_1 = null
	tie_type = "tie_collar_lawyer_black"

/obj/item/clothing/neck/bunny/bunnytie/lawyer_blue
	name = "lawyer's blue tie collar"
	desc = "A blue tie that includes a collar. Looking defensive!"
	icon_state = "tie_collar_lawyer_blue_tied"
	flags_1 = null
	tie_type = "tie_collar_lawyer_blue"

/obj/item/clothing/neck/bunny/bunnytie/lawyer_red
	name = "lawyer's red tie collar"
	desc = "A red tie that includes a collar. Looking prosecutive!"
	icon_state = "tie_collar_lawyer_red_tied"
	flags_1 = null
	tie_type = "tie_collar_lawyer_red"

/obj/item/clothing/neck/bunny/bunnytie/lawyer_good
	name = "good lawyer's tie collar"
	desc = "A black tie that includes a collar. Looking technically legal!"
	icon_state = "tie_collar_lawyer_good_tied"
	flags_1 = null
	tie_type = "tie_collar_lawyer_good"

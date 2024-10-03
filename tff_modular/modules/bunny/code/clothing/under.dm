/obj/item/clothing/under/costume/playbunny
	name = "bunny suit"
	desc = "The staple of any bunny themed waiters and the like. It has a little cottonball tail too."
	worn_icon = 'tff_modular/modules/bunny/icons/mob/under.dmi'
	icon = 'tff_modular/modules/bunny/icons/obj/under.dmi'
	worn_icon_digi = 'tff_modular/modules/bunny/icons/mob/under_digi.dmi'
	icon_state = "playbunny_base"
	flags_1 = IS_PLAYER_COLORABLE_1
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE


/obj/item/clothing/under/costume/playbunny/syndibunny //heh
	name = "blood-red bunny suit"
	desc = "The staple of any bunny themed syndicate assassins. Are those carbon nanotube stockings?"
	icon_state = "syndi"

/obj/item/clothing/under/costume/playbunny/magician
	name = "magician's bunny suit"
	desc = "The staple of any bunny themed stage magician."
	icon_state = "wiz"

/obj/item/clothing/under/costume/playbunny/magician/Initialize(mapload)
	. = ..()
	create_storage(storage_type = /datum/storage/pockets/tiny/magician)

/datum/storage/pockets/tiny/magician/New() //this is probably a good idea
	. = ..()
	var/static/list/exception_cache = typecacheof(list(
		/obj/item/gun/magic/wand,
		/obj/item/warp_whistle,
	))
	exception_hold = exception_cache

/obj/item/clothing/under/costume/playbunny/centcom
	name = "centcom bunnysuit"
	desc = "A modified Centcom version of a bunny outfit, using Lunarian technology to condense countless amounts of rabbits into a material that is extremely comfortable and light to wear."
	icon_state = "centcom"

/obj/item/clothing/under/costume/playbunny/british
	name = "british bunny suit"
	desc = "The staple of any bunny themed monarchists. It has a little cottonball tail too."
	icon_state = "brit"

/obj/item/clothing/under/costume/playbunny/communist
	name = "really red bunny suit"
	desc = "The staple of any bunny themed communists. It has a little cottonball tail too."
	icon_state = "communist"

/obj/item/clothing/under/costume/playbunny/usa
	name = "striped bunny suit"
	desc = "A bunny outfit stitched together from several American flags. It has a little cottonball tail too."
	icon_state = "usa"

//CAPTAIN

/obj/item/clothing/under/costume/playbunny/captain
	desc = "The staple of any bunny themed captains. Great for securing the disk."
	name = "captain's bunnysuit"
	icon_state = "captain"
	inhand_icon_state = null

//CARGO

/obj/item/clothing/under/costume/playbunny/qm
	name = "quartermaster's bunny suit"
	desc = "The staple of any bunny themed quartermasters. Complete with gold buttons and a nametag."
	icon_state = "qm"
	inhand_icon_state = null

/obj/item/clothing/under/costume/playbunny/cargo
	name = "cargo bunny suit"
	desc = "The staple of any bunny themed cargo technicians. Nigh indistinguishable from the quartermasters bunny suit."
	icon_state = "cargo"
	inhand_icon_state = null

/obj/item/clothing/under/costume/playbunny/miner
	name = "shaft miner's bunny suit"
	desc = "The staple of any bunny themed shaft miners. The perfect outfit for fighting demons on an ash choked hell planet."
	icon_state = "miner"
	inhand_icon_state = null

/obj/item/clothing/under/costume/playbunny/mailman
	name = "mailman's bunny suit"
	desc = "The staple of any bunny themed mailmen. A sleek mailman outfit for when you need to deliver mail as quickly and with as little wind resistance possible."
	icon_state = "mail"
	inhand_icon_state = null

/obj/item/clothing/under/costume/playbunny/bitrunner
	name = "bunrunner suit"
	desc = "The staple of any bunny themed gamer. Has enough space for one extra soda, if you're worthy."
	icon_state = "bitrunner"
	inhand_icon_state = null

//ENGI

/obj/item/clothing/under/costume/playbunny/engineer
	name = "engineering bunny suit"
	desc = "The staple of any bunny themed engineers. Keeps loose clothing to a minimum in a fashionable manner."
	icon_state = "engi"
	inhand_icon_state = null

/obj/item/clothing/under/costume/playbunny/atmos_tech
	name = "atmospheric technician's bunny suit"
	desc = "The staple of any bunny themed atmospheric technicians. Perfect for any blue collar worker wanting to keep up with fashion trends."
	icon_state = "atmos"
	inhand_icon_state = null

/obj/item/clothing/under/costume/playbunny/ce
	name = "chief engineer's bunny suit"
	desc = "The staple of any bunny themed chief engineers. The airy design helps with keeping cool when  engine fires get too hot to handle."
	icon_state = "ce"
	inhand_icon_state = null

//MEDICAL

/obj/item/clothing/under/costume/playbunny/doctor
	desc = "The staple of any bunny themed doctors. The open design is great for both comfort and surgery."
	name = "medical bunnysuit"
	icon_state = "doctor"

/obj/item/clothing/under/costume/playbunny/paramedic
	desc = "The staple of any bunny themed paramedics. Comes with spare pockets for medical supplies fastened to the leggings."
	name = "paramedic's bunnysuit"
	icon_state = "paramedic"

/obj/item/clothing/under/costume/playbunny/chemist
	desc = "The staple of any bunny themed chemists. The stockings are both airy and acid resistant."
	name = "chemist's bunnysuit"
	icon_state = "chem"

/obj/item/clothing/under/costume/playbunny/pathologist
	desc = "The staple of any bunny themed pathologists. The stockings, while cute, do nothing to combat pathogens."
	name = "pathologist's bunnysuit"
	icon_state = "viro"

/obj/item/clothing/under/costume/playbunny/coroner
	desc = "The staple of any bunny themed coroners. A rejected mime costume."
	name = "coroner's bunnysuit"
	icon_state = "coroner"

/obj/item/clothing/under/costume/playbunny/cmo
	desc = "The staple of any bunny themed chief medical officers. The more vibrant blue accents denote a higher status."
	name = "chief medical officer's bunnysuit"
	icon_state = "cmo"

//SCIENCE

/obj/item/clothing/under/costume/playbunny/scientist
	desc = "The staple of any bunny themed scientists. Smart bunnies, Hef."
	name = "scientist's bunnysuit"
	icon_state = "sci"

/obj/item/clothing/under/costume/playbunny/roboticist
	desc = "The staple of any bunny themed roboticists. The open design and thin leggings help to keep cool when piloting mechs."
	name = "roboticist's bunnysuit"
	icon_state = "roboticist"

/obj/item/clothing/under/costume/playbunny/geneticist
	desc = "The staple of any bunny themed geneticists. Doesn’t go great with an abominable green muscled physique, but then again, what does?"
	name = "geneticist's bunnysuit"
	icon_state = "genetics"

/obj/item/clothing/under/costume/playbunny/rd
	desc = "The staple of any bunny themed head researchers. Advanced technology allows this suit to stimulate spontaneous bunny tail growth when worn, though it's nigh-indistinguishable from the standard cottonball and disappears as soon as the suit is removed."
	name = "research director's bunnysuit"
	icon_state = "rd"
	can_adjust = TRUE
	alt_covers_chest = TRUE

//SECURITY

/obj/item/clothing/under/costume/playbunny/security
	desc = "The staple of any bunny themed security officers. The red coloring helps to hide any blood that may stain this."
	name = "security bunnysuit"
	icon_state = "sec"

/obj/item/clothing/under/costume/playbunny/security_assistant
	desc = "The staple of any bunny themed security assistants. Can't lost respect you don't have!"
	name = "security assistant's bunnysuit"
	icon_state = "sec_assistant"

/obj/item/clothing/under/costume/playbunny/warden
	desc = "The staple of any bunny themed wardens. The more formal security bunny suit for a less combat focused job."
	name = "warden's bunnysuit"
	icon_state = "warden"

/obj/item/clothing/under/costume/playbunny/brig_phys
	desc = "The staple of any bunny themed brig physicians. The rejected alternative to an already discontinued alternate uniform, now sold at a premium!"
	name = "brig physician's bunnysuit"
	icon_state = "brig_phys"

/obj/item/clothing/under/costume/playbunny/detective
	desc = "The staple of any bunny themed detectives. Capable of storing precious candy corns."
	name = "detective's bunnysuit"
	icon_state = "det"

/obj/item/clothing/under/costume/playbunny/detective/noir
	desc = "The staple of any noir bunny themed detectives. Capable of storing precious candy corns."
	name = "noir detective's bunnysuit"
	icon_state = "det_noir"

/obj/item/clothing/under/costume/playbunny/prisoner
	desc = "The staple of any bunny themed prisoners. Great for hiding shanks and other small contrabands."
	name = "prisoner's bunnysuit"
	icon_state = "prisoner"

/obj/item/clothing/under/costume/playbunny/hos
	desc = "The staple of any bunny themed security commanders. Includes kevlar weave stockings and a gilded tail."
	name = "Head of Security's bunnysuit"
	icon_state = "hos"

//SERVICE

/obj/item/clothing/under/costume/playbunny/hop
	name = "head of personnel's bunny suit"
	desc = "The staple of any bunny themed bureaucrats. It has a spare “pocket” for holding extra pens and paper."
	icon_state = "hop"
	inhand_icon_state = null

/obj/item/clothing/under/costume/playbunny/janitor
	name = "janitor's bunny suit"
	desc = "The staple of any bunny themed janitors. The stockings are made of cotton to allow for easy laundering."
	icon_state = "janitor"
	inhand_icon_state = null

/obj/item/clothing/under/costume/playbunny/bartender
	name = "bartender's bunnysuit"
	desc = "The staple of any bunny themed bartenders. Looks even more stylish than the standard bunny suit."
	icon_state = "bar"
	inhand_icon_state = null
	custom_price = PAYCHECK_CREW

/obj/item/clothing/under/costume/playbunny/cook
	name = "cook's bunny suit"
	desc = "The staple of any bunny themed chefs. Shame there aren't any fishnets."
	icon_state = "chef"
	inhand_icon_state = null

/obj/item/clothing/under/costume/playbunny/hydroponics
	name = "botanist's bunny suit"
	desc = "The staple of any bunny themed botanists. The stockings are made of faux-denim to mimic the look of overalls."
	icon_state = "botany"
	inhand_icon_state = null

/obj/item/clothing/under/costume/playbunny/clown
	name = "clown's bunny suit"
	desc = "The staple of any bunny themed clowns. Now this is just ridiculous."
	icon_state = "clown"
	inhand_icon_state = null

/obj/item/clothing/under/costume/playbunny/mime
	name = "mime's bunny suit"
	desc = "The staple of any bunny themed mimes. Includes black and white stockings in order to comply with mime federation outfit regulations."
	icon_state = "mime"
	inhand_icon_state = null

/obj/item/clothing/under/costume/playbunny/chaplain
	name = "chaplain's bunny suit"
	desc = "The staple of any bunny themed chaplains. The wool for the stockings came from a sacrificial lamb, making them extra holy."
	icon_state = "chaplain"
	inhand_icon_state = null

/obj/item/clothing/under/costume/playbunny/curator_red
	name = "curator's red bunny suit"
	desc = "The staple of any bunny themed librarians. A professional yet comfortable suit perfect for the aspiring bunny academic."
	icon_state = "curator_red"
	inhand_icon_state = null

/obj/item/clothing/under/costume/playbunny/curator_green
	name = "curator's green bunny suit"
	desc = "The staple of any bunny themed librarians. A professional yet comfortable suit perfect for the aspiring bunny academic."
	icon_state = "curator_green"
	inhand_icon_state = null

/obj/item/clothing/under/costume/playbunny/curator_teal
	name = "curator's teal bunny suit"
	desc = "The staple of any bunny themed librarians. A professional yet comfortable suit perfect for the aspiring bunny academic."
	icon_state = "curator_teal"
	inhand_icon_state = null

/obj/item/clothing/under/costume/playbunny/curator_black
	name = "lawyer's black bunny suit"
	desc = "A black linen coat worn by bunny themed lawyers. May or may not contain souls of the damned in suit pockets."
	icon_state = "law_black"
	inhand_icon_state = null

/obj/item/clothing/under/costume/playbunny/curator_blue
	name = "lawyer's blue bunny suit"
	desc = "The staple of any bunny themed lawyers. EXTREMELY professional."
	icon_state = "law_blue"
	inhand_icon_state = null

/obj/item/clothing/under/costume/playbunny/curator_red
	name = "lawyer's red bunny suit"
	desc = "The staple of any bunny themed lawyers. EXTREMELY professional."
	icon_state = "law_red"
	inhand_icon_state = null

/obj/item/clothing/under/costume/playbunny/lawyer_good
	name = "good lawyer's bunny suit"
	desc = "The staple of any bunny themed lawyers. EXTREMELY professional."
	icon_state = "law_good"
	inhand_icon_state = null

/obj/item/clothing/under/costume/playbunny/psychologist
	name = "psychologist's bunny suit"
	desc = "The staple of any bunny themed psychologists. Perhaps not the best choice for making your patients feel at home."
	icon_state = "psychologist"
	inhand_icon_state = null

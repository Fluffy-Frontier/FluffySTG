
//Gadgets that require batteries or fuel to function!
/obj/item/powered_gadget
	name = "gadget template"
	desc = "A template for a battery powered tool, the battery compartment is screwed shut in order to prevent people from eating the batteries."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/teguitems.dmi'
	icon_state = "gadget1"
	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_POCKETS
	w_class = WEIGHT_CLASS_SMALL
	force = 5

	//Trapspawner
/obj/item/powered_gadget/slowingtrapmk1
	name = "Qliphoth Field Projector"
	desc = "This device places traps that reduces the mobility of Abnormalities for a limited time when used in hand. The Movement Speed of an Abnormality will be reduced via overloading the Qliphoth control"
	icon_state = "gadget1"

/obj/structure/slowingmk1
	name = "qliphoth overloader mk1"//very placeholder name
	desc = "A device that delivers a burst of energy designed to overload the Qliphoth Control of abnormalities."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/teguitems.dmi'
	icon_state = "oddity2"
	anchored = TRUE

/obj/item/powered_gadget/teleporter
	name = "W-Corp instant transmission device"
	desc = "A battery powered tool that can be used to jump between departments."
	icon_state = "teleporter"

//The taser
/obj/item/powered_gadget/handheld_taser
	name = "Handheld Taser"
	desc = "A portable electricution device. Two settings, stun and slow. Automatically slows abnormalities instead of stunning them."
	icon_state = "taser"

	//Vitals Projector
/obj/item/powered_gadget/vitals_projector
	name = "vitals projector"
	desc = "Point this device at a enemy and use it to project the current vitals of its target. A wrench can change its target type."
	icon_state = "gadgetmod"
	force = 0

//Injector
/obj/item/powered_gadget/enkephalin_injector
	name = "Prototype Enkephalin Injector"
	desc = "A tool designed to inject raw enkephalin from our batteries to pacify hostile lifeforms. \
			However, the development was discontinued after the safety department abused it for... other purposes. \
			This version only makes the entities even more hostile towards you."
	icon_state = "e_injector"

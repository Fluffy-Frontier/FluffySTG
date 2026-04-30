//Dyne
/obj/vehicle/ridden/atv/rsx8i
	name = "RSX-8 Interdyne Medical Emergency ATV"
	desc = "An all-terrain vehicle built for traversing rough terrain with ease. One of the few old-Earth technologies that are still relevant on most planet-bound outposts. Woop-Woop"
	icon_state = "ematv"
	icon = 'tff_modular/modules/rsx_atv/icons/vechicle.dmi'
	var/static/mutable_appearance/ematvcover
	var/static/mutable_appearance/lightblue
	var/static/mutable_appearance/emis

/obj/vehicle/ridden/atv/rsx8i/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/ridable, /datum/component/riding/vehicle/atv)
	if(!ematvcover)
		ematvcover = mutable_appearance(icon, "ematvcover", MOB_LAYER + 0.1)
	if(!lightblue)
		lightblue = mutable_appearance(icon, "lightblue", MOB_LAYER + 0.1)
	if(!emis)
		emis = mutable_appearance(icon, "emis", MOB_LAYER + 0.1)
		emis = emissive_appearance(icon, "emis", src, alpha = src.alpha)

/obj/vehicle/ridden/atv/rsx8i/post_buckle_mob(mob/living/M)
	add_overlay(ematvcover)
	add_overlay(lightblue)
	add_overlay(emis)
	return ..()

/obj/vehicle/ridden/atv/rsx8i/post_unbuckle_mob(mob/living/M)
	if(!has_buckled_mobs())
		cut_overlay(ematvcover)
		cut_overlay(lightblue)
		cut_overlay(emis)
	return ..()

//paramed
/obj/vehicle/ridden/atv/rsx8p
	name = "RSX-8 Medical Emergency ATV"
	desc = "An all-terrain vehicle built for traversing rough terrain with ease. One of the few old-Earth technologies that are still relevant on most planet-bound outposts. Woop-Woop"
	icon_state = "em2atv"
	icon = 'tff_modular/modules/rsx_atv/icons/vechicle.dmi'
	var/static/mutable_appearance/em2atvcover
	var/static/mutable_appearance/lightblue
	var/static/mutable_appearance/emis

/obj/vehicle/ridden/atv/rsx8p/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/ridable, /datum/component/riding/vehicle/atv)
	if(!em2atvcover)
		em2atvcover = mutable_appearance(icon, "em2atvcover", MOB_LAYER + 0.1)
	if(!lightblue)
		lightblue = mutable_appearance(icon, "lightblue", MOB_LAYER + 0.1)
	if(!emis)
		emis = mutable_appearance(icon, "emis", MOB_LAYER + 0.1)
		emis = emissive_appearance(icon, "emis", src, alpha = src.alpha)

/obj/vehicle/ridden/atv/rsx8p/post_buckle_mob(mob/living/M)
	add_overlay(em2atvcover)
	add_overlay(lightblue)
	add_overlay(emis)
	return ..()

/obj/vehicle/ridden/atv/rsx8p/post_unbuckle_mob(mob/living/M)
	if(!has_buckled_mobs())
		cut_overlay(em2atvcover)
		cut_overlay(lightblue)
		cut_overlay(emis)
	return ..()

//engi
/obj/vehicle/ridden/atv/rsx8e
	name = "RSX-8 Technical ATV"
	desc = "An all-terrain vehicle built for traversing rough terrain with ease. One of the few old-Earth technologies that are still relevant on most planet-bound outposts."
	icon_state = "engatv"
	icon = 'tff_modular/modules/rsx_atv/icons/vechicle.dmi'
	var/static/mutable_appearance/engatvcover
	var/static/mutable_appearance/lightorang
	var/static/mutable_appearance/emiseng

/obj/vehicle/ridden/atv/rsx8e/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/ridable, /datum/component/riding/vehicle/atv)
	if(!engatvcover)
		engatvcover = mutable_appearance(icon, "engatvcover", MOB_LAYER + 0.1)
	if(!lightorang)
		lightorang = mutable_appearance(icon, "lightorang", MOB_LAYER + 0.1)
	if(!emiseng)
		emiseng = mutable_appearance(icon, "emiseng", MOB_LAYER + 0.1)
		emiseng = emissive_appearance(icon, "emiseng", src, alpha = src.alpha)

/obj/vehicle/ridden/atv/rsx8e/post_buckle_mob(mob/living/M)
	add_overlay(engatvcover)
	add_overlay(lightorang)
	add_overlay(emiseng)
	return ..()

/obj/vehicle/ridden/atv/rsx8e/post_unbuckle_mob(mob/living/M)
	if(!has_buckled_mobs())
		cut_overlay(engatvcover)
		cut_overlay(lightorang)
		cut_overlay(emiseng)
	return ..()

//sec
/obj/vehicle/ridden/atv/rsx8s
	name = "RSX-8 Security ATV"
	desc = "An all-terrain vehicle built for traversing rough terrain with ease. One of the few old-Earth technologies that are still relevant on most planet-bound outposts. Woop-Woop"
	icon_state = "sbatv"
	icon = 'tff_modular/modules/rsx_atv/icons/vechicle.dmi'
	var/static/mutable_appearance/sbatvcover
	var/static/mutable_appearance/lightred
	var/static/mutable_appearance/emis

/obj/vehicle/ridden/atv/rsx8s/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/ridable, /datum/component/riding/vehicle/atv)
	if(!sbatvcover)
		sbatvcover = mutable_appearance(icon, "sbatvcover", MOB_LAYER + 0.1)
	if(!lightred)
		lightred = mutable_appearance(icon, "lightred", MOB_LAYER + 0.1)
	if(!emis)
		emis = mutable_appearance(icon, "emis", MOB_LAYER + 0.1)
		emis = emissive_appearance(icon, "emis", src, alpha = src.alpha)

/obj/vehicle/ridden/atv/rsx8s/post_buckle_mob(mob/living/M)
	add_overlay(sbatvcover)
	add_overlay(lightred)
	add_overlay(emis)
	return ..()

/obj/vehicle/ridden/atv/rsx8s/post_unbuckle_mob(mob/living/M)
	if(!has_buckled_mobs())
		cut_overlay(sbatvcover)
		cut_overlay(lightred)
		cut_overlay(emis)
	return ..()

//cargoshop
/datum/supply_pack/medical/rsx
	name = "RSX-8 Medical Emergency ATV"
	desc = "Contains an RSX-8 EMT All Terrain Vehicle."
	cost = CARGO_CRATE_VALUE * 10
	access = ACCESS_MEDICAL
	contains = list(
		/obj/vehicle/ridden/atv/rsx8p,
		/obj/item/key/atv,
	)
	crate_name = "RSX-8 EMT kit"
	crate_type = /obj/structure/closet/crate

/datum/supply_pack/engineering/rsx
	name = "RSX-8 Technical ATV"
	desc = "Contains an RSX-8 Technical All Terrain Vehicle."
	cost = CARGO_CRATE_VALUE * 10
	access = ACCESS_ENGINEERING
	contains = list(
		/obj/vehicle/ridden/atv/rsx8e,
		/obj/item/key/atv,
	)
	crate_name = "RSX-8 Technical kit"
	crate_type = /obj/structure/closet/crate

/datum/supply_pack/companies/machines/interdyne/rsx
	name = "RSX-8 Interdyne Medical Emergency ATV"
	desc = "Contains an RSX-8 I-EMT All Terrain Vehicle."
	contains = list(
		/obj/vehicle/ridden/atv/rsx8i,
		/obj/item/key/atv,
	)
	crate_name = "RSX-8 I-EMT kit"
	crate_type = /obj/structure/closet/crate
	cost = CARGO_CRATE_VALUE * 10

/datum/supply_pack/security/rsx
	name = "RSX-8 Security ATV"
	desc = "Contains an RSX-8 Security All Terrain Vehicle."
	contains = list(
		/obj/vehicle/ridden/atv/rsx8s,
		/obj/item/key/atv,
	)
	crate_name = "RSX-8 SEC kit"
	crate_type = /obj/structure/closet/crate
	cost = CARGO_CRATE_VALUE * 10

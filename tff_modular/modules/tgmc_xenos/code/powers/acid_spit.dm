/// TGMC_XENOS (old nova sector xenos)

// Наши личные нейротоксичные гланды, большую часть мехаана которых по хорошему бы на ТГ перенести, ведь у этих куда большая возможность настройки без боли
/datum/action/cooldown/alien/acid/tgmc
	name = "Spit Neurotoxin"
	desc = "Spits neurotoxin at someone, exhausting them."
	button_icon = 'tff_modular/modules/tgmc_xenos/icons/xeno_actions.dmi'
	button_icon_state = "neurospit_0"
	shared_cooldown = MOB_SHARED_COOLDOWN_3
	cooldown_time = 3 SECONDS
	plasma_cost = 40
	ranged_mousepointer = 'icons/effects/mouse_pointers/weapon_pointer.dmi'

	/// A singular projectile? Use this one and leave acid_casing null
	var/acid_projectile = /obj/projectile/neurotoxin/tgmc
	/// You want it to be more like a shotgun style attack? Use this one and make acid_projectile null
	var/acid_casing
	/// Used in to_chat messages to the owner
	var/projectile_name = "neurotoxin"
	/// The base icon for the ability, so a red box can be put on it using _0 or _1
	var/button_base_icon = "neurospit"
	/// The sound that should be played when the xeno actually spits
	var/spit_sound = 'tff_modular/modules/tgmc_xenos/sound/alien_spitacid.ogg'

	// Костыль, чтобы выключать способность не сразу, а только при многократных нажатиях
	var/too_much_clicks = 0

/datum/action/cooldown/alien/acid/tgmc/IsAvailable(feedback = FALSE)
	return ..() && isturf(owner.loc)

/datum/action/cooldown/alien/acid/tgmc/set_click_ability(mob/on_who)
	. = ..()
	if(!.)
		return

	to_chat(on_who, span_notice("You prepare your [projectile_name] gland. <B>Left-click to fire at a target!</B>"))

	button_icon_state = "[button_base_icon]_1"
	build_all_button_icons()
	on_who.update_icons()

/datum/action/cooldown/alien/acid/tgmc/unset_click_ability(mob/on_who, refund_cooldown = TRUE)
	. = ..()
	if(!.)
		return

	if(refund_cooldown)
		to_chat(on_who, span_notice("You empty your [projectile_name] gland."))

	button_icon_state = "[button_base_icon]_0"
	build_all_button_icons()
	on_who.update_icons()

/datum/action/cooldown/alien/acid/tgmc/InterceptClickOn(mob/living/clicker, params, atom/target)
	. = ..()
	if(!.)
		if(too_much_clicks >= 2)
			unset_click_ability(clicker, refund_cooldown = FALSE)
			too_much_clicks = 0
		else
			too_much_clicks += 1
		clicker.balloon_alert(clicker, "Not ready!")
		return FALSE

	too_much_clicks = 0
	var/turf/user_turf = clicker.loc
	var/turf/target_turf = get_step(clicker, target.dir)
	if(!isturf(target_turf))
		return FALSE

	var/modifiers = params2list(params)
	clicker.visible_message(
		span_danger("[clicker] spits [projectile_name]!"),
		span_alertalien("You spit [projectile_name]."),
	)

	if(acid_projectile)
		var/obj/projectile/spit_projectile = new acid_projectile(clicker.loc)
		spit_projectile.aim_projectile(target, clicker, modifiers)
		spit_projectile.firer = clicker
		spit_projectile.fire()
		playsound(clicker, spit_sound, 100, TRUE, 5, 0.9)
		clicker.newtonian_move(get_dir(target_turf, user_turf))
		StartCooldown()
		return TRUE

	if(acid_casing)
		var/obj/item/ammo_casing/casing = new acid_casing(clicker.loc)
		playsound(clicker, spit_sound, 100, TRUE, 5, 0.9)
		casing.fire_casing(target, clicker, null, null, null, ran_zone(), 0, clicker)
		clicker.newtonian_move(get_dir(target_turf, user_turf))
		StartCooldown()
		return TRUE

	CRASH("Neither acid_projectile or acid_casing are set on [clicker]'s spit attack!")

/datum/action/cooldown/alien/acid/tgmc/Activate(atom/target)
	return TRUE


// Летальная версия плевка
/datum/action/cooldown/alien/acid/tgmc/lethal
	name = "Spit Acid"
	desc = "Spits neurotoxin at someone, burning them."
	acid_projectile = /obj/projectile/neurotoxin/tgmc/acid
	button_icon_state = "acidspit_0"
	projectile_name = "acid"
	button_base_icon = "acidspit"


// Королевские версии плевков нейротоксина
/datum/action/cooldown/alien/acid/tgmc/queen
	acid_projectile = /obj/projectile/neurotoxin/tgmc/queen
	cooldown_time = 6 SECONDS

/datum/action/cooldown/alien/acid/tgmc/lethal/queen
	acid_projectile = /obj/projectile/neurotoxin/tgmc/acid/queen


// Версия плевка нейротоксина, который работает как дробовик
/datum/action/cooldown/alien/acid/tgmc/spread
	name = "Spit Neurotoxin Spread"
	desc = "Spits a spread neurotoxin at someone, exhausting them."
	plasma_cost = 50
	acid_projectile = null
	acid_casing = /obj/item/ammo_casing/xenospit
	spit_sound = 'tff_modular/modules/tgmc_xenos/sound/alien_spitacid2.ogg'
	cooldown_time = 5 SECONDS

// Немного хренового кода, но блин, какой же прошлый кодер крутой, что нашел такой забавный способ)
/obj/item/ammo_casing/xenospit //This is probably really bad, however I couldn't find any other nice way to do this
	name = "big glob of neurotoxin"
	projectile_type = /obj/projectile/neurotoxin/tgmc/spitter_spread
	pellets = 3
	variance = 20

/obj/item/ammo_casing/xenospit/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/caseless)

/obj/item/ammo_casing/xenospit/tk_firing(mob/living/user, atom/fired_from)
	return FALSE


// Летальная версия дробовик-плевка
/datum/action/cooldown/alien/acid/tgmc/spread/lethal
	name = "Spit Acid Spread"
	desc = "Spits a spread of acid at someone, burning them."
	acid_projectile = null
	acid_casing = /obj/item/ammo_casing/xenospit/spread/lethal
	button_icon_state = "acidspit_0"
	projectile_name = "acid"
	button_base_icon = "acidspit"

/obj/item/ammo_casing/xenospit/spread/lethal
	name = "big glob of acid"
	projectile_type = /obj/projectile/neurotoxin/tgmc/acid/spitter_spread
	pellets = 4
	variance = 30


// Плевок кислоты
/datum/action/cooldown/alien/acid/corrosion/tgmc
	name = "Corrosive Acid (150)"
	desc = "Drench an object in acid, destroying it over time."
	button_icon_state = "alien_acid"
	plasma_cost = 150
	corrosion_acid_power = 100
	corrosion_acid_volume = 500

/datum/action/cooldown/alien/acid/corrosion/tgmc/strong
	name = "Corrosive Acid (200)"
	desc = "Drench an object in acid, destroying it over time."
	button_icon_state = "alien_acid"
	plasma_cost = 200
	corrosion_acid_power = 400
	corrosion_acid_volume = 1000


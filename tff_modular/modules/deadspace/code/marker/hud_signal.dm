/datum/hud/marker_signal
	var/atom/movable/screen/meter/background/psy/background_psy
	var/atom/movable/screen/meter/foreground/psy/foreground_psy
	var/atom/movable/screen/meter/background/bio/background_bio
	var/atom/movable/screen/meter/foreground/bio/foreground_bio
	var/atom/movable/screen/meter/psy/psy_energy
	var/atom/movable/screen/meter/biomass/biomass

/datum/hud/marker_signal/New(mob/eye/marker_signal/owner)
	background_psy = new
	background_psy.plane = HUD_PLANE
	foreground_psy = new
	foreground_psy.plane = HUD_PLANE
	background_bio = new
	background_bio.plane = HUD_PLANE
	foreground_bio = new
	foreground_bio.plane = HUD_PLANE
	psy_energy = new
	psy_energy.plane = HUD_PLANE
	biomass = new
	biomass.plane = HUD_PLANE
	psy_energy.add_filter("alpha_filter", 1, alpha_mask_filter(clamp(HUD_METER_PIXEL_WIDTH*(owner.psy_energy/owner.psy_energy_maximum), 0, owner.psy_energy_maximum), 0, icon('tff_modular/modules/deadspace/icons/hud/healthbar.dmi', "alpha_mask"), flags = MASK_INVERSE))

	foreground_psy.maptext_x = 53
	foreground_psy.maptext = MAPTEXT("[round(owner.psy_energy, 1)]/[owner.psy_energy_maximum] | +[owner.psy_energy_generation] psy/sec")

	foreground_bio.maptext_x = 53
	owner.update_biomass_hud(src)

	infodisplay += background_psy
	infodisplay += psy_energy
	infodisplay += foreground_psy
	infodisplay += background_bio
	infodisplay += biomass
	infodisplay += foreground_bio
	..()

/atom/movable/screen/meter/psy
	icon_state  = "health_grayscale"
	color = COLOR_PURPLE
	screen_loc = "BOTTOM,CENTER-2:-8"

/atom/movable/screen/meter/background/psy
	screen_loc = "BOTTOM,CENTER-2:-8"

/atom/movable/screen/meter/foreground/psy
	screen_loc = "BOTTOM,CENTER-2:-8"

/atom/movable/screen/meter/biomass
	icon_state  = "health_grayscale"
	color = COLOR_DARK_ORANGE
	screen_loc = "BOTTOM+1:-8,CENTER-2:-8"

/atom/movable/screen/meter/background/bio
	screen_loc = "BOTTOM+1:-8,CENTER-2:-8"

/atom/movable/screen/meter/foreground/bio
	screen_loc = "BOTTOM+1:-8,CENTER-2:-8"

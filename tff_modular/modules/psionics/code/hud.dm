#define UI_PSI_DISPLAY "EAST:2,CENTER+3:-8"
#define UI_PSI_SIGNAL "EAST:2, CENTER+2:-8"
#define FORMAT_PSI_HUD_TEXT(valuecolor, value) MAPTEXT("<div align='center' valign='middle' style='position:relative; top:0px; left:6px'><font color='[valuecolor]'>[round(value,1)]</font></div>")

/atom/movable/screen/psionic
	icon = 'tff_modular/modules/psionics/icons/psi_hud.dmi'
	mouse_over_pointer = MOUSE_HAND_POINTER

/atom/movable/screen/psionic/psionic_energy
	name = "Psionic Status"
	icon_state = "psi_active"
	screen_loc = UI_PSI_DISPLAY

/atom/movable/screen/psionic/psionic_energy/Click()
	. = ..()
	var/list/msg = list()
	var/mob/living/owner_mob = hud.mymob
	var/datum/psionic/psi_datum = owner_mob.get_psionic()

	if(!psi_datum)
		return

	msg += span_horizonblue("This is your Psionic Status.")
	msg += span_horizonblue("Here you see your current level of psi-energy. This is used for all of your psi spells.")
	msg += span_horizonblue("\n<b>Your psi-energy restores passively, but some conditions can speed it up.</b>")
	msg += span_horizonblue("If your psi energy becomes zero, you will begin to suffer from exhaustion.")

	var/psylevel
	switch(psi_datum.mana_level)
		if(0)
			psylevel = "exhaustion"
		if(1 to INFINITY)
			psylevel = "saturation"

	msg += span_horizonblue("Your current maximum is: [psi_datum.max_mana].")

	msg += span_cult_large("\n<b>Right now, you are feeling <i>[psylevel].</i></b>")

	to_chat(usr, boxed_message(msg.Join("\n")))

/atom/movable/screen/psionic/psionic_signal
	name = "Psionic Signal"
	icon_state = "psi_broad_inactive"
	screen_loc = UI_PSI_SIGNAL

/atom/movable/screen/psionic/psionic_signal/Click(location, control, params)
	. = ..()
	var/list/msg = list()
	var/mob/living/owner_mob = hud.mymob
	var/datum/psionic/psi_datum = owner_mob.get_psionic()

	if(!psi_datum)
		return

	msg += span_horizonblue("This is your Psionic Signal.")
	msg += span_horizonblue("This signal allows the psionics to sense each other. When there is a psionic nearby, this signal starts to glow blue.")
	msg += span_horizonblue("If your psionic being suppressed, you can't sense the psionics nearby, but they can't sense you either.")
	msg += span_horizonblue("\n<b>Some extremely powerful psionics are able to partially suppress their signal.</b>")

	to_chat(usr, boxed_message(msg.Join("\n")))

/datum/psionic/proc/update_hud()
	var/psi_energy_color
	var/psi_energy_icon_state
	switch(mana_level)
		if(-100 to 0)
			psi_energy_color = "#480607"
			psi_energy_icon_state = "psi_suppressed"
		if(1 to INFINITY)
			psi_energy_color = "#00BFFF"
			psi_energy_icon_state = "psi_active"

	var/atom/movable/screen/psionic/psionic_energy/psi_display = psi_owner?.hud_used?.screen_objects[HUD_PSI_DISPLAY]
	psi_display?.maptext = FORMAT_PSI_HUD_TEXT(psi_energy_color, mana_level)
	psi_display?.icon_state = psi_energy_icon_state

	var/psi_signal_icon_state
	if(detect_psionic())
		psi_signal_icon_state = "psi_signal_active"
	else
		psi_signal_icon_state = "psi_signal_inactive"

	var/atom/movable/screen/psionic/psionic_signal/psi_signal = psi_owner?.hud_used?.screen_objects[HUD_PSI_SIGNAL]
	psi_signal?.icon_state = psi_signal_icon_state

#undef UI_PSI_DISPLAY
#undef UI_PSI_SIGNAL
#undef FORMAT_PSI_HUD_TEXT

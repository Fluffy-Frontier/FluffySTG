// Данный фикс благополучно портирован с ТауКеков. - Sensum
/client/verb/reset_macros_wrapper()
	set category = "OOC"
	set name = "Fix Hotkeys"
	reset_macros()

/client/proc/reset_macros()
	var/ans
	if(!skip_alert)
		ans = tgui_alert(src, "Включите английскую (ENG) расскладку и нажмите \"Ok\".", "Fixing Hotkeys")
	to_chat(src, "<span class='notice'>Ваши хоткеи были перезагружены, если это не помогло - попробуйте ещё раз.</span>")
	set_macros()

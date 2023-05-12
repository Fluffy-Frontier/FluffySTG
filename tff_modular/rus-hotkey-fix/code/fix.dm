// Данный фикс благополучно портирован с ТауКеков. - Sensum
/client/verb/reset_macros_wrapper()
	set category = "OOC"
	set name = "Fix Hotkeys" 
	reset_macros()

/client/proc/reset_macros()
	var/ans = tgui_alert(src, "Включите английскую (ENG) расскладку и нажмите \"Ok\".", "Fixing Hotkeys")
	if(ans != "Ok")
		return
	to_chat(src, "<span class='notice'>Ваши хоткеи были перезагружены, если это не помогло - попробуйте ещё раз.</span>")
	set_macros()

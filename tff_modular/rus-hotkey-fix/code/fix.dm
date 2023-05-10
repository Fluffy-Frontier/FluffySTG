// Данный фикс благополучно портирован с ТауКеков. - Sensum
/client/verb/reset_macros_wrapper()
	set category = "OOC"
	set name = "Fix Hotkeys"
	reset_macros()

/client/proc/reset_macros(skip_alert = FALSE)
	var/ans
	if(!skip_alert)
		ans = tgui_alert(src, "Включите английскую (ENG) расскладку и нажмите \"Ok\".", "Fixing Hotkeys")

	if(skip_alert || ans == "Ok")
		to_chat(src, "<span class='notice'>Если после данного сообщения не последует очередная ошибка - ваши хоткеи восстановлены. В ином случае - повторите попытку.</span>")
		set_macros()

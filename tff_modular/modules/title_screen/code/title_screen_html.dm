/mob/dead/new_player/get_title_html()
	var/dat = SStitle.title_html
	if(SSticker.current_state == GAME_STATE_STARTUP)
		dat += {"<img src="loading_screen.gif" class="bg" alt="">"}
		dat += {"<div class="container_terminal" id="terminal"></div>"}
		dat += {"<div class="papers_header">SUBSYSTEMS INFO</div>"}
		dat += {"<div class="container_progress" id="progress_container"><div class="progress_bar" id="progress"><div class="sub_progress_bar" id="sub_progress"></div></div></div>"}
		dat += {"<div class="progress_label">LOADING GAME...</div>"}

		dat += {"
		<script language="JavaScript">
			var terminal = document.getElementById("terminal");
			var terminal_lines = \[
		"}

		for(var/message in GLOB.startup_messages)
			dat += {""[replacetext(message, "\"", "\\\"")]","}

		dat += {"
			\];

			function append_terminal_text(text) {
				if(text) {
					terminal_lines.push(text);
				}
				while(terminal_lines.length > [MAX_STARTUP_MESSAGES]) {
					terminal_lines.shift();
				}

				terminal.innerHTML = terminal_lines.join("");
			}

			append_terminal_text();

			var progress_bar = document.getElementById("progress");
			var sub_progress_bar = document.getElementById("sub_progress");
			var progress_container = document.getElementById("progress_container");
			var previous_tick = new Date().getTime();
			var progress_current_time = [world.timeofday - SStitle.progress_reference_time];
			var progress_completion_time = [SStitle.average_completion_time];
			var progress_current_position = 0;
			var progress_sub_start = 0;
			var target_sub_start = 0;

			setInterval(function() {
				if(progress_current_time < progress_completion_time) {
					var current_tick = new Date().getTime();
					progress_current_time += (current_tick - previous_tick) / 100;
					previous_tick = current_tick;
				}

				progress_current_position = Math.min(Math.max(progress_current_time / progress_completion_time * 100, progress_current_position), 100);

				if(progress_sub_start == 0) {
					progress_sub_start = target_sub_start = progress_current_position;
				} else {
					progress_sub_start = Math.min(progress_sub_start + 0.1, target_sub_start);
				}

				var progress_sub_current_position = (progress_current_position - progress_sub_start) / progress_current_position * 100;

				progress_bar.style.width = "" + progress_current_position + "%";
				sub_progress_bar.style.width = "" + progress_sub_current_position + "%";
			}, 16.666666667);

			function update_loading_progress(current_time, total_time) {
				progress_current_time = parseFloat(current_time);
				progress_completion_time = parseFloat(total_time);
				target_sub_start = progress_current_position;
			}

			function update_current_character() {}
		</script>
		"}

	else
		dat += {"<img src="loading_screen.gif" class="bg" alt="">"}

		if(SStitle.current_notice)
			dat += {"
			<div class="container_notice">
				<p class="menu_notice">[SStitle.current_notice]</p>
			</div>
		"}
		dat += {"<div class="char_text" id="character">[uppertext(client.prefs.read_preference(/datum/preference/name/real_name))]</div>"}
		dat += {"
			<div class="left_side_container">
				<a href='byond://?src=[text_ref(src)];game_options=1' class="circle_button"
					><img src="http://cdn.fluffy-frontier.ru/icons/settings.png" alt=""
				/></a>
				<a href='byond://?src=[text_ref(src)];character_setup=1' class="circle_button"
					><img src="http://cdn.fluffy-frontier.ru/icons/char.png" alt=""
				/></a>
			</div>
		"}
		dat += {"<div class="container_nav">"}

		if(!SSticker || SSticker.current_state <= GAME_STATE_PREGAME)
			dat += {"<a id="ready" class="menu_button" href='byond://?src=[text_ref(src)];toggle_ready=1'>[ready == PLAYER_READY_TO_PLAY ? "READY" : "NOT READY"]</a>"}
		else
			dat += {"
				<a class="menu_button" href='byond://?src=[text_ref(src)];late_join=1'>JOIN GAME</a>
				<a class="menu_button" href='byond://?src=[text_ref(src)];view_manifest=1'>CREW MANIFEST</a>
				<hr>
			"}

		dat += {"<a class="menu_button" href='byond://?src=[text_ref(src)];observe=1'>OBSERVE</a>"}

		dat += {"
			<a class="menu_button" href='byond://?src=[text_ref(src)];view_directory=1'>CHARACTER DIRECTORY</a>
			<a id="be_antag" class="menu_button" href='byond://?src=[text_ref(src)];toggle_antag=1'>[client.prefs.read_preference(/datum/preference/toggle/be_antag) ? "BE ANTAGONIST" : "NOT TO BE ANTAG"]</a>
			<hr>
		"}

		if(!is_guest_key(src.key))
			dat += playerpolls()

		dat += "</div>"
		dat += {"
		<script language="JavaScript">
			var ready_int = 0;
			var ready_mark = document.getElementById("ready");
			var ready_marks = \[ "NOT READY", "READY" \];
			function toggle_ready(setReady) {
				if(setReady) {
					ready_int = setReady;
					ready_mark.innerHTML = ready_marks\[ready_int\];
				}
				else {
					ready_int++;
					if (ready_int === ready_marks.length)
						ready_int = 0;
					ready_mark.innerHTML = ready_marks\[ready_int\];
				}
			}
			var antag_int = 0;
			var antag_mark = document.getElementById("be_antag");
			var antag_marks = \[ "NOT TO BE ANTAG", "BE ANTAGONIST" \];
			function toggle_antag(setAntag) {
				if(setAntag) {
					antag_int = setAntag;
					antag_mark.innerHTML = antag_marks\[antag_int\];
				}
				else {
					antag_int++;
					if (antag_int === antag_marks.length)
						antag_int = 0;
					antag_mark.innerHTML = antag_marks\[antag_int\];
				}
			}

			var character_name_slot = document.getElementById("character");
			function update_current_character(name) {
				character_name_slot.textContent = name.toUpperCase();
			}

			function append_terminal_text() {}
			function update_loading_progress() {}
		</script>
		"}

	if(!title_screen_is_ready)
		dat += {"
			<script>
				window.location = "byond://?src=[text_ref(src)];title_is_ready=1"
			</script>
		"}

	dat += "</body></html>"

	return dat

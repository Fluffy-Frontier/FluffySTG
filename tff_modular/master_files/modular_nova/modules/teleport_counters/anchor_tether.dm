/obj/item/mod/module/tether/anti_teleport
	var/list/accepted_anomalies = list(/obj/item/assembly/signaler/anomaly/bluespace)
	var/prebuilt = FALSE
	var/core_removable = TRUE

/obj/item/mod/module/tether/anti_teleport/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/anomaly_locked_module, accepted_anomalies, prebuilt, core_removable)

/obj/item/mod/module/tether/anti_teleport/update_icon_state()
	. = ..()
	icon_state = replacetext(icon_state, "-core", "")

/obj/item/mod/module/tether/anti_teleport/prebuilt
	prebuilt = TRUE

/obj/item/mod/module/tether/anti_teleport/prebuilt/locked
	core_removable = FALSE

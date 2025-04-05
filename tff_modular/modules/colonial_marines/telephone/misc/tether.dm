/// Creates a tether between two objects that limits movement range. Tether requires LOS and can be adjusted by left/right clicking its
/datum/component/transmitter_tether
	/// Other side of the tether
	var/atom/tether_target
	/// Maximum (and initial) distance that this tether can be adjusted to
	var/max_dist
	/// What the tether is going to be called
	var/tether_name
	/// Current extension distance
	var/cur_dist
	/// Beam effect
	var/datum/beam/tether_beam

	var/icon_name
	var/icon_file
	var/can_be_blocked

/datum/component/transmitter_tether/Initialize(atom/tether_target, max_dist = 7, tether_name, icon="line", icon_file='icons/obj/clothing/modsuit/mod_modules.dmi', can_be_blocked = FALSE)
	if(!ismovable(parent) || !istype(tether_target) || !tether_target.loc)
		return COMPONENT_INCOMPATIBLE

	src.tether_target = tether_target
	src.max_dist = max_dist
	src.icon_name = icon
	src.icon_file = icon_file
	cur_dist = max_dist
	var/datum/beam/beam = tether_target.Beam(parent, src.icon_name, src.icon_file, emissive = FALSE, beam_type = /obj/effect/ebeam/custom_tether, layer = GIB_LAYER)
	tether_beam = beam
	src.tether_name = tether_name
	src.can_be_blocked = can_be_blocked

/datum/component/transmitter_tether/RegisterWithParent()
	RegisterSignal(parent, COMSIG_MOVABLE_PRE_MOVE, PROC_REF(check_tether))
	RegisterSignal(parent, COMSIG_MOVABLE_MOVED, PROC_REF(check_snap))
	RegisterSignal(tether_target, COMSIG_MOVABLE_PRE_MOVE, PROC_REF(check_tether))
	RegisterSignal(tether_target, COMSIG_MOVABLE_MOVED, PROC_REF(check_snap))
	RegisterSignal(tether_target, COMSIG_QDELETING, PROC_REF(on_delete))
	// Also snap if the beam gets deleted, more of a backup check than anything
	RegisterSignal(tether_beam.visuals, COMSIG_QDELETING, PROC_REF(on_delete))

	RegisterSignal(parent, COMSIG_TRANSMITTER_NEED_DELETE_TETHER, PROC_REF(on_delete))

/datum/component/transmitter_tether/UnregisterFromParent()
	UnregisterSignal(parent, list(COMSIG_MOVABLE_PRE_MOVE, COMSIG_MOVABLE_MOVED, COMSIG_TRANSMITTER_NEED_DELETE_TETHER))
	if(!QDELETED(tether_target))
		UnregisterSignal(tether_target, list(COMSIG_MOVABLE_PRE_MOVE, COMSIG_MOVABLE_MOVED, COMSIG_QDELETING))
	if(!QDELETED(tether_beam))
		UnregisterSignal(tether_beam.visuals, COMSIG_QDELETING)
		qdel(tether_beam)

/datum/component/transmitter_tether/proc/check_tether(atom/source, new_loc)
	SIGNAL_HANDLER

	if(check_snap())
		return

	if(!isturf(new_loc))
		to_chat(source, span_warning("[tether_name] prevents you from entering [new_loc]!"))
		return COMPONENT_MOVABLE_BLOCK_PRE_MOVE

	// If this was called, we know its a movable
	var/atom/movable/movable_source = source
	var/atom/movable/anchor = (source == tether_target ? parent : tether_target)
	if(get_dist(anchor, new_loc) > cur_dist)
		if(!istype(anchor) || anchor.anchored || !(!anchor.anchored && anchor.move_resist <= movable_source.move_force && anchor.Move(get_step_towards(anchor, new_loc))))
			to_chat(source, span_warning("[tether_name] runs out of slack and prevents you from moving!"))
			return COMPONENT_MOVABLE_BLOCK_PRE_MOVE

	if(can_be_blocked && check_block(source, anchor, new_loc))
		return COMPONENT_MOVABLE_BLOCK_PRE_MOVE

	if(get_dist(anchor, new_loc) != cur_dist || !ismovable(source))
		return

	var/datum/drift_handler/handler = movable_source.drift_handler
	if(isnull(handler))
		return
	handler.remove_angle_force(get_angle(anchor, source))

/datum/component/transmitter_tether/proc/check_block(atom/movable/source, atom/movable/anchor, new_loc, silent = FALSE)
	var/atom/blocker
	var/anchor_dir = get_dir(source, anchor)
	for(var/turf/line_turf in get_line(anchor, new_loc))
		if(line_turf.density && line_turf != anchor.loc && line_turf != source.loc)
			blocker = line_turf
			break
		if(line_turf == anchor.loc || line_turf == source.loc)
			for(var/atom/in_turf in line_turf)
				if((in_turf.flags_1 & ON_BORDER_1) && (in_turf.dir & anchor_dir))
					blocker = in_turf
					break
		else
			for(var/atom/in_turf in line_turf)
				if (in_turf.density && in_turf != source && in_turf != tether_target)
					blocker = in_turf
					break

		if(!isnull(blocker))
			break

	if(blocker)
		if(!silent)
			to_chat(source, span_warning("[tether_name] catches on [blocker] and prevents you from moving!"))
		return TRUE

	return FALSE

/datum/component/transmitter_tether/proc/check_snap()
	SIGNAL_HANDLER

	var/atom/atom_target = parent
	// Something broke us out, snap the tether
	if(get_dist(atom_target, tether_target) > cur_dist + 1 || !isturf(atom_target.loc) || !isturf(tether_target.loc) || atom_target.z != tether_target.z)
		snap()

/datum/component/transmitter_tether/proc/snap()
	SIGNAL_HANDLER

	var/atom/atom_target = parent
	atom_target.visible_message(span_warning("[atom_target]'s [tether_name] snaps!"), span_userdanger("Your [tether_name] snaps!"), span_hear("You hear a cable snapping."))
	playsound(atom_target, 'sound/effects/snap.ogg', 50, TRUE)
	SEND_SIGNAL(parent, COMSIG_ATOM_TETHER_SNAPPED)
	SEND_SIGNAL(tether_target, COMSIG_ATOM_TETHER_SNAPPED)
	qdel(src)

/datum/component/transmitter_tether/proc/on_delete()
	SIGNAL_HANDLER
	qdel(src)

/obj/effect/ebeam/custom_tether
	name = "cable"
	mouse_opacity = MOUSE_OPACITY_ICON
	layer = GIB_LAYER

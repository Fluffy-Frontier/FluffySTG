/obj/item/circuit_component/rbmk2
	display_name = "RB-MK2 reactor"
	desc = "The interface for communicating with a Radioscopical Bluespace Mark 2 reactor."

	var/datum/port/input/toggle_reactor
	var/datum/port/input/remove_rod
	var/datum/port/input/toggle_vents
	var/datum/port/input/toggle_vent_direction
	var/datum/port/input/toggle_safety
	var/datum/port/input/toggle_overclock
	///Signals the circuit to retrieve the machine's data
	var/datum/port/input/request_data

	var/datum/port/output/port_active
	var/datum/port/output/port_meltdown
	var/datum/port/output/port_meltdown_signal
	var/datum/port/output/port_jammed
	var/datum/port/output/port_power_generation
	var/datum/port/output/port_rod_pressure
	var/datum/port/output/port_rod_temperature
	var/datum/port/output/port_remaining_fuel
	var/datum/port/output/port_criticality
	var/datum/port/output/port_integrity

	var/datum/port/output/port_venting
	var/datum/port/output/port_vent_direction

	var/datum/port/output/port_safety
	var/datum/port/output/port_overclock

	var/datum/port/output/port_data_updated

	var/obj/machinery/power/rbmk2/connected_machine

/obj/item/circuit_component/rbmk2/populate_ports()
	toggle_reactor = add_input_port("Toggle Reactor", PORT_TYPE_SIGNAL, trigger = PROC_REF(handle_toggle_reactor))
	remove_rod = add_input_port("Remove Rod", PORT_TYPE_SIGNAL, trigger = PROC_REF(handle_remove_rod))
	toggle_vents = add_input_port("Toggle Vents", PORT_TYPE_SIGNAL, trigger = PROC_REF(handle_toggle_vents))
	toggle_vent_direction = add_input_port("Toggle Vent Direction", PORT_TYPE_SIGNAL, trigger = PROC_REF(handle_toggle_vent_dir))
	toggle_safety = add_input_port("Toggle Safety", PORT_TYPE_SIGNAL, trigger = PROC_REF(handle_toggle_safety))
	toggle_overclock = add_input_port("Toggle Overclock", PORT_TYPE_SIGNAL, trigger = PROC_REF(handle_toggle_overclock))
	request_data = add_input_port("Request Port Data", PORT_TYPE_SIGNAL, trigger = PROC_REF(request_reactor_data))

	port_active = add_output_port("Activity", PORT_TYPE_BOOLEAN)
	port_meltdown = add_output_port("Meldown", PORT_TYPE_BOOLEAN)
	port_meltdown_signal = add_output_port("Meldown Signal", PORT_TYPE_SIGNAL)
	port_jammed = add_output_port("Jammed", PORT_TYPE_BOOLEAN)
	port_power_generation = add_output_port("Power Generation", PORT_TYPE_NUMBER)
	port_rod_pressure = add_output_port("Rod Pressure", PORT_TYPE_NUMBER)
	port_rod_temperature = add_output_port("Rod Temperature", PORT_TYPE_NUMBER)
	port_remaining_fuel = add_output_port("Remaining Fuel", PORT_TYPE_NUMBER)
	port_criticality = add_output_port("Criticality", PORT_TYPE_NUMBER)
	port_integrity = add_output_port("Integrity", PORT_TYPE_NUMBER)

	port_venting = add_output_port("Venting", PORT_TYPE_BOOLEAN)
	port_vent_direction = add_output_port("Vent Direction", PORT_TYPE_BOOLEAN)

	port_safety = add_output_port("Safety", PORT_TYPE_BOOLEAN)
	port_overclock = add_output_port("Overclock", PORT_TYPE_BOOLEAN)

	port_data_updated = add_output_port("Data Updated", PORT_TYPE_SIGNAL)

/obj/item/circuit_component/rbmk2/register_usb_parent(atom/movable/shell)
	. = ..()
	if(istype(shell, /obj/machinery/power/rbmk2))
		connected_machine = shell
		RegisterSignal(connected_machine, COMSIG_RBMK2_MELTDOWN, PROC_REF(handle_reactor_meltdown))

/obj/item/circuit_component/rbmk2/unregister_usb_parent(atom/movable/shell)
	UnregisterSignal(connected_machine, COMSIG_RBMK2_MELTDOWN)
	connected_machine = null
	return ..()

/obj/item/circuit_component/rbmk2/proc/handle_reactor_meltdown(datum/source)
	SIGNAL_HANDLER
	port_meltdown.set_output(TRUE)
	port_meltdown_signal.set_output(COMPONENT_SIGNAL)

/obj/item/circuit_component/rbmk2/proc/handle_toggle_reactor()
	CIRCUIT_TRIGGER
	if(!connected_machine)
		return
	connected_machine.toggle_active()

/obj/item/circuit_component/rbmk2/proc/handle_remove_rod()
	CIRCUIT_TRIGGER
	if(!connected_machine)
		return
	INVOKE_ASYNC(connected_machine, TYPE_PROC_REF(/obj/machinery/power/rbmk2, remove_rod), do_throw = TRUE)

/obj/item/circuit_component/rbmk2/proc/handle_toggle_vents()
	CIRCUIT_TRIGGER
	if(!connected_machine)
		return
	connected_machine.toggle_vents()

/obj/item/circuit_component/rbmk2/proc/handle_toggle_vent_dir()
	CIRCUIT_TRIGGER
	if(!connected_machine)
		return
	connected_machine.toggle_reverse_vents()

/obj/item/circuit_component/rbmk2/proc/handle_toggle_safety()
	CIRCUIT_TRIGGER
	if(!connected_machine)
		return
	connected_machine.safety = !connected_machine.safety

/obj/item/circuit_component/rbmk2/proc/handle_toggle_overclock()
	CIRCUIT_TRIGGER
	if(!connected_machine)
		return
	connected_machine.overclocked = !connected_machine.overclocked

/obj/item/circuit_component/rbmk2/proc/request_reactor_data()
	CIRCUIT_TRIGGER
	if(!connected_machine)
		return

	port_active.set_output(connected_machine.active)
	port_meltdown.set_output(connected_machine.meltdown)
	port_jammed.set_output(connected_machine.jammed)
	port_power_generation.set_output(energy_to_power(connected_machine.last_power_generation))
	port_rod_pressure.set_output(connected_machine.stored_rod?.air_contents.return_pressure() || 0)
	port_rod_temperature.set_output(connected_machine.stored_rod?.air_contents.temperature || 0)
	port_remaining_fuel.set_output(connected_machine.stored_rod?.air_contents.moles[/datum/gas/tritium] || 0)
	port_criticality.set_output(connected_machine.criticality)
	port_integrity.set_output(connected_machine.get_health_percent())

	port_venting.set_output(connected_machine.venting)
	port_vent_direction.set_output(connected_machine.vent_reverse_direction)

	port_safety.set_output(connected_machine.safety)
	port_overclock.set_output(connected_machine.overclocked)

	port_data_updated.set_output(COMPONENT_SIGNAL)

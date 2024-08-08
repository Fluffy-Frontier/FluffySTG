/datum/computer_file/program/disk_binded/accounting
	filename = "accounting"
	filedesc = "Employee Banking Accounts"
	program_open_overlay = "bounty"
	extended_desc = "Connect to the NT Accounting Division for control of employee finances."
	program_flags = PROGRAM_REQUIRES_NTNET
	tgui_id = "NtosAccounting"
	program_icon = FA_ICON_CREDIT_CARD_ALT
	icon_keyboard = "id_key"

/datum/computer_file/program/disk_binded/accounting/ui_data(mob/user)
	. = ..()
	var/list/data = list()
	var/list/player_accounts = list()
	var/list/audit_list = SSeconomy.audit_log

	for(var/current_account as anything in SSeconomy.bank_accounts_by_id)
		var/datum/bank_account/current_bank_account = SSeconomy.bank_accounts_by_id[current_account]
		player_accounts += list(list(
			"name" = current_bank_account.account_holder,
			"job" = current_bank_account.account_job?.title || "No job", // because this can be null
			"balance" = round(current_bank_account.account_balance),
			"modifier" = round((current_bank_account.payday_modifier * 0.9), 0.1),
		))
	data["PlayerAccounts"] = player_accounts
	data["AuditLog"] = audit_list
	data["Crashing"] = HAS_TRAIT(SSeconomy, TRAIT_MARKET_CRASHING)
	return data

/obj/item/computer_console_disk/command/accounting
	program = /datum/computer_file/program/disk_binded/accounting
	light_color = LIGHT_COLOR_YELLOW

/obj/machinery/modular_computer/preset/battery_less/console/accounting
	name = "account lookup console"
	desc = "Used to view crew member accounts and purchases."
	console_disk = /obj/item/computer_console_disk/command/accounting

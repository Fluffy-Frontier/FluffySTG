#define CQD_HOLSTER_BLACKLIST_FILE "tff_modular/modules/cqd_holsters/holster_holdable_blacklist.txt"
#define CQD_HOLSTER_WHITELIST_FILE "tff_modular/modules/cqd_holsters/holster_holdable_whitelist.txt"
#define CQD_HOLSTER_DEFAULT_LIST_FILE "tff_modular/modules/cqd_holsters/holster_holdable_default_list.txt"

GLOBAL_LIST_INIT(cqd_holster_storage_whitelist, load_types_from_txtfile(CQD_HOLSTER_WHITELIST_FILE))
GLOBAL_LIST_INIT(cqd_holster_storage_blacklist, load_types_from_txtfile(CQD_HOLSTER_BLACKLIST_FILE))
GLOBAL_LIST_INIT(cqd_holster_storage_deafault_list, load_types_from_txtfile(CQD_HOLSTER_DEFAULT_LIST_FILE))

/proc/load_types_from_txtfile(filepath as text)
	var/list/pathlist = list()
	for(var/str as anything in splittext(file2text(filepath), "\n"))
		var/path = text2path(trim(str))
		if(path)
			pathlist += path
	return pathlist

/datum/storage/cqd_holster_storage
	max_slots = 1
	max_specific_storage = WEIGHT_CLASS_NORMAL

/datum/storage/cqd_holster_storage/can_insert(obj/item/to_insert, mob/user, messages = TRUE, force = FALSE)
	. = ..()
	if(is_type_in_typecache(to_insert, exception_hold))
		return TRUE

/datum/storage/cqd_holster_storage/New()
	. = ..()
	can_hold = typecacheof(GLOB.cqd_holster_storage_deafault_list)
	cant_hold = typecacheof(GLOB.cqd_holster_storage_blacklist)
	exception_hold = typecacheof(GLOB.cqd_holster_storage_whitelist)

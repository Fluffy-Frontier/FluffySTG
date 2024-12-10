#define JOB_GROUP_MEDICAL list(JOB_CORONER, \
	JOB_MEDICAL_DOCTOR, \
	JOB_PARAMEDIC, \
	JOB_CHEMIST, \
	JOB_VIROLOGIST, \
	JOB_ORDERLY, \
	JOB_CHIEF_MEDICAL_OFFICER, \
)

/datum/loadout_item/pocket_items/medkit
	restricted_roles = list(JOB_GROUP_MEDICAL)

/datum/loadout_item/pocket_items/deforest_frontiermedkit
	restricted_roles = list(JOB_GROUP_MEDICAL)

#undef JOB_GROUP_MEDICAL

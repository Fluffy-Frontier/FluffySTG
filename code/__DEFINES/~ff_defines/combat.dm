//aiming down sights values
#define PISTOL_ZOOM 2
#define SHOTGUN_ZOOM 2
#define SMG_ZOOM 2
#define RIFLE_ZOOM 2
#define DMR_ZOOM 6

//ads slowdown
#define LIGHTEST_AIM_SLOWDOWN 0.05
#define LIGHT_AIM_SLOWDOWN 0.15
#define AIM_SLOWDOWN 0.2
#define MEDIUM_AIM_SLOWDOWN 0.25
#define HEAVY_AIM_SLOWDOWN 0.3

//slowdown defines
#define NO_SLOWDOWN 0.0
#define LIGHT_PISTOL_SLOWDOWN 0.15
#define PISTOL_SLOWDOWN 0.2
#define HEAVY_PISTOL_SLOWDOWN 0.25
#define SMG_SLOWDOWN 0.3
#define LIGHT_RIFLE_SLOWDOWN 0.4
#define RIFLE_SLOWDOWN 0.45
#define SHOTGUN_SLOWDOWN 0.5
#define DMR_SLOWDOWN 0.6
#define HMG_SLOWDOWN 0.65

/////////////////
// ATTACHMENTS //
/////////////////
#define TRAIT_ATTACHABLE "attachable"

#define COMSIG_ATTACHMENT_ATTACH "attach-attach"
#define COMSIG_ATTACHMENT_DETACH "attach-detach"
#define COMSIG_ATTACHMENT_EXAMINE "attach-examine"
#define COMSIG_ATTACHMENT_EXAMINE_MORE "attach-examine-more"
#define COMSIG_ATTACHMENT_PRE_ATTACK "attach-pre-attack"
#define COMSIG_ATTACHMENT_AFTER_ATTACK "attach-after-attack"
#define COMSIG_ATTACHMENT_ATTACK "attach-attacked"
#define COMSIG_ATTACHMENT_WIELD "attach-wield"
#define COMSIG_ATTACHMENT_UNWIELD "attach-unwield"
#define COMSIG_ATTACHMENT_UPDATE_OVERLAY "attach-overlay"
#define COMSIG_ATTACHMENT_UNIQUE_ACTION "attach-unique-action"
#define COMSIG_ATTACHMENT_CTRL_CLICK "attach-ctrl-click"
#define COMSIG_ATTACHMENT_ALT_CLICK "attach-alt-click"
#define COMSIG_ATTACHMENT_ATTACK_HAND "attach-attack-hand"

#define COMSIG_ATTACHMENT_TOGGLE "attach-toggle"

#define COMSIG_ATTACHMENT_GET_SLOT "attach-slot-who"
#define ATTACHMENT_SLOT_MUZZLE "muzzle"
#define ATTACHMENT_SLOT_SCOPE "scope"
#define ATTACHMENT_SLOT_GRIP "grip"
#define ATTACHMENT_SLOT_RAIL "rail"
#define ATTACHMENT_SLOT_STOCK "stock"

/proc/attachment_slot_to_bflag(slot)
	switch(slot)
		if(ATTACHMENT_SLOT_MUZZLE)
			return (1<<0)
		if(ATTACHMENT_SLOT_SCOPE)
			return (1<<1)
		if(ATTACHMENT_SLOT_GRIP)
			return (1<<2)
		if(ATTACHMENT_SLOT_RAIL)
			return (1<<3)
		if(ATTACHMENT_SLOT_STOCK)
			return (1<<4)

/proc/attachment_slot_from_bflag(slot)
	switch(slot)
		if(1<<0)
			return ATTACHMENT_SLOT_MUZZLE
		if(1<<1)
			return ATTACHMENT_SLOT_SCOPE
		if(1<<2)
			return ATTACHMENT_SLOT_GRIP
		if(1<<3)
			return ATTACHMENT_SLOT_RAIL
		if(1<<4)
			return ATTACHMENT_SLOT_STOCK

#define ATTACHMENT_DEFAULT_SLOT_AVAILABLE list( \
	ATTACHMENT_SLOT_MUZZLE = 1, \
	ATTACHMENT_SLOT_SCOPE = 1, \
	ATTACHMENT_SLOT_GRIP = 1, \
	ATTACHMENT_SLOT_RAIL = 1, \
	ATTACHMENT_SLOT_STOCK = 1, \
)

//attach_features_flags
/// Removable by hand
#define ATTACH_REMOVABLE_HAND (1<<0)
/// Removable via crowbar
#define ATTACH_REMOVABLE_TOOL (1<<1)
#define ATTACH_TOGGLE (1<<2)
#define ATTACH_NO_SPRITE (1<<3)

#define FIREMODE_SEMIAUTO "single"
#define FIREMODE_BURST "burst"
#define FIREMODE_FULLAUTO "auto"
#define FIREMODE_OTHER "other"
#define FIREMODE_OTHER_TWO "other2"
#define FIREMODE_UNDERBARREL "underbarrel"

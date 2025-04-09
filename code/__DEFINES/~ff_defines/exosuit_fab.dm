//Defines for FF mechs!

//Clammechs
/// Module is compatible with TideShark Exosuit models
#define EXOSUIT_MODULE_TIDESHARK (1<<0)
/// Module is compatible with ReefBreaker Exosuit models
#define EXOSUIT_MODULE_REEFBREAKER (1<<1)
/// Module is compatible with Kelp Wulp Exosuit models
#define EXOSUIT_MODULE_KELPWULP (1<<2)
/// Module is compatible with Seagull Exosuit models
#define EXOSUIT_MODULE_SEAGULL (1<<3)
/// Module is compatible with Striker Eel Exosuit models
#define EXOSUIT_MODULE_STRIKEREEL (1<<4)

//Maybe some other ones later

/// Module is compatible with "Clamtech" Exosuit models - TideShark, ReefBreaker, Kelp Wulp, Seagull and Striker Eel
#define EXOSUIT_MODULE_CLAM (EXOSUIT_MODULE_TIDESHARK | EXOSUIT_MODULE_REEFBREAKER | EXOSUIT_MODULE_KELPWULP | EXOSUIT_MODULE_SEAGULL | EXOSUIT_MODULE_STRIKEREEL)

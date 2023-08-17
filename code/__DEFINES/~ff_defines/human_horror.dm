#define span_black(str) ("<span style='color: [COLOR_ALMOST_BLACK];'>" + str + "</span>")

#define HUMAN_HORROR_STATE_NORMAL 0
#define HUMAN_HORROR_STATE_PANIC 1
#define HUMAN_HORROR_STATE_FEAR 2

//Включен ли глобальный режим страха!
GLOBAL_VAR_INIT(world_horror_mode, TRUE)
//Текущий активный гость войда. Может быть всего один в мире.
GLOBAL_VAR(void_creature)
//Перечень глаз, что будут уничтожены при использовании в хоррор моде!
#define HORROR_MODE_BLECKLISTED_EYES list(/obj/item/organ/internal/eyes/night_vision, /obj/item/organ/internal/eyes/robotic/flashlight)

//Из /client/proc/enable_horror_mode()
#define COMSIG_WORLD_HORROR_MODE_ENABLED "horror_mode_enabled"
//Из /client/proc/disable_horror_mode()
#define COMSIG_WORLD_HORROR_MODE_DISABLED "horror_mode_disabled"

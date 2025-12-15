/// from /datum/component/supermatter_crystal/proc/consume()
/// called on the thing consumed, passes the thing which consumed it
/// #define COMSIG_SUPERMATTER_CONSUMED "sm_consumed_this" - мы оверайдим код кристала супер материи и добавляем возможность ответа на сигнал
	// Вернуть, как ответ на сигнал для предотвращения поглащения кристалом супер материи
	#define COMPONENT_PREVENT_SUPERMATTER_CONSUM (1 << 0)

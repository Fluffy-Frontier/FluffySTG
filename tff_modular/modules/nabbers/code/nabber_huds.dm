#define NABBER_HUD_Y_SHIFT 16

/mob/living/carbon/human/species/nabber/adjust_hud_position(image/holder, animate_time)
	. = ..()
	holder.pixel_z += NABBER_HUD_Y_SHIFT // По идее, по хорошему, должно быть сделано через set_hud_image_state() с указанным офсетами, но кто-то придумал вызывать adjust_hud_position() вне того прока, от чего на оффсеты игре становится абсолютно плевать...

#undef NABBER_HUD_Y_SHIFT

# Shift Intensity

## Описание

Модуль, добавляющий систему т.н. "светофора". Дает возможность людями голосовать за уровень динамика на смене

## TG File Changes

Additions:

- code/controllers/subsystem/dynamic/dynamic.dm: `/datum/controller/subsystem/dynamic/proc/get_latejoin_chance()`
- code/controllers/subsystem/statpanel.dm: `/datum/controller/subsystem/statpanels/fire()`
- code/modules/mob/dead/new_player/login.dm: `/mob/dead/new_player/Login()`

## Defines

IN: code/\_\_DEFINES/~ff_defines/dynamic.dm

- `ROUND_LIGHT_SHIFT_STRING`
- `ROUND_MID_SHIFT_STRING`
- `ROUND_HEAVY_SHIFT_STRING`
- `ROUND_TOTALLY_HELL_SHIFT_STRING`

Global Vars:

- `shift_intensity_level`

# Config

IN: config/tff/config_tff.txt

- `SHIFT_INTENSITY`
- `ALLOW_SHIFT_INTENSITY_VOTE`
- `SHIFT_INTENSITY_VOTE_STARTTIME`
- `SHIFT_INTENSITY_VOTE_MINIMUM_PLAYERS`

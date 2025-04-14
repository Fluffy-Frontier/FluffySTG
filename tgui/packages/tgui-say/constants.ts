/** Window sizes in pixels */
export enum WindowSize {
  Small = 30,
  Medium = 50,
  Large = 70,
  Width = 231,
}

/** Line lengths for autoexpand */
export enum LineLength {
  Small = 20,
  Medium = 40,
}

/**
 * Radio prefixes.
 * Displays the name in the left button, tags a css class.
 */
export const RADIO_PREFIXES = {
  ':a ': 'Hive',
  ':b ': 'io',
  ':c ': 'Cmd',
  ':e ': 'Engi',
  ':g ': 'Cling',
  ':m ': 'Med',
  ':n ': 'Sci',
  ':o ': 'AI',
  ':p ': 'Ent',
  ':s ': 'Sec',
  ':t ': 'Synd',
  ':u ': 'Supp',
  ':v ': 'Svc',
  ':y ': 'CCom',
  // NOVA EDIT ADDITION START
  ':w ': 'Dyne',
  ':k ': 'Tark',
  ':q ': 'Csun',
  ':i ': 'Guild',
  ':l ': 'SolFed',
  // NOVA EDIT ADDITION END
} as const;

// TFF EDIT ADDITION START
export const RUS_PREFIXES = {
  ':ф ': ':a ',
  ':и ': ':b ',
  ':с ': ':c ',
  ':у ': ':e ',
  ':п ': ':g ',
  ':ь ': ':m ',
  ':т ': ':n ',
  ':щ ': ':o ',
  ':з ': ':p ',
  ':ы ': ':s ',
  ':е ': ':t ',
  ':г ': ':u ',
  ':м ': ':v ',
  ':н ': ':y ',
  ':ц ': ':w ',
  ':л ': ':k ',
  ':й ': ':q ',
  ':ш ': ':i ',
  ':д ': ':l ',
} as const;
// TFF EDIT ADDITION END

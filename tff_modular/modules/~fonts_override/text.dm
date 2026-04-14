/**
 * Be warned, those fonts do not replace original fonts entirely. They only replace the fonts for maptext and status display, so you can still use the original fonts for other things if you want.
 * If you want to replace the original fonts entirely, you need to add those changes in this module.
 */

/// Standard size (ie: normal runechat) - Size options: 6pt 12pt 18pt.
/// Smallest size. (ie: whisper runechat) - Size options: 6pt 12pt 18pt.
/// Replaces BOTH Grand9K Pixel font AND Spess Font (you may want to find better font)
#define MAPTEXT_GRAPH35PIX(text) {"<span style='font-family: \"Graph 35+ pix\"; font-size: 6pt; -dm-text-outline: 1px black'>[##text]</span>"}

/// Small size. (ie: context subtooltips, spell delays) - Size options: 12pt 24pt.
/// Replaces Tiny Unicode font
#define MAPTEXT_INSTRUCTIONS(text) {"<span style='font-family: \"Instructions\"; font-size: 12pt; line-height: 0.75; -dm-text-outline: 1px black'>[##text]</span>"}

// For now Pixellari is only used for context tooltips, which always in latin, so there is no need for alternative.

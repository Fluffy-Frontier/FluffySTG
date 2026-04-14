/// For clean results on map, use only sizing pt, multiples of 6: 6pt 12pt 18pt 24pt etc. - Not for use with px sizing
/// Can be used in TGUI etc, px sizing is pt / 0.75. 6pt = 8px, 12pt = 16px etc.

/// Base font
/datum/font/graph_35_pix
	name = "Graph 35+ pix"
	font_family = 'tff_modular/modules/~fonts_override/fonts/Graph-35-pix.ttf'

/// For icon overlays
/// Graph 35+ pix 6pt metrics generated using Lummox's dmifontsplus (https://www.byond.com/developer/LummoxJR/DmiFontsPlus)
/// Note: these variable names have been changed, so you can't straight copy/paste from dmifontsplus.exe
/datum/font/graph_35_pix/size_6pt
	name = "Graph 35+ pix 6pt"
	height = 7
	ascent = 7
	descent = 0
	average_width = 5
	max_width = 7
	overhang = 0
	in_leading = -1
	ex_leading = 0
	default_character = 31
	start = 30
	end = 255

	metrics = list(\
		0, 7, -7,	/* char 30 */ \
		0, 7, -7,	/* char 31 */ \
		0, 1, 5,	/* char 32 */ \
		2, 1, 3,	/* char 33 */ \
		1, 3, 2,	/* char 34 */ \
		0, 5, 1,	/* char 35 */ \
		0, 5, 1,	/* char 36 */ \
		0, 5, 1,	/* char 37 */ \
		0, 5, 1,	/* char 38 */ \
		1, 2, 3,	/* char 39 */ \
		1, 3, 2,	/* char 40 */ \
		1, 3, 2,	/* char 41 */ \
		1, 3, 2,	/* char 42 */ \
		0, 5, 1,	/* char 43 */ \
		1, 2, 3,	/* char 44 */ \
		0, 5, 1,	/* char 45 */ \
		1, 2, 3,	/* char 46 */ \
		0, 5, 1,	/* char 47 */ \
		0, 5, 1,	/* char 48 */ \
		1, 3, 2,	/* char 49 */ \
		0, 5, 1,	/* char 50 */ \
		0, 5, 1,	/* char 51 */ \
		0, 5, 1,	/* char 52 */ \
		0, 5, 1,	/* char 53 */ \
		0, 5, 1,	/* char 54 */ \
		0, 5, 1,	/* char 55 */ \
		0, 5, 1,	/* char 56 */ \
		0, 5, 1,	/* char 57 */ \
		1, 2, 3,	/* char 58 */ \
		1, 2, 3,	/* char 59 */ \
		0, 4, 2,	/* char 60 */ \
		0, 5, 1,	/* char 61 */ \
		1, 4, 1,	/* char 62 */ \
		0, 5, 1,	/* char 63 */ \
		0, 5, 1,	/* char 64 */ \
		0, 5, 1,	/* char 65 */ \
		0, 5, 1,	/* char 66 */ \
		0, 5, 1,	/* char 67 */ \
		0, 5, 1,	/* char 68 */ \
		0, 5, 1,	/* char 69 */ \
		0, 5, 1,	/* char 70 */ \
		0, 5, 1,	/* char 71 */ \
		0, 5, 1,	/* char 72 */ \
		1, 3, 2,	/* char 73 */ \
		0, 5, 1,	/* char 74 */ \
		0, 5, 1,	/* char 75 */ \
		0, 5, 1,	/* char 76 */ \
		0, 5, 1,	/* char 77 */ \
		0, 5, 1,	/* char 78 */ \
		0, 5, 1,	/* char 79 */ \
		0, 5, 1,	/* char 80 */ \
		0, 5, 1,	/* char 81 */ \
		0, 5, 1,	/* char 82 */ \
		0, 5, 1,	/* char 83 */ \
		0, 5, 1,	/* char 84 */ \
		0, 5, 1,	/* char 85 */ \
		0, 5, 1,	/* char 86 */ \
		0, 5, 1,	/* char 87 */ \
		0, 5, 1,	/* char 88 */ \
		0, 5, 1,	/* char 89 */ \
		0, 5, 1,	/* char 90 */ \
		1, 3, 2,	/* char 91 */ \
		0, 5, 1,	/* char 92 */ \
		1, 3, 2,	/* char 93 */ \
		0, 5, 1,	/* char 94 */ \
		0, 5, 1,	/* char 95 */ \
		1, 3, 2,	/* char 96 */ \
		0, 5, 1,	/* char 97 */ \
		0, 5, 1,	/* char 98 */ \
		0, 5, 1,	/* char 99 */ \
		0, 5, 1,	/* char 100 */ \
		0, 5, 1,	/* char 101 */ \
		0, 4, 2,	/* char 102 */ \
		0, 5, 1,	/* char 103 */ \
		0, 5, 1,	/* char 104 */ \
		1, 3, 2,	/* char 105 */ \
		0, 4, 2,	/* char 106 */ \
		0, 4, 2,	/* char 107 */ \
		1, 3, 2,	/* char 108 */ \
		0, 5, 1,	/* char 109 */ \
		0, 5, 1,	/* char 110 */ \
		0, 5, 1,	/* char 111 */ \
		0, 5, 1,	/* char 112 */ \
		0, 5, 1,	/* char 113 */ \
		0, 5, 1,	/* char 114 */ \
		0, 5, 1,	/* char 115 */ \
		0, 5, 1,	/* char 116 */ \
		0, 5, 1,	/* char 117 */ \
		0, 5, 1,	/* char 118 */ \
		0, 5, 1,	/* char 119 */ \
		0, 5, 1,	/* char 120 */ \
		0, 5, 1,	/* char 121 */ \
		0, 5, 1,	/* char 122 */ \
		0, 3, 3,	/* char 123 */ \
		2, 1, 3,	/* char 124 */ \
		2, 3, 1,	/* char 125 */ \
		0, 5, 1,	/* char 126 */ \
		0, 7, -7,	/* char 127 */ \
		0, 7, -7,	/* char 128 */ \
		0, 7, -7,	/* char 129 */ \
		0, 7, -7,	/* char 130 */ \
		0, 7, -7,	/* char 131 */ \
		0, 7, -7,	/* char 132 */ \
		0, 5, 1,	/* char 133 */ \
		1, 3, 2,	/* char 134 */ \
		0, 7, -7,	/* char 135 */ \
		0, 5, 1,	/* char 136 */ \
		0, 7, -7,	/* char 137 */ \
		0, 7, -7,	/* char 138 */ \
		1, 2, 3,	/* char 139 */ \
		0, 7, -7,	/* char 140 */ \
		0, 7, -7,	/* char 141 */ \
		0, 7, -7,	/* char 142 */ \
		0, 7, -7,	/* char 143 */ \
		0, 7, -7,	/* char 144 */ \
		1, 2, 3,	/* char 145 */ \
		1, 2, 3,	/* char 146 */ \
		0, 5, 1,	/* char 147 */ \
		0, 5, 1,	/* char 148 */ \
		0, 5, 1,	/* char 149 */ \
		0, 7, -7,	/* char 150 */ \
		0, 7, -7,	/* char 151 */ \
		0, 7, -7,	/* char 152 */ \
		0, 5, 1,	/* char 153 */ \
		0, 7, -7,	/* char 154 */ \
		1, 2, 3,	/* char 155 */ \
		0, 7, -7,	/* char 156 */ \
		0, 7, -7,	/* char 157 */ \
		0, 7, -7,	/* char 158 */ \
		0, 7, -7,	/* char 159 */ \
		0, 7, -7,	/* char 160 */ \
		0, 7, -7,	/* char 161 */ \
		0, 7, -7,	/* char 162 */ \
		0, 7, -7,	/* char 163 */ \
		0, 5, 1,	/* char 164 */ \
		0, 7, -7,	/* char 165 */ \
		2, 1, 3,	/* char 166 */ \
		0, 5, 1,	/* char 167 */ \
		0, 5, 1,	/* char 168 */ \
		0, 5, 1,	/* char 169 */ \
		0, 5, 1,	/* char 170 */ \
		0, 5, 1,	/* char 171 */ \
		0, 5, 1,	/* char 172 */ \
		1, 3, 2,	/* char 173 */ \
		0, 5, 1,	/* char 174 */ \
		0, 7, -7,	/* char 175 */ \
		0, 4, 2,	/* char 176 */ \
		0, 5, 1,	/* char 177 */ \
		0, 7, -7,	/* char 178 */ \
		0, 7, -7,	/* char 179 */ \
		0, 7, -7,	/* char 180 */ \
		0, 5, 1,	/* char 181 */ \
		0, 5, 1,	/* char 182 */ \
		2, 1, 3,	/* char 183 */ \
		0, 5, 1,	/* char 184 */ \
		0, 7, -7,	/* char 185 */ \
		0, 5, 1,	/* char 186 */ \
		0, 5, 1,	/* char 187 */ \
		0, 7, -7,	/* char 188 */ \
		0, 7, -7,	/* char 189 */ \
		0, 7, -7,	/* char 190 */ \
		0, 7, -7,	/* char 191 */ \
		0, 5, 1,	/* char 192 */ \
		0, 5, 1,	/* char 193 */ \
		0, 5, 1,	/* char 194 */ \
		0, 5, 1,	/* char 195 */ \
		0, 5, 1,	/* char 196 */ \
		0, 5, 1,	/* char 197 */ \
		0, 5, 1,	/* char 198 */ \
		0, 5, 1,	/* char 199 */ \
		0, 5, 1,	/* char 200 */ \
		0, 5, 1,	/* char 201 */ \
		0, 5, 1,	/* char 202 */ \
		0, 5, 1,	/* char 203 */ \
		0, 5, 1,	/* char 204 */ \
		0, 5, 1,	/* char 205 */ \
		0, 5, 1,	/* char 206 */ \
		0, 5, 1,	/* char 207 */ \
		0, 5, 1,	/* char 208 */ \
		0, 5, 1,	/* char 209 */ \
		0, 5, 1,	/* char 210 */ \
		0, 5, 1,	/* char 211 */ \
		0, 5, 1,	/* char 212 */ \
		0, 5, 1,	/* char 213 */ \
		0, 5, 1,	/* char 214 */ \
		0, 5, 1,	/* char 215 */ \
		0, 5, 1,	/* char 216 */ \
		0, 5, 1,	/* char 217 */ \
		0, 5, 1,	/* char 218 */ \
		0, 5, 1,	/* char 219 */ \
		0, 5, 1,	/* char 220 */ \
		0, 5, 1,	/* char 221 */ \
		0, 5, 1,	/* char 222 */ \
		0, 5, 1,	/* char 223 */ \
		0, 5, 1,	/* char 224 */ \
		0, 5, 1,	/* char 225 */ \
		0, 5, 1,	/* char 226 */ \
		0, 5, 1,	/* char 227 */ \
		0, 5, 1,	/* char 228 */ \
		0, 5, 1,	/* char 229 */ \
		0, 5, 1,	/* char 230 */ \
		0, 5, 1,	/* char 231 */ \
		0, 5, 1,	/* char 232 */ \
		0, 5, 1,	/* char 233 */ \
		0, 5, 1,	/* char 234 */ \
		0, 5, 1,	/* char 235 */ \
		0, 5, 1,	/* char 236 */ \
		0, 5, 1,	/* char 237 */ \
		0, 5, 1,	/* char 238 */ \
		0, 5, 1,	/* char 239 */ \
		0, 5, 1,	/* char 240 */ \
		0, 5, 1,	/* char 241 */ \
		0, 5, 1,	/* char 242 */ \
		0, 5, 1,	/* char 243 */ \
		0, 5, 1,	/* char 244 */ \
		0, 5, 1,	/* char 245 */ \
		0, 5, 1,	/* char 246 */ \
		0, 5, 1,	/* char 247 */ \
		0, 5, 1,	/* char 248 */ \
		0, 5, 1,	/* char 249 */ \
		0, 5, 1,	/* char 250 */ \
		0, 5, 1,	/* char 251 */ \
		0, 5, 1,	/* char 252 */ \
		0, 5, 1,	/* char 253 */ \
		0, 5, 1,	/* char 254 */ \
		0, 5, 1,	/* char 255 */ \
		226
		)

/datum/language/selestial
    name = "Selestial"
    desc = "A human language of the Romance group, the basis of which is highly modified and transformed French. The largest number of native speakers resides on the Moon, where it is spoken by all the indigenous inhabitants."
    key = "L"
    flags = TONGUELESS_SPEECH
    space_chance = 65
    // слоги взяты из французского
    syllables = list(
        "ai", "an", "ar", "au", "ce", "ch", "co", "de", "em", "en", "er", 
        "es", "et", "eu", "ie", "il", "in", "is", "it", "la", "le", "ma", 
        "me", "ne", "ns", "nt", "on", "ou", "pa", "qu", "ra", "re", "se", 
        "te", "ti", "tr", "ue", "un", "ur", "us", "ve", "om",

        "ain", "ais", "ait", "ans", "ant", "ati", "ava", "ave", "cha", "che", "com", 
        "con", "dan", "des", "ell", "eme", "ent", "est", "eur", "eux", "fai", "ien", 
        "ion", "ire", "les", "lle", "lus", "mai", "men", "nte", "ont", "our", "ous",
        "out", "ouv", "par", "pas", "plu", "pou", "que", "res", "son", "sur", "tai", 
        "tio", "tou", "tre", "une", "ure", "ver", "vou", "éta", 

        "ça", "ço", "çu", "ré", "pé", "fé", "pè", "fê", "mè", "él", "ép", 
        "ét", "êt", "rê", "pî", "ît", "sûr", "dû", "té", "lé", "rè", "où", 
        "tê", "rô", "ân", "îl", "jeû", "ès", "ère", "ème",
    )
    icon_state = "selestial"
    icon = 'tff_modular/modules/selestial_language/selestial.dmi'
    default_priority = 80

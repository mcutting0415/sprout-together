// ─────────────────────────────────────────────────────────────────────────────
// PLANT IMAGE FALLBACKS — Wikipedia verified images
// Every plant in the DB is mapped to a scientifically accurate image from
// Wikimedia Commons. Keys are lowercase plant_name values from Supabase.
// Updated 2026-07-13 with Wikipedia REST API images for all 154 plants.
// ─────────────────────────────────────────────────────────────────────────────

const Map<String, String> kPlantImageFallbacks = {
  'acorn squash': 'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b1/Starr_070730-7820_Cucurbita_pepo.jpg/600px-Starr_070730-7820_Cucurbita_pepo.jpg',
  'alyssum': 'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3b/Alyssum_montanum_ENBLA06.jpg/600px-Alyssum_montanum_ENBLA06.jpg',
  'amaranth': 'https://upload.wikimedia.org/wikipedia/commons/thumb/9/91/Amaranthus_tricolor0.jpg/600px-Amaranthus_tricolor0.jpg',
  'amaranth (grain)': 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/eb/Amaranth_und_WW.jpg/600px-Amaranth_und_WW.jpg',
  'apple': 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a6/Pink_lady_and_cross_section.jpg/600px-Pink_lady_and_cross_section.jpg',
  'artichoke': 'https://upload.wikimedia.org/wikipedia/commons/thumb/6/6d/Artichoke_J1.jpg/600px-Artichoke_J1.jpg',
  'arugula (wild/rocket)': 'https://upload.wikimedia.org/wikipedia/commons/thumb/1/1c/Eruca_sativa_sl11.jpg/600px-Eruca_sativa_sl11.jpg',
  'ashwagandha': 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ad/WithaniaFruit.jpg/600px-WithaniaFruit.jpg',
  'bachelor\'s button': 'https://upload.wikimedia.org/wikipedia/commons/thumb/0/07/Centaurea_cyanus_flower_001.jpg/600px-Centaurea_cyanus_flower_001.jpg',
  'bachelor\'s button / cornflower': 'https://upload.wikimedia.org/wikipedia/commons/thumb/0/07/Centaurea_cyanus_flower_001.jpg/600px-Centaurea_cyanus_flower_001.jpg',
  'banana pepper': 'https://upload.wikimedia.org/wikipedia/commons/thumb/2/24/Banana_Peppers_%28Armenia%29.jpg/600px-Banana_Peppers_%28Armenia%29.jpg',
  'basil': 'https://upload.wikimedia.org/wikipedia/commons/thumb/9/97/Ocimum_basilicum_8zz.jpg/600px-Ocimum_basilicum_8zz.jpg',
  'beefsteak tomato': 'https://upload.wikimedia.org/wikipedia/commons/thumb/8/89/Tomato_je.jpg/600px-Tomato_je.jpg',
  'bell pepper': 'https://upload.wikimedia.org/wikipedia/commons/thumb/8/85/Green-Yellow-Red-Pepper-2009.jpg/600px-Green-Yellow-Red-Pepper-2009.jpg',
  'bitter melon': 'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2f/Momordica_charantia_Blanco2.357.png/600px-Momordica_charantia_Blanco2.357.png',
  'black-eyed susan': 'https://upload.wikimedia.org/wikipedia/commons/thumb/1/1f/Rudbeckia_hirta_kz03.jpg/600px-Rudbeckia_hirta_kz03.jpg',
  'bok choy (baby)': 'https://upload.wikimedia.org/wikipedia/commons/thumb/9/99/Bok_Choy_%2849553125456%29.jpg/600px-Bok_Choy_%2849553125456%29.jpg',
  'borage': 'https://upload.wikimedia.org/wikipedia/commons/thumb/2/26/Borago_officinalis_%282025%29.jpg/600px-Borago_officinalis_%282025%29.jpg',
  'borage (for continuity)': 'https://upload.wikimedia.org/wikipedia/commons/thumb/2/26/Borago_officinalis_%282025%29.jpg/600px-Borago_officinalis_%282025%29.jpg',
  'broccoli': 'https://upload.wikimedia.org/wikipedia/commons/thumb/0/03/Broccoli_and_cross_section_edit.jpg/600px-Broccoli_and_cross_section_edit.jpg',
  'buckwheat (cover crop)': 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a7/Japanese_Buckwheat_Flower.JPG/600px-Japanese_Buckwheat_Flower.JPG',
  'butternut squash': 'https://upload.wikimedia.org/wikipedia/commons/thumb/7/77/Cucurbita_moschata_Butternut_2012_G2.jpg/600px-Cucurbita_moschata_Butternut_2012_G2.jpg',
  'cabbage': 'https://upload.wikimedia.org/wikipedia/commons/thumb/6/6f/Cabbage_and_cross_section_on_white.jpg/600px-Cabbage_and_cross_section_on_white.jpg',
  'calendula (medicinal)': 'https://upload.wikimedia.org/wikipedia/commons/thumb/5/52/Calendula_officinalis%2C_pot_marigold.JPG/600px-Calendula_officinalis%2C_pot_marigold.JPG',
  'carrot': 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a2/Vegetable-Carrot-Bundle-wStalks.jpg/600px-Vegetable-Carrot-Bundle-wStalks.jpg',
  'cauliflower': 'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2f/Chou-fleur_02.jpg/600px-Chou-fleur_02.jpg',
  'cayenne pepper': 'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d2/Capsicum_annuum_-_K%C3%B6hler%E2%80%93s_Medizinal-Pflanzen-027.jpg/600px-Capsicum_annuum_-_K%C3%B6hler%E2%80%93s_Medizinal-Pflanzen-027.jpg',
  'celeriac': 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/ec/C%C3%A9leri-rave-fendu.jpg/600px-C%C3%A9leri-rave-fendu.jpg',
  'chamomile': 'https://upload.wikimedia.org/wikipedia/commons/thumb/2/26/Kamomillasaunio_%28Matricaria_recutita%29.JPG/600px-Kamomillasaunio_%28Matricaria_recutita%29.JPG',
  'chamomile (german)': 'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c8/Matricaria_February_2008-1.jpg/600px-Matricaria_February_2008-1.jpg',
  'chard (swiss chard)': 'https://upload.wikimedia.org/wikipedia/commons/thumb/4/45/Chard_%28Beta_vulgaris_var_cicla%29.jpg/600px-Chard_%28Beta_vulgaris_var_cicla%29.jpg',
  'chickpea / garbanzo bean': 'https://upload.wikimedia.org/wikipedia/commons/thumb/8/89/Chickpea_BNC.jpg/600px-Chickpea_BNC.jpg',
  'chives': 'https://upload.wikimedia.org/wikipedia/commons/thumb/4/49/Allium_schoenoprasum_-_Bombus_lapidarius_-_Tootsi.jpg/600px-Allium_schoenoprasum_-_Bombus_lapidarius_-_Tootsi.jpg',
  'clover (white / dutch)': 'https://upload.wikimedia.org/wikipedia/commons/thumb/5/52/Trifolium_repens_-_white_clover_on_way_from_Govindghat_to_Gangria_at_Valley_of_Flowers_National_Park_-_during_LGFC_-_VOF_2019_%281%29.jpg/600px-Trifolium_repens_-_white_clover_on_way_from_Govindghat_to_Gangria_at_Valley_of_Flowers_National_Park_-_during_LGFC_-_VOF_2019_%281%29.jpg',
  'columbine': 'https://upload.wikimedia.org/wikipedia/commons/thumb/b/bb/Wald-Akelei.JPG/600px-Wald-Akelei.JPG',
  'comfrey': 'https://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/Symphytum_caucasicum_-_Curtis.jpg/600px-Symphytum_caucasicum_-_Curtis.jpg',
  'corn': 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e3/Zea_mays_-_K%C3%B6hler%E2%80%93s_Medizinal-Pflanzen-283.jpg/600px-Zea_mays_-_K%C3%B6hler%E2%80%93s_Medizinal-Pflanzen-283.jpg',
  'cowpea / black-eyed pea': 'https://upload.wikimedia.org/wikipedia/commons/thumb/0/08/Lobia.jpg/600px-Lobia.jpg',
  'crimson clover': 'https://upload.wikimedia.org/wikipedia/commons/thumb/5/5d/Kals_am_Grossglockner_flowers_256.jpg/600px-Kals_am_Grossglockner_flowers_256.jpg',
  'cucumber': 'https://upload.wikimedia.org/wikipedia/commons/thumb/9/96/ARS_cucumber.jpg/600px-ARS_cucumber.jpg',
  'curly parsley': 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e4/Petroselinum.jpg/600px-Petroselinum.jpg',
  'currant (black)': 'https://upload.wikimedia.org/wikipedia/commons/thumb/0/05/Ribes_nigrum_a1.JPG/600px-Ribes_nigrum_a1.JPG',
  'currant (red)': 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a5/Ribes_rubrum_1.jpg/600px-Ribes_rubrum_1.jpg',
  'dahlia': 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ab/Dahlia_x_hybrida.jpg/600px-Dahlia_x_hybrida.jpg',
  'delicata squash': 'https://upload.wikimedia.org/wikipedia/commons/thumb/f/f0/Cucurbita_pepo_Delicata_squash_Green_Mountain_Girls_Farm.jpg/600px-Cucurbita_pepo_Delicata_squash_Green_Mountain_Girls_Farm.jpg',
  'delphinium': 'https://upload.wikimedia.org/wikipedia/commons/thumb/6/6d/Delphinium_elatum_var._palmatifidum_as_Delphinium_intermedium_var._palmatifidum_by_S._A._Drake._Edwards%27s_Botanical_Register_vol._24%2C_t._38_%281838%29.tif/600px-Delphinium_elatum_var._palmatifidum_as_Delphinium_intermedium_var._palmatifidum_by_S._A._Drake._Edwards%27s_Botanical_Register_vol._24%2C_t._38_%281838%29.tif',
  'dill': 'https://upload.wikimedia.org/wikipedia/commons/thumb/4/4b/Illustration_Anethum_graveolens_clean.jpg/600px-Illustration_Anethum_graveolens_clean.jpg',
  'echinacea': 'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b4/EchinaceaPurpureaMaxima1a.UME.JPG/600px-EchinaceaPurpureaMaxima1a.UME.JPG',
  'echinacea (coneflower)': 'https://upload.wikimedia.org/wikipedia/commons/thumb/8/8e/Echinacea_purpurea_Grandview_Prairie.jpg/600px-Echinacea_purpurea_Grandview_Prairie.jpg',
  'echinacea / coneflower (purple)': 'https://upload.wikimedia.org/wikipedia/commons/thumb/8/8e/Echinacea_purpurea_Grandview_Prairie.jpg/600px-Echinacea_purpurea_Grandview_Prairie.jpg',
  'edamame': 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e7/Edamame_by_Zesmerelda_in_Chicago.jpg/600px-Edamame_by_Zesmerelda_in_Chicago.jpg',
  'eggplant': 'https://upload.wikimedia.org/wikipedia/commons/thumb/7/76/Solanum_melongena_24_08_2012_%281%29.JPG/600px-Solanum_melongena_24_08_2012_%281%29.JPG',
  'endive': 'https://upload.wikimedia.org/wikipedia/commons/thumb/0/00/Cichorium_endivia_-_Botanischer_Garten_Mainz_IMG_5453.JPG/600px-Cichorium_endivia_-_Botanischer_Garten_Mainz_IMG_5453.JPG',
  'epazote': 'https://upload.wikimedia.org/wikipedia/commons/thumb/d/df/Dysphania_ambrosioides_NRCS-1_%28cropped%29.jpg/600px-Dysphania_ambrosioides_NRCS-1_%28cropped%29.jpg',
  'fava bean': 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e1/Illustration_Vicia_faba1.jpg/600px-Illustration_Vicia_faba1.jpg',
  'fennel': 'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c0/Foeniculum_July_2011-1a.jpg/600px-Foeniculum_July_2011-1a.jpg',
  'fennel (florence)': 'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c0/Foeniculum_July_2011-1a.jpg/600px-Foeniculum_July_2011-1a.jpg',
  'garlic': 'https://upload.wikimedia.org/wikipedia/commons/3/39/Allium_sativum_Woodwill_1793.jpg',
  'ginger': 'https://upload.wikimedia.org/wikipedia/commons/thumb/1/18/Koeh-146-no_text.jpg/600px-Koeh-146-no_text.jpg',
  'goji berry': 'https://upload.wikimedia.org/wikipedia/commons/thumb/6/62/Lycium_barbarum_-_Wolfberries_China_7-05.jpg/600px-Lycium_barbarum_-_Wolfberries_China_7-05.jpg',
  'grape': 'https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Grapes%2C_Rostov-on-Don%2C_Russia.jpg/600px-Grapes%2C_Rostov-on-Don%2C_Russia.jpg',
  'grape (table)': 'https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Grapes%2C_Rostov-on-Don%2C_Russia.jpg/600px-Grapes%2C_Rostov-on-Don%2C_Russia.jpg',
  'green bean': 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a0/Heaps_of_beans.jpg/600px-Heaps_of_beans.jpg',
  'ground cherry': 'https://upload.wikimedia.org/wikipedia/commons/thumb/4/47/Starr_061225-2955_Physalis_peruviana.jpg/600px-Starr_061225-2955_Physalis_peruviana.jpg',
  'heirloom tomato': 'https://upload.wikimedia.org/wikipedia/commons/thumb/8/89/Tomato_je.jpg/600px-Tomato_je.jpg',
  'holy basil / tulsi': 'https://upload.wikimedia.org/wikipedia/commons/thumb/0/01/Tulsi_or_Tulasi_Holy_basil.jpg/600px-Tulsi_or_Tulasi_Holy_basil.jpg',
  'honeydew': 'https://upload.wikimedia.org/wikipedia/commons/thumb/f/f5/Honeydew.jpg/600px-Honeydew.jpg',
  'hops': 'https://upload.wikimedia.org/wikipedia/commons/thumb/0/08/Humulus_Lupulus_Hopfendolde-mit-hopfengarten.jpg/600px-Humulus_Lupulus_Hopfendolde-mit-hopfengarten.jpg',
  'horseradish': 'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Armoracia_rusticana.jpg/600px-Armoracia_rusticana.jpg',
  'hot pepper': 'https://upload.wikimedia.org/wikipedia/commons/thumb/5/50/Madame_Jeanette_and_other_chillies.jpg/600px-Madame_Jeanette_and_other_chillies.jpg',
  'hot pepper (jalapeño)': 'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d6/Immature_jalapeno_capsicum_annuum_var_annuum.jpeg/600px-Immature_jalapeno_capsicum_annuum_var_annuum.jpeg',
  'hydrangea': 'https://upload.wikimedia.org/wikipedia/commons/thumb/f/fc/Hydrangea_arborescens_139866012.jpg/600px-Hydrangea_arborescens_139866012.jpg',
  'italian parsley': 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e4/Petroselinum.jpg/600px-Petroselinum.jpg',
  'jerusalem artichoke / sunchoke': 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ae/Sunroot_top.jpg/600px-Sunroot_top.jpg',
  'kale': 'https://upload.wikimedia.org/wikipedia/commons/thumb/2/20/Boerenkool.jpg/600px-Boerenkool.jpg',
  'kiwi': 'https://upload.wikimedia.org/wikipedia/commons/thumb/0/0a/Actinidia_fruits.jpg/600px-Actinidia_fruits.jpg',
  'kiwi (hardy)': 'https://upload.wikimedia.org/wikipedia/commons/thumb/1/13/Weiki01.jpg/600px-Weiki01.jpg',
  'lavender': 'https://upload.wikimedia.org/wikipedia/commons/thumb/7/7e/Single_lavender_flower02.jpg/600px-Single_lavender_flower02.jpg',
  'lavender (english)': 'https://upload.wikimedia.org/wikipedia/commons/thumb/4/40/Lavandula_angustifolia_-_K%C3%B6hler%E2%80%93s_Medizinal-Pflanzen-087.jpg/600px-Lavandula_angustifolia_-_K%C3%B6hler%E2%80%93s_Medizinal-Pflanzen-087.jpg',
  'lemon basil': 'https://upload.wikimedia.org/wikipedia/commons/thumb/9/97/Kemangi.jpg/600px-Kemangi.jpg',
  'lemon thyme': 'https://upload.wikimedia.org/wikipedia/commons/thumb/2/29/Starr_070906-8846_Thymus_citriodorus.jpg/600px-Starr_070906-8846_Thymus_citriodorus.jpg',
  'lettuce': 'https://upload.wikimedia.org/wikipedia/commons/thumb/d/da/Iceberg_lettuce_in_SB.jpg/600px-Iceberg_lettuce_in_SB.jpg',
  'lettuce (butterhead)': 'https://upload.wikimedia.org/wikipedia/commons/thumb/d/da/Iceberg_lettuce_in_SB.jpg/600px-Iceberg_lettuce_in_SB.jpg',
  'lima bean': 'https://upload.wikimedia.org/wikipedia/commons/thumb/9/9b/Phaseoulus_lunatus.jpg/600px-Phaseoulus_lunatus.jpg',
  'luffa / loofah': 'https://upload.wikimedia.org/wikipedia/commons/thumb/7/7d/Luffa_aegyptica.jpg/600px-Luffa_aegyptica.jpg',
  'lupine': 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e5/Lupinus_polyphyllus_526960203.jpg/600px-Lupinus_polyphyllus_526960203.jpg',
  'marigold': 'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b0/Tagetes_erecta_chendumalli_chedi.jpg/600px-Tagetes_erecta_chendumalli_chedi.jpg',
  'medicinal aloe vera': 'https://upload.wikimedia.org/wikipedia/commons/thumb/4/4b/Aloe_vera_flower_inset.png/600px-Aloe_vera_flower_inset.png',
  'microgreens mix': 'https://upload.wikimedia.org/wikipedia/commons/thumb/6/67/Liping_Kou_observes_microgreens.jpg/600px-Liping_Kou_observes_microgreens.jpg',
  'mint': 'https://upload.wikimedia.org/wikipedia/commons/thumb/4/4d/Mentha_spicata-IMG_6186.jpg/600px-Mentha_spicata-IMG_6186.jpg',
  'mizuna': 'https://upload.wikimedia.org/wikipedia/commons/thumb/c/cd/Mizuna_001.jpg/600px-Mizuna_001.jpg',
  'moringa': 'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2e/DrumstickFlower.jpg/600px-DrumstickFlower.jpg',
  'mulberry': 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ad/Morus_alba_FrJPG.jpg/600px-Morus_alba_FrJPG.jpg',
  'nasturtium': 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ab/TropaeolumMajusOrange.jpg/600px-TropaeolumMajusOrange.jpg',
  'new zealand spinach': 'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b5/Tetragonia_tetragonioides.jpg/600px-Tetragonia_tetragonioides.jpg',
  'nigella / love-in-a-mist': 'https://upload.wikimedia.org/wikipedia/commons/thumb/1/1f/2007-10-25Nigella_damascena_10.jpg/600px-2007-10-25Nigella_damascena_10.jpg',
  'onion': 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a2/Mixed_onions.jpg/600px-Mixed_onions.jpg',
  'pansy': 'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b8/PansyScan_%28cropped%29.jpg/600px-PansyScan_%28cropped%29.jpg',
  'pansy / viola': 'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c0/Violatricolorarvensis.jpg/600px-Violatricolorarvensis.jpg',
  'parsley': 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e4/Petroselinum.jpg/600px-Petroselinum.jpg',
  'passion fruit': 'https://upload.wikimedia.org/wikipedia/commons/thumb/9/91/Passiflora_edulis_forma_flavicarpa.jpg/600px-Passiflora_edulis_forma_flavicarpa.jpg',
  'passionflower (medicinal)': 'https://upload.wikimedia.org/wikipedia/commons/thumb/9/93/Passiflora_incarnata_fruit.jpg/600px-Passiflora_incarnata_fruit.jpg',
  'pea shoots': 'https://upload.wikimedia.org/wikipedia/commons/thumb/1/11/Peas_in_pods_-_Studio.jpg/600px-Peas_in_pods_-_Studio.jpg',
  'peach': 'https://upload.wikimedia.org/wikipedia/commons/thumb/9/92/Illustration_Prunus_persica_clean_no_descr.jpg/600px-Illustration_Prunus_persica_clean_no_descr.jpg',
  'pear': 'https://upload.wikimedia.org/wikipedia/commons/thumb/c/cf/Pears.jpg/600px-Pears.jpg',
  'peas': 'https://upload.wikimedia.org/wikipedia/commons/thumb/1/11/Peas_in_pods_-_Studio.jpg/600px-Peas_in_pods_-_Studio.jpg',
  'peony': 'https://upload.wikimedia.org/wikipedia/commons/thumb/f/fd/PaeoniaSuffruticosa7.jpg/600px-PaeoniaSuffruticosa7.jpg',
  'persimmon': 'https://upload.wikimedia.org/wikipedia/commons/thumb/7/78/Fuyu_persimmon_fruits%2C_one_cut_open.jpg/600px-Fuyu_persimmon_fruits%2C_one_cut_open.jpg',
  'phacelia': 'https://upload.wikimedia.org/wikipedia/commons/thumb/f/fb/Phacelia_tanacetifolia_7735.JPG/600px-Phacelia_tanacetifolia_7735.JPG',
  'poblano pepper': 'https://upload.wikimedia.org/wikipedia/commons/thumb/f/f6/Poblano_Pepper.jpg/600px-Poblano_Pepper.jpg',
  'potato': 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ab/Patates.jpg/600px-Patates.jpg',
  'pumpkin': 'https://upload.wikimedia.org/wikipedia/commons/thumb/5/5c/FrenchMarketPumpkinsB.jpg/600px-FrenchMarketPumpkinsB.jpg',
  'quince': 'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b5/Pancrace_Bessa00.jpg/600px-Pancrace_Bessa00.jpg',
  'quinoa': 'https://upload.wikimedia.org/wikipedia/commons/thumb/9/96/Reismelde.jpg/600px-Reismelde.jpg',
  'radish microgreens': 'https://upload.wikimedia.org/wikipedia/commons/thumb/0/0c/Radish_3371103037_4ab07db0bf_o.jpg/600px-Radish_3371103037_4ab07db0bf_o.jpg',
  'rhubarb': 'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2b/Rheum_rhabarbarum.2006-04-27.uellue.jpg/600px-Rheum_rhabarbarum.2006-04-27.uellue.jpg',
  'roma tomato': 'https://upload.wikimedia.org/wikipedia/commons/thumb/5/52/TomateTrossRomanaTyp.jpg/600px-TomateTrossRomanaTyp.jpg',
  'romaine lettuce': 'https://upload.wikimedia.org/wikipedia/commons/thumb/5/5c/Starr_070730-7911_Lactuca_sativa.jpg/600px-Starr_070730-7911_Lactuca_sativa.jpg',
  'rosemary': 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a3/Rosemary_in_bloom.JPG/600px-Rosemary_in_bloom.JPG',
  'runner bean': 'https://upload.wikimedia.org/wikipedia/commons/thumb/f/f7/Illustration_Phaseolus_coccineus0.jpg/600px-Illustration_Phaseolus_coccineus0.jpg',
  'rutabaga': 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a7/Rutabaga%2C_variety_nadmorska.JPG/600px-Rutabaga%2C_variety_nadmorska.JPG',
  'sage': 'https://upload.wikimedia.org/wikipedia/commons/thumb/5/5a/Salvia_officinalis0.jpg/600px-Salvia_officinalis0.jpg',
  'serviceberry': 'https://upload.wikimedia.org/wikipedia/commons/thumb/1/16/Amelanchier_grandiflora2.jpg/600px-Amelanchier_grandiflora2.jpg',
  'shallot': 'https://upload.wikimedia.org/wikipedia/commons/thumb/2/22/Shallots_-_sliced_and_whole.jpg/600px-Shallots_-_sliced_and_whole.jpg',
  'shishito pepper': 'https://upload.wikimedia.org/wikipedia/commons/thumb/1/16/Kkwari-gochu.jpg/600px-Kkwari-gochu.jpg',
  'shiso / perilla': 'https://upload.wikimedia.org/wikipedia/commons/thumb/4/46/Perilla_frutescens_in_Gimpo.jpg/600px-Perilla_frutescens_in_Gimpo.jpg',
  'snow pea': 'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b7/Snow_Pea_on_Plant.JPG/600px-Snow_Pea_on_Plant.JPG',
  'spaghetti squash': 'https://upload.wikimedia.org/wikipedia/commons/thumb/1/1e/Starr_070730-7822_Cucurbita_pepo.jpg/600px-Starr_070730-7822_Cucurbita_pepo.jpg',
  'sprouts (broccoli)': 'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Broccoli_sprouts.jpg/600px-Broccoli_sprouts.jpg',
  'stevia (for tea use)': 'https://upload.wikimedia.org/wikipedia/commons/thumb/2/26/Stevia_rebaudiana_flowers.jpg/600px-Stevia_rebaudiana_flowers.jpg',
  'strawberry': 'https://upload.wikimedia.org/wikipedia/commons/thumb/4/4c/Garden_strawberry_%28Fragaria_%C3%97_ananassa%29_single2.jpg/600px-Garden_strawberry_%28Fragaria_%C3%97_ananassa%29_single2.jpg',
  'sugar snap pea': 'https://upload.wikimedia.org/wikipedia/commons/thumb/8/8a/Sugar_Snap_Pea.JPG/600px-Sugar_Snap_Pea.JPG',
  'sunflower': 'https://upload.wikimedia.org/wikipedia/commons/thumb/4/40/Sunflower_sky_backdrop.jpg/600px-Sunflower_sky_backdrop.jpg',
  'sunflower microgreens': 'https://upload.wikimedia.org/wikipedia/commons/thumb/4/40/Sunflower_sky_backdrop.jpg/600px-Sunflower_sky_backdrop.jpg',
  'sweet corn': 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e3/Zea_mays_-_K%C3%B6hler%E2%80%93s_Medizinal-Pflanzen-283.jpg/600px-Zea_mays_-_K%C3%B6hler%E2%80%93s_Medizinal-Pflanzen-283.jpg',
  'swiss chard': 'https://upload.wikimedia.org/wikipedia/commons/thumb/4/45/Chard_%28Beta_vulgaris_var_cicla%29.jpg/600px-Chard_%28Beta_vulgaris_var_cicla%29.jpg',
  'taro': 'https://upload.wikimedia.org/wikipedia/commons/thumb/3/30/Songe-R%C3%A9union.JPG/600px-Songe-R%C3%A9union.JPG',
  'tarragon': 'https://upload.wikimedia.org/wikipedia/commons/thumb/6/6c/Estragon_1511.jpg/600px-Estragon_1511.jpg',
  'tarragon (french)': 'https://upload.wikimedia.org/wikipedia/commons/thumb/6/6c/Estragon_1511.jpg/600px-Estragon_1511.jpg',
  'tatsoi': 'https://upload.wikimedia.org/wikipedia/commons/thumb/6/6c/Brassica_rapa_subsp_narinosa.jpg/600px-Brassica_rapa_subsp_narinosa.jpg',
  'thai basil': 'https://upload.wikimedia.org/wikipedia/commons/thumb/1/1f/Thai_basil.jpg/600px-Thai_basil.jpg',
  'thyme': 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/ea/Thyme-Bundle.jpg/600px-Thyme-Bundle.jpg',
  'tomato': 'https://upload.wikimedia.org/wikipedia/commons/thumb/8/89/Tomato_je.jpg/600px-Tomato_je.jpg',
  'turmeric': 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ab/Turmeric_inflorescence.jpg/600px-Turmeric_inflorescence.jpg',
  'valerian': 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/af/Valeriana_officinalis_inflorescence_-_Niitv%C3%A4lja.jpg/600px-Valeriana_officinalis_inflorescence_-_Niitv%C3%A4lja.jpg',
  'watercress': 'https://upload.wikimedia.org/wikipedia/commons/thumb/d/dd/Watercress_%282%29.JPG/600px-Watercress_%282%29.JPG',
  'wheatgrass': 'https://upload.wikimedia.org/wikipedia/commons/thumb/6/67/Wheatgrass.jpg/600px-Wheatgrass.jpg',
  'winter rye (cover crop)': 'https://upload.wikimedia.org/wikipedia/commons/thumb/7/79/Ear_of_rye.jpg/600px-Ear_of_rye.jpg',
  'winter savory': 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a7/Satureja_montana2.jpg/600px-Satureja_montana2.jpg',
  'winter squash': 'https://upload.wikimedia.org/wikipedia/commons/thumb/b/bd/Squashes.jpg/600px-Squashes.jpg',
  'winter squash (butternut)': 'https://upload.wikimedia.org/wikipedia/commons/thumb/7/77/Cucurbita_moschata_Butternut_2012_G2.jpg/600px-Cucurbita_moschata_Butternut_2012_G2.jpg',
  'yellow squash': 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a6/Cucurbita_pepo_collage_1.png/600px-Cucurbita_pepo_collage_1.png',
  'zucchini': 'https://upload.wikimedia.org/wikipedia/commons/thumb/9/92/CSA-Striped-Zucchini.jpg/600px-CSA-Striped-Zucchini.jpg',
};

/// Returns the best image URL for a plant.
/// Priority: kPlantImageFallbacks (verified correct) > Supabase DB URL.
/// The fallback map is checked first to guarantee correct plant images
/// regardless of what the DB contains.
String? bestPlantImageUrl(String? supabaseUrl, String? plantName) {
  // 1. Check kPlantImageFallbacks first — verified correct image for this plant.
  if (plantName != null && plantName.isNotEmpty) {
    final key = plantName.toLowerCase().trim();
    // Exact match
    if (kPlantImageFallbacks.containsKey(key)) {
      return kPlantImageFallbacks[key];
    }
    // Partial match handles DB variants like "chamomile (german)" -> "chamomile",
    // "arugula (wild/rocket)" -> "arugula", etc.
    // Longest-key-first prevents short keys (e.g. "pea") stealing longer names.
    String? bestMatchUrl;
    int bestMatchLen = 0;
    for (final entry in kPlantImageFallbacks.entries) {
      if ((key.contains(entry.key) || entry.key.contains(key)) &&
          entry.key.length > bestMatchLen) {
        bestMatchUrl = entry.value;
        bestMatchLen = entry.key.length;
      }
    }
    if (bestMatchUrl != null) return bestMatchUrl;
  }

  // 2. Trusted DB URL (Unsplash, Wikimedia, or our own Supabase storage).
  if (supabaseUrl != null &&
      supabaseUrl.isNotEmpty &&
      (supabaseUrl.contains('images.unsplash.com') ||
       supabaseUrl.contains('upload.wikimedia.org') ||
       supabaseUrl.contains('supabase.co/storage'))) {
    return supabaseUrl;
  }

  return null;
}

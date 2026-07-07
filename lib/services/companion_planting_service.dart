/// Companion planting data — which plants help or hurt each other.
class CompanionPlantingService {
  CompanionPlantingService._();
  static final instance = CompanionPlantingService._();

  // Keys are lowercase plant names (partial match friendly)
  // Each entry: { 'good': [...], 'bad': [...], 'tip': '...' }
  static const Map<String, Map<String, dynamic>> _data = {
    'tomato': {
      'good': ['basil', 'parsley', 'carrot', 'marigold', 'borage'],
      'bad': ['fennel', 'cabbage', 'broccoli', 'cauliflower', 'corn'],
      'tip': 'Basil repels aphids and improves flavor. Plant marigolds to deter nematodes.',
    },
    'basil': {
      'good': ['tomato', 'pepper', 'marigold'],
      'bad': ['sage', 'thyme'],
      'tip': 'Basil is a powerful friend to tomatoes — it repels pests and may improve yield.',
    },
    'pepper': {
      'good': ['basil', 'carrot', 'tomato', 'parsley', 'oregano', 'geranium'],
      'bad': ['fennel', 'kohlrabi'],
      'tip': 'Peppers and basil are great neighbors. Geraniums deter budworms. Keep away from fennel.',
    },
    'carrot': {
      'good': ['tomato', 'lettuce', 'onion', 'leek', 'rosemary', 'sage'],
      'bad': ['dill', 'parsnip'],
      'tip': 'Onions and leeks repel carrot fly. Avoid dill — it inhibits carrot growth.',
    },
    'lettuce': {
      'good': ['carrot', 'radish', 'strawberry', 'onion', 'garlic'],
      'bad': ['celery', 'parsley'],
      'tip': 'Radishes act as a trap crop for flea beetles, protecting lettuce.',
    },
    'cucumber': {
      'good': ['bean', 'pea', 'radish', 'sunflower', 'nasturtium'],
      'bad': ['potato', 'sage', 'fennel'],
      'tip': 'Nasturtiums repel aphids and cucumber beetles. Sunflowers provide beneficial shade.',
    },
    'bean': {
      'good': ['carrot', 'corn', 'cucumber', 'squash', 'radish'],
      'bad': ['onion', 'garlic', 'leek', 'fennel'],
      'tip': 'Beans fix nitrogen in the soil, benefiting nearby crops. Keep away from alliums.',
    },
    'corn': {
      'good': ['bean', 'squash', 'cucumber', 'melon'],
      'bad': ['tomato', 'celery'],
      'tip': 'The "Three Sisters" — corn, beans, and squash — work together perfectly.',
    },
    'squash': {
      'good': ['bean', 'corn', 'nasturtium', 'radish'],
      'bad': ['potato'],
      'tip': 'Large squash leaves shade the ground, suppressing weeds for the whole bed.',
    },
    'onion': {
      'good': ['carrot', 'lettuce', 'strawberry', 'tomato', 'chamomile'],
      'bad': ['bean', 'pea', 'asparagus'],
      'tip': 'Onions repel many pests but inhibit legumes. Keep away from beans and peas.',
    },
    'garlic': {
      'good': ['tomato', 'rose', 'carrot', 'apple'],
      'bad': ['bean', 'pea', 'strawberry'],
      'tip': 'Garlic repels aphids, spider mites, and Japanese beetles naturally.',
    },
    'spinach': {
      'good': ['strawberry', 'tomato', 'pea', 'bean'],
      'bad': ['potato'],
      'tip': 'Spinach and strawberries are great companions — spinach acts as a living mulch.',
    },
    'kale': {
      'good': ['beet', 'celery', 'herb', 'onion'],
      'bad': ['tomato', 'strawberry', 'bean'],
      'tip': 'Kale thrives with aromatic herbs nearby that repel cabbage worms.',
    },
    'strawberry': {
      'good': ['lettuce', 'spinach', 'thyme', 'borage'],
      'bad': ['cabbage', 'fennel', 'garlic'],
      'tip': 'Borage deters pests and is said to improve strawberry flavor and yield.',
    },
    'radish': {
      'good': ['cucumber', 'lettuce', 'pea', 'spinach', 'carrot'],
      'bad': ['hyssop'],
      'tip': 'Radishes are a great trap crop, luring aphids away from other plants.',
    },
    'pea': {
      'good': ['carrot', 'radish', 'spinach', 'bean', 'cucumber'],
      'bad': ['onion', 'garlic', 'leek'],
      'tip': 'Peas fix nitrogen, improving soil for neighboring plants.',
    },
    'zucchini': {
      'good': ['bean', 'nasturtium', 'corn'],
      'bad': ['potato', 'fennel'],
      'tip': 'Nasturtiums repel squash bugs — plant them as a border around zucchini.',
    },
    'broccoli': {
      'good': ['onion', 'chamomile', 'beet', 'celery'],
      'bad': ['tomato', 'strawberry', 'pepper'],
      'tip': 'Chamomile improves growth and flavor of broccoli when planted nearby.',
    },
    'mint': {
      'good': ['cabbage', 'tomato', 'pea', 'broccoli', 'kale'],
      'bad': ['chamomile', 'parsley'], // mint can inhibit nearby plants and cross-pollinate
      'tip': 'Mint repels aphids, ants, and flea beetles — but plant in pots to contain it!',
    },
    'marigold': {
      'good': ['tomato', 'pepper', 'squash', 'cucumber', 'bean', 'carrot', 'lettuce'],
      'bad': ['bean', 'cabbage'], // French marigold can inhibit some beans
      'tip': 'Marigolds are the ultimate companion plant — they repel nematodes and many pests.',
    },
    'sunflower': {
      'good': ['cucumber', 'squash', 'corn', 'tomato', 'melon'],
      'bad': ['potato', 'bean', 'fennel'],
      'tip': 'Sunflowers attract pollinators and provide beneficial shade for heat-sensitive crops.',
    },
    'lavender': {
      'good': ['tomato', 'rose', 'vegetable', 'brassica', 'thyme', 'oregano'],
      'bad': ['mint', 'other moisture-loving herbs'], // lavender needs dry conditions unlike wet herbs
      'tip': 'Lavender attracts pollinators and repels fleas, flies, and moths.',
    },
    'rosemary': {
      'good': ['carrot', 'bean', 'cabbage', 'sage', 'broccoli'],
      'bad': ['cucumber', 'pumpkin', 'basil'], // rosemary and basil compete for similar resources
      'tip': 'Rosemary repels cabbage moths, bean beetles, and carrot flies.',
    },
    'thyme': {
      'good': ['tomato', 'eggplant', 'strawberry', 'cabbage', 'broccoli', 'pepper'],
      'bad': ['chive', 'fennel'], // aromatic competition
      'tip': 'Thyme deters cabbage worms and whiteflies. A great general companion.',
    },
    'fennel': {
      'good': ['fennel'], // fennel only likes itself
      'bad': ['tomato', 'pepper', 'cucumber', 'bean', 'kohlrabi', 'carrot'],
      'tip': 'Fennel is allelopathic — keep it isolated. It inhibits most vegetables.',
    },
    'eggplant': {
      'good': ['pepper', 'tomato', 'basil', 'marigold', 'spinach'],
      'bad': ['fennel'],
      'tip': 'Eggplant pairs well with peppers and basil. Marigolds help deter aphids and whiteflies.',
    },
    'cabbage': {
      'good': ['mint', 'rosemary', 'thyme', 'onion', 'beet', 'chamomile', 'dill'],
      'bad': ['tomato', 'strawberry', 'pepper'],
      'tip': 'Aromatic herbs like thyme and rosemary repel cabbage moths. Chamomile improves growth.',
    },
    'potato': {
      'good': ['bean', 'corn', 'horseradish', 'chamomile'],
      'bad': ['tomato', 'squash', 'sunflower', 'cucumber', 'pumpkin', 'fennel'],
      'tip': 'Horseradish planted at the corners of a potato bed deters Colorado potato beetles.',
    },
    'cauliflower': {
      'good': ['onion', 'chamomile', 'beet', 'celery', 'dill'],
      'bad': ['tomato', 'strawberry', 'pepper'],
      'tip': 'Chamomile and dill attract beneficial insects that help control cauliflower pests.',
    },
    'beet': {
      'good': ['onion', 'lettuce', 'kale', 'broccoli', 'chard', 'garlic'],
      'bad': ['pole bean', 'field mustard'],
      'tip': 'Beets and onions make excellent neighbors — they share space well without competing.',
    },
    'celery': {
      'good': ['tomato', 'dill', 'bean', 'leek', 'spinach', 'broccoli'],
      'bad': ['corn', 'potato', 'parsley'],
      'tip': 'Celery deters white cabbage moths and is a great neighbor for tomatoes and beans.',
    },
    'leek': {
      'good': ['carrot', 'celery', 'onion', 'beet'],
      'bad': ['bean', 'pea', 'legume'],
      'tip': 'Leeks and carrots are mutually beneficial — they repel each other\'s key pests.',
    },
    'chard': {
      'good': ['bean', 'onion', 'kale', 'lettuce'],
      'bad': ['beet'],
      'tip': 'Swiss chard does well with most vegetables. Keep it away from beets as they compete.',
    },
    'arugula': {
      'good': ['lettuce', 'spinach', 'cucumber', 'radish', 'carrot', 'beet'],
      'bad': ['fennel', 'hyssop'],
      'tip': 'Arugula is a good cool-season companion. It bolts quickly so plant in rounds.',
    },
    'turnip': {
      'good': ['pea', 'onion', 'bean', 'lettuce', 'spinach'],
      'bad': ['tomato', 'potato', 'fennel'],
      'tip': 'Turnips grow quickly and make efficient use of space alongside slow-growing vegetables.',
    },
    'kohlrabi': {
      'good': ['beet', 'onion', 'cucumber'],
      'bad': ['tomato', 'pepper', 'strawberry', 'fennel'],
      'tip': 'Kohlrabi gets along with root vegetables and onions but conflicts with nightshades.',
    },
    'sweet potato': {
      'good': ['bean', 'beet', 'thyme'],
      'bad': ['squash', 'okra'],
      'tip': 'Sweet potatoes fix nitrogen and grow well with beans. Their spreading vines shade out weeds.',
    },
    'pumpkin': {
      'good': ['corn', 'bean', 'nasturtium', 'radish'],
      'bad': ['potato', 'fennel'],
      'tip': 'Pumpkins are part of the traditional "Three Sisters" planting with corn and beans.',
    },
    'watermelon': {
      'good': ['nasturtium', 'radish', 'marigold', 'corn'],
      'bad': ['potato', 'fennel'],
      'tip': 'Nasturtiums repel aphids and cucumber beetles that also target watermelon.',
    },
    'cantaloupe': {
      'good': ['nasturtium', 'radish', 'corn', 'marigold'],
      'bad': ['potato', 'fennel'],
      'tip': 'Cantaloupes benefit from the same companions as cucumbers and other melons.',
    },
    'asparagus': {
      'good': ['tomato', 'parsley', 'basil', 'marigold'],
      'bad': ['onion', 'garlic', 'potato'],
      'tip': 'Tomatoes and asparagus are excellent long-term companions — both benefit from the pairing.',
    },
    'okra': {
      'good': ['pepper', 'eggplant', 'basil', 'sunflower', 'cucumber'],
      'bad': ['sweet potato'],
      'tip': 'Okra and sunflowers both love heat and grow well together, with sunflowers providing support.',
    },
    'dill': {
      'good': ['cabbage', 'lettuce', 'onion', 'broccoli', 'cucumber'],
      'bad': ['carrot', 'tomato', 'fennel'],
      'tip': 'Dill attracts beneficial wasps and hoverflies. Avoid planting near carrot — they cross-pollinate.',
    },
    'cilantro': {
      'good': ['tomato', 'spinach', 'bean', 'anise'],
      'bad': ['fennel'],
      'tip': 'Cilantro attracts beneficial insects when it flowers. Let some bolt to seed for free plants.',
    },
    'parsley': {
      'good': ['tomato', 'carrot', 'asparagus', 'rose'],
      'bad': ['onion', 'garlic', 'celery'],
      'tip': 'Parsley attracts predatory wasps that control aphids. It is a great neighbor for tomatoes.',
    },
    'oregano': {
      'good': ['tomato', 'pepper', 'squash', 'broccoli', 'cucumber', 'eggplant', 'cabbage'],
      'bad': ['fennel', 'mint'],
      'tip': 'Oregano is a broadly beneficial herb — it repels many pests and attracts pollinators.',
    },
    'sage': {
      'good': ['carrot', 'cabbage', 'broccoli', 'strawberry', 'rosemary'],
      'bad': ['cucumber', 'onion', 'fennel'],
      'tip': 'Sage deters cabbage moths and carrot flies. It pairs well with rosemary in an herb bed.',
    },
    'chive': {
      'good': ['carrot', 'tomato', 'apple', 'rose'],
      'bad': ['bean', 'pea'],
      'tip': 'Chives repel aphids and Japanese beetles. They are one of the best companions for carrots.',
    },
    'chamomile': {
      'good': ['brassica', 'onion', 'cucumber', 'broccoli', 'cabbage', 'carrot', 'wheat'],
      'bad': ['mint', 'fennel'],
      'tip': 'Chamomile is the "physician of the garden" — it improves the health and flavor of nearby plants.',
    },
    'nasturtium': {
      'good': ['cucumber', 'squash', 'bean', 'broccoli', 'cabbage', 'tomato', 'radish'],
      'bad': ['fennel', 'cauliflower'], // fennel inhibits most plants; cauliflower stunts nasturtiums
      'tip': 'Nasturtiums act as a trap crop for aphids and repel squash bugs and whiteflies.',
    },
    'zinnia': {
      'good': ['tomato', 'pepper', 'cucumber', 'melon', 'squash'],
      'bad': ['fennel'], // fennel inhibits most plants
      'tip': 'Zinnias attract butterflies, hummingbirds, and predatory wasps that control garden pests.',
    },
    'echinacea': {
      'good': ['wildflower', 'lavender', 'sage', 'bee balm', 'yarrow'],
      'bad': ['fennel', 'black walnut'],
      'tip': 'Echinacea (coneflower) is a pollinator magnet that supports the entire garden ecosystem.',
    },
    'lemon balm': {
      'good': ['tomato', 'squash', 'pumpkin', 'cucumber', 'melon'],
      'bad': ['fennel'],
      'tip': 'Lemon balm attracts bees and beneficial insects, improving pollination throughout the garden.',
    },
    'blueberry': {
      'good': ['strawberry', 'thyme', 'lavender', 'basil'],
      'bad': ['fennel', 'nightshade'],
      'tip': 'Blueberries need acidic soil. Thyme as a groundcover helps retain moisture and deter pests.',
    },
    'raspberry': {
      'good': ['garlic', 'lavender', 'marigold'],
      'bad': ['blackberry', 'fennel', 'nightshade'],
      'tip': 'Garlic planted near raspberries deters Japanese beetles and aphids naturally.',
    },
    'artichoke': {
      'good': ['sunflower', 'tarragon', 'tomato', 'basil'],
      'bad': ['potato', 'fennel', 'bean'],
      'tip': 'Artichokes are mostly standalone plants but benefit from sunflowers nearby for pollination.',
    },
    'rose': {
      'good': ['garlic', 'chive', 'parsley', 'lavender', 'marigold', 'geranium'],
      'bad': ['fennel'],
      'tip': 'Garlic and chives planted near roses repel aphids and black spot naturally. Marigolds keep pests at bay.',
    },
    'borage': {
      'good': ['tomato', 'squash', 'strawberry', 'cucumber', 'bean', 'pepper'],
      'bad': ['fennel', 'brassica'], // borage can self-seed aggressively and crowd brassicas
      'tip': 'Borage deters tomato hornworms and cabbage worms. It also improves the flavor of nearby tomatoes and strawberries.',
    },
    'horseradish': {
      'good': ['potato', 'fruit tree', 'rhubarb', 'sweet potato'],
      'bad': ['brassica', 'bean', 'pea'], // horseradish root secretions inhibit these crops
      'tip': 'Horseradish planted at potato bed corners deters Colorado potato beetles. Its volatile oils protect the whole area.',
    },
    'anise': {
      'good': ['cilantro', 'coriander', 'bean', 'brassica'],
      'bad': ['carrot', 'dill'],
      'tip': 'Anise attracts beneficial predatory wasps and repels aphids. It cross-pollinates with dill and carrot so keep them apart.',
    },
    'tarragon': {
      'good': ['eggplant', 'pepper', 'tomato', 'most vegetables', 'squash', 'cucumber'],
      'bad': ['fennel', 'dill'], // cross-pollination concerns with related herbs
      'tip': 'Tarragon is called the "friend of all vegetables" — it enhances flavor and repels many common pests.',
    },
    'geranium': {
      'good': ['rose', 'grape', 'corn', 'pepper', 'tomato'],
      'bad': ['fennel', 'potato'],
      'tip': 'Geraniums repel Japanese beetles, tobacco budworms, and spider mites. Great near roses and grape vines.',
    },
    'hyssop': {
      'good': ['cabbage', 'grape', 'broccoli', 'bean', 'cucumber'],
      'bad': ['radish', 'fennel'],
      'tip': 'Hyssop deters cabbage moths and flea beetles. Keep it away from radishes — they inhibit each other.',
    },
    'lemon grass': {
      'good': ['tomato', 'pepper', 'basil', 'cucumber', 'squash'],
      'bad': ['fennel', 'mint'],
      'tip': 'Lemon grass repels mosquitoes and many garden pests with its citronella oils.',
    },
    'bok choy': {
      'good': ['onion', 'beet', 'celery', 'chamomile'],
      'bad': ['tomato', 'strawberry', 'pepper'],
      'tip': 'Bok choy is a brassica and benefits from the same companions — onions and aromatic herbs deter its main pests.',
    },
    'collard': {
      'good': ['onion', 'chamomile', 'beet', 'celery'],
      'bad': ['tomato', 'strawberry', 'pepper'],
      'tip': 'Collards are brassicas — aromatic herbs nearby help repel cabbage moths and whiteflies.',
    },
    'mustard': {
      'good': ['grape', 'bean', 'brassica'],
      'bad': ['beet'],
      'tip': 'Mustard acts as a trap crop for aphids. Let it flower to attract beneficial insects throughout the garden.',
    },
    'melon': {
      'good': ['nasturtium', 'radish', 'corn', 'marigold'],
      'bad': ['potato', 'fennel'],
      'tip': 'Nasturtiums repel aphids and cucumber beetles that target melons. Corn provides windbreak and support.',
    },

    // ── New additions ────────────────────────────────────────────────────────
    'asparagus': {
      'good': ['tomato', 'parsley', 'basil', 'marigold', 'nasturtium'],
      'bad': ['onion', 'garlic', 'potato', 'fennel'],
      'tip': 'Tomatoes and asparagus are excellent long-term companions — both benefit from the pairing.',
    },
    'blueberry': {
      'good': ['strawberry', 'thyme', 'lavender', 'basil', 'azalea'],
      'bad': ['fennel', 'nightshade', 'tomato', 'pepper'],
      'tip': 'Blueberries need acidic soil. Thyme as a groundcover helps retain moisture and deter pests.',
    },
    'broccoli': {
      'good': ['onion', 'chamomile', 'beet', 'celery', 'dill', 'rosemary', 'thyme'],
      'bad': ['tomato', 'strawberry', 'pepper', 'bean', 'mustard'],
      'tip': 'Chamomile improves growth and flavor of broccoli when planted nearby.',
    },
    'cabbage': {
      'good': ['mint', 'rosemary', 'thyme', 'onion', 'beet', 'chamomile', 'dill'],
      'bad': ['tomato', 'strawberry', 'pepper', 'fennel', 'bean'],
      'tip': 'Aromatic herbs like thyme and rosemary repel cabbage moths. Chamomile improves growth.',
    },
    'corn': {
      'good': ['bean', 'squash', 'cucumber', 'pumpkin', 'melon', 'sunflower'],
      'bad': ['tomato', 'celery', 'fennel'],
      'tip': 'The "Three Sisters" — corn, beans, and squash — work together perfectly.',
    },
    'dill': {
      'good': ['cabbage', 'lettuce', 'onion', 'broccoli', 'cucumber', 'asparagus'],
      'bad': ['carrot', 'tomato', 'fennel', 'pepper'],
      'tip': 'Dill attracts beneficial wasps and hoverflies. Avoid planting near carrot — they cross-pollinate.',
    },
    'eggplant': {
      'good': ['pepper', 'tomato', 'basil', 'marigold', 'spinach', 'thyme'],
      'bad': ['fennel', 'potato', 'corn'],
      'tip': 'Eggplant pairs well with peppers and basil. Marigolds help deter aphids and whiteflies.',
    },
    'hot pepper': {
      'good': ['basil', 'carrot', 'tomato', 'parsley', 'oregano', 'marigold'],
      'bad': ['fennel', 'kohlrabi', 'brassica'],
      'tip': 'Hot peppers benefit from the same companions as sweet peppers. Marigolds deter nematodes.',
    },
    'lavender': {
      'good': ['tomato', 'rose', 'brassica', 'thyme', 'oregano', 'sage'],
      'bad': ['mint', 'basil', 'camint'],
      'tip': 'Lavender attracts pollinators and repels fleas, flies, and moths.',
    },
    'oregano': {
      'good': ['tomato', 'pepper', 'squash', 'broccoli', 'cucumber', 'eggplant'],
      'bad': ['fennel', 'mint'],
      'tip': 'Oregano is a broadly beneficial herb — it repels many pests and attracts pollinators.',
    },
    'potato': {
      'good': ['bean', 'corn', 'horseradish', 'chamomile', 'marigold', 'nasturtium'],
      'bad': ['tomato', 'squash', 'sunflower', 'cucumber', 'pumpkin', 'fennel', 'rosemary'],
      'tip': 'Horseradish planted at the corners of a potato bed deters Colorado potato beetles.',
    },
    'sage': {
      'good': ['carrot', 'cabbage', 'broccoli', 'strawberry', 'rosemary', 'bean'],
      'bad': ['cucumber', 'onion', 'fennel', 'basil'],
      'tip': 'Sage deters cabbage moths and carrot flies. It pairs well with rosemary in an herb bed.',
    },
    'sweet potato': {
      'good': ['bean', 'beet', 'thyme', 'lavender', 'oregano'],
      'bad': ['squash', 'potato', 'fennel'],
      'tip': 'Sweet potatoes fix nitrogen and grow well with beans. Their spreading vines shade out weeds.',
    },
  };

  // Common name aliases → canonical key in _data
  static const Map<String, String> _aliases = {
    'chives': 'chive',
    'shallot': 'onion',
    'scallion': 'onion',
    'green onion': 'onion',
    'spring onion': 'onion',
    'tomatillo': 'tomato',
    'ground cherry': 'tomato',
    'hot pepper': 'pepper',
    'chili': 'pepper',
    'chilli': 'pepper',
    'jalapeño': 'pepper',
    'jalapeno': 'pepper',
    'banana pepper': 'pepper',
    'bell pepper': 'pepper',
    'sweet pepper': 'pepper',
    'chile': 'pepper',
    'habanero': 'pepper',
    'serrano': 'pepper',
    'cayenne': 'pepper',
    'sweet corn': 'corn',
    'popcorn': 'corn',
    'swiss chard': 'chard',
    'silverbeet': 'chard',
    'collard greens': 'collard',
    'collards': 'collard',
    'gai lan': 'bok choy',
    'pak choi': 'bok choy',
    'pak choy': 'bok choy',
    'snap pea': 'pea',
    'snow pea': 'pea',
    'sugar snap pea': 'pea',
    'edamame': 'bean',
    'soybean': 'bean',
    'fava bean': 'bean',
    'lima bean': 'bean',
    'bush bean': 'bean',
    'pole bean': 'bean',
    'green bean': 'bean',
    'snap bean': 'bean',
    'runner bean': 'bean',
    'broad bean': 'bean',
    'butternut squash': 'squash',
    'acorn squash': 'squash',
    'delicata squash': 'squash',
    'spaghetti squash': 'squash',
    'summer squash': 'squash',
    'patty pan': 'squash',
    'crookneck squash': 'squash',
    'romaine': 'lettuce',
    'romaine lettuce': 'lettuce',
    'butter lettuce': 'lettuce',
    'iceberg lettuce': 'lettuce',
    'leaf lettuce': 'lettuce',
    'head lettuce': 'lettuce',
    'bibb lettuce': 'lettuce',
    'butterhead lettuce': 'lettuce',
    'celeriac': 'celery',
    'celery root': 'celery',
    'parsnip': 'carrot',
    'rutabaga': 'turnip',
    'swede': 'turnip',
    'endive': 'lettuce',
    'escarole': 'lettuce',
    'frisee': 'lettuce',
    'radicchio': 'lettuce',
    'mache': 'lettuce',
    'corn salad': 'lettuce',
    'sorrel': 'chard',
    'rhubarb': 'chard',
    'watercress': 'arugula',
    'lemongrass': 'lemon grass',
    'lemon verbena': 'lemon balm',
    'sweet basil': 'basil',
    'thai basil': 'basil',
    'holy basil': 'basil',
    'italian basil': 'basil',
    'genovese basil': 'basil',
    'spearmint': 'mint',
    'peppermint': 'mint',
    'apple mint': 'mint',
    'chocolate mint': 'mint',
    'flat leaf parsley': 'parsley',
    'curly parsley': 'parsley',
    'italian parsley': 'parsley',
    'english lavender': 'lavender',
    'french lavender': 'lavender',
    'common thyme': 'thyme',
    'lemon thyme': 'thyme',
    'french thyme': 'thyme',
    'english rosemary': 'rosemary',
    'common sage': 'sage',
    'garden sage': 'sage',
    'purple sage': 'sage',
    'common oregano': 'oregano',
    'greek oregano': 'oregano',
    'italian oregano': 'oregano',
    'common chamomile': 'chamomile',
    'german chamomile': 'chamomile',
    'roman chamomile': 'chamomile',
    'common dill': 'dill',
    'dill weed': 'dill',
    'coriander': 'cilantro',
    'chinese parsley': 'cilantro',
    'common fennel': 'fennel',
    'florence fennel': 'fennel',
    'bulb fennel': 'fennel',
    'common borage': 'borage',
    'starflower': 'borage',
    'pot marigold': 'marigold',
    'french marigold': 'marigold',
    'african marigold': 'marigold',
    'calendula': 'marigold',
    'common nasturtium': 'nasturtium',
    'garden nasturtium': 'nasturtium',
    'garden zinnia': 'zinnia',
    'common zinnia': 'zinnia',
    'common echinacea': 'echinacea',
    'coneflower': 'echinacea',
    'purple coneflower': 'echinacea',
    'common sunflower': 'sunflower',
    'russian sunflower': 'sunflower',
    'artichoke': 'artichoke',
    'globe artichoke': 'artichoke',
    'jerusalem artichoke': 'artichoke',
    'sunchoke': 'artichoke',
    'cherry tomato': 'tomato',
    'grape tomato': 'tomato',
    'roma tomato': 'tomato',
    'beefsteak tomato': 'tomato',
    'heirloom tomato': 'tomato',
    'plum tomato': 'tomato',
    'cocktail tomato': 'tomato',
    'garden tomato': 'tomato',
    'black krim': 'tomato',
    'mortgage lifter': 'tomato',
    'japanese eggplant': 'eggplant',
    'italian eggplant': 'eggplant',
    'chinese eggplant': 'eggplant',
    'thai eggplant': 'eggplant',
    'aubergine': 'eggplant',
    'brinjal': 'eggplant',
    'yellow onion': 'onion',
    'red onion': 'onion',
    'white onion': 'onion',
    'vidalia onion': 'onion',
    'sweet onion': 'onion',
    'walla walla onion': 'onion',
    'elephant garlic': 'garlic',
    'softneck garlic': 'garlic',
    'hardneck garlic': 'garlic',
    'nantes carrot': 'carrot',
    'baby carrot': 'carrot',
    'chantenay carrot': 'carrot',
    'danvers carrot': 'carrot',
    'purple carrot': 'carrot',
    'rainbow carrot': 'carrot',
    'red radish': 'radish',
    'daikon': 'radish',
    'daikon radish': 'radish',
    'white radish': 'radish',
    'french breakfast radish': 'radish',
    'sugar beet': 'beet',
    'red beet': 'beet',
    'golden beet': 'beet',
    'chioggia beet': 'beet',
    'baby beet': 'beet',
    'red cabbage': 'cabbage',
    'green cabbage': 'cabbage',
    'savoy cabbage': 'cabbage',
    'napa cabbage': 'cabbage',
    'chinese cabbage': 'cabbage',
    'baby kale': 'kale',
    'dinosaur kale': 'kale',
    'lacinato kale': 'kale',
    'russian kale': 'kale',
    'curly kale': 'kale',
    'red kale': 'kale',
    'winter squash': 'squash',
    'honeynut squash': 'squash',
    'kabocha squash': 'squash',
    'sugar pumpkin': 'pumpkin',
    'jack o lantern': 'pumpkin',
    'giant pumpkin': 'pumpkin',
    'pie pumpkin': 'pumpkin',
    'kentucky wonder bean': 'bean',
    'blue lake bean': 'bean',
    'yellow wax bean': 'bean',
    'sugar snap': 'pea',
    'garden pea': 'pea',
    'shelling pea': 'pea',
    'english pea': 'pea',
    'honeydew': 'cantaloupe',
    'honeydew melon': 'cantaloupe',
    'galia melon': 'cantaloupe',
    'canary melon': 'cantaloupe',
    'casaba melon': 'cantaloupe',
    'seedless watermelon': 'watermelon',
    'sugar baby watermelon': 'watermelon',
    'crimson sweet watermelon': 'watermelon',
    'thompson seedless grape': 'blueberry',
    'concord grape': 'blueberry',
    'wine grape': 'blueberry',
    'highbush blueberry': 'blueberry',
    'lowbush blueberry': 'blueberry',
    'wild blueberry': 'blueberry',
    'black raspberry': 'raspberry',
    'golden raspberry': 'raspberry',
    'heritage raspberry': 'raspberry',
    'june-bearing strawberry': 'strawberry',
    'everbearing strawberry': 'strawberry',
    'wild strawberry': 'strawberry',
    'alpine strawberry': 'strawberry',
  };

  /// Find companion data for a plant by name (fuzzy match with aliases).
  Map<String, dynamic>? findCompanions(String plantName) {
    final lower = plantName.toLowerCase().trim();
    // 1. Exact match
    if (_data.containsKey(lower)) return _data[lower];
    // 2. Alias match
    if (_aliases.containsKey(lower)) return _data[_aliases[lower]!];
    // 3. Word-level exact match (e.g. "Sweet Basil" → "basil")
    final words = lower.split(RegExp(r'[\s\-/,]+'));
    for (final word in words) {
      if (word.length >= 4 && _data.containsKey(word)) return _data[word];
      if (word.length >= 4 && _aliases.containsKey(word)) return _data[_aliases[word]!];
    }
    // 4. Substring match (original behavior)
    for (final key in _data.keys) {
      if (lower.contains(key) || key.contains(lower)) return _data[key];
    }
    return null;
  }

  /// Cross-check two plants: returns 'good', 'bad', or 'neutral'.
  String relationship(String plant1, String plant2) {
    final d = findCompanions(plant1.toLowerCase());
    if (d == null) return 'neutral';
    final lower2 = plant2.toLowerCase();
    final good = (d['good'] as List).cast<String>();
    final bad = (d['bad'] as List).cast<String>();
    if (good.any((g) => lower2.contains(g) || g.contains(lower2))) return 'good';
    if (bad.any((b) => lower2.contains(b) || b.contains(lower2))) return 'bad';
    return 'neutral';
  }
}

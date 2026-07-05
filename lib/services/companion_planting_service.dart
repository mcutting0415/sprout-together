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
      'good': ['basil', 'carrot', 'tomato', 'parsley'],
      'bad': ['fennel', 'kohlrabi'],
      'tip': 'Peppers and basil are great neighbors — both benefit in taste and pest resistance.',
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
      'good': ['cabbage', 'tomato', 'pea'],
      'bad': [], // Mint can become invasive — isolate it
      'tip': 'Mint repels aphids, ants, and flea beetles — but plant in pots to contain it!',
    },
    'marigold': {
      'good': ['tomato', 'pepper', 'squash', 'cucumber', 'bean'],
      'bad': [],
      'tip': 'Marigolds are the ultimate companion plant — they repel nematodes and many pests.',
    },
    'sunflower': {
      'good': ['cucumber', 'squash', 'corn'],
      'bad': ['potato', 'bean'],
      'tip': 'Sunflowers attract pollinators and provide beneficial shade for heat-sensitive crops.',
    },
    'lavender': {
      'good': ['tomato', 'rose', 'vegetable'],
      'bad': [],
      'tip': 'Lavender attracts pollinators and repels fleas, flies, and moths.',
    },
    'rosemary': {
      'good': ['carrot', 'bean', 'cabbage', 'sage'],
      'bad': [],
      'tip': 'Rosemary repels cabbage moths, bean beetles, and carrot flies.',
    },
    'thyme': {
      'good': ['tomato', 'eggplant', 'strawberry', 'cabbage'],
      'bad': [],
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
      'good': ['lettuce', 'spinach', 'cucumber', 'radish'],
      'bad': [],
      'tip': 'Arugula is a good cool-season companion. It bolts quickly so plant in rounds.',
    },
    'turnip': {
      'good': ['pea', 'onion', 'bean'],
      'bad': [],
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
      'good': ['tomato', 'pepper', 'squash', 'broccoli', 'cucumber'],
      'bad': [],
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
      'good': ['brassica', 'onion', 'cucumber', 'broccoli', 'cabbage'],
      'bad': [],
      'tip': 'Chamomile is the "physician of the garden" — it improves the health and flavor of nearby plants.',
    },
    'nasturtium': {
      'good': ['cucumber', 'squash', 'bean', 'broccoli', 'cabbage', 'tomato'],
      'bad': [],
      'tip': 'Nasturtiums act as a trap crop for aphids and repel squash bugs and whiteflies.',
    },
    'zinnia': {
      'good': ['tomato', 'pepper', 'cucumber'],
      'bad': [],
      'tip': 'Zinnias attract butterflies, hummingbirds, and predatory wasps that control garden pests.',
    },
    'echinacea': {
      'good': ['wildflower', 'lavender', 'sage'],
      'bad': [],
      'tip': 'Echinacea (coneflower) is a pollinator magnet that supports the entire garden ecosystem.',
    },
    'lemon balm': {
      'good': ['tomato', 'squash', 'pumpkin'],
      'bad': [],
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
      'good': ['sunflower', 'tarragon'],
      'bad': [],
      'tip': 'Artichokes are mostly standalone plants but benefit from sunflowers nearby for pollination.',
    },
  };

  /// Find companion data for a plant by name (fuzzy match).
  Map<String, dynamic>? findCompanions(String plantName) {
    final lower = plantName.toLowerCase();
    // Exact match first
    if (_data.containsKey(lower)) return _data[lower];
    // Partial match
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

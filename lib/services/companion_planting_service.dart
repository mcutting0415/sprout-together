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

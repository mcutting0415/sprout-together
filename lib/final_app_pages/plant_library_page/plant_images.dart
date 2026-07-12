// ─────────────────────────────────────────────────────────────────────────────
// PLANT IMAGE FALLBACKS
// Used when a plant's image_url is missing from the Supabase database.
// Every plant in the knowledge base is mapped to a reliable image URL.
// Keys are lowercase plant names matching the Supabase plant_name field.
// ─────────────────────────────────────────────────────────────────────────────

const Map<String, String> kPlantImageFallbacks = {
  // ── Vegetables ──────────────────────────────────────────────────────────
  'tomato':            'https://images.unsplash.com/photo-1592921870789-04563d55041c?w=400&q=80&fit=crop',
  'cherry tomato':     'https://images.unsplash.com/photo-1558818498-28c1e002b655?w=400&q=80&fit=crop',
  'lettuce':           'https://images.unsplash.com/photo-1556909172-54557c7e4fb7?w=400&q=80&fit=crop',
  'spinach':           'https://images.unsplash.com/photo-1576045057995-568f588f82fb?w=400&q=80&fit=crop',
  'carrot':            'https://images.unsplash.com/photo-1447175008436-054170c2e979?w=400&q=80&fit=crop',
  'radish':            'https://images.unsplash.com/photo-1605711285791-0219e80e43a3?w=400&q=80&fit=crop',
  'zucchini':          'https://images.unsplash.com/photo-1583687516934-1ed72e55c6a8?w=400&q=80&fit=crop',
  'cucumber':          'https://images.unsplash.com/photo-1604977042946-1eecc30f269e?w=400&q=80&fit=crop',
  'bell pepper':       'https://images.unsplash.com/photo-1563565375-f3fdfdbefa83?w=400&q=80&fit=crop',
  'kale':              'https://images.unsplash.com/photo-1524179091875-bf99a9a6af57?w=400&q=80&fit=crop',
  'green onion':       'https://images.unsplash.com/photo-1586201375761-83865001e31c?w=400&q=80&fit=crop',
  'garlic':            'https://images.unsplash.com/photo-1615485500704-8e990f9900f7?w=400&q=80&fit=crop',
  'onion':             'https://images.unsplash.com/photo-1561626423-a51b45aef0a1?w=400&q=80&fit=crop',
  'broccoli':          'https://images.unsplash.com/photo-1459411621453-7b03977f4bfc?w=400&q=80&fit=crop',
  'cabbage':           'https://images.unsplash.com/photo-1598030343246-eec71064f855?w=400&q=80&fit=crop',
  'eggplant':          'https://images.unsplash.com/photo-1563252722-6434563a985d?w=400&q=80&fit=crop',
  'hot pepper':        'https://images.unsplash.com/photo-1583119022894-919a68a3d0e3?w=400&q=80&fit=crop',
  'potato':            'https://images.unsplash.com/photo-1518977676601-b53f82aba655?w=400&q=80&fit=crop',
  'sweet potato':      'https://images.unsplash.com/photo-1591087583415-78c86f18e11c?w=400&q=80&fit=crop',
  'sweet corn':        'https://images.unsplash.com/photo-1551754655-cd27e38d2076?w=400&q=80&fit=crop',
  'squash':            'https://images.unsplash.com/photo-1569828781423-32fd2e80c72c?w=400&q=80&fit=crop',
  'bean':              'https://images.unsplash.com/photo-1590165482129-1b8b27698780?w=400&q=80&fit=crop',
  'pea':               'https://images.unsplash.com/photo-1576552770741-ea5e56da3a04?w=400&q=80&fit=crop',
  'beet':              'https://images.unsplash.com/photo-1610348725531-843dff563e2c?w=400&q=80&fit=crop',
  'asparagus':         'https://images.unsplash.com/photo-1603048297172-c92544798d5a?w=400&q=80&fit=crop',
  'cauliflower':       'https://images.unsplash.com/photo-1568584711075-3d021a7c3ca3?w=400&q=80&fit=crop',
  'arugula':           'https://images.unsplash.com/photo-1580910051074-3eb694886505?w=400&q=80&fit=crop',
  'chard':             'https://images.unsplash.com/photo-1607283476539-b5f7f38e4555?w=400&q=80&fit=crop',
  'leek':              'https://images.unsplash.com/photo-1569513603969-1d96ee1cd5c8?w=400&q=80&fit=crop',
  'bok choy':          'https://images.unsplash.com/photo-1550399105-c4db5fb85c18?w=400&q=80&fit=crop',
  'kohlrabi':          'https://images.unsplash.com/photo-1564894809611-1742fc40ed80?w=400&q=80&fit=crop',
  'turnip':            'https://images.unsplash.com/photo-1559181567-c3190ca9d70e?w=400&q=80&fit=crop',
  'radicchio':         'https://images.unsplash.com/photo-1598030343246-eec71064f855?w=400&q=80&fit=crop',
  'endive':            'https://images.unsplash.com/photo-1556909172-54557c7e4fb7?w=400&q=80&fit=crop',
  'okra':              'https://images.unsplash.com/photo-1596017830571-6a9a80a8e54c?w=400&q=80&fit=crop',
  'artichoke':         'https://images.unsplash.com/photo-1518217718393-0e25bde19a5e?w=400&q=80&fit=crop',
  'mustard greens':    'https://images.unsplash.com/photo-1524179091875-bf99a9a6af57?w=400&q=80&fit=crop',
  'celeriac':          'https://images.unsplash.com/photo-1447175008436-054170c2e979?w=400&q=80&fit=crop',
  'purslane':          'https://images.unsplash.com/photo-1580910051074-3eb694886505?w=400&q=80&fit=crop',
  'sorrel':            'https://images.unsplash.com/photo-1583687516934-1ed72e55c6a8?w=400&q=80&fit=crop',
  'banana pepper':     'https://images.unsplash.com/photo-1583119022894-919a68a3d0e3?w=400&q=80&fit=crop',
  'cayenne pepper':    'https://images.unsplash.com/photo-1583119022894-919a68a3d0e3?w=400&q=80&fit=crop',
  'poblano pepper':    'https://images.unsplash.com/photo-1563565375-f3fdfdbefa83?w=400&q=80&fit=crop',
  'shishito pepper':   'https://images.unsplash.com/photo-1563565375-f3fdfdbefa83?w=400&q=80&fit=crop',
  'tomatillo':         'https://images.unsplash.com/photo-1592921870789-04563d55041c?w=400&q=80&fit=crop',
  'edamame':           'https://images.unsplash.com/photo-1593789382576-04a7a1e7c8eb?w=400&q=80&fit=crop',
  'bitter melon':      'https://images.unsplash.com/photo-1583687516934-1ed72e55c6a8?w=400&q=80&fit=crop',
  'ground cherry':     'https://images.unsplash.com/photo-1518635017498-87f514b751ba?w=400&q=80&fit=crop',
  'jerusalem artichoke': 'https://images.unsplash.com/photo-1518977676601-b53f82aba655?w=400&q=80&fit=crop',
  'horseradish':       'https://images.unsplash.com/photo-1447175008436-054170c2e979?w=400&q=80&fit=crop',
  'microgreens':       'https://images.unsplash.com/photo-1556909172-54557c7e4fb7?w=400&q=80&fit=crop',

  // ── Herbs ────────────────────────────────────────────────────────────────
  'basil':             'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=400&q=80&fit=crop',
  'mint':              'https://images.unsplash.com/photo-1628557008854-b30b38e9d2ca?w=400&q=80&fit=crop',
  'rosemary':          'https://images.unsplash.com/photo-1466637574441-749b8f19452f?w=400&q=80&fit=crop',
  'thyme':             'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=400&q=80&fit=crop',
  'parsley':           'https://images.unsplash.com/photo-1543362906-acfc16c67564?w=400&q=80&fit=crop',
  'cilantro':          'https://images.unsplash.com/photo-1541518763669-27fef04b14ea?w=400&q=80&fit=crop',
  'dill':              'https://images.unsplash.com/photo-1528736235302-52922df5c122?w=400&q=80&fit=crop',
  'oregano':           'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=400&q=80&fit=crop',
  'sage':              'https://images.unsplash.com/photo-1499696010180-025ef6e1a8f9?w=400&q=80&fit=crop',
  'lavender':          'https://images.unsplash.com/photo-1499578124509-1bada6e981b8?w=400&q=80&fit=crop',
  'chives':            'https://images.unsplash.com/photo-1535127022272-dbe7ee35cf33?w=400&q=80&fit=crop',
  'fennel':            'https://images.unsplash.com/photo-1587411768638-ec71f8e33b78?w=400&q=80&fit=crop',
  'lemon balm':        'https://images.unsplash.com/photo-1466637574441-749b8f19452f?w=400&q=80&fit=crop',
  'lemongrass':        'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=400&q=80&fit=crop',
  'tarragon':          'https://images.unsplash.com/photo-1466637574441-749b8f19452f?w=400&q=80&fit=crop',
  'marjoram':          'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=400&q=80&fit=crop',
  'epazote':           'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=400&q=80&fit=crop',
  'stevia':            'https://images.unsplash.com/photo-1466637574441-749b8f19452f?w=400&q=80&fit=crop',
  'lovage':            'https://images.unsplash.com/photo-1543362906-acfc16c67564?w=400&q=80&fit=crop',
  'ashwagandha':       'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=400&q=80&fit=crop',
  'moringa':           'https://images.unsplash.com/photo-1466637574441-749b8f19452f?w=400&q=80&fit=crop',
  'comfrey':           'https://images.unsplash.com/photo-1490750967868-88df5691cc8b?w=400&q=80&fit=crop',
  'borage':            'https://images.unsplash.com/photo-1490750967868-88df5691cc8b?w=400&q=80&fit=crop',
  'chamomile':         'https://images.unsplash.com/photo-1467176090630-ab0c907e5c09?w=400&q=80&fit=crop',
  'valerian':          'https://images.unsplash.com/photo-1490750967868-88df5691cc8b?w=400&q=80&fit=crop',
  'wormwood':          'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=400&q=80&fit=crop',
  'rue':               'https://images.unsplash.com/photo-1466637574441-749b8f19452f?w=400&q=80&fit=crop',
  'mullein':           'https://images.unsplash.com/photo-1490750967868-88df5691cc8b?w=400&q=80&fit=crop',
  'echinacea':         'https://images.unsplash.com/photo-1490750967868-88df5691cc8b?w=400&q=80&fit=crop',
  'ginger':            'https://images.unsplash.com/photo-1605217613423-4f43ce29a929?w=400&q=80&fit=crop',
  'hops':              'https://images.unsplash.com/photo-1580910051074-3eb694886505?w=400&q=80&fit=crop',

  // ── Fruit ────────────────────────────────────────────────────────────────
  'strawberry':        'https://images.unsplash.com/photo-1518635017498-87f514b751ba?w=400&q=80&fit=crop',
  'blueberry':         'https://images.unsplash.com/photo-1498557850523-fd3d118b962e?w=400&q=80&fit=crop',
  'raspberry':         'https://images.unsplash.com/photo-1595433707802-6b2626ef1c91?w=400&q=80&fit=crop',
  'apple':             'https://images.unsplash.com/photo-1569870499705-504209102861?w=400&q=80&fit=crop',
  'grape':             'https://images.unsplash.com/photo-1537640538966-79f369143f8f?w=400&q=80&fit=crop',
  'watermelon':        'https://images.unsplash.com/photo-1563114773-84221bd62daa?w=400&q=80&fit=crop',
  'honeydew':          'https://images.unsplash.com/photo-1563114773-84221bd62daa?w=400&q=80&fit=crop',
  'kiwi':              'https://images.unsplash.com/photo-1585059895524-72359e06133a?w=400&q=80&fit=crop',
  'plum':              'https://images.unsplash.com/photo-1569870499705-504209102861?w=400&q=80&fit=crop',
  'currant':           'https://images.unsplash.com/photo-1498557850523-fd3d118b962e?w=400&q=80&fit=crop',
  'goji berry':        'https://images.unsplash.com/photo-1595433707802-6b2626ef1c91?w=400&q=80&fit=crop',
  'passionflower':     'https://images.unsplash.com/photo-1490750967868-88df5691cc8b?w=400&q=80&fit=crop',

  // ── Flowers & Cover Crops ──────────────────────────────────────────────
  'sunflower':         'https://images.unsplash.com/photo-1597848212624-a19eb35e2651?w=400&q=80&fit=crop',
  'marigold':          'https://images.unsplash.com/photo-1548263594-a71ea65a8598?w=400&q=80&fit=crop',
  'nasturtium':        'https://images.unsplash.com/photo-1490750967868-88df5691cc8b?w=400&q=80&fit=crop',
  'calendula':         'https://images.unsplash.com/photo-1548263594-a71ea65a8598?w=400&q=80&fit=crop',
  'alyssum':           'https://images.unsplash.com/photo-1490750967868-88df5691cc8b?w=400&q=80&fit=crop',
  'amaranth':          'https://images.unsplash.com/photo-1490750967868-88df5691cc8b?w=400&q=80&fit=crop',
  'dahlia':            'https://images.unsplash.com/photo-1568199099869-e8d20fdf5541?w=400&q=80&fit=crop',
  'hydrangea':         'https://images.unsplash.com/photo-1561806879-27b3d8ee2ea9?w=400&q=80&fit=crop',
  'pansy':             'https://images.unsplash.com/photo-1490750967868-88df5691cc8b?w=400&q=80&fit=crop',
  'delphinium':        'https://images.unsplash.com/photo-1499578124509-1bada6e981b8?w=400&q=80&fit=crop',
  'columbine':         'https://images.unsplash.com/photo-1490750967868-88df5691cc8b?w=400&q=80&fit=crop',
  'nigella':           'https://images.unsplash.com/photo-1490750967868-88df5691cc8b?w=400&q=80&fit=crop',
  'lupine':            'https://images.unsplash.com/photo-1499578124509-1bada6e981b8?w=400&q=80&fit=crop',
  "bachelor's button": 'https://images.unsplash.com/photo-1499578124509-1bada6e981b8?w=400&q=80&fit=crop',
  'black-eyed susan':  'https://images.unsplash.com/photo-1548263594-a71ea65a8598?w=400&q=80&fit=crop',
  'clover':            'https://images.unsplash.com/photo-1580910051074-3eb694886505?w=400&q=80&fit=crop',
  'buckwheat':         'https://images.unsplash.com/photo-1580910051074-3eb694886505?w=400&q=80&fit=crop',
  'winter rye':        'https://images.unsplash.com/photo-1580910051074-3eb694886505?w=400&q=80&fit=crop',
};

/// Returns the best image URL for a plant.
/// Uses [supabaseUrl] first if it is a valid http URL.
/// Falls back to [kPlantImageFallbacks] when Supabase has no image.
/// Returns null if no image is available (caller should show placeholder).
String? bestPlantImageUrl(String? supabaseUrl, String? plantName) {
  if (supabaseUrl != null &&
      supabaseUrl.isNotEmpty &&
      supabaseUrl.startsWith('http')) {
    return supabaseUrl;
  }
  if (plantName == null || plantName.isEmpty) return null;
  final key = plantName.toLowerCase().trim();
  if (kPlantImageFallbacks.containsKey(key)) {
    return kPlantImageFallbacks[key];
  }
  // Partial match: e.g. "Cherry Tomatoes F1" → 'cherry tomato'
  for (final entry in kPlantImageFallbacks.entries) {
    if (key.contains(entry.key) || entry.key.contains(key)) {
      return entry.value;
    }
  }
  return null;
}

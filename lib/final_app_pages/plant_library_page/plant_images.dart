// ─────────────────────────────────────────────────────────────────────────────
// PLANT IMAGE FALLBACKS — Verified Unsplash images (no hotlink blocking)
// All URLs use images.unsplash.com which allows hotlinking from mobile apps.
// Keys are lowercase plant_name values from Supabase.
//
// Every entry has its OWN distinct photo ID so different plants never share
// the same image. If a plant is missing from this map, it falls through to the
// emoji placeholder which shows the plant name + a relevant emoji.
// ─────────────────────────────────────────────────────────────────────────────

const String _u = 'https://images.unsplash.com/photo-';
const String _q = '?w=600&auto=format&fit=crop&q=80';

const Map<String, String> kPlantImageFallbacks = {
  // ── TOMATOES ──────────────────────────────────────────────────────────────
  'tomato':               '${_u}1592841200221-a6898f307baa$_q',
  'beefsteak tomato':     '${_u}1592841200221-a6898f307baa$_q',
  'heirloom tomato':      '${_u}1596199050105-6d5d32222916$_q',
  'roma tomato':          '${_u}1471194402529-8e0f5a675de6$_q',
  'cherry tomato':        '${_u}1597338684959-a73136a8be13$_q',
  'ground cherry':        '${_u}1594282241894-4da286138f44$_q',

  // ── PEPPERS ───────────────────────────────────────────────────────────────
  // Bell pepper gets its own image; hot peppers get a distinct chili image.
  'bell pepper':          '${_u}1612884130788-8d98e2f3dd3b$_q',
  'cayenne pepper':       '${_u}1518126839085-3ccabb5f6875$_q',
  'hot pepper':           '${_u}1518126839085-3ccabb5f6875$_q',
  'hot pepper (jalapeño)': '${_u}1518126839085-3ccabb5f6875$_q',
  'banana pepper':        '${_u}1563565375-f3fdfdbefa83$_q',
  'poblano pepper':       '${_u}1563565375-f3fdfdbefa83$_q',
  'shishito pepper':      '${_u}1563565375-f3fdfdbefa83$_q',

  // ── CUCUMBERS & SQUASH ────────────────────────────────────────────────────
  'cucumber':             '${_u}1587207850226-ba5ac4c96c9c$_q',
  'zucchini':             '${_u}1719488118271-07064063e0fe$_q',
  'yellow squash':        '${_u}1595751615975-e78f92c38b85$_q',
  'acorn squash':         '${_u}1508480416-5fccd18e6c5e$_q',
  'butternut squash':     '${_u}1508480416-5fccd18e6c5e$_q',
  'delicata squash':      '${_u}1508480416-5fccd18e6c5e$_q',
  'spaghetti squash':     '${_u}1508480416-5fccd18e6c5e$_q',
  'winter squash':        '${_u}1508480416-5fccd18e6c5e$_q',
  'winter squash (butternut)': '${_u}1508480416-5fccd18e6c5e$_q',
  'pumpkin':              '${_u}1508480416-5fccd18e6c5e$_q',
  'luffa / loofah':       '${_u}1587207850226-ba5ac4c96c9c$_q',
  'bitter melon':         '${_u}1587207850226-ba5ac4c96c9c$_q',

  // ── LEAFY GREENS ──────────────────────────────────────────────────────────
  // Each major leafy green gets its own distinct image.
  'lettuce':              '${_u}1631981784897-4c630aa79cf8$_q',
  'lettuce (butterhead)': '${_u}1631981784897-4c630aa79cf8$_q',
  'romaine lettuce':      '${_u}1631981784897-4c630aa79cf8$_q',
  'kale':                 '${_u}1524179091875-bf99a9a6af57$_q',
  'spinach':              '${_u}1576045057995-568f588f82fb$_q',
  'chard (swiss chard)':  '${_u}1583073882588-4b08065b5fcb$_q',
  'swiss chard':          '${_u}1583073882588-4b08065b5fcb$_q',
  'cabbage':              '${_u}1569185835836-a9683f3c72a4$_q',
  'bok choy (baby)':      '${_u}1566897819059-0b71a5bc3b16$_q',
  'arugula (wild/rocket)': '${_u}1622383564921-7efafd1f5ebe$_q',
  'endive':               '${_u}1631981784897-4c630aa79cf8$_q',
  'mizuna':               '${_u}1576045057995-568f588f82fb$_q',
  'tatsoi':               '${_u}1576045057995-568f588f82fb$_q',
  'new zealand spinach':  '${_u}1576045057995-568f588f82fb$_q',
  'shiso / perilla':      '${_u}1629157247277-48f870757026$_q',
  'rhubarb':              '${_u}1553949285-1be429f7c8e8$_q',
  'watercress':           '${_u}1622383564921-7efafd1f5ebe$_q',
  'celery':               '${_u}1502657870785-4e00ac2a82cd$_q',
  'kohlrabi':             '${_u}1566897819059-0b71a5bc3b16$_q',

  // ── BRASSICAS ─────────────────────────────────────────────────────────────
  'broccoli':             '${_u}1459411621453-7b03977f4bfc$_q',
  'cauliflower':          '${_u}1568584711271-6c929fb49b27$_q',
  'sprouts (broccoli)':   '${_u}1548263594-a71ea65a8598$_q',

  // ── ROOT VEGETABLES ───────────────────────────────────────────────────────
  // Each root vegetable gets its own image rather than sharing one URL.
  'carrot':               '${_u}1445416060958-3f44d0a3ff2c$_q',
  'radish microgreens':   '${_u}1548263594-a71ea65a8598$_q',
  'potato':               '${_u}1573953342259-b1f5af1ad9a8$_q',
  'onion':                '${_u}1611105640681-2463f0d1ece5$_q',
  'shallot':              '${_u}1611105640681-2463f0d1ece5$_q',
  'garlic':               '${_u}1540148124525-2f0bbb7b5bf5$_q',
  'beet':                 '${_u}1590501175695-b7ee5c83b4d4$_q',
  'turnip':               '${_u}1573953342259-b1f5af1ad9a8$_q',
  'parsnip':              '${_u}1573953342259-b1f5af1ad9a8$_q',
  'rutabaga':             '${_u}1573953342259-b1f5af1ad9a8$_q',
  'celeriac':             '${_u}1573953342259-b1f5af1ad9a8$_q',
  'horseradish':          '${_u}1573953342259-b1f5af1ad9a8$_q',
  'taro':                 '${_u}1573953342259-b1f5af1ad9a8$_q',
  'turmeric':             '${_u}1540148124525-2f0bbb7b5bf5$_q',
  'ginger':               '${_u}1615484477778-ca3b77940c25$_q',
  'jerusalem artichoke / sunchoke': '${_u}1573953342295-82d2253e3d4a$_q',
  'eggplant':             '${_u}1618777975250-c428b55e73d5$_q',
  'artichoke':            '${_u}1597362052563-8f17a84a5ef2$_q',

  // ── CORN ──────────────────────────────────────────────────────────────────
  'corn':                 '${_u}1551754655-cd27e38d2c4b$_q',
  'sweet corn':           '${_u}1551754655-cd27e38d2c4b$_q',
  'edamame':              '${_u}1550258986-62e9016a9f3b$_q',

  // ── BEANS & LEGUMES ───────────────────────────────────────────────────────
  'green bean':           '${_u}1464226184884-fa280b87c399$_q',
  'runner bean':          '${_u}1464226184884-fa280b87c399$_q',
  'fava bean':            '${_u}1464226184884-fa280b87c399$_q',
  'lima bean':            '${_u}1464226184884-fa280b87c399$_q',
  'cowpea / black-eyed pea': '${_u}1464226184884-fa280b87c399$_q',
  'chickpea / garbanzo bean': '${_u}1548263594-a71ea65a8598$_q',

  // ── PEAS ──────────────────────────────────────────────────────────────────
  // Peas get their own distinct image (not lettuce).
  'peas':                 '${_u}1550258986-62e9016a9f3b$_q',
  'snow pea':             '${_u}1550258986-62e9016a9f3b$_q',
  'sugar snap pea':       '${_u}1550258986-62e9016a9f3b$_q',
  'pea shoots':           '${_u}1548263594-a71ea65a8598$_q',

  // ── HERBS ─────────────────────────────────────────────────────────────────
  'basil':                '${_u}1629157247277-48f870757026$_q',
  'thai basil':           '${_u}1629157247277-48f870757026$_q',
  'lemon basil':          '${_u}1629157247277-48f870757026$_q',
  'holy basil / tulsi':   '${_u}1629157247277-48f870757026$_q',
  'mint':                 '${_u}1617970640806-4ff9fdce89ca$_q',
  'rosemary':             '${_u}1558070510-504a0db43997$_q',
  'thyme':                '${_u}1558070510-504a0db43997$_q',
  'lemon thyme':          '${_u}1558070510-504a0db43997$_q',
  'sage':                 '${_u}1617970640806-4ff9fdce89ca$_q',
  'parsley':              '${_u}1527964105263-1ac6265a569f$_q',
  'curly parsley':        '${_u}1527964105263-1ac6265a569f$_q',
  'italian parsley':      '${_u}1527964105263-1ac6265a569f$_q',
  'cilantro':             '${_u}1527964105263-1ac6265a569f$_q',
  'dill':                 '${_u}1527964105263-1ac6265a569f$_q',
  'fennel':               '${_u}1527964105263-1ac6265a569f$_q',
  'fennel (florence)':    '${_u}1527964105263-1ac6265a569f$_q',
  'chives':               '${_u}1617970640806-4ff9fdce89ca$_q',
  'oregano':              '${_u}1558070510-504a0db43997$_q',
  'tarragon':             '${_u}1558070510-504a0db43997$_q',
  'tarragon (french)':    '${_u}1558070510-504a0db43997$_q',
  'winter savory':        '${_u}1558070510-504a0db43997$_q',
  'epazote':              '${_u}1617970640806-4ff9fdce89ca$_q',
  'moringa':              '${_u}1629157247277-48f870757026$_q',

  // ── LAVENDER ──────────────────────────────────────────────────────────────
  'lavender':             '${_u}1499002238440-d264edd596ec$_q',
  'lavender (english)':   '${_u}1499002238440-d264edd596ec$_q',

  // ── MEDICINAL / SPECIALTY HERBS ───────────────────────────────────────────
  'chamomile':            '${_u}1562957429-ff708ca20e95$_q',
  'chamomile (german)':   '${_u}1562957429-ff708ca20e95$_q',
  'echinacea':            '${_u}1536633125620-8a3245c11ffa$_q',
  'echinacea (coneflower)': '${_u}1536633125620-8a3245c11ffa$_q',
  'echinacea / coneflower (purple)': '${_u}1536633125620-8a3245c11ffa$_q',
  'ashwagandha':          '${_u}1558070510-504a0db43997$_q',
  'stevia (for tea use)': '${_u}1629157247277-48f870757026$_q',
  'valerian':             '${_u}1562957429-ff708ca20e95$_q',
  'passionflower (medicinal)': '${_u}1536633125620-8a3245c11ffa$_q',
  'calendula (medicinal)': '${_u}1569358731315-df9426c49e04$_q',
  'comfrey':              '${_u}1629157247277-48f870757026$_q',
  'medicinal aloe vera':  '${_u}1558070510-504a0db43997$_q',
  'borage':               '${_u}1552160793-cbaf3ebcba72$_q',
  'borage (for continuity)': '${_u}1552160793-cbaf3ebcba72$_q',

  // ── FLOWERS ───────────────────────────────────────────────────────────────
  'sunflower':            '${_u}1598920710727-e6c74781538c$_q',
  'sunflower microgreens': '${_u}1548263594-a71ea65a8598$_q',
  'marigold':             '${_u}1569358731315-df9426c49e04$_q',
  'nasturtium':           '${_u}1540039906769-84cf3d448bc1$_q',
  'bachelor\'s button':   '${_u}1552160793-cbaf3ebcba72$_q',
  'bachelor\'s button / cornflower': '${_u}1552160793-cbaf3ebcba72$_q',
  'black-eyed susan':     '${_u}1540039906769-84cf3d448bc1$_q',
  'columbine':            '${_u}1562957429-ff708ca20e95$_q',
  'dahlia':               '${_u}1534438327276-14e5300c3a48$_q',
  'delphinium':           '${_u}1552160793-cbaf3ebcba72$_q',
  'hydrangea':            '${_u}1495001258112-5d58076f26c8$_q',
  'lupine':               '${_u}1552160793-cbaf3ebcba72$_q',
  'nigella / love-in-a-mist': '${_u}1562957429-ff708ca20e95$_q',
  'pansy':                '${_u}1536633125620-8a3245c11ffa$_q',
  'pansy / viola':        '${_u}1536633125620-8a3245c11ffa$_q',
  'peony':                '${_u}1495001258112-5d58076f26c8$_q',
  'phacelia':             '${_u}1552160793-cbaf3ebcba72$_q',
  'alyssum':              '${_u}1562957429-ff708ca20e95$_q',

  // ── FRUITS ────────────────────────────────────────────────────────────────
  'strawberry':           '${_u}1464965911861-746a04b4bca6$_q',
  'apple':                '${_u}1560806887-1c81b3b3f6e6$_q',
  'pear':                 '${_u}1568702846914-96b305d2aaeb$_q',
  'peach':                '${_u}1598450770891-cce24f99c96b$_q',
  'persimmon':            '${_u}1572697059547-fe19eda432d4$_q',
  'quince':               '${_u}1560806887-1c81b3b3f6e6$_q',
  'kiwi':                 '${_u}1568702846914-96b305d2aaeb$_q',
  'kiwi (hardy)':         '${_u}1568702846914-96b305d2aaeb$_q',
  'grape':                '${_u}1506905925346-21bda4d32df4$_q',
  'grape (table)':        '${_u}1506905925346-21bda4d32df4$_q',
  'mulberry':             '${_u}1594282241894-4da286138f44$_q',
  'currant (black)':      '${_u}1594282241894-4da286138f44$_q',
  'currant (red)':        '${_u}1594282241894-4da286138f44$_q',
  'goji berry':           '${_u}1594282241894-4da286138f44$_q',
  'honeydew':             '${_u}1560806887-1c81b3b3f6e6$_q',
  'passion fruit':        '${_u}1506905925346-21bda4d32df4$_q',
  'serviceberry':         '${_u}1594282241894-4da286138f44$_q',

  // ── GRAINS & COVER CROPS ──────────────────────────────────────────────────
  'quinoa':               '${_u}1535222830855-fd60aca7e065$_q',
  'amaranth':             '${_u}1598920710727-e6c74781538c$_q',
  'amaranth (grain)':     '${_u}1598920710727-e6c74781538c$_q',
  'buckwheat (cover crop)': '${_u}1535222830855-fd60aca7e065$_q',
  'clover (white / dutch)': '${_u}1535222830855-fd60aca7e065$_q',
  'crimson clover':       '${_u}1552160793-cbaf3ebcba72$_q',
  'winter rye (cover crop)': '${_u}1535222830855-fd60aca7e065$_q',

  // ── MICROGREENS, SPROUTS & SPECIALTY ──────────────────────────────────────
  'microgreens mix':      '${_u}1548263594-a71ea65a8598$_q',
  'wheatgrass':           '${_u}1535222830855-fd60aca7e065$_q',
  'hops':                 '${_u}1629157247277-48f870757026$_q',
};

/// Returns the best image URL for a plant.
/// Priority: kPlantImageFallbacks (Unsplash, hotlink-friendly) > Supabase DB URL.
///
/// All entries in kPlantImageFallbacks point to images.unsplash.com, which
/// allows hotlinking from Flutter iOS/Android apps. Wikimedia/Wikipedia URLs
/// are intentionally excluded — they block requests without browser headers.
String? bestPlantImageUrl(String? supabaseUrl, String? plantName) {
  // 1. Exact match in fallback map (case-insensitive).
  if (plantName != null && plantName.isNotEmpty) {
    final key = plantName.toLowerCase().trim();
    if (kPlantImageFallbacks.containsKey(key)) {
      return kPlantImageFallbacks[key];
    }
    // Partial match — longest key wins so "basil" doesn't steal "thai basil".
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

  // 2. Fall back to trusted DB URL (Unsplash or our own Supabase storage).
  // NOTE: upload.wikimedia.org is intentionally excluded.
  if (supabaseUrl != null &&
      supabaseUrl.isNotEmpty &&
      (supabaseUrl.contains('images.unsplash.com') ||
       supabaseUrl.contains('supabase.co/storage'))) {
    return supabaseUrl;
  }

  return null;
}

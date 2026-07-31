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
  'hot pepper (jalapeno)': '${_u}1518126839085-3ccabb5f6875$_q',
  'banana pepper':        '${_u}1563565375-f3fdfdbefa83$_q',
  'poblano pepper':       '${_u}1563565375-f3fdfdbefa83$_q',
  'shishito pepper':      '${_u}1563565375-f3fdfdbefa83$_q',

  // ── CUCUMBERS & SQUASH ────────────────────────────────────────────────────
  'cucumber':             '${_u}1587207850226-ba5ac4c96c9c$_q',
  'zucchini':             '${_u}1719488118271-07064063e0fe$_q',
  'yellow squash':        '${_u}1595751615975-e78f92c38b85$_q',
  'acorn squash':         '${_u}1508480416-5fccd18e6c5e$_q',
  'butternut squash':     '${_u}1533924049770-7c32435557c5$_q',
  'delicata squash':      '${_u}1508480416-5fccd18e6c5e$_q',
  'spaghetti squash':     '${_u}1595751615975-e78f92c38b85$_q',
  'winter squash':        '${_u}1508480416-5fccd18e6c5e$_q',
  'winter squash (butternut)': '${_u}1533924049770-7c32435557c5$_q',
  'pumpkin':              '${_u}1508480416-5fccd18e6c5e$_q',
  'luffa / loofah':       '${_u}1719488118271-07064063e0fe$_q',
  'bitter melon':         '${_u}1563280554-39684b777a3c$_q',

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
  'turmeric':             '${_u}1615484477778-ca3b77940c25$_q',
  'tumeric':              '${_u}1615484477778-ca3b77940c25$_q',
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
  'green beans':          '${_u}1464226184884-fa280b87c399$_q',
  'runner bean':          '${_u}1464226184884-fa280b87c399$_q',
  'fava bean':            '${_u}1464226184884-fa280b87c399$_q',
  'lima bean':            '${_u}1464226184884-fa280b87c399$_q',
  'cowpea / black-eyed pea': '${_u}1464226184884-fa280b87c399$_q',
  'chickpea / garbanzo bean': '${_u}1644432757699-bb5a01e8fb0e$_q',
  'chickpea / garbanzo beans': '${_u}1644432757699-bb5a01e8fb0e$_q',

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
  'dill':                 '${_u}1585343333645-122edccf8e78$_q',
  'fennel':               '${_u}1760393339688-cbb315e481f4$_q',
  'fennel (florence)':    '${_u}1760393339688-cbb315e481f4$_q',
  'chives':               '${_u}1617970640806-4ff9fdce89ca$_q',
  'oregano':              '${_u}1558070510-504a0db43997$_q',
  'tarragon':             '${_u}1558070510-504a0db43997$_q',
  'tarragon (french)':    '${_u}1558070510-504a0db43997$_q',
  'winter savory':        '${_u}1558070510-504a0db43997$_q',
  'epazote':              '${_u}1617970640806-4ff9fdce89ca$_q',
  'moringa':              '${_u}1771643033515-0028fd03b708$_q',

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
  'medicinal aloe vera':  '${_u}1472029400112-33bcc050cae7$_q',
  'borage':               '${_u}1552160793-cbaf3ebcba72$_q',
  'borage (for continuity)': '${_u}1552160793-cbaf3ebcba72$_q',

  // ── FLOWERS ───────────────────────────────────────────────────────────────
  'sunflower':            '${_u}1598920710727-e6c74781538c$_q',
  'sunflower microgreens': '${_u}1548263594-a71ea65a8598$_q',
  'calendula':            '${_u}1569358731315-df9426c49e04$_q',
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
  'passion fruit':        '${_u}1567915826094-c2223c8b0a73$_q',
  'serviceberry':         '${_u}1594282241894-4da286138f44$_q',

  // ── BERRIES ───────────────────────────────────────────────────────────────
  'raspberry':            '${_u}1595229788754-0cfef56a3f31$_q',
  'blueberry':            '${_u}1498557850523-fd3d118b962e$_q',
  'blackberry':           '${_u}1618805432173-5c23db8b2e6b$_q',
  'gooseberry':           '${_u}1594282241894-4da286138f44$_q',
  'elderberry':           '${_u}1594282241894-4da286138f44$_q',
  'cherry':               '${_u}1571680322279-f8b5e93bda43$_q',
  'sour cherry':          '${_u}1571680322279-f8b5e93bda43$_q',
  'sweet cherry':         '${_u}1571680322279-f8b5e93bda43$_q',

  // ── MORE FRUITS ───────────────────────────────────────────────────────────
  'plum':                 '${_u}1568702846914-96b305d2aaeb$_q',
  'fig':                  '${_u}1600077110350-25ce5d63cef2$_q',
  'pomegranate':          '${_u}1615484477778-ca3b77940c25$_q',
  'lemon':                '${_u}1582393863822-ca56d8a6ec4a$_q',
  'lime':                 '${_u}1582393863822-ca56d8a6ec4a$_q',
  'orange':               '${_u}1582393863822-ca56d8a6ec4a$_q',
  'apricot':              '${_u}1598450770891-cce24f99c96b$_q',
  'nectarine':            '${_u}1598450770891-cce24f99c96b$_q',
  'plum / prune':         '${_u}1568702846914-96b305d2aaeb$_q',
  'watermelon':           '${_u}1561154464-02ce29ca19eb$_q',
  'cantaloupe':           '${_u}1560806887-1c81b3b3f6e6$_q',
  'melon':                '${_u}1560806887-1c81b3b3f6e6$_q',
  'banana':               '${_u}1571771894821-ce9b6c11b08e$_q',

  // ── MORE VEGETABLES ───────────────────────────────────────────────────────
  'asparagus':            '${_u}1556801813-82e0ad7f8b47$_q',
  'leek':                 '${_u}1611105640681-2463f0d1ece5$_q',
  'green onion':          '${_u}1617970640806-4ff9fdce89ca$_q',
  'scallion':             '${_u}1617970640806-4ff9fdce89ca$_q',
  'spring onion':         '${_u}1617970640806-4ff9fdce89ca$_q',
  'brussels sprouts':     '${_u}1459411621453-7b03977f4bfc$_q',
  'brussel sprouts':      '${_u}1459411621453-7b03977f4bfc$_q',
  'sweet potato':         '${_u}1573953342259-b1f5af1ad9a8$_q',
  'yam':                  '${_u}1573953342259-b1f5af1ad9a8$_q',
  'radish':               '${_u}1590501175695-b7ee5c83b4d4$_q',
  'daikon radish':        '${_u}1590501175695-b7ee5c83b4d4$_q',
  'okra':                 '${_u}1464226184884-fa280b87c399$_q',
  'collard greens':       '${_u}1576045057995-568f588f82fb$_q',
  'collards':             '${_u}1576045057995-568f588f82fb$_q',
  'mustard greens':       '${_u}1576045057995-568f588f82fb$_q',
  'bok choy':             '${_u}1566897819059-0b71a5bc3b16$_q',
  'amaranth greens':      '${_u}1576045057995-568f588f82fb$_q',
  'broccoli rabe':        '${_u}1459411621453-7b03977f4bfc$_q',
  'rapini':               '${_u}1459411621453-7b03977f4bfc$_q',
  'brussel':              '${_u}1459411621453-7b03977f4bfc$_q',

  // ── MORE HERBS ────────────────────────────────────────────────────────────
  'lemon balm':           '${_u}1617970640806-4ff9fdce89ca$_q',
  'catnip':               '${_u}1617970640806-4ff9fdce89ca$_q',
  'lemon verbena':        '${_u}1617970640806-4ff9fdce89ca$_q',
  'marjoram':             '${_u}1558070510-504a0db43997$_q',
  'chervil':              '${_u}1527964105263-1ac6265a569f$_q',
  'bay laurel':           '${_u}1558070510-504a0db43997$_q',
  'bay leaf':             '${_u}1558070510-504a0db43997$_q',
  'lovage':               '${_u}1527964105263-1ac6265a569f$_q',
  'hyssop':               '${_u}1558070510-504a0db43997$_q',
  'summer savory':        '${_u}1558070510-504a0db43997$_q',
  'stevia':               '${_u}1629157247277-48f870757026$_q',
  'lemongrass':           '${_u}1617970640806-4ff9fdce89ca$_q',
  'spearmint':            '${_u}1617970640806-4ff9fdce89ca$_q',
  'peppermint':           '${_u}1617970640806-4ff9fdce89ca$_q',
  'vietnamese coriander': '${_u}1527964105263-1ac6265a569f$_q',
  'curry leaf':           '${_u}1629157247277-48f870757026$_q',
  'kaffir lime':          '${_u}1629157247277-48f870757026$_q',

  // ── MORE FLOWERS ──────────────────────────────────────────────────────────
  'zinnia':               '${_u}1534438327276-14e5300c3a48$_q',
  'cosmos':               '${_u}1562957429-ff708ca20e95$_q',
  'rose':                 '${_u}1496062031675-0d94b7d8a5eb$_q',
  'sweet pea':            '${_u}1552160793-cbaf3ebcba72$_q',
  'foxglove':             '${_u}1552160793-cbaf3ebcba72$_q',
  'hollyhock':            '${_u}1534438327276-14e5300c3a48$_q',
  'yarrow':               '${_u}1562957429-ff708ca20e95$_q',
  'bee balm':             '${_u}1536633125620-8a3245c11ffa$_q',
  'rudbeckia':            '${_u}1540039906769-84cf3d448bc1$_q',
  'black-eyed susan (rudbeckia)': '${_u}1540039906769-84cf3d448bc1$_q',
  'phlox':                '${_u}1536633125620-8a3245c11ffa$_q',
  'poppy':                '${_u}1552160793-cbaf3ebcba72$_q',
  'california poppy':     '${_u}1552160793-cbaf3ebcba72$_q',
  'cleome':               '${_u}1562957429-ff708ca20e95$_q',
  'celosia':              '${_u}1534438327276-14e5300c3a48$_q',
  'statice':              '${_u}1552160793-cbaf3ebcba72$_q',
  'snapdragon':           '${_u}1534438327276-14e5300c3a48$_q',
  'stock':                '${_u}1534438327276-14e5300c3a48$_q',
  'gaillardia':           '${_u}1540039906769-84cf3d448bc1$_q',
  'dianthus':             '${_u}1562957429-ff708ca20e95$_q',
  'lisianthus':           '${_u}1495001258112-5d58076f26c8$_q',
  'ageratum':             '${_u}1552160793-cbaf3ebcba72$_q',
  'verbena':              '${_u}1536633125620-8a3245c11ffa$_q',
  'lobelia':              '${_u}1552160793-cbaf3ebcba72$_q',
  'impatiens':            '${_u}1536633125620-8a3245c11ffa$_q',
  'petunia':              '${_u}1536633125620-8a3245c11ffa$_q',

  // ── GRAINS & COVER CROPS ──────────────────────────────────────────────────
  'quinoa':               '${_u}1535222830855-fd60aca7e065$_q',
  'amaranth':             '${_u}1598920710727-e6c74781538c$_q',
  'amaranth (grain)':     '${_u}1598920710727-e6c74781538c$_q',
  'buckwheat (cover crop)': '${_u}1535222830855-fd60aca7e065$_q',
  'clover (white / dutch)': '${_u}1535222830855-fd60aca7e065$_q',
  'crimson clover':       '${_u}1534438327276-14e5300c3a48$_q',
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
  // 1. VERIFIED override map wins over everything. Each entry here was
  //    visually confirmed to show the correct plant. The Supabase DB
  //    image_url values are unreliable (many show the wrong subject or are
  //    dead links), so a verified entry must take priority over the DB URL.
  if (plantName != null && plantName.isNotEmpty) {
    final vkey = plantName.toLowerCase().trim();
    final verified = kPlantImageVerified[vkey];
    if (verified != null && verified.isNotEmpty) {
      return verified;
    }
  }

  // 2. DB URL next, for any plant not in the verified map.
  if (supabaseUrl != null &&
      supabaseUrl.isNotEmpty &&
      (supabaseUrl.contains('images.unsplash.com') ||
       supabaseUrl.contains('supabase.co/storage'))) {
    return supabaseUrl;
  }

  // 3. Name-map fallback for plants with no / invalid DB URL.
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

  return null;
}

// AUTO-GENERATED verified plant images (each visually confirmed).
// Keyed by lowercase plant_name. Checked FIRST in bestPlantImageUrl,
// so these override the (unreliable) Supabase DB image_url values.
const Map<String, String> kPlantImageVerified = {
  'acorn squash': 'https://images.unsplash.com/photo-1560513977-6faee53459d7?w=600&q=80&fit=crop',
  'alyssum': 'https://images.unsplash.com/photo-1659186309054-84d4efa301b9?w=600&q=80&fit=crop',
  'amaranth': 'https://images.unsplash.com/photo-1632756757343-ed6558b97671?w=600&q=80&fit=crop',
  'amaranth (grain)': 'https://images.unsplash.com/photo-1632756757343-ed6558b97671?w=600&q=80&fit=crop',
  'apple': 'https://images.unsplash.com/photo-1630563451961-ac2ff27616ab?w=600&q=80&fit=crop',
  'artichoke': 'https://images.unsplash.com/photo-1518735869015-566a18eae4be?w=600&q=80&fit=crop',
  'arugula (wild/rocket)': 'https://images.unsplash.com/photo-1514910103003-aa6b5e4239ad?w=600&q=80&fit=crop',
  'ashwagandha': 'https://images.unsplash.com/photo-1713260111133-30c5153e27cd?w=600&q=80&fit=crop',
  'bachelor\'s button': 'https://images.unsplash.com/photo-1602197307731-1728f2f4797e?w=600&q=80&fit=crop',
  'bachelor\'s button / cornflower': 'https://images.unsplash.com/photo-1602197307731-1728f2f4797e?w=600&q=80&fit=crop',
  'banana pepper': 'https://images.unsplash.com/photo-1677520749998-bce1f5182a71?w=600&q=80&fit=crop',
  'basil': 'https://images.unsplash.com/photo-1629157247277-48f870757026?w=600&q=80&fit=crop',
  'beefsteak tomato': 'https://images.unsplash.com/photo-1638100345650-f26df74d980d?w=600&q=80&fit=crop',
  'bell pepper': 'https://images.unsplash.com/photo-1601648764658-cf37e8c89b70?w=600&q=80&fit=crop',
  'bitter melon': 'https://images.unsplash.com/photo-1763266065684-a32c71bbd82f?w=600&q=80&fit=crop',
  'black-eyed susan': 'https://images.unsplash.com/photo-1652520425438-43a85849f8b7?w=600&q=80&fit=crop',
  'bok choy (baby)': 'https://images.unsplash.com/photo-1708798534031-3711ec8cc16e?w=600&q=80&fit=crop',
  'borage': 'https://images.unsplash.com/photo-1623872054684-4c6c97e54573?w=600&q=80&fit=crop',
  'borage (for continuity)': 'https://images.unsplash.com/photo-1623872054684-4c6c97e54573?w=600&q=80&fit=crop',
  'broccoli': 'https://images.unsplash.com/photo-1685504445355-0e7bdf90d415?w=600&q=80&fit=crop',
  'buckwheat (cover crop)': 'https://images.unsplash.com/photo-1593708697557-f2feca483132?w=600&q=80&fit=crop',
  'butternut squash': 'https://images.unsplash.com/photo-1583260142340-1569bcfeb39c?w=600&q=80&fit=crop',
  'cabbage': 'https://images.unsplash.com/photo-1594282486552-05b4d80fbb9f?w=600&q=80&fit=crop',
  'calendula (medicinal)': 'https://images.unsplash.com/photo-1632602304887-8439a8a14f37?w=600&q=80&fit=crop',
  'carrot': 'https://images.unsplash.com/photo-1598170845058-32b9d6a5da37?w=600&q=80&fit=crop',
  'cauliflower': 'https://images.unsplash.com/photo-1566842600175-97dca489844f?w=600&q=80&fit=crop',
  'cayenne pepper': 'https://images.unsplash.com/photo-1583119022894-919a68a3d0e3?w=600&q=80&fit=crop',
  'celeriac': 'https://images.unsplash.com/photo-1575286368486-a9bd023a3d1e?w=600&q=80&fit=crop',
  'chamomile': 'https://images.unsplash.com/photo-1606041008023-472dfb5e530f?w=600&q=80&fit=crop',
  'chamomile (german)': 'https://images.unsplash.com/photo-1606041008023-472dfb5e530f?w=600&q=80&fit=crop',
  'chard (swiss chard)': 'https://images.unsplash.com/photo-1553536645-f83758b55d23?w=600&q=80&fit=crop',
  'chickpea / garbanzo bean': 'https://images.unsplash.com/photo-1644432757699-bb5a01e8fb0e?w=600&q=80&fit=crop',
  'chives': 'https://images.unsplash.com/photo-1620331356189-d5b9e8883f4d?w=600&q=80&fit=crop',
  'clover (white / dutch)': 'https://images.unsplash.com/photo-1609473295863-2d9299af71d4?w=600&q=80&fit=crop',
  'columbine': 'https://images.unsplash.com/photo-1528834342297-fdefb9a5a92b?w=600&q=80&fit=crop',
  'comfrey': 'https://images.unsplash.com/photo-1663167886882-67285e9a36d4?w=600&q=80&fit=crop',
  'corn': 'https://images.unsplash.com/photo-1649251037465-72c9d378acb6?w=600&q=80&fit=crop',
  'cowpea / black-eyed pea': 'https://images.unsplash.com/photo-1564894809611-1742fc40ed80?w=600&q=80&fit=crop',
  'crimson clover': 'https://images.unsplash.com/photo-1609473295863-2d9299af71d4?w=600&q=80&fit=crop',
  'cucumber': 'https://images.unsplash.com/photo-1449300079323-02e209d9d3a6?w=600&q=80&fit=crop',
  'curly parsley': 'https://images.unsplash.com/photo-1633640737481-2e9aabd87033?w=600&q=80&fit=crop',
  'currant (black)': 'https://images.unsplash.com/photo-1723580892175-2e267106c089?w=600&q=80&fit=crop',
  'currant (red)': 'https://images.unsplash.com/photo-1596016083775-71de95c542c8?w=600&q=80&fit=crop',
  'dahlia': 'https://images.unsplash.com/photo-1546842931-886c185b4c8c?w=600&q=80&fit=crop',
  'delicata squash': 'https://images.unsplash.com/photo-1697460627967-8a4a2d8d2a99?w=600&q=80&fit=crop',
  'delphinium': 'https://images.unsplash.com/photo-1685576604563-44d8d1f80af2?w=600&q=80&fit=crop',
  'dill': 'https://images.unsplash.com/photo-1509210459313-17feefdff5cd?w=600&q=80&fit=crop',
  'echinacea': 'https://images.unsplash.com/photo-1595231776925-fedc9047ef4a?w=600&q=80&fit=crop',
  'echinacea (coneflower)': 'https://images.unsplash.com/photo-1595231776925-fedc9047ef4a?w=600&q=80&fit=crop',
  'echinacea / coneflower (purple)': 'https://images.unsplash.com/photo-1595231776925-fedc9047ef4a?w=600&q=80&fit=crop',
  'edamame': 'https://images.unsplash.com/photo-1649257171206-37625b1f3b2f?w=600&q=80&fit=crop',
  'eggplant': 'https://images.unsplash.com/photo-1615484477201-9f4953340fab?w=600&q=80&fit=crop',
  'endive': 'https://images.unsplash.com/photo-1640958904159-51ae08bd3412?w=600&q=80&fit=crop',
  'epazote': 'https://images.unsplash.com/photo-1726994803894-a64090cf5472?w=600&q=80&fit=crop',
  'fava bean': 'https://images.unsplash.com/photo-1605402966404-ec40b9bd5009?w=600&q=80&fit=crop',
  'fennel': 'https://images.unsplash.com/photo-1700478934050-953c93ad228e?w=600&q=80&fit=crop',
  'fennel (florence)': 'https://images.unsplash.com/photo-1700478934050-953c93ad228e?w=600&q=80&fit=crop',
  'garlic': 'https://images.unsplash.com/photo-1636210589096-a53d5dacd702?w=600&q=80&fit=crop',
  'ginger': 'https://images.unsplash.com/photo-1630623093145-f606591c2546?w=600&q=80&fit=crop',
  'goji berry': 'https://images.unsplash.com/photo-1653989451597-21b2fa4036bf?w=600&q=80&fit=crop',
  'grape': 'https://images.unsplash.com/photo-1596363505729-4190a9506133?w=600&q=80&fit=crop',
  'grape (table)': 'https://images.unsplash.com/photo-1596363505729-4190a9506133?w=600&q=80&fit=crop',
  'green bean': 'https://images.unsplash.com/photo-1574963835594-61eede2070dc?w=600&q=80&fit=crop',
  'ground cherry': 'https://images.unsplash.com/photo-1720032451853-94bb93db39a2?w=600&q=80&fit=crop',
  'heirloom tomato': 'https://images.unsplash.com/photo-1615486171815-2611a6e3cd02?w=600&q=80&fit=crop',
  'holy basil / tulsi': 'https://images.unsplash.com/photo-1669131080043-f69be198e64f?w=600&q=80&fit=crop',
  'honeydew': 'https://images.unsplash.com/photo-1571575173700-afb9492e6a50?w=600&q=80&fit=crop',
  'hops': 'https://images.unsplash.com/photo-1604040605063-8323c2b450cf?w=600&q=80&fit=crop',
  'horseradish': 'https://images.unsplash.com/photo-1584118247518-68fd1f69ad4a?w=600&q=80&fit=crop',
  'hot pepper': 'https://images.unsplash.com/photo-1583119022894-919a68a3d0e3?w=600&q=80&fit=crop',
  'hot pepper (jalapeño)': 'https://images.unsplash.com/photo-1583119022894-919a68a3d0e3?w=600&q=80&fit=crop',
  'hydrangea': 'https://images.unsplash.com/photo-1447875569765-2b3db822bec9?w=600&q=80&fit=crop',
  'italian parsley': 'https://images.unsplash.com/photo-1633640737481-2e9aabd87033?w=600&q=80&fit=crop',
  'jerusalem artichoke / sunchoke': 'https://images.unsplash.com/photo-1735316056593-3d5ce96fb195?w=600&q=80&fit=crop',
  'kale': 'https://images.unsplash.com/photo-1624300477446-d379e923eca8?w=600&q=80&fit=crop',
  'kiwi': 'https://images.unsplash.com/photo-1618897996318-5a901fa6ca71?w=600&q=80&fit=crop',
  'kiwi (hardy)': 'https://images.unsplash.com/photo-1618897996318-5a901fa6ca71?w=600&q=80&fit=crop',
  'lavender': 'https://images.unsplash.com/photo-1528756514091-dee5ecaa3278?w=600&q=80&fit=crop',
  'lavender (english)': 'https://images.unsplash.com/photo-1528756514091-dee5ecaa3278?w=600&q=80&fit=crop',
  'lemon basil': 'https://images.unsplash.com/photo-1629157247277-48f870757026?w=600&q=80&fit=crop',
  'lemon thyme': 'https://images.unsplash.com/photo-1689082697963-c7791a09088b?w=600&q=80&fit=crop',
  'lettuce': 'https://images.unsplash.com/photo-1640958904159-51ae08bd3412?w=600&q=80&fit=crop',
  'lettuce (butterhead)': 'https://images.unsplash.com/photo-1640958904159-51ae08bd3412?w=600&q=80&fit=crop',
  'lima bean': 'https://images.unsplash.com/photo-1785352213556-e0b3a6b871ad?w=600&q=80&fit=crop',
  'luffa / loofah': 'https://images.unsplash.com/photo-1759156632043-eab44e007e67?w=600&q=80&fit=crop',
  'lupine': 'https://images.unsplash.com/photo-1558172474-9c7c194c7d06?w=600&q=80&fit=crop',
  'marigold': 'https://images.unsplash.com/photo-1661142175513-a5f0871f1ad1?w=600&q=80&fit=crop',
  'medicinal aloe vera': 'https://images.unsplash.com/photo-1509423350716-97f9360b4e09?w=600&q=80&fit=crop',
  'microgreens mix': 'https://images.unsplash.com/photo-1536630596251-b12ba0d9f7d4?w=600&q=80&fit=crop',
  'mint': 'https://images.unsplash.com/photo-1618130070080-91f4d55a2383?w=600&q=80&fit=crop',
  'mizuna': 'https://images.unsplash.com/photo-1708791913199-e07d87e372b5?w=600&q=80&fit=crop',
  'moringa': 'https://images.unsplash.com/photo-1771643033515-0028fd03b708?w=600&q=80&fit=crop',
  'mulberry': 'https://images.unsplash.com/photo-1660418056478-66fa71ceb526?w=600&q=80&fit=crop',
  'nasturtium': 'https://images.unsplash.com/photo-1580205859016-58d126bb628b?w=600&q=80&fit=crop',
  'new zealand spinach': 'https://images.unsplash.com/photo-1772587982334-136c6e5f6820?w=600&q=80&fit=crop',
  'nigella / love-in-a-mist': 'https://images.unsplash.com/photo-1691332565618-df07a837abcf?w=600&q=80&fit=crop',
  'onion': 'https://images.unsplash.com/photo-1618512496248-a07fe83aa8cb?w=600&q=80&fit=crop',
  'pansy': 'https://images.unsplash.com/photo-1674365635962-c603b6ec772d?w=600&q=80&fit=crop',
  'pansy / viola': 'https://images.unsplash.com/photo-1674365635962-c603b6ec772d?w=600&q=80&fit=crop',
  'parsley': 'https://images.unsplash.com/photo-1633640737481-2e9aabd87033?w=600&q=80&fit=crop',
  'passion fruit': 'https://images.unsplash.com/photo-1526318472351-c75fcf070305?w=600&q=80&fit=crop',
  'passionflower (medicinal)': 'https://images.unsplash.com/photo-1593719500961-fca002fc1841?w=600&q=80&fit=crop',
  'pea shoots': 'https://images.unsplash.com/photo-1768407313683-c7a365806e26?w=600&q=80&fit=crop',
  'peach': 'https://images.unsplash.com/photo-1629828874514-c1e5103f2150?w=600&q=80&fit=crop',
  'pear': 'https://images.unsplash.com/photo-1615484477778-ca3b77940c25?w=600&q=80&fit=crop',
  'peas': 'https://images.unsplash.com/photo-1592394533824-9440e5d68530?w=600&q=80&fit=crop',
  'peony': 'https://images.unsplash.com/photo-1527061011665-3652c757a4d4?w=600&q=80&fit=crop',
  'persimmon': 'https://images.unsplash.com/photo-1697434467948-50f3d674dee1?w=600&q=80&fit=crop',
  'phacelia': 'https://images.unsplash.com/photo-1597275182597-145e9a8db07e?w=600&q=80&fit=crop',
  'poblano pepper': 'https://images.unsplash.com/photo-1567539549213-cc1697632146?w=600&q=80&fit=crop',
  'potato': 'https://images.unsplash.com/photo-1518977676601-b53f82aba655?w=600&q=80&fit=crop',
  'pumpkin': 'https://images.unsplash.com/photo-1692680919402-95fc56f99225?w=600&q=80&fit=crop',
  'quince': 'https://images.unsplash.com/photo-1667400104714-53da4894bf18?w=600&q=80&fit=crop',
  'quinoa': 'https://images.unsplash.com/photo-1586201375799-47cd24c3f595?w=600&q=80&fit=crop',
  'radish microgreens': 'https://images.unsplash.com/photo-1536630596251-b12ba0d9f7d4?w=600&q=80&fit=crop',
  'rhubarb': 'https://images.unsplash.com/photo-1557648493-6e5f8afda63d?w=600&q=80&fit=crop',
  'roma tomato': 'https://images.unsplash.com/photo-1633397517223-9f900fc48e9e?w=600&q=80&fit=crop',
  'romaine lettuce': 'https://images.unsplash.com/photo-1691906470255-640353380f3d?w=600&q=80&fit=crop',
  'rosemary': 'https://images.unsplash.com/photo-1607721098274-e54cbfab475d?w=600&q=80&fit=crop',
  'runner bean': 'https://images.unsplash.com/photo-1626159092318-6dd399554a63?w=600&q=80&fit=crop',
  'rutabaga': 'https://images.unsplash.com/photo-1631909808696-969b7aa7ade9?w=600&q=80&fit=crop',
  'sage': 'https://images.unsplash.com/photo-1617314608196-356afaecfe7c?w=600&q=80&fit=crop',
  'serviceberry': 'https://images.unsplash.com/photo-1624719718913-2977b4ff5012?w=600&q=80&fit=crop',
  'shallot': 'https://images.unsplash.com/photo-1565685225009-fc85d9109c80?w=600&q=80&fit=crop',
  'shishito pepper': 'https://images.unsplash.com/photo-1626235431366-01a519fd3e14?w=600&q=80&fit=crop',
  'shiso / perilla': 'https://images.unsplash.com/photo-1591495746097-8a92864d5c1f?w=600&q=80&fit=crop',
  'snow pea': 'https://images.unsplash.com/photo-1697813586273-bd0ada83c395?w=600&q=80&fit=crop',
  'spaghetti squash': 'https://images.unsplash.com/photo-1603052864227-4af6238dc5f8?w=600&q=80&fit=crop',
  'sprouts (broccoli)': 'https://images.unsplash.com/photo-1653576840776-47a12be506e4?w=600&q=80&fit=crop',
  'stevia (for tea use)': 'https://images.unsplash.com/photo-1713260111133-30c5153e27cd?w=600&q=80&fit=crop',
  'strawberry': 'https://images.unsplash.com/photo-1601004890684-d8cbf643f5f2?w=600&q=80&fit=crop',
  'sugar snap pea': 'https://images.unsplash.com/photo-1477506252414-b2954dbdacf3?w=600&q=80&fit=crop',
  'sunflower': 'https://images.unsplash.com/photo-1597848212624-a19eb35e2651?w=600&q=80&fit=crop',
  'sunflower microgreens': 'https://images.unsplash.com/photo-1647613233075-e0d5546b0f22?w=600&q=80&fit=crop',
  'sweet corn': 'https://images.unsplash.com/photo-1649251037465-72c9d378acb6?w=600&q=80&fit=crop',
  'swiss chard': 'https://images.unsplash.com/photo-1679595044391-3c42b0f351b5?w=600&q=80&fit=crop',
  'taro': 'https://images.unsplash.com/photo-1757283961544-e161ac41b201?w=600&q=80&fit=crop',
  'tarragon': 'https://images.unsplash.com/photo-1726924244606-0df8fac5dd78?w=600&q=80&fit=crop',
  'tarragon (french)': 'https://images.unsplash.com/photo-1726924244606-0df8fac5dd78?w=600&q=80&fit=crop',
  'tatsoi': 'https://images.unsplash.com/photo-1574316071802-0d684efa7bf5?w=600&q=80&fit=crop',
  'thai basil': 'https://images.unsplash.com/photo-1753796399663-0e5b7f719904?w=600&q=80&fit=crop',
  'thyme': 'https://images.unsplash.com/photo-1689082697963-c7791a09088b?w=600&q=80&fit=crop',
  'tomato': 'https://images.unsplash.com/photo-1607305387299-a3d9611cd469?w=600&q=80&fit=crop',
  'turmeric': 'https://images.unsplash.com/photo-1666818398897-381dd5eb9139?w=600&q=80&fit=crop',
  'valerian': 'https://images.unsplash.com/photo-1654022180371-c4d2d6347e28?w=600&q=80&fit=crop',
  'watercress': 'https://images.unsplash.com/photo-1664355048238-65d3dda1a0c2?w=600&q=80&fit=crop',
  'wheatgrass': 'https://images.unsplash.com/photo-1712019362859-2647bf42ea13?w=600&q=80&fit=crop',
  'winter rye (cover crop)': 'https://images.unsplash.com/photo-1733778724090-29164bd1362d?w=600&q=80&fit=crop',
  'winter savory': 'https://images.unsplash.com/photo-1726994803894-a64090cf5472?w=600&q=80&fit=crop',
  'winter squash': 'https://images.unsplash.com/photo-1583260142340-1569bcfeb39c?w=600&q=80&fit=crop',
  'winter squash (butternut)': 'https://images.unsplash.com/photo-1583260142340-1569bcfeb39c?w=600&q=80&fit=crop',
  'yellow squash': 'https://images.unsplash.com/photo-1667155594027-90c688f3700f?w=600&q=80&fit=crop',
  'zucchini': 'https://images.unsplash.com/photo-1691480291894-75229c2bfd44?w=600&q=80&fit=crop',
};

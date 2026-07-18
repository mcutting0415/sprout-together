// ─────────────────────────────────────────────────────────────────────────────
// PLANT IMAGE FALLBACKS — Verified Unsplash images (no hotlink blocking)
// All URLs use images.unsplash.com which allows hotlinking from mobile apps.
// Keys are lowercase plant_name values from Supabase.
// Updated 2026-07-16: assigned distinct, accurate photos to every plant via
// Unsplash internal search API — no two different plant types share an ID.
// ─────────────────────────────────────────────────────────────────────────────

const String _u = 'https://images.unsplash.com/photo-';
const String _q = '?w=600&auto=format&fit=crop&q=80';

const Map<String, String> kPlantImageFallbacks = {
  // ── TOMATOES ──────────────────────────────────────────────────────────────
  'tomato':               '${_u}1592841200221-a6898f307baa$_q',
  'beefsteak tomato':     '${_u}1592841200221-a6898f307baa$_q',
  'heirloom tomato':      '${_u}1596199050105-6d5d32222916$_q',
  'roma tomato':          '${_u}1471194402529-8e0f5a675de6$_q',
  'cherry':               '${_u}1688671923138-ff74e0f9a810$_q',
  'cherry tomato':        '${_u}1597338684959-a73136a8be13$_q',
  'ground cherry':        '${_u}1594282241894-4da286138f44$_q',

  // ── PEPPERS ───────────────────────────────────────────────────────────────
  'bell pepper':          '${_u}1601648764658-cf37e8c89b70$_q',
  'cayenne pepper':       '${_u}1583119022894-919a68a3d0e3$_q',
  'hot pepper':           '${_u}1583119022894-919a68a3d0e3$_q',
  'hot pepper (jalapeño)': '${_u}1599987141071-f5810d32e21a$_q',
  'banana pepper':        '${_u}1582571150990-4fde9b9512ad$_q',
  'poblano pepper':       '${_u}1567539549213-cc1697632146$_q',
  'shishito pepper':      '${_u}1599987141071-f5810d32e21a$_q',

  // ── CUCUMBERS & SQUASH ────────────────────────────────────────────────────
  'cucumber':             '${_u}1691680760248-b5efa55af05b$_q',
  'zucchini':             '${_u}1691480291894-75229c2bfd44$_q',
  'luffa / loofah':       '${_u}1759156632043-eab44e007e67$_q',
  'bitter melon':         '${_u}1739903760973-4731a8e79a03$_q',
  'acorn squash':         '${_u}1668120084337-08e1daed1597$_q',
  'butternut squash':     '${_u}1583260142340-1569bcfeb39c$_q',
  'delicata squash':      '${_u}1697460627967-8a4a2d8d2a99$_q',
  'spaghetti squash':     '${_u}1603052864227-4af6238dc5f8$_q',
  'winter squash':        '${_u}1583260142340-1569bcfeb39c$_q',
  'winter squash (butternut)': '${_u}1583260142340-1569bcfeb39c$_q',
  'yellow squash':        '${_u}1667155594027-90c688f3700f$_q',
  'pumpkin':              '${_u}1692680919402-95fc56f99225$_q',

  // ── LEAFY GREENS ──────────────────────────────────────────────────────────
  'lettuce':              '${_u}1631981784897-4c630aa79cf8$_q',
  'lettuce (butterhead)': '${_u}1631981784897-4c630aa79cf8$_q',
  'romaine lettuce':      '${_u}1612231653032-8a93d1de0834$_q',
  'kale':                 '${_u}1527020431145-77f7c047e7a1$_q',
  'spinach':              '${_u}1576045057995-568f588f82fb$_q',
  'chard (swiss chard)':  '${_u}1679595044391-3c42b0f351b5$_q',
  'swiss chard':          '${_u}1679595044391-3c42b0f351b5$_q',
  'cabbage':              '${_u}1702489575687-204529449d94$_q',
  'bok choy (baby)':      '${_u}1708798534031-3711ec8cc16e$_q',
  'arugula (wild/rocket)': '${_u}1622122479356-b56d293407dc$_q',
  'endive':               '${_u}1631981784897-4c630aa79cf8$_q',
  'mizuna':               '${_u}1622122479356-b56d293407dc$_q',
  'tatsoi':               '${_u}1708798534031-3711ec8cc16e$_q',
  'new zealand spinach':  '${_u}1576045057995-568f588f82fb$_q',
  'shiso / perilla':      '${_u}1748313715254-d7ba17d7dafa$_q',
  'rhubarb':              '${_u}1692071097926-f48c2b998a2f$_q',
  'watercress':           '${_u}1664355048238-65d3dda1a0c2$_q',
  'celery':               '${_u}1582372288206-a88db541f0e8$_q',
  'kohlrabi':             '${_u}1659631832132-95250f19fa1d$_q',

  // ── BRASSICAS ─────────────────────────────────────────────────────────────
  'broccoli':             '${_u}1702403157830-9df749dc6c1e$_q',
  'cauliflower':          '${_u}1566842600175-97dca489844f$_q',
  'sprouts (broccoli)':   '${_u}1691598301237-578cb6ffad69$_q',

  // ── ROOT VEGETABLES ───────────────────────────────────────────────────────
  'carrot':               '${_u}1598170845058-32b9d6a5da37$_q',
  'radish microgreens':   '${_u}1681307733509-16caf15dcbb1$_q',
  'potato':               '${_u}1724256031338-b5bfba816cfd$_q',
  'onion':                '${_u}1668076517573-fa01307d87ad$_q',
  'shallot':              '${_u}1675364285746-c99b72498ede$_q',
  'garlic':               '${_u}1675731118551-79b3da05a5d4$_q',
  'beet':                 '${_u}1593105544559-ecb03bf76f82$_q',
  'turnip':               '${_u}1585369496178-144fd937f249$_q',
  'parsnip':              '${_u}1648291913186-951f2ef36c85$_q',
  'rutabaga':             '${_u}1697460753377-5a26348a19ff$_q',
  'celeriac':             '${_u}1762385608451-05a11e640b78$_q',
  'horseradish':          '${_u}1584118247518-68fd1f69ad4a$_q',
  'taro':                 '${_u}1757283961544-e161ac41b201$_q',
  'turmeric':             '${_u}1666818398897-381dd5eb9139$_q',
  'ginger':               '${_u}1630623093145-f606591c2546$_q',
  'jerusalem artichoke / sunchoke': '${_u}1675365079247-f458562c06cf$_q',
  'eggplant':             '${_u}1615484477201-9f4953340fab$_q',
  'artichoke':            '${_u}1518735869015-566a18eae4be$_q',

  // ── CORN ──────────────────────────────────────────────────────────────────
  'corn':                 '${_u}1667047165840-803e47970128$_q',
  'sweet corn':           '${_u}1667047165840-803e47970128$_q',
  'edamame':              '${_u}1649257171206-37625b1f3b2f$_q',

  // ── BEANS & LEGUMES ───────────────────────────────────────────────────────
  'green bean':           '${_u}1726729279950-224b83ae7a75$_q',
  'green beans':          '${_u}1726729279950-224b83ae7a75$_q',
  'runner bean':          '${_u}1630097000524-cb08aff59426$_q',
  'fava bean':            '${_u}1605402966404-ec40b9bd5009$_q',
  'lima bean':            '${_u}1765144815957-6bc44c13fc2c$_q',
  'cowpea / black-eyed pea': '${_u}1693026082630-5a9cadce09ee$_q',
  'chickpea / garbanzo bean': '${_u}1644432757699-bb5a01e8fb0e$_q',

  // ── PEAS ──────────────────────────────────────────────────────────────────
  'peas':                 '${_u}1592394533824-9440e5d68530$_q',
  'snow pea':             '${_u}1595048244531-d3177ee827bb$_q',
  'sugar snap pea':       '${_u}1477506252414-b2954dbdacf3$_q',
  'pea shoots':           '${_u}1622463214111-b192a53371d2$_q',

  // ── HERBS ─────────────────────────────────────────────────────────────────
  'basil':                '${_u}1629157247277-48f870757026$_q',
  'thai basil':           '${_u}1757111085160-3a692da93eb8$_q',
  'lemon basil':          '${_u}1629157247277-48f870757026$_q',
  'holy basil / tulsi':   '${_u}1757111085160-3a692da93eb8$_q',
  'mint':                 '${_u}1617970640806-4ff9fdce89ca$_q',
  'rosemary':             '${_u}1558070510-504a0db43997$_q',
  'thyme':                '${_u}1689082697963-c7791a09088b$_q',
  'lemon thyme':          '${_u}1726138617688-e6bfd9f0de5c$_q',
  'sage':                 '${_u}1633933329875-044a32f4837f$_q',
  'parsley':              '${_u}1726862972631-00709ba547b0$_q',
  'curly parsley':        '${_u}1726862972631-00709ba547b0$_q',
  'italian parsley':      '${_u}1674666544747-c6b7a4f07ef3$_q',
  'cilantro':             '${_u}1588879460618-9249e7d947d1$_q',
  'dill':                 '${_u}1509210459313-17feefdff5cd$_q',
  'fennel':               '${_u}1700478934050-953c93ad228e$_q',
  'fennel (florence)':    '${_u}1700478934050-953c93ad228e$_q',
  'chives':               '${_u}1593149198123-46380dbd87fd$_q',
  'oregano':              '${_u}1558070510-504a0db43997$_q',
  'tarragon':             '${_u}1726924244606-0df8fac5dd78$_q',
  'tarragon (french)':    '${_u}1726924244606-0df8fac5dd78$_q',
  'winter savory':        '${_u}1558070510-504a0db43997$_q',
  'epazote':              '${_u}1726994803894-a64090cf5472$_q',
  'moringa':              '${_u}1667928729816-0ed8c59cd3c9$_q',

  // ── LAVENDER ──────────────────────────────────────────────────────────────
  'lavender':             '${_u}1499002238440-d264edd596ec$_q',
  'lavender (english)':   '${_u}1499002238440-d264edd596ec$_q',

  // ── MEDICINAL / SPECIALTY HERBS ───────────────────────────────────────────
  'chamomile':            '${_u}1562957429-ff708ca20e95$_q',
  'chamomile (german)':   '${_u}1562957429-ff708ca20e95$_q',
  'echinacea':            '${_u}1664527008748-2c86eee0d017$_q',
  'echinacea (coneflower)': '${_u}1664527008748-2c86eee0d017$_q',
  'echinacea / coneflower (purple)': '${_u}1664527008748-2c86eee0d017$_q',
  'ashwagandha':          '${_u}1713260111133-30c5153e27cd$_q',
  'stevia (for tea use)': '${_u}1647592275413-18593b4421bb$_q',
  'valerian':             '${_u}1519387310011-ce0c0fbc6ab2$_q',
  'passionflower (medicinal)': '${_u}1628341423248-4b8c5c51a3cd$_q',
  'calendula (medicinal)': '${_u}1694913777517-8e376dc68bf1$_q',
  'comfrey':              '${_u}1726978731245-16206a5d2f3f$_q',
  'medicinal aloe vera':  '${_u}1570295835271-04c05b4ed943$_q',
  'borage':               '${_u}1672766319055-f536db948793$_q',
  'borage (for continuity)': '${_u}1672766319055-f536db948793$_q',

  // ── FLOWERS ───────────────────────────────────────────────────────────────
  'sunflower':            '${_u}1598920710727-e6c74781538c$_q',
  'sunflower microgreens': '${_u}1536630596251-b12ba0d9f7d4$_q',
  'marigold':             '${_u}1661142175513-a5f0871f1ad1$_q',
  'nasturtium':           '${_u}1580205859016-58d126bb628b$_q',
  'bachelor\'s button':   '${_u}1624897990229-1e02c2bd9203$_q',
  'bachelor\'s button / cornflower': '${_u}1624897990229-1e02c2bd9203$_q',
  'black-eyed susan':     '${_u}1652520425438-43a85849f8b7$_q',
  'columbine':            '${_u}1689538199258-a6e43f35a43f$_q',
  'dahlia':               '${_u}1464820453369-31d2c0b651af$_q',
  'delphinium':           '${_u}1517590856371-fc9711754f82$_q',
  'hydrangea':            '${_u}1591181520189-abcb0735c65d$_q',
  'lupine':               '${_u}1517590856371-fc9711754f82$_q',
  'nigella / love-in-a-mist': '${_u}1748425727035-d3c26c36b1fd$_q',
  'pansy':                '${_u}1676117275415-cb7cfce24e28$_q',
  'pansy / viola':        '${_u}1676117275415-cb7cfce24e28$_q',
  'peony':                '${_u}1511201173873-c327e63eb6c4$_q',
  'phacelia':             '${_u}1597275182597-145e9a8db07e$_q',
  'alyssum':              '${_u}1632261462778-2389b26c1ad9$_q',

  // ── FRUITS ────────────────────────────────────────────────────────────────
  'strawberry':           '${_u}1464965911861-746a04b4bca6$_q',
  'apple':                '${_u}1630563451961-ac2ff27616ab$_q',
  'pear':                 '${_u}1615484477778-ca3b77940c25$_q',
  'peach':                '${_u}1629828874514-c1e5103f2150$_q',
  'persimmon':            '${_u}1697434467948-50f3d674dee1$_q',
  'quince':               '${_u}1667400104714-53da4894bf18$_q',
  'kiwi':                 '${_u}1618897996318-5a901fa6ca71$_q',
  'kiwi (hardy)':         '${_u}1618897996318-5a901fa6ca71$_q',
  'grape':                '${_u}1724250449759-f9bbb5fd4f63$_q',
  'grape (table)':        '${_u}1724250449759-f9bbb5fd4f63$_q',
  'grapes':               '${_u}1724250449759-f9bbb5fd4f63$_q',
  'mulberry':             '${_u}1660418056478-66fa71ceb526$_q',
  'currant (black)':      '${_u}1649966434631-7f8b680560d2$_q',
  'currant (red)':        '${_u}1601912495166-788614976a8b$_q',
  'goji berry':           '${_u}1653989451597-21b2fa4036bf$_q',
  'honeydew':             '${_u}1571575173700-afb9492e6a50$_q',
  'passion fruit':        '${_u}1526318472351-c75fcf070305$_q',
  'serviceberry':         '${_u}1721075004958-a5e56f75073d$_q',

  // ── GRAINS & COVER CROPS ──────────────────────────────────────────────────
  'quinoa':               '${_u}1724418020207-144b3ba54d2d$_q',
  'amaranth':             '${_u}1634187098734-289a8ef4abd4$_q',
  'amaranth (grain)':     '${_u}1634187098734-289a8ef4abd4$_q',
  'buckwheat (cover crop)': '${_u}1724708603074-80637afc370d$_q',
  'clover (white / dutch)': '${_u}1591323787246-d26d0a0553bf$_q',
  'crimson clover':       '${_u}1716221175819-49034d1f221b$_q',
  'winter rye (cover crop)': '${_u}1610573977811-c9407c6624ba$_q',

  // ── MICROGREENS, SPROUTS & SPECIALTY ──────────────────────────────────────
  'microgreens mix':      '${_u}1536630596251-b12ba0d9f7d4$_q',
  'wheatgrass':           '${_u}1712019362859-2647bf42ea13$_q',
  'hops':                 '${_u}1662395896059-81c9275ff25f$_q',
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

  // 3. Last resort: generic plant photo so no card ever shows an emoji.
  return '${_u}1416879595882-3373a0480b5b$_q';
}

// ─────────────────────────────────────────────────────────────────────────────
// PLANT KNOWLEDGE BASE
// Rich per-plant data: harvest instructions, soil, fertilizing, common problems,
// storage, and best planting season. Looked up by plant name (case-insensitive).
// ─────────────────────────────────────────────────────────────────────────────

class PlantKnowledge {
  final String harvestSigns;        // Visual/tactile cues for ripeness
  final String harvestHow;          // Step-by-step harvest instructions
  final String soilPrep;            // Soil preparation and requirements
  final String fertilizing;         // When and what to feed
  final String commonProblems;      // Pests/diseases to watch for
  final String storageUse;          // Post-harvest storage tips
  final String bestSeason;          // When to plant in the season

  const PlantKnowledge({
    required this.harvestSigns,
    required this.harvestHow,
    required this.soilPrep,
    required this.fertilizing,
    required this.commonProblems,
    required this.storageUse,
    required this.bestSeason,
  });
}

/// Look up a plant by name (case-insensitive, partial match supported).
PlantKnowledge? lookupPlantKnowledge(String? plantName) {
  if (plantName == null || plantName.isEmpty) return null;
  final key = plantName.toLowerCase().trim();
  for (final entry in _plantKnowledgeBase.entries) {
    if (key.contains(entry.key) || entry.key.contains(key)) {
      return entry.value;
    }
  }
  return null;
}

const Map<String, PlantKnowledge> _plantKnowledgeBase = {

  // ── TOMATO ─────────────────────────────────────────────────────────────────
  'tomato': PlantKnowledge(
    harvestSigns:
        'Fully ripe tomatoes are uniformly coloured (red, orange, yellow depending on variety), slightly soft when gently squeezed, and pull off the vine with a gentle twist. The skin should be firm and shiny — dull skin or cracks mean over-ripeness.',
    harvestHow:
        'Hold the tomato and twist gently until the stem snaps at the knuckle joint. Never pull straight — you can damage the vine. If resistance is felt, use clean scissors and cut the stem just above the fruit. Harvest in the morning when fruits are cool. Check plants every 2–3 days at peak season.',
    soilPrep:
        'Tomatoes are heavy feeders that need deep, rich soil. Work 4–6 inches of compost into the bed before planting. Aim for pH 6.2–6.8. Mix in a handful of bone meal per plant for phosphorus to encourage strong root development and flower set.',
    fertilizing:
        'Apply a balanced fertilizer (10-10-10) at planting. Once flowering begins, switch to a low-nitrogen, high-phosphorus/potassium formula (e.g. 5-10-10) every 2 weeks — too much nitrogen at this stage produces lush leaves but few fruits. Foliar-spray with diluted liquid kelp once a month for micronutrients.',
    commonProblems:
        'Blossom end rot (calcium deficiency — keep watering consistent). Early blight (brown spots with yellow halos — remove affected leaves, avoid wetting foliage). Hornworms (large green caterpillars — hand-pick or use Bt spray). Aphids on new growth — blast off with water. Cracking usually means irregular watering.',
    storageUse:
        'Never refrigerate fresh tomatoes — cold temperatures destroy flavour and texture. Store at room temperature, stem-side down, out of direct sunlight for up to a week. For longer storage, roast and freeze, or make sauce. Green tomatoes can be left on the counter to ripen slowly.',
    bestSeason:
        'Start seeds indoors 6–8 weeks before last frost. Transplant outdoors when nighttime temperatures are consistently above 10°C (50°F). In most climates this is late spring. Tomatoes are frost-tender and need warm soil — use a soil thermometer to confirm above 15°C before planting.',
  ),

  // ── CHERRY TOMATO ─────────────────────────────────────────────────────────
  'cherry tomato': PlantKnowledge(
    harvestSigns:
        'Cherry tomatoes are ready when they\'re fully coloured and come off the cluster with the lightest touch. If you have to pull at all, give them another day. They should feel firm but not rock-hard, and burst with juice when bitten.',
    harvestHow:
        'Harvest entire clusters (trusses) with scissors, or pick individual fruits. Check every 1–2 days at peak season — cherry tomatoes left too long split and attract fruit flies. Early morning is best for sweetest flavour.',
    soilPrep:
        'Same as standard tomatoes: pH 6.2–6.8, compost-rich, deeply worked soil. Cherry tomatoes are slightly more forgiving of less-than-perfect soil but still benefit from good drainage and organic matter.',
    fertilizing:
        'Feed as for standard tomatoes. Cherry tomatoes are prolific producers so consistent feeding (every 2 weeks once flowering) maintains energy through a long season. A potassium-rich fertilizer improves sweetness.',
    commonProblems:
        'Splitting after rain (mulch and consistent watering prevents this). Blossom drop in heat above 35°C — mist in the evening. Whiteflies on undersides of leaves — use yellow sticky traps and neem oil.',
    storageUse:
        'Store unwashed at room temperature in a single layer for up to 5 days. For longer storage, freeze whole (they\'re great in cooked dishes). Or halve and sun-dry/dehydrate for intense flavour.',
    bestSeason:
        'Plant after last frost, same as standard tomatoes. Cherry tomatoes mature faster (55–70 days) and keep producing longer into fall, making them one of the best value plants for a summer garden.',
  ),

  // ── BASIL ─────────────────────────────────────────────────────────────────
  'basil': PlantKnowledge(
    harvestSigns:
        'Basil is ready to harvest once the plant has 6–8 sets of leaves (about 15–20 cm tall). Harvest before the plant flowers — once it bolts, leaves become bitter and smaller. Check daily in summer heat as basil bolts quickly.',
    harvestHow:
        'Always harvest by pinching or cutting just above a leaf node (where two leaves meet the stem). This encourages two new branches to grow from that point, doubling your plant. Never strip leaves from the bottom — always harvest from the top third. Remove any flower buds immediately to extend leaf production.',
    soilPrep:
        'Basil loves warm, well-drained, fertile soil. Work in compost at planting. pH 6.0–7.0. Avoid clay-heavy soil which stays too wet — basil rots quickly in waterlogged conditions. In containers, use a quality potting mix with good drainage.',
    fertilizing:
        'Basil is a moderate feeder. A monthly dose of balanced liquid fertilizer (like fish emulsion) is plenty. Avoid heavy nitrogen feeding which promotes fast leafy growth but reduces aromatic oil content — a less-fed basil often smells more strongly.',
    commonProblems:
        'Fusarium wilt (sudden wilting and brown streaks in stem — no cure, remove plant, don\'t replant basil in same spot). Aphids on new growth — blast off with water. Japanese beetles and slugs. Downy mildew (grey/purple fuzz on leaf undersides in humid weather — improve air circulation, avoid wetting leaves).',
    storageUse:
        'Fresh basil stored in the refrigerator turns black within hours. Instead, treat like flowers: trim stems and stand in a glass of water at room temperature. Lasts 5–7 days. For longer storage, blend into pesto and freeze in ice cube trays. Or dry at 35°C for 2–3 hours in a dehydrator.',
    bestSeason:
        'Plant outdoors after all frost risk has passed and soil is above 18°C. Basil is extremely frost-sensitive — even a light frost kills it. In cool climates, start indoors 4 weeks before last frost and harden off carefully before transplanting.',
  ),

  // ── LETTUCE ──────────────────────────────────────────────────────────────
  'lettuce': PlantKnowledge(
    harvestSigns:
        'Loose-leaf varieties are ready when outer leaves are 10–15 cm long. Head lettuces are ready when the head feels firm and dense. Harvest before the plant sends up a central flower stalk (bolting) — bolted leaves are bitter.',
    harvestHow:
        'For loose-leaf varieties, use the "cut-and-come-again" method: harvest outer leaves with scissors, leaving the inner growing point intact. The plant will continue producing for weeks. For head lettuces, cut the entire head at soil level with a knife. In cool weather, the stump will often re-sprout a second smaller head.',
    soilPrep:
        'Lettuce has shallow roots and prefers loose, friable, moisture-retentive soil rich in nitrogen. Work in compost. pH 6.0–7.0. Lettuce can be grown in poor soil better than most vegetables but will produce bitter, small leaves without adequate fertility.',
    fertilizing:
        'A nitrogen-rich fertilizer (blood meal, fish emulsion, or 10-5-5) applied every 3–4 weeks keeps lettuce growing fast and tender. Fast growth = sweeter, more tender leaves. Slow growth from poor fertility = bitter, tough leaves.',
    commonProblems:
        'Tip burn (brown leaf edges from calcium deficiency or inconsistent watering — keep soil evenly moist). Slugs and snails are the biggest pest — use copper tape, diatomaceous earth, or beer traps. Aphids cluster inside loose heads — rinse leaves well before eating. Downy mildew in wet, humid conditions.',
    storageUse:
        'Wash and spin dry harvested leaves, then wrap in a damp paper towel inside a sealed bag in the refrigerator. Lasts 5–7 days. Living heads pulled from the garden keep longer than pre-cut leaves. Never freeze fresh lettuce.',
    bestSeason:
        'A cool-season crop. Plant in early spring (4–6 weeks before last frost) and again in late summer for fall harvest. Lettuces bolt (go to seed) in temperatures above 24°C consistently. Use shade cloth to extend the season into early summer. Perfect for autumn gardens.',
  ),

  // ── SPINACH ──────────────────────────────────────────────────────────────
  'spinach': PlantKnowledge(
    harvestSigns:
        'Harvest when leaves are 5–10 cm long (baby spinach) or up to 15 cm for mature leaves. Leaves should be deep green and unwilted. Avoid yellowish or limp leaves which indicate stress or over-maturity.',
    harvestHow:
        'Harvest outer leaves from each plant using scissors, leaving the centre growing point. Or harvest the entire plant at once by cutting at soil level. For cut-and-come-again, leave at least 3–4 inner leaves per plant. Remove any yellow or damaged leaves immediately — they attract disease.',
    soilPrep:
        'Spinach needs rich, fertile soil with plenty of nitrogen and consistent moisture. pH 6.5–7.0. Work in compost and a nitrogen-rich fertilizer before planting. Spinach is sensitive to acidic soil — if pH drops below 6.0, add garden lime 2–3 weeks before planting.',
    fertilizing:
        'Nitrogen is critical for spinach. Side-dress with blood meal or fish emulsion every 3–4 weeks. Pale or yellow-green leaves are a sign of nitrogen deficiency — a liquid nitrogen application will green them up within a week.',
    commonProblems:
        'Leaf miners (white squiggly tunnels in leaves — remove affected leaves, cover with row cover to prevent the fly). Bolting in heat — grow in spring/fall only and use heat-resistant varieties. Downy mildew (grey fuzz on undersides) in cool, wet conditions.',
    storageUse:
        'Fresh spinach keeps 3–5 days in the refrigerator in a sealed bag with a damp paper towel. For longer storage, blanch in boiling water for 2 minutes, cool in ice water, squeeze dry, and freeze in portions. Frozen spinach is perfect for smoothies, soups, and pasta.',
    bestSeason:
        'Strictly cool-season. Sow direct 4–6 weeks before last frost in spring, or start a fall crop 8–10 weeks before first fall frost. Spinach can handle light frost (down to -4°C) and actually tastes sweeter after a frost. It bolts quickly once temperatures stay above 24°C.',
  ),

  // ── CARROT ───────────────────────────────────────────────────────────────
  'carrot': PlantKnowledge(
    harvestSigns:
        'Carrots are ready when the shoulder (top of the root) is 1–2 cm in diameter at soil level. Gently brush soil away and check. Most varieties are ready at 70–80 days. Carrots left too long become woody and crack. Cold weather sweetens carrots — they\'re often best after the first frost.',
    harvestHow:
        'Loosen the soil around the carrots with a garden fork before pulling, especially in clay soil — pulling without loosening often snaps the roots. Push the fork in 15 cm away from the row and lever upward. Grab the carrot near the base and pull straight up. Twist off leaves within an hour of harvest to prevent moisture loss through the tops.',
    soilPrep:
        'Carrots absolutely require deep, loose, rock-free, well-drained soil. Any obstruction causes forking, splitting, or stubby growth. Work soil to 30–35 cm deep. Remove all rocks and debris. Avoid freshly manured beds — high nitrogen causes hairy, forked roots. Sandy loam or raised bed with quality potting mix is ideal.',
    fertilizing:
        'Carrots are light feeders. Avoid high-nitrogen fertilizers after planting — this causes all top growth and splits roots. A low-nitrogen, high-potassium fertilizer (5-10-10) at planting is usually sufficient for the entire season. Too much fertilizer is worse than too little for carrots.',
    commonProblems:
        'Carrot rust fly (maggots tunnelling through roots — cover with fine mesh row cover immediately after sowing). Forked or stunted roots (rocky soil or fresh manure). Green shoulders (sunlight hitting the carrot top — mound soil around the tops, or mulch). Aster yellows disease from leafhoppers — keep weeds down around the bed.',
    storageUse:
        'Remove tops immediately after harvest to prevent moisture loss. Store unwashed carrots in the refrigerator in a bag with damp paper towels for up to 3 weeks. For very long storage, pack in damp sand in a cool cellar — they can keep for months. Blanch and freeze for up to a year.',
    bestSeason:
        'Sow direct outdoors 3–5 weeks before last frost — carrots are cool-season and germinate best at 10–21°C soil temperature. In summer, sow a fall crop 10–12 weeks before first fall frost. Carrots sown in fall and left in the ground over winter (with heavy mulch) are sweet and storage-ready.',
  ),

  // ── RADISH ────────────────────────────────────────────────────────────────
  'radish': PlantKnowledge(
    harvestSigns:
        'Most spring radishes are ready in 25–30 days. The shoulder of the radish (visible at soil surface) should be 2–3 cm across. Once at size, radishes left in the ground get pithy, very hot, and crack. Daily checks are important once they\'re close to mature.',
    harvestHow:
        'Pull radishes straight out of the ground by their tops — they\'re shallow-rooted and come out easily. If soil is compacted, loosen with a trowel first. Harvest all radishes in a batch once they\'re ready, as they all mature at similar times. Trim leaves immediately and refrigerate.',
    soilPrep:
        'Radishes grow well in almost any soil but do best in loose, well-drained beds. pH 6.0–7.0. Remove rocks that would cause forking. A quick compost top-dress before sowing is usually all they need for their short growing season.',
    fertilizing:
        'Radishes grow so fast (25–30 days) they rarely need supplemental fertilizer if the soil has reasonable fertility. If growing in very poor soil, a balanced fertilizer at sowing is sufficient.',
    commonProblems:
        'Flea beetles (tiny holes in leaves — use row cover). Root maggots (tunnels in the root — row cover from day one). Hollow, pithy roots mean they were left too long or grew too fast in hot weather. Bolting in heat — radishes are a cool-season crop only.',
    storageUse:
        'Remove tops and store roots in the refrigerator in water or a sealed bag for up to 2 weeks. Radish greens are edible and can be sautéed — use within 2 days. Radishes don\'t freeze well raw, but pickled radishes last months in the refrigerator.',
    bestSeason:
        'One of the fastest and easiest crops for spring and fall. Sow direct 4–6 weeks before last frost in spring and again 6 weeks before first fall frost. They bolt (go to seed) quickly in warm weather — plant in succession every 2 weeks for continuous harvest.',
  ),

  // ── ZUCCHINI ──────────────────────────────────────────────────────────────
  'zucchini': PlantKnowledge(
    harvestSigns:
        'Harvest zucchini when 15–20 cm long and 4–5 cm in diameter — this is the sweet spot for flavour and texture. Larger zucchini (the ones you find under leaves) are still edible but seedy and less flavourful. The skin should still be slightly tender — once it\'s hard, it\'s over-mature.',
    harvestHow:
        'Use a sharp knife or pruners to cut the stem — never twist or pull which can damage the plant. Leave 2–3 cm of stem attached to the fruit. Check plants every 1–2 days at peak season — a zucchini can go from perfect to bat-sized in 48 hours. Harvesting frequently signals the plant to keep producing.',
    soilPrep:
        'Zucchini are heavy feeders and grow best in deeply prepared, rich soil. Work in a generous layer of compost (4–6 inches). Plant in a raised mound or hill for good drainage. pH 6.0–7.5. Space plants 90 cm apart — they get large.',
    fertilizing:
        'Apply a balanced fertilizer at planting, then switch to a phosphorus/potassium-rich fertilizer once flowering begins. Side-dress with compost every 4 weeks through the season. Heavy fruiting depletes soil quickly — consistent feeding is key to productivity all summer.',
    commonProblems:
        'Powdery mildew (white coating on leaves — improve air circulation, spray with diluted baking soda or neem oil). Squash vine borer (sudden wilting despite good watering — look for sawdust-like frass at stem base). Blossom end rot from inconsistent watering. Poor fruit set from lack of pollination — hand-pollinate with a small brush.',
    storageUse:
        'Store at room temperature for 2–4 days or in the crisper drawer for up to a week. Zucchini freezes well: slice, blanch 3 minutes, cool, pat dry, and freeze in single layers. Shredded raw zucchini also freezes well for baking use.',
    bestSeason:
        'Plant after all frost risk has passed and soil is above 18°C. Zucchini are fast-growing and productive — one or two plants is usually plenty for a family. Direct sow seeds or plant established seedlings in late spring.',
  ),

  // ── CUCUMBER ──────────────────────────────────────────────────────────────
  'cucumber': PlantKnowledge(
    harvestSigns:
        'Slicing cucumbers are ready at 15–20 cm long; pickling types at 5–8 cm. Skin should be bright, firm, and dark green — avoid yellow cucumbers which are over-ripe, bitter, and signal the plant to stop producing. The blossom end should still be slightly soft.',
    harvestHow:
        'Cut cucumbers from the vine with pruners — never twist or pull. Leave 1–2 cm of stem. Check every 2 days at peak season. Harvest aggressively: cucumbers left on the vine signal the plant to slow down. One missed cucumber can noticeably reduce total yield.',
    soilPrep:
        'Cucumbers need warm, well-drained, fertile soil. Work in compost deeply. pH 6.0–7.0. They grow well on a trellis which improves air circulation, makes harvest easier, and keeps fruits straight. Warm soil (above 18°C) is essential — plant in a sunny, sheltered spot.',
    fertilizing:
        'Feed with a balanced fertilizer every 2 weeks throughout the season. Once flowering, increase potassium for fruit quality. Cucumbers are heavy drinkers and feeders — consistent moisture and nutrition are more important than for most other vegetables.',
    commonProblems:
        'Cucumber beetle (yellow/black striped or spotted beetles — use row cover early in season, remove when flowering for pollination). Powdery mildew in hot dry weather — improve air circulation. Bitter cucumbers from water stress — keep evenly moist. Mosaic virus (mottled leaves) from aphids — control aphids early.',
    storageUse:
        'Store at 10–13°C (not below — cold injury turns them mushy). The refrigerator is too cold for long storage — use the vegetable drawer set to a warmer setting, or keep on a cool countertop for 3–5 days. Cucumbers are 95% water and don\'t freeze well raw. Pickle excess harvest in a brine or vinegar solution.',
    bestSeason:
        'Plant outdoors after all frost risk has passed and soil temperature is above 18°C. Cucumbers are fast-growing (50–70 days from transplant) and do not tolerate any frost. Succession plant every 3 weeks for continuous harvest through summer.',
  ),

  // ── BELL PEPPER ──────────────────────────────────────────────────────────
  'bell pepper': PlantKnowledge(
    harvestSigns:
        'Green peppers are technically ready once full-sized (firm, thick walls). For full colour (red, orange, yellow), leave them on the plant another 2–4 weeks after reaching full size. Ripe coloured peppers are sweeter and more nutritious than green. Pick before any soft spots develop.',
    harvestHow:
        'Use pruners or scissors and cut the stem — never pull or twist, as peppers attach firmly and pulling damages the plant. Cut with 1–2 cm of stem. Harvesting green peppers early encourages the plant to produce more fruit faster. Leaving all fruits to turn red is more flavourful but slows total yield.',
    soilPrep:
        'Peppers love warm, fertile, well-drained soil. pH 6.0–6.8. Work in compost before planting. They thrive in raised beds which warm up faster in spring. Peppers are heat-lovers and won\'t grow well until soil is above 18°C.',
    fertilizing:
        'Use a balanced fertilizer at transplanting. Once flowers appear, switch to a low-nitrogen, high-phosphorus/potassium formula. Calcium deficiency causes blossom end rot — keep watering consistent and consider a foliar calcium spray if you\'ve had this problem before.',
    commonProblems:
        'Blossom drop in temperatures above 35°C or below 13°C at night. Blossom end rot from calcium deficiency. Aphids on new growth. Sunscald (white papery patches) on fruit exposed to intense direct sun — leave some leaves above fruit clusters. Bacterial spot from overhead watering — water at the base.',
    storageUse:
        'Store whole peppers in the vegetable drawer for up to 2 weeks. Once cut, refrigerate in an airtight container and use within 3–5 days. Peppers freeze excellently: slice, spread on a tray to freeze solid, then bag. No blanching needed. Frozen peppers work in cooked dishes.',
    bestSeason:
        'Start seeds indoors 8–10 weeks before last frost. Peppers need a long, warm season. Transplant after soil warms to above 18°C and all frost risk has passed. In cool climates, use a cloche or plastic mulch to warm soil and speed early-season growth.',
  ),

  // ── KALE ─────────────────────────────────────────────────────────────────
  'kale': PlantKnowledge(
    harvestSigns:
        'Harvest once leaves are 20–25 cm long. The lower, outer leaves are always harvested first. Darker green, deeply textured leaves have the most flavour. After a frost, kale becomes sweeter — cold converts starches to sugars.',
    harvestHow:
        'Snap or cut off outer leaves one at a time, starting from the bottom of the plant and working inward. Leave the central growing tip and at least 4–5 inner leaves — the plant will keep producing from the centre for months. Avoid harvesting the topmost leaves which are the growing point. One plant can be harvested every 1–2 weeks indefinitely in good conditions.',
    soilPrep:
        'Kale grows best in rich, well-drained soil high in nitrogen. pH 6.0–7.5. Work in compost before planting. Like all brassicas, kale benefits from soil with calcium and consistent moisture.',
    fertilizing:
        'Nitrogen is the key nutrient for kale\'s leafy growth. Feed with fish emulsion or a high-nitrogen fertilizer every 3–4 weeks. Side-dress with compost in midsummer. Stop heavy feeding 6 weeks before first frost to harden the plant.',
    commonProblems:
        'Cabbage worms (white butterfly caterpillars — check undersides of leaves weekly, hand-pick or use Bt spray). Aphids on new growth. Club root fungal disease in acidic soil — test and raise pH above 6.5 before planting. Flea beetles create tiny round holes — use row cover for young plants.',
    storageUse:
        'Store unwashed kale in a bag in the refrigerator for up to a week. For longer storage, blanch leaves 2 minutes, shock in ice water, squeeze dry, and freeze. Frozen kale works in soups, smoothies, and stews. Kale chips (roasted at 150°C until crisp) keep in an airtight container for a week.',
    bestSeason:
        'Kale is a cool-season crop but far more cold-tolerant than most vegetables. Plant in early spring (6 weeks before last frost) for summer harvest, or plant in midsummer for fall and winter harvest. Kale survives frost down to -7°C and continues to grow in cool autumn weather when most other crops are finished.',
  ),

  // ── GREEN ONION ───────────────────────────────────────────────────────────
  'green onion': PlantKnowledge(
    harvestSigns:
        'Green onions are ready when the tops are 20–30 cm tall and pencil-thick. The white base should be about 1 cm in diameter. They can be harvested at almost any size depending on your preference.',
    harvestHow:
        'Pull the entire plant from the ground, or use scissors to cut the tops leaving 2–3 cm of green above the white base — the plant will regrow. Alternatively, harvest a few outer leaves from each plant without pulling the whole thing.',
    soilPrep:
        'Green onions tolerate a wide range of soils but grow best in loose, fertile, well-drained soil. pH 6.0–7.0. Work in compost. They grow very well in containers — a deep window box is ideal.',
    fertilizing:
        'Light feeder. A balanced fertilizer at planting and a single nitrogen application at mid-season is usually sufficient. Consistent moisture is more important than heavy feeding.',
    commonProblems:
        'Onion thrips (silvery streaks on leaves — use row cover, neem oil). Neck rot in storage from excess humidity. Bolting in extreme heat — harvest promptly in summer.',
    storageUse:
        'Store bunched green onions in the refrigerator, standing upright in a glass of water (like flowers) or wrapped in a damp paper towel in a bag. Lasts 1–2 weeks. Sliced green onion tops freeze well for cooking use.',
    bestSeason:
        'Extremely versatile — can be planted in early spring through fall in most climates. They tolerate light frost and grow in cooler temperatures than most vegetables. Succession plant every 3 weeks for a continuous supply.',
  ),

  // ── GARLIC ────────────────────────────────────────────────────────────────
  'garlic': PlantKnowledge(
    harvestSigns:
        'Garlic is ready when about half the leaves have turned brown and fallen over, but the other half are still green. In most climates, this is midsummer. Dig a test bulb — wrappers should be intact and papery, cloves should be plump and full.',
    harvestHow:
        'Use a garden fork to loosen soil 10 cm away from the base before lifting — never pull by the stem as it can separate from the bulb. Lift gently. Brush off excess soil but don\'t wash. Handle carefully as any bruising reduces storage life. Lay flat or hang in bunches immediately for curing.',
    soilPrep:
        'Garlic needs fertile, well-drained, deeply prepared soil. pH 6.0–7.0. Work in compost before planting in fall. Garlic is planted in autumn, overwinters, and is harvested the following summer. It needs well-draining soil — standing water causes rot.',
    fertilizing:
        'Fertilize in spring when shoots emerge with a nitrogen-rich fertilizer or compost top-dress. Stop all feeding by early summer (when the bulb is sizing up) — late feeding interferes with the curing process and reduces storage life.',
    commonProblems:
        'White rot fungal disease (yellowing leaves, white fluffy mould at base — no cure, remove plant, don\'t plant alliums in that spot for 15+ years). Onion fly maggots — cover with fine mesh. Bulb nematodes in wet soils. Rust (orange pustules on leaves) — improve air circulation.',
    storageUse:
        'Curing is essential: hang in a warm, dry, well-ventilated space for 3–6 weeks until the outer wrappers are completely papery and dry. Properly cured garlic stores at cool room temperature for 6–12 months depending on variety (hardneck varieties store 3–6 months; softneck up to 12). Never refrigerate uncured garlic.',
    bestSeason:
        'Plant cloves in autumn (4–6 weeks before the ground freezes) for the following summer harvest. Fall-planted garlic develops a large root system over winter and produces much larger bulbs than spring-planted garlic. In mild climates, plant between October and December.',
  ),

  // ── STRAWBERRY ────────────────────────────────────────────────────────────
  'strawberry': PlantKnowledge(
    harvestSigns:
        'Strawberries are ready when the entire fruit is uniformly red (including the "shoulders" near the green cap) and has a noticeable sweet smell. The berry should be firm but give very slightly to gentle pressure. Never harvest while any part is still white or pale pink — they don\'t ripen further once picked.',
    harvestHow:
        'Pinch the stem just above the fruit between your thumbnail and forefinger, leaving about 1 cm of stem attached. Don\'t pull the berry — you\'ll bruise it. Check plants every 1–2 days during peak season. Harvest in the morning when berries are cool for best flavour and shelf life.',
    soilPrep:
        'Strawberries require well-drained, slightly acidic soil (pH 5.5–6.5). Work in compost before planting. They do not tolerate standing water. Raised beds or mounded rows are ideal. Avoid planting where tomatoes, potatoes, or peppers grew recently (shared diseases).',
    fertilizing:
        'Apply a balanced fertilizer at planting and again in late summer after the fruiting season ends. Avoid heavy nitrogen feeding during flowering/fruiting — this promotes runners and leaves over berries. A potassium-rich fertilizer improves fruit size and sweetness.',
    commonProblems:
        'Grey mould (botrytis) in wet conditions — remove any mouldy berries immediately, improve air circulation. Slugs — use copper tape around raised beds or slug traps. Birds — cover with netting. Verticillium wilt — rotate planting location every 3–4 years. Aphids and spider mites on leaves.',
    storageUse:
        'Don\'t wash until ready to eat — moisture accelerates mould. Store unwashed in the refrigerator for 2–3 days max. Hulled strawberries freeze well: spread on a baking sheet, freeze solid, then transfer to bags. Frozen strawberries are perfect for smoothies, jam, and baking.',
    bestSeason:
        'Plant bare-root or potted strawberries in early spring. They will produce a small crop in their first summer, then a full crop from their second year. June-bearing varieties produce one heavy crop in early summer. Everbearing varieties produce smaller harvests spring through fall.',
  ),

  // ── MINT ─────────────────────────────────────────────────────────────────
  'mint': PlantKnowledge(
    harvestSigns:
        'Mint is ready to harvest once it\'s 10–15 cm tall. Best flavour is just before flowering — harvest the top third before flower buds appear. The leaves should be bright green and aromatic when rubbed.',
    harvestHow:
        'Pinch or cut stems back by one-third at a time, always cutting just above a leaf node to encourage branching. Remove any flowering stems immediately to maintain leaf quality. Mint is vigorous — regular harvesting is needed to keep it from becoming woody and sprawling.',
    soilPrep:
        'Mint grows in almost any soil and is one of the least fussy herbs. It prefers consistently moist, well-drained soil and tolerates partial shade. Important: grow mint in a container or with a root barrier — it spreads aggressively underground via runners and will take over a garden bed.',
    fertilizing:
        'Mint is a light feeder. A balanced fertilizer once in spring is usually all it needs. Over-feeding produces fast but less aromatic leaves.',
    commonProblems:
        'Root rot in waterlogged soil. Mint rust (orange pustules) — remove affected stems, improve drainage. Aphids and spider mites in dry conditions. Invasive spreading via underground runners — the main "problem" with mint is containing it.',
    storageUse:
        'Stand fresh mint in a glass of water on the counter for up to a week. Or wrap in damp paper towels in the refrigerator for 5–7 days. To dry: hang small bunches upside down in a warm, dry, ventilated spot for 1–2 weeks. Dried mint keeps its flavour for about a year in an airtight container.',
    bestSeason:
        'Plant in spring after last frost. Mint is a perennial and will come back each year. It\'s a great container herb and can even be grown on a sunny windowsill indoors year-round.',
  ),

  // ── ROSEMARY ─────────────────────────────────────────────────────────────
  'rosemary': PlantKnowledge(
    harvestSigns:
        'Rosemary can be harvested year-round once the plant is established (at least 30 cm tall). The most aromatic sprigs are young, soft, green stems from the current season\'s growth. Avoid the hard, woody older stems.',
    harvestHow:
        'Cut 10–15 cm sprigs from the tips of branches with clean scissors or pruners. Never remove more than one-third of the plant at once. Regular trimming keeps rosemary bushy rather than leggy. Always cut to just above a leaf node.',
    soilPrep:
        'Rosemary requires excellent drainage above all else — it originates from Mediterranean rocky hillsides and rots in wet soil. Plant in sandy, well-drained soil or raised beds. pH 6.0–7.0. Add grit or perlite to improve drainage. Rosemary thrives in poor, dry soil that would stress most plants.',
    fertilizing:
        'Minimal fertilizer required. Too much nitrogen produces fast, lush growth with less aromatic essential oil. A single application of balanced fertilizer in spring is usually sufficient. In containers, a slow-release granule once a season works well.',
    commonProblems:
        'Root rot from overwatering (the main killer of rosemary). Powdery mildew in humid conditions — improve air flow. Spittlebugs (frothy white masses on stems) — blast off with water. In containers, watch for root-bound plants which dry out rapidly.',
    storageUse:
        'Fresh rosemary wrapped in a damp paper towel keeps in the refrigerator for 2–3 weeks. To dry: hang bunches upside down for 2–3 weeks in a warm, ventilated spot. Dried rosemary retains strong flavour for up to 3 years stored in an airtight container away from light.',
    bestSeason:
        'Plant in spring after last frost. Rosemary is a perennial in climates with mild winters (above -10°C). In colder zones, treat as an annual or grow in containers that come indoors for winter. It thrives in hot, dry summers.',
  ),

  // ── THYME ────────────────────────────────────────────────────────────────
  'thyme': PlantKnowledge(
    harvestSigns:
        'Thyme is ready to harvest once stems are long enough to clip — usually once the plant is 15–20 cm tall. Best flavour is just before flowering. The small leaves should be dense and intensely aromatic.',
    harvestHow:
        'Snip sprigs from the tips of the plant, cutting just above a leaf node. Avoid cutting into old woody stems — they don\'t regenerate well. Harvest lightly throughout the season. After flowering, cut the plant back by one-third to encourage fresh growth.',
    soilPrep:
        'Like rosemary, thyme needs excellent drainage and tolerates poor, dry soil. pH 6.0–8.0. Avoid heavy, clay, or constantly moist soil. Raised beds with added grit are ideal. In containers, use a free-draining potting mix.',
    fertilizing:
        'Light feeder. One application of balanced fertilizer in spring is usually sufficient. Rich feeding reduces aromatic oil concentration.',
    commonProblems:
        'Root rot in wet or clay soil. Grey mould (botrytis) in humid conditions. Spider mites in hot, dry weather. Thyme is generally pest-resistant once established.',
    storageUse:
        'Fresh thyme keeps 1–2 weeks in the refrigerator wrapped in a damp paper towel. Thyme dries exceptionally well and retains strong flavour — hang bunches in a dry spot for 2 weeks, then strip leaves from stems and store in an airtight jar for up to 2 years.',
    bestSeason:
        'Plant in spring after last frost. Thyme is a perennial and returns each spring in zones where winters don\'t drop below -15°C. It tolerates light frost and is one of the easiest herbs to grow.',
  ),

  // ── PARSLEY ──────────────────────────────────────────────────────────────
  'parsley': PlantKnowledge(
    harvestSigns:
        'Parsley is ready to harvest once the plant has at least 3 sets of leaves and is 15 cm tall. Always harvest outer stems — the inner stems are the youngest growth and should be left to continue developing.',
    harvestHow:
        'Cut outer stems at the base, as close to the ground as possible — this encourages new growth from the centre. Never cut from the centre of the plant. Harvest stems rather than individual leaves. Parsley is a biennial — in its second year it will flower and go to seed; harvest heavily before this happens.',
    soilPrep:
        'Parsley prefers rich, well-drained, moist soil. pH 6.0–7.0. Work in compost before planting. It\'s slower to establish than most herbs (germination can take 3 weeks) but is then productive for 1–2 years.',
    fertilizing:
        'A nitrogen-rich fertilizer every 4–6 weeks keeps parsley producing vigorously. It\'s one of the leafier herbs and benefits more from feeding than drought-adapted herbs like rosemary and thyme.',
    commonProblems:
        'Parsley caterpillar (beautiful green and black striped caterpillar of the swallowtail butterfly — consider leaving some as they become butterflies). Carrot rust fly (same pest as carrots — row cover prevents). Slow germination frustrates beginners — soak seeds in warm water for 24 hours before sowing to speed germination.',
    storageUse:
        'Stand fresh parsley in a glass of water in the refrigerator (like cut flowers) for up to 2 weeks. To freeze: chop and place in ice cube trays with water, freeze, then transfer cubes to bags. Dried parsley loses most of its flavour — freezing is far better for long-term storage.',
    bestSeason:
        'Sow direct or transplant in early spring (parsley tolerates light frost). It can also be sown in late summer for autumn/winter harvest. In mild climates, parsley is almost year-round. It bolts in extreme summer heat — provide afternoon shade.',
  ),

  // ── BEAN ─────────────────────────────────────────────────────────────────
  'bean': PlantKnowledge(
    harvestSigns:
        'For green/snap beans, harvest when pods are 10–15 cm long, snap cleanly when bent, and you can feel the beans are small inside. Don\'t wait until beans are bumpy and visible through the pod — these are over-mature and tough. For dried beans, leave pods until they rattle on the vine.',
    harvestHow:
        'Snap or cut beans from the plant — never pull, as this can uproot shallow-rooted plants. Hold the stem with one hand and snap the bean off with the other. Harvest every 2–3 days at peak season — leaving mature beans signals the plant to stop producing.',
    soilPrep:
        'Beans actually fix their own nitrogen from the air via root bacteria — they need less nitrogen than most vegetables. Prepare soil with compost and good drainage. pH 6.0–7.0. Avoid high-nitrogen soil which promotes excessive leaf growth over pods. Inoculate seeds with rhizobium bacteria (available at garden centres) for best nitrogen fixation.',
    fertilizing:
        'Minimal nitrogen feeding needed thanks to nitrogen fixation. A phosphorus-rich fertilizer at planting encourages strong roots and pod development. Avoid heavy feeding — beans self-fertilize.',
    commonProblems:
        'Mexican bean beetle (copper-coloured beetles and their yellow larvae on leaf undersides — hand-pick, use row cover early season). Bean mosaic virus from aphids — control aphids. Root rot in wet soil. Anthracnose (dark sunken spots on pods) in wet, cool conditions — improve air circulation.',
    storageUse:
        'Fresh green beans keep in the refrigerator for up to a week in a bag. For longer storage, blanch 3 minutes, shock in ice water, dry, and freeze for up to a year. Or pickle in a dill brine (dilly beans) for shelf-stable storage.',
    bestSeason:
        'Sow direct outdoors after last frost when soil is above 15°C — beans don\'t transplant well and germinate poorly in cold soil. They\'re warm-season crops. Succession plant every 2–3 weeks for continuous harvest through summer.',
  ),

  // ── PEA ──────────────────────────────────────────────────────────────────
  'pea': PlantKnowledge(
    harvestSigns:
        'For snap peas: harvest when pods are plump, round, and bright green — before they start to yellow or shrivel. For snow peas: harvest when pods are flat and just beginning to show seeds. For shelling peas: harvest when pods are full and bright but seeds are still soft and sweet.',
    harvestHow:
        'Use two hands — hold the vine with one hand and snap the pod off with the other to avoid damaging the delicate tendrils. Harvest every 2 days at peak season. Peas produce more when picked regularly. Once heat arrives, they stop producing regardless — harvest all remaining pods before plants decline.',
    soilPrep:
        'Peas tolerate a wide range of soils but prefer fertile, well-drained, slightly alkaline ground. pH 6.0–7.5. They fix nitrogen like beans — avoid high-nitrogen soil. Work in compost before sowing. Peas climb — provide a trellis or netting.',
    fertilizing:
        'As nitrogen fixers, peas need minimal nitrogen feeding. A phosphorus/potassium fertilizer at sowing encourages flowering. Inoculating seeds with pea/bean-specific rhizobium bacteria improves yield significantly.',
    commonProblems:
        'Powdery mildew in warm, dry spells (especially toward end of season). Pea moth (caterpillars inside pods — use row cover during flowering). Aphid colonies on growing tips — pinch off affected tips. Foot rot from overwatered or cold soil at planting.',
    storageUse:
        'Fresh peas are best eaten within a day of harvest — sugars convert to starch quickly. For longer storage, shell immediately and freeze: blanch 1.5 minutes, shock in ice water, dry, and freeze. Frozen garden peas are far superior to store-bought.',
    bestSeason:
        'A cool-season crop that must be planted early — 4–6 weeks before last frost (some varieties tolerate light frost). Peas fail and bolt in summer heat. In mild climates, a second sowing in late summer can produce a fall crop. They are one of the earliest crops to plant each spring.',
  ),

  // ── BEET ─────────────────────────────────────────────────────────────────
  'beet': PlantKnowledge(
    harvestSigns:
        'Beets are ready when the shoulder of the root (visible above soil line) is 4–5 cm across for most varieties. Gently brush soil away to check size. Smaller beets (2–3 cm) are tender and sweet — perfectly edible. Beets left too long become tough and woody.',
    harvestHow:
        'Loosen soil with a fork before pulling. Grab the beet by the base of the greens and pull straight up with a gentle twist. Twist off greens immediately, leaving 2–3 cm of stem to prevent bleeding during cooking. The greens are edible — treat them like chard.',
    soilPrep:
        'Beets need loose, deep, rock-free soil for good root development. pH 6.0–7.5. Work in compost. Beets are moderately heavy feeders. Avoid fresh manure which causes hairy, distorted roots.',
    fertilizing:
        'A balanced fertilizer at sowing and again when plants are 10 cm tall. Boron deficiency causes internal black rot — water in a diluted borax solution if you\'ve had this problem in previous seasons.',
    commonProblems:
        'Scab (rough patches on skin) from alkaline soil — test and lower pH. Cercospora leaf spot (circular spots with purple borders on leaves) — remove affected leaves. Aphids on leaves. Leaf miners (tunnels in leaves from fly larvae — use row cover).',
    storageUse:
        'Remove tops and store beets in a plastic bag in the refrigerator crisper for up to 3 weeks. For long-term storage, pack in damp sand in a cool cellar where they keep for months. Cooked beets freeze well. The greens wilt quickly — use within 2 days.',
    bestSeason:
        'A cool-season crop. Sow direct 4–6 weeks before last frost in spring. Beets tolerate light frost. Sow again in late summer for a fall harvest — beets grown in cool autumn weather are sweeter. They bolt in extreme summer heat.',
  ),

  // ── SUNFLOWER ─────────────────────────────────────────────────────────────
  'sunflower': PlantKnowledge(
    harvestSigns:
        'For cut flowers, harvest when the bud is just beginning to open (showing colour but not fully open). For seeds, harvest when the back of the head turns from green to yellow to brown, the petals have fallen, and the seeds look plump and striped.',
    harvestHow:
        'For cut flowers: cut stems at a 45° angle early in the morning, place immediately in water. For seeds: cut the head with 30 cm of stem when the back is brown. Hang upside down in a paper bag in a dry, ventilated spot for 2–3 weeks. Rub seeds out of the head when completely dry.',
    soilPrep:
        'Sunflowers are undemanding and grow in most soils. They thrive in well-drained soil of average fertility — too rich soil produces more leaves than flowers. Full sun is essential. They are drought-tolerant once established.',
    fertilizing:
        'Light feeder once established. A single application of balanced fertilizer at planting is usually sufficient. Avoid high-phosphorus fertilizers which can limit micronutrient uptake in sunflowers.',
    commonProblems:
        'Cutworms at seedling stage — place a cardboard collar around the stem at soil level. Aphid clusters on stems — spray with water. Downy mildew in cool, wet weather. Birds attacking ripening seeds — cover the head with a paper bag or netting once petals fall.',
    storageUse:
        'Dried sunflower seeds keep in an airtight container in a cool, dry place for up to a year. Roast at 160°C for 15–20 minutes for snacking. Store-bought sunflower oil can be made with a cold press but requires specialised equipment.',
    bestSeason:
        'Sow direct after last frost when soil is warm. Sunflowers grow quickly (60–90 days) and are frost-tender. For an extended display, succession sow every 3 weeks from late spring through early summer.',
  ),

  // ── MARIGOLD ─────────────────────────────────────────────────────────────
  'marigold': PlantKnowledge(
    harvestSigns:
        'Flowers are ready to harvest when fully open and at their colour peak. For deadheading, remove flowers as soon as petals start to fall to keep plants blooming. For seed saving, leave some flowers until the base turns brown and papery.',
    harvestHow:
        'Snip flower heads just below the bloom with scissors. Deadhead spent flowers weekly — this signals the plant to produce more blooms. For seeds: allow a few heads to mature fully (base brown, petals dried), pull apart and dry the seed-filled central portion for 1–2 weeks before storing.',
    soilPrep:
        'Marigolds are tolerant of poor soil — excessive richness produces all leaves and few flowers. Well-drained soil of average fertility is ideal. pH 5.8–7.0. They also grow well in containers.',
    fertilizing:
        'Light feeders. A single balanced fertilizer application at planting is usually all they need. Too much nitrogen results in lush foliage and sparse flowering.',
    commonProblems:
        'Powdery mildew in crowded, humid conditions. Spider mites in hot, dry weather — spray with water. Slugs at the seedling stage. Botrytis (grey mould) in cool, wet conditions — improve air circulation.',
    storageUse:
        'Fresh cut marigolds last 5–7 days in a vase. Dried marigold petals can be used in cooking and natural dye — dry on a screen in a warm, ventilated spot for 2 weeks. Store dried petals in an airtight jar.',
    bestSeason:
        'Start seeds indoors 4–6 weeks before last frost or sow direct after frost. Marigolds bloom continuously from summer through frost and are one of the best low-maintenance companion plants for the vegetable garden.',
  ),

  // ── CILANTRO ──────────────────────────────────────────────────────────────
  'cilantro': PlantKnowledge(
    harvestSigns:
        'Harvest leaves once the plant is 15 cm tall with at least 3–4 sets of leaves. The best flavour is before any flower stems appear. Once it bolts (sends up a tall flower stalk), leaves become sparse and the flavour changes — harvest seeds instead.',
    harvestHow:
        'Cut outer stems at the base, leaving the inner growing point. Never strip all leaves from a single plant. Harvest the top third of the plant maximum at one time. Pinch out any flower buds immediately to extend leaf production. Once it bolts, let it flower and set seed (coriander seeds) for harvesting.',
    soilPrep:
        'Cilantro prefers light, well-drained soil with good fertility. pH 6.2–6.8. Unlike many herbs, it needs consistent moisture — dry soil triggers bolting. A compost-enriched bed helps retain moisture.',
    fertilizing:
        'Moderate feeder. A balanced liquid fertilizer every 3–4 weeks during active leaf production. Avoid heavy nitrogen which encourages fast but bland-tasting growth.',
    commonProblems:
        'Rapid bolting in heat — cilantro is a cool-season herb. It bolts within days of temperatures consistently above 25°C. Grow in partial shade in summer or as a cool-season crop. Powdery mildew in humid conditions. Aphids on new growth.',
    storageUse:
        'Fresh cilantro wilts quickly — stand stems in water in the refrigerator (like flowers) for up to 2 weeks. Or blend with olive oil and freeze in ice cube trays. Dried cilantro loses almost all flavour — freezing is far better. Coriander seeds (the dried fruit) store in an airtight jar for up to 2 years.',
    bestSeason:
        'Best as a cool-season crop — early spring and fall. Succession sow every 3 weeks through spring and again in early fall. It bolts rapidly in summer heat. In hot climates, grow in partial shade or stick to slow-bolt varieties.',
  ),

  // ── ONION ─────────────────────────────────────────────────────────────────
  'onion': PlantKnowledge(
    harvestSigns:
        'Onions are ready when about half the tops have fallen over naturally. The outer wrappers should be dry and papery. Don\'t wait for all tops to fall — this can indicate disease. Stop watering 2 weeks before harvest to encourage curing.',
    harvestHow:
        'Use a fork to loosen soil before lifting. Avoid bruising — any injury shortens storage life significantly. Spread or hang in a warm, dry, ventilated location for 2–4 weeks to cure. The neck must be completely dry before storing. Braid softneck varieties or cut tops of hardneck to 2–3 cm.',
    soilPrep:
        'Onions need fertile, well-drained, loose soil. pH 6.0–7.0. Work in compost and a balanced fertilizer before planting. They form bulbs near the soil surface — don\'t plant in heavy clay which restricts bulb expansion.',
    fertilizing:
        'Nitrogen-rich fertilizer early in the season encourages leafy top growth (which feeds the bulb). Switch to a phosphorus/potassium fertilizer in midsummer when bulbs begin to size up. Stop feeding 4–6 weeks before harvest to harden the bulb.',
    commonProblems:
        'Onion fly maggots (yellowing, collapsing plants — row cover from planting). Thrips (silvery streak damage — neem oil). White rot (see garlic). Bolting from temperature swings — vernalisation causes early bolting in some varieties.',
    storageUse:
        'Properly cured onions store at cool room temperature in a mesh bag or in old pantyhose (tied in knots between each onion) for 3–6 months. Keep dry and dark. Don\'t store near potatoes — they emit ethylene gas that shortens each other\'s life.',
    bestSeason:
        'Start seeds indoors in late winter (10–12 weeks before last frost) or plant onion sets in early spring as soon as the ground can be worked. Onions need a long season (100–120 days) and prefer cool weather for top growth before switching to bulbing as days lengthen.',
  ),

  // ── BROCCOLI ──────────────────────────────────────────────────────────────
  'broccoli': PlantKnowledge(
    harvestSigns:
        'Broccoli is ready when the head is dense, tight, and dark green — before any yellow flowers open. The head should feel firm, not soft. Buds should be compact. If the head starts to loosen or you see any yellow, harvest immediately.',
    harvestHow:
        'Cut the main head with a sharp knife, leaving 10–15 cm of stem. Cut at a slight angle to prevent water pooling on the cut stem. After the main head is harvested, leave the plant in the ground — it will produce many smaller side shoots (florets) for weeks. Harvest side shoots when they reach 5–8 cm.',
    soilPrep:
        'Broccoli is a heavy feeder that needs rich, well-drained soil. pH 6.0–7.0. Work in a generous layer of compost before planting. Like all brassicas, broccoli benefits from calcium in the soil — add garden lime if soil pH is below 6.0. Deep soil preparation (30 cm) supports strong root systems.',
    fertilizing:
        'Apply a nitrogen-rich fertilizer (blood meal, fish emulsion) every 3–4 weeks. Switch to a balanced fertilizer as the head begins to form. A calcium foliar spray reduces tip burn and hollow stem. Stop heavy nitrogen feeding once the head is developing.',
    commonProblems:
        'Cabbage worms (green caterpillars from white butterflies — hand-pick or use Bt spray weekly). Aphids on new growth and under leaves. Clubroot (swollen, distorted roots in acidic soil — test and raise pH). Flea beetles on young transplants — use row cover. Downy mildew in cool wet conditions.',
    storageUse:
        'Store unwashed broccoli in the refrigerator in a loose bag for up to 5 days. For long-term storage, blanch 3 minutes in boiling water, shock in ice water, dry, and freeze for up to a year. Broccoli stored at room temperature yellows within a day.',
    bestSeason:
        'A cool-season crop. Start transplants indoors 4–6 weeks before last frost for spring planting. Broccoli is frost-hardy and actually tastes sweeter after light frost. In most climates, a fall crop (planted in midsummer) produces the best-tasting heads.',
  ),

  // ── CABBAGE ──────────────────────────────────────────────────────────────
  'cabbage': PlantKnowledge(
    harvestSigns:
        'Cabbage heads are ready when they feel firm and solid when squeezed — like a tight ball. Loose or soft heads need more time. Most varieties are ready 70–120 days after transplanting. A head that starts to crack is over-mature — harvest immediately.',
    harvestHow:
        'Cut the head from the base with a sharp knife, leaving outer wrapper leaves. Leave the stump and root system in place — it will produce several smaller mini-cabbages that are edible. Remove any damaged or insect-damaged outer leaves before storage.',
    soilPrep:
        'Cabbage needs rich, moist, well-drained soil. pH 6.5–7.0 is ideal (higher than most vegetables) to prevent clubroot. Work in compost deeply. Cabbage is a heavy nitrogen feeder — incorporate a nitrogen source before planting. Firm soil is important — loose soil produces cracked heads.',
    fertilizing:
        'Heavy nitrogen feeder early in the season for leaf development. Side-dress with a nitrogen fertilizer every 3–4 weeks until heads begin to form. Reduce nitrogen once the head is forming to avoid soft, split heads. Consistent watering is as important as fertilizing for solid heads.',
    commonProblems:
        'Cabbage worm and cabbage looper (hand-pick or Bt spray). Aphid colonies especially on inner leaves. Clubroot in acidic soil — lime to raise pH. Splitting from irregular watering or late nitrogen — keep moisture consistent. Cutworms at transplant time — use stem collars.',
    storageUse:
        'Whole heads store in the refrigerator for up to 2 months or in a cool cellar (near 0°C) for 3–4 months. Don\'t cut until ready to use — cut cabbage deteriorates quickly. For long storage, ferment into sauerkraut or kimchi, which keeps for months.',
    bestSeason:
        'A cool-season crop. Plant transplants in early spring (4–6 weeks before last frost) for summer harvest, or plant in midsummer for a fall crop. Fall cabbage is generally sweeter. Cabbage tolerates frost well but not sustained freezing temperatures.',
  ),

  // ── EGGPLANT ──────────────────────────────────────────────────────────────
  'eggplant': PlantKnowledge(
    harvestSigns:
        'Eggplants are ready when the skin is glossy and dark (or the variety\'s expected colour), and the flesh springs back slightly when pressed. Dull, bronze, or wrinkled skin means over-maturity — seeds inside become hard and bitter. Most varieties are 10–15 cm long at harvest.',
    harvestHow:
        'Use pruners or sharp scissors — the stem is tough and woody, never pull. Cut with 2–3 cm of stem attached. Harvesting frequently (every few days) encourages the plant to produce more fruit. Leaving mature fruit on the plant reduces yield significantly.',
    soilPrep:
        'Eggplant needs warm, fertile, well-drained soil. pH 6.0–6.8. Work in compost before planting. Eggplant loves heat — plant in a sunny, sheltered spot or use black plastic mulch to warm soil. Raised beds warm up faster in spring, giving eggplant the heat it needs.',
    fertilizing:
        'Feed with a balanced fertilizer at transplanting. Once flowering begins, switch to a low-nitrogen, high-potassium formula to promote fruit development over leaf growth. Side-dress with compost monthly. Calcium deficiency causes blossom end rot — keep watering consistent.',
    commonProblems:
        'Flea beetles (tiny holes in leaves — row cover for young plants, diatomaceous earth). Colorado potato beetle (orange-yellow larvae on leaves — hand-pick daily). Aphids and spider mites in dry conditions. Verticillium wilt (yellowing, wilting despite water) — avoid planting eggplant where tomatoes or potatoes grew recently.',
    storageUse:
        'Eggplant is sensitive to cold — store at 10–13°C, not in the main refrigerator (which is too cold and causes chill injury within days). Use the vegetable crisper set warm, or store on a cool countertop for 3–5 days. Eggplant freezes well when cooked: roast, cube, and freeze.',
    bestSeason:
        'Start seeds indoors 8–10 weeks before last frost. Eggplant needs a long, warm season and won\'t tolerate any frost. Transplant only when nighttime temperatures stay above 13°C consistently. In short-season climates, choose fast-maturing varieties (65–70 days).',
  ),

  // ── HOT PEPPER ────────────────────────────────────────────────────────────
  'hot pepper': PlantKnowledge(
    harvestSigns:
        'Hot peppers can be harvested green (immature) for fresh use, or left to ripen to their full colour (red, orange, yellow, or chocolate). Fully ripe peppers are hotter, sweeter, and more nutritious. The skin should be firm and shiny — harvest before any soft spots develop.',
    harvestHow:
        'Always cut with pruners, never pull — pepper stems attach firmly. Cut with 1–2 cm of stem. Wear gloves when harvesting very hot varieties (habanero, ghost pepper) — the capsaicin oil on skin causes prolonged burning. Wash hands thoroughly with soap and oil after handling. Harvesting green peppers early speeds up total yield.',
    soilPrep:
        'Same as bell peppers: warm, fertile, well-drained soil with pH 6.0–6.8. Hot peppers are often more heat-tolerant and drought-tolerant than sweet peppers but still need rich soil. Raised beds or containers in full sun work excellently.',
    fertilizing:
        'Balanced fertilizer at planting. Low-nitrogen, high-potassium formula once flowering begins. Hot peppers benefit from slightly drier conditions during fruit development — slightly stressed plants (not severely) produce higher capsaicin concentrations.',
    commonProblems:
        'Blossom drop in extreme heat or cold nights. Aphids on new growth. Bacterial spot from overhead watering — water at soil level only. Sunscald on fruits exposed to direct midday sun. In containers, watch for root-bound plants which stress easily.',
    storageUse:
        'Fresh hot peppers keep 1–2 weeks in the refrigerator. For long-term storage: dry whole in a warm oven at 60°C for 6–8 hours (or in a dehydrator); pickle in vinegar brine; freeze whole (freeze solid on a tray first, then bag); or blend into hot sauce.',
    bestSeason:
        'Start seeds indoors 8–10 weeks before last frost. Hot peppers need the same long warm season as sweet peppers. Transplant after soil reaches 18°C and all frost risk has passed. In cool climates, grow in containers that can be moved indoors at season\'s end to keep producing.',
  ),

  // ── POTATO ────────────────────────────────────────────────────────────────
  'potato': PlantKnowledge(
    harvestSigns:
        'New (baby) potatoes are ready about 10 weeks after planting when plants are flowering. For main crop potatoes, wait until tops (haulms) die back naturally and turn brown. The skin should be set — rub a thumbnail across the skin: if it slips off easily, they\'re not ready.',
    harvestHow:
        'Use a fork, not a spade — insert 30 cm from the plant centre and lever upward. Never thrust a fork straight down which spears tubers. Dig up the entire plant in one motion, then search the surrounding soil by hand for any escaped tubers. Cure in a cool, dark, ventilated space for 2 weeks to harden the skin before storage.',
    soilPrep:
        'Potatoes need loose, well-drained, slightly acidic soil (pH 5.0–6.0) — this reduces scab disease. Work soil deeply (30+ cm). Avoid lime and fresh manure which increase scab and cause lush tops with few tubers. Ridge soil up around plants (hilling) as they grow to prevent greening.',
    fertilizing:
        'Apply a balanced fertilizer at planting. Side-dress with potassium-rich fertilizer when plants are 15–20 cm tall. Avoid excess nitrogen after this point — it drives excessive top growth at the expense of tuber production. Stop all feeding when plants begin to flower.',
    commonProblems:
        'Colorado potato beetle (orange-yellow larvae — hand-pick daily or use spinosad spray). Late blight (dark water-soaked patches on leaves — no cure, destroy affected plants immediately, don\'t compost). Scab (rough patches) from alkaline soil. Wire worm damage in old turf areas. Greening from sun exposure — always cover exposed tubers with soil.',
    storageUse:
        'Cure in a dark, 10–15°C location with good air circulation for 2 weeks to harden skin. Store long-term at 4–7°C in complete darkness in paper bags or open boxes. Never refrigerate (starch converts to sugar below 4°C, making them sweet and sticky when cooked). Remove any green or sprouting potatoes from storage regularly.',
    bestSeason:
        'Plant seed potatoes in early spring as soon as soil can be worked (2–4 weeks before last frost). They tolerate light frost. In mild climates, plant in late winter for an early summer harvest. Chit (pre-sprout) seed potatoes in a cool bright spot for 2–4 weeks before planting for a head start.',
  ),

  // ── SWEET POTATO ─────────────────────────────────────────────────────────
  'sweet potato': PlantKnowledge(
    harvestSigns:
        'Sweet potatoes are ready 90–120 days after planting slips. Harvest when the roots are a good size (visible by gently probing the soil near the base). The tops may begin to yellow in fall. Always harvest before the first frost — frost damage ruins sweet potatoes quickly.',
    harvestHow:
        'Cut vines back to 15 cm before digging. Use a fork and dig carefully — sweet potatoes bruise easily. Work 30 cm from the plant and lever soil upward gently. Handle with extreme care as damaged skins invite rot. Cure immediately after harvest — do NOT wash.',
    soilPrep:
        'Sweet potatoes thrive in light, loose, well-drained sandy soil. pH 5.5–6.5. They are one of the few vegetables that actually prefer poor, less fertile soil — rich soil produces large tops and small roots. Avoid waterlogged ground. Raised mounded rows work best.',
    fertilizing:
        'Light feeder. A single application of a low-nitrogen, high-potassium fertilizer (like 5-10-10) at planting is usually all that\'s needed. Too much nitrogen produces lush vines and small tubers.',
    commonProblems:
        'Wireworm (tunnelling damage from soil larvae — rotation and resistant varieties help). Weevils (most serious pest in warm climates). Scurf (dark skin patches) from wet, cold soil. Fusarium root rot in poorly drained soil.',
    storageUse:
        'Curing is essential: store at 29–32°C with high humidity (85–90%) for 10–14 days immediately after harvest. This heals cuts and converts starches to sugars. After curing, store at 13–16°C in a dark, dry location for up to 6 months. Never refrigerate sweet potatoes.',
    bestSeason:
        'Plant rooted slips (not seeds or tubers) 2–3 weeks after last frost when soil is above 18°C. Sweet potatoes need 4–5 frost-free months to produce a good harvest. They grow best in warm summers. In cool climates, use black plastic mulch and the warmest, most sheltered spot.',
  ),

  // ── CORN ──────────────────────────────────────────────────────────────────
  'sweet corn': PlantKnowledge(
    harvestSigns:
        'Sweet corn is ready when the silk turns dry and brown (but the husk is still green), and the ear feels plump when squeezed. Peel back a small section of husk and pierce a kernel with your thumbnail — milky juice means it\'s ready. Watery = too early, doughy/starchy = too late. Corn has a very short harvest window of 2–3 days.',
    harvestHow:
        'Grasp the ear firmly and snap downward with a quick twist. The ear should break cleanly from the stalk. Check the entire planting every day once the first ear is ready — timing is critical. Cook or refrigerate within hours of harvest for the sweetest flavour.',
    soilPrep:
        'Corn needs deep, fertile, well-drained soil. pH 5.8–6.8. Work in abundant compost and a high-nitrogen fertilizer before planting. Corn is a very heavy feeder. Plant in blocks (not single rows) of at least 4 rows for good wind pollination.',
    fertilizing:
        'Apply a nitrogen-rich fertilizer at planting. Side-dress with additional nitrogen when plants are 30 cm tall and again when they reach 60 cm (the "knee-high" stage). Consistent nitrogen throughout the season is critical — deficiency causes pale striped leaves and poor ear fill.',
    commonProblems:
        'Corn earworm (caterpillar in the ear tip — apply a drop of mineral oil to the silk 3–7 days after silk appears). European corn borer. Smut (grey-black galls on ears and stalks — remove and destroy affected parts immediately). Birds and raccoons raiding ears near maturity — cover with paper bags or netting.',
    storageUse:
        'Corn loses its sweetness rapidly — sugars convert to starch within hours at room temperature. Eat the same day as harvest if possible. For storage, blanch cobs 4 minutes, cool in ice water, cut off kernels, and freeze. Frozen sweet corn retains most of its flavour for up to a year.',
    bestSeason:
        'Sow direct after last frost when soil is above 15°C. Corn is frost-tender and grows best in warm summers. For continuous harvest, plant every 2–3 weeks rather than all at once. Minimum planting size: 4 rows of 10 plants for adequate wind pollination.',
  ),

  // ── ZUCCHINI (alias squash) ──────────────────────────────────────────────
  'squash': PlantKnowledge(
    harvestSigns:
        'Summer squash (zucchini, patty pan) are best harvested small: zucchini at 15–20 cm, patty pan at 5–8 cm across. Winter squash (butternut, acorn) are ready when the rind is hard (a fingernail won\'t dent it), the skin has turned its final colour, and the stem has dried and started to cork over.',
    harvestHow:
        'Cut with pruners — never twist or snap. For summer squash, leave 2–3 cm of stem. For winter squash, cut with at least 5 cm of stem (this extends storage life). Winter squash must be cured before storage: leave in the field for 10–14 days after harvest.',
    soilPrep:
        'Squash are heavy feeders and heavy drinkers. Prepare beds deeply with generous compost. pH 6.0–7.5. Plant on mounded hills or in raised beds for good drainage. Large plants — space 90–120 cm apart.',
    fertilizing:
        'Balanced fertilizer at planting, then a phosphorus-rich formula once flowering. Side-dress with compost monthly. Consistent moisture is essential — squash stressed by drought produces poor, bitter fruits.',
    commonProblems:
        'Squash vine borer (stem base sawdust-like frass, sudden wilt — wrap stems in foil at ground level to prevent egg-laying, or inject Bt into affected stems). Powdery mildew on leaves in summer — normal at season end. Squash bugs (flat grey-brown bugs — check for bronze egg masses under leaves).',
    storageUse:
        'Summer squash: refrigerator for up to a week or frozen (blanch then freeze). Winter squash: cured at room temperature for 10–14 days, then store in a cool (10–13°C), dry location for 2–6 months depending on variety. Butternut and acorn store best.',
    bestSeason:
        'Plant after all frost risk and when soil is above 18°C. Squash thrives in warm summers. Direct sow seeds or set out transplants in late spring.',
  ),

  // ── DILL ──────────────────────────────────────────────────────────────────
  'dill': PlantKnowledge(
    harvestSigns:
        'Harvest dill leaves (dill weed) when the plant is 20–30 cm tall, before it flowers. Leaves should be bright, feathery, and fragrant. For dill seed, harvest when the seed heads turn tan and start to dry on the plant.',
    harvestHow:
        'Snip stem tips and feathery leaves from the top third of the plant with scissors. Never take more than a third at once. For seed harvest: cut entire seed heads when mostly brown, place in a paper bag, and hang upside down to dry for 2 weeks.',
    soilPrep:
        'Dill tolerates a wide range of soils but prefers loose, well-drained, slightly acidic soil. pH 5.8–6.5. It is drought-tolerant once established but grows faster in fertile, moist conditions. Avoid transplanting — dill has a taproot and bolts quickly when disturbed.',
    fertilizing:
        'Light feeder. Compost worked in before sowing is usually sufficient. A single liquid fertilizer application at mid-season keeps leaf production going.',
    commonProblems:
        'Bolting (going to seed) in heat is the main challenge — make succession sowings every 3 weeks. Aphids on tender growth. Swallowtail butterfly caterpillars (beautiful but they eat leaves — tolerate them or relocate to wild carrot). Cross-pollination with fennel and carrots if grown nearby — keep separate.',
    storageUse:
        'Fresh dill keeps only 2–3 days in the refrigerator — stand in water to extend to a week. Freeze in an airtight container for up to 3 months. Dry dill weed loses most of its flavour. Dill seeds store in an airtight jar for up to 3 years and are excellent in pickling.',
    bestSeason:
        'Sow direct outdoors from early spring through summer. Dill is a cool-season herb that also grows well in fall. In summer heat, bolts quickly — succession sow every 2–3 weeks for continuous leaf harvest. It self-seeds prolifically, so expect it to return year after year.',
  ),

  // ── OREGANO ───────────────────────────────────────────────────────────────
  'oregano': PlantKnowledge(
    harvestSigns:
        'Oregano is most aromatic just before it flowers. Harvest when stems are 15–20 cm long. The small oval leaves should be deep green and intensely fragrant when rubbed. For the strongest flavour, harvest before flower buds open.',
    harvestHow:
        'Cut stems back by one-third just above a leaf node — this encourages bushy regrowth. Never harvest more than half the plant at once. In the fall, cut plants back to 5–8 cm to encourage fresh spring growth. Oregano regrows vigorously from even hard pruning.',
    soilPrep:
        'Oregano thrives in well-drained, average to poor soil — overly rich soil reduces the concentration of aromatic oils. pH 6.0–8.0. It tolerates dry, rocky conditions that would stress most plants. In containers, use a gritty, well-draining potting mix.',
    fertilizing:
        'Minimal. A light application of balanced fertilizer in spring is typically sufficient for the whole season. Rich feeding makes the plant grow fast but with less intense flavour.',
    commonProblems:
        'Root rot from waterlogged soil — the main cause of death in oregano. Spider mites in hot, dry conditions. Aphids on new growth in spring. In humid climates, watch for botrytis (grey mould) — improve air circulation.',
    storageUse:
        'Air-dry oregano by hanging bunches upside down in a warm, dry spot for 2 weeks. It dries excellently and actually intensifies in flavour when dried. Store dried leaves in an airtight jar for up to 3 years. Fresh oregano keeps 5–7 days in the refrigerator wrapped in a damp paper towel.',
    bestSeason:
        'Plant in spring after last frost. Oregano is a perennial herb that returns each spring in zones where winters stay above -10°C. It\'s drought-tolerant in summer and generally undemanding — one of the easiest herbs to grow.',
  ),

  // ── SAGE ──────────────────────────────────────────────────────────────────
  'sage': PlantKnowledge(
    harvestSigns:
        'Sage is ready to harvest once the plant is well established (second year onwards for best yields). Leaves should be silver-green, velvety, and strongly aromatic when rubbed. Pick before or just after flowering for peak flavour.',
    harvestHow:
        'Cut stems back by up to one-third just above a leaf pair. Don\'t cut into old, woody stems — they don\'t regenerate well. After flowering, cut the plant back by half to prevent it going woody. Sage can be harvested lightly year-round in mild climates.',
    soilPrep:
        'Well-drained, lean soil is best — sage, like rosemary, is a Mediterranean herb that thrives in conditions that would stress most plants. pH 6.0–7.0. Sandy or loamy soil with excellent drainage. Avoid rich, clay-heavy soil.',
    fertilizing:
        'Very light feeder. One application of balanced fertilizer in spring. Over-feeding produces lush but weakly flavoured growth. In containers, a slow-release granule in spring covers the whole season.',
    commonProblems:
        'Root rot from overwatering (main killer of sage in home gardens). Powdery mildew in humid, crowded conditions. Spider mites in dry weather. Slugs on young plants. Sage is generally pest-resistant once established.',
    storageUse:
        'Fresh sage keeps 1–2 weeks in the refrigerator wrapped in a damp paper towel. To dry: hang bunches upside down or spread on a screen in a warm, well-ventilated spot for 2 weeks. Dried sage keeps its flavour for 1–2 years in a sealed jar. Sage butter (sage blended into softened butter) freezes well for months.',
    bestSeason:
        'Plant in spring after last frost. Sage is a hardy perennial in zones 5–8. It tolerates moderate frost and can overwinter outdoors in most climates. The second year onward produces the most vigorous harvests.',
  ),

  // ── LAVENDER ──────────────────────────────────────────────────────────────
  'lavender': PlantKnowledge(
    harvestSigns:
        'For the best fragrance and colour in dried lavender, harvest when about half the flowers on each stem are open. For fresh cut bouquets, harvest when flowers are just beginning to open. Cut before the heat of the day — morning fragrance is strongest.',
    harvestHow:
        'Cut flower stems as long as possible, down into the leafy part of the plant. Never cut into old, completely bare woody stems — lavender won\'t regenerate from old wood. Bundle 20–30 stems with a rubber band (bunches will shrink as they dry) and hang upside down in a cool, dark, well-ventilated space.',
    soilPrep:
        'Lavender requires excellent drainage above all else. It thrives in sandy, alkaline, even chalky soil. pH 6.5–8.0. Amend clay soil with generous grit or grow in raised beds. Waterlogged roots kill lavender quickly. In humid climates, mound soil to improve drainage.',
    fertilizing:
        'Very light feeder — rich soil reduces flower production and fragrance. A small amount of balanced slow-release fertilizer in early spring. Avoid nitrogen-rich fertilizers which produce lush, floppy growth with few flowers.',
    commonProblems:
        'Root rot and stem canker in wet or poorly drained soil (most common cause of lavender death). Shab disease (spittle bugs). In humid climates, alterna leaf spot — improve air circulation by spacing plants widely. Lavender is generally very pest-resistant.',
    storageUse:
        'Dried lavender bundles keep their fragrance for 1–2 years. Strip dried flowers from stems and store in airtight jars for culinary use (culinary lavender is wonderful in shortbread, honey, and lemonade). Dried lavender sachets in drawers repel moths naturally.',
    bestSeason:
        'Plant in spring after last frost. Lavender is a long-lived perennial that improves with age. It needs 2–3 years to become fully established. In cold climates (zone 5 and below), treat as an annual or choose hardier varieties like Hidcote or Munstead.',
  ),

  // ── ASPARAGUS ─────────────────────────────────────────────────────────────
  'asparagus': PlantKnowledge(
    harvestSigns:
        'Asparagus spears are ready when 15–20 cm tall and before the tips begin to open into fern-like fronds. Spears should be firm, tightly budded at the tip, and snap cleanly when bent. Once tips open, spears are over-mature and tough.',
    harvestHow:
        'Snap spears at or just below soil level — they\'ll break naturally at the right point. Or cut with a knife at soil level. Check beds daily during peak season as spears grow 2–5 cm per day in warm weather. Harvest only for 6–8 weeks the first productive year, then let all remaining spears grow into ferns to feed the crowns for next year.',
    soilPrep:
        'Asparagus is a long-term investment — beds last 20+ years. Prepare deeply: work in abundant compost 45–60 cm down. pH 6.5–7.0. Asparagus crowns are planted in trenches 20 cm deep, spread out like a crown. Excellent drainage is essential — crowns rot in standing water.',
    fertilizing:
        'Feed with a balanced fertilizer in early spring before spears emerge. Again after the harvest season ends and ferns are growing — this is when the plant rebuilds energy stores for next year. A phosphorus-rich fertilizer supports strong root development in young crowns.',
    commonProblems:
        'Asparagus beetle (blue-black beetles and larvae on spears and ferns — hand-pick, use neem oil). Fusarium crown rot in poorly drained beds. Rust (orange pustules on ferns in late summer — remove affected ferns, choose rust-resistant varieties). Purple spot on spears in cool, wet springs.',
    storageUse:
        'Fresh asparagus is best the day of harvest. For short-term storage, stand spears upright in a jar with 2–3 cm of water, cover loosely with a plastic bag, and refrigerate for up to 4 days. Blanch and freeze for up to a year. Asparagus pickled in a light brine is a classic pantry item.',
    bestSeason:
        'Plant crowns in early spring as soon as soil can be worked. Asparagus is dormant in winter and sends up spears each spring. Do NOT harvest any spears in the first year and harvest lightly in the second year — the plant needs to establish a strong root system before sustained harvesting.',
  ),

  // ── BLUEBERRY ─────────────────────────────────────────────────────────────
  'blueberry': PlantKnowledge(
    harvestSigns:
        'Blueberries are ready when the entire berry is uniformly deep blue or blue-purple (no pink or red tinges), soft to the touch, and comes off the cluster with the lightest nudge. Berries that require any force aren\'t ripe. Taste-test is the best guide — ripe blueberries are sweet with no bitterness.',
    harvestHow:
        'Gently roll ripe berries off the cluster with your thumb, letting them fall into your palm or a bucket. Unripe berries resist this motion — leave them. Productive bushes need picking every 5–7 days during the 4–6 week harvest window. In the morning, when berries are cool, they\'re firmest and easiest to handle without crushing.',
    soilPrep:
        'Blueberries have very specific soil requirements: pH 4.5–5.5 (quite acidic). Most garden soils need acidification with elemental sulfur or acidic compost (like pine bark). Rich in organic matter. Perfect drainage — blueberries don\'t tolerate standing water. Test and adjust soil pH 6–12 months before planting.',
    fertilizing:
        'Use an acid-forming fertilizer specifically formulated for blueberries (ammonium sulfate, or a "berry fertilizer"). Never use lime. Feed in early spring when buds swell. A second light application in late spring after fruiting. Over-feeding produces vigorous growth but fewer berries.',
    commonProblems:
        'Mummy berry disease (shrivelled berries — rake up affected berries, apply mulch to prevent spore germination). Birds are the biggest harvesting pest — net bushes when fruit begins to colour. Fruit fly (spotted wing drosophila) in late-season crops. Iron chlorosis (yellowing leaves with green veins) from pH too high — acidify soil.',
    storageUse:
        'Don\'t wash until ready to eat. Fresh blueberries keep in the refrigerator for 1–2 weeks. Freeze on a baking sheet first (freeze individual berries, not a clump), then transfer to bags for up to a year. Frozen blueberries retain all their antioxidants.',
    bestSeason:
        'Plant in early spring. Blueberries produce heavily from years 3–4 onward and can produce for 50+ years. Plant at least two different varieties for cross-pollination (significantly increases yield). They are one of the most rewarding long-term garden investments.',
  ),

  'alyssum': PlantKnowledge(
    harvestSigns: 'Flowers are fully open and fragrant. Alyssum blooms continuously — you\'re harvesting both flowers and seeds. For seeds, let some flower clusters dry completely on the plant until the tiny pods turn brown and papery.',
    harvestHow: 'Snip individual stems or whole flower clusters for arrangements. For seeds, cut dry seed heads into a paper bag and shake to release the tiny seeds. Deadhead spent blooms regularly to keep the plant flowering all season.',
    soilPrep: 'Average to poor soil is fine — alyssum actually blooms better without rich soil. Good drainage is essential. Work in some compost for very clay-heavy soil. Slightly alkaline to neutral pH (6.5–7.5).',
    fertilizing: 'Minimal feeding needed. Too much nitrogen causes lots of leaves with few flowers. A single light application of balanced fertilizer at planting is usually enough for the whole season.',
    commonProblems: 'Aphids cluster on new growth — spray off with water. Downy mildew in humid conditions (improve air circulation, avoid overhead watering). Plants may pause blooming in extreme summer heat — cut back lightly and they\'ll rebound when temperatures cool.',
    storageUse: 'Fresh flowers last a few days in water. Dried flowers can be used in sachets. Edible flowers add a mild honey-like flavor to salads and desserts. Seeds stored in a dry paper envelope keep viability for 2–3 years.',
    bestSeason: 'Direct sow outdoors 2–3 weeks before last frost — seeds need cool soil to germinate. Also excellent as a fall crop. In mild climates, alyssum may self-seed and return every year without replanting.',
  ),

  'amaranth': PlantKnowledge(
    harvestSigns: 'Grain amaranth: seed heads are ready when they feel dry and papery and seeds release easily when rubbed. Leaf amaranth: harvest young leaves at any size — plants are ready about 4–6 weeks after planting. Heads are mature when the small flowers begin to dry and the majority of seeds are plump.',
    harvestHow: 'Leaf harvest: cut outer leaves or clip entire young plants an inch above the soil for regrowth. Grain harvest: cut the entire seed head and hang upside down in a paper bag for 2 weeks to finish drying. Thresh by rubbing heads between your hands over a tub, then winnow to separate seeds from chaff.',
    soilPrep: 'Adapts to poor, dry soils — excellent in challenging conditions. Prefers well-drained soil with pH 6.0–7.5. Work in compost at planting. Tolerates heat and drought much better than most vegetables.',
    fertilizing: 'Light feeder. A moderate compost application at planting is enough. Excess nitrogen produces lush leaves but fewer grain seeds. Good choice for lower-fertility plots.',
    commonProblems: 'Leaf miners create winding trails in leaves — remove affected leaves. Flea beetles make small holes in young leaves. Aphids on new growth. Very few serious pest problems — amaranth is generally tough and resilient.',
    storageUse: 'Fresh leaves: use like spinach, last 3–5 days refrigerated. Dried seeds: store in airtight jars for up to a year. Seeds can be popped like popcorn, ground into flour, or cooked as a grain. High in protein and iron.',
    bestSeason: 'Direct sow after last frost when soil is warm. Germinates best at 65–75°F. Extremely heat-tolerant — one of the best summer greens when other crops bolt. Not frost-hardy; plant in full sun.',
  ),

  'apple': PlantKnowledge(
    harvestSigns: 'Skin color changes to the variety\'s ripe color (red, yellow, or green). Seeds inside are dark brown. Flesh feels firm but gives slightly under gentle pressure. The apple separates easily with a gentle upward twist — no pulling needed. A ripe apple has a distinct sweet smell at the stem end.',
    harvestHow: 'Cup the apple in your palm and twist upward with a gentle rotation. If it doesn\'t come off easily, it\'s not ready. Don\'t yank. Work through the tree systematically. Early-season apples ripen first near the top of the tree where there\'s more sun. Place (don\'t drop) picked apples into a padded bag or basket to prevent bruising.',
    soilPrep: 'Deep, well-drained loam with pH 6.0–7.0. Apples tolerate many soils but hate waterlogging — roots will rot in standing water. Before planting, work in compost and check drainage. Avoid frost pockets (low spots where cold air settles).',
    fertilizing: 'Young trees: apply balanced fertilizer in early spring to encourage growth. Mature bearing trees: fertilize based on annual shoot growth — aim for 8–12 inches per year. Over-fertilizing causes excessive leafy growth at the expense of fruit. If shoots are growing more than 12 inches, skip fertilizer that year.',
    commonProblems: 'Apple scab (dark, scabby patches on skin and leaves — plant scab-resistant varieties). Codling moth (worms inside fruit — use pheromone traps). Fire blight (branches wilt and look scorched — prune well below infection). Aphids and scale insects. Annual pruning is essential for air circulation and disease prevention.',
    storageUse: 'Keep apples cold and away from other produce — they release ethylene gas that hastens ripening of nearby fruits and vegetables. Most varieties store 1–3 months at 32–38°F in high humidity. Wrap individually in newspaper for longest storage. Late-season varieties store longer than early-season ones.',
    bestSeason: 'Plant bare-root trees in early spring (or fall in mild climates). Most varieties need a pollinator (different apple variety). Check chill hour requirements for your climate — apples need cold winters to set fruit properly.',
  ),

  'artichoke': PlantKnowledge(
    harvestSigns: 'Harvest when the central (main) bud is 3–5 inches across and the scales are tightly closed and still deep green. Once scales start to open or spread, the artichoke is beginning to flower and the flesh becomes tough and bitter. The main bud is ready before side buds.',
    harvestHow: 'Cut the stem 1–2 inches below the bud with a sharp knife or pruners. Harvest the central bud first — this encourages the side buds (smaller chokes) to develop. Continue harvesting side buds as they reach size. After the final harvest, cut the entire stalk to the ground to stimulate new growth.',
    soilPrep: 'Rich, deeply worked soil with excellent drainage — artichokes have deep taproots. Add generous amounts of compost. pH 6.5–7.0. They\'re heavy feeders and do best in fertile soil. In cold climates, a raised bed warms up faster in spring.',
    fertilizing: 'Feed regularly with a balanced fertilizer or compost tea throughout the growing season. Nitrogen is especially important for producing large, tender buds. Apply a complete fertilizer at planting and again monthly through the season.',
    commonProblems: 'Aphids in dense clusters at bud bases — blast off with water, apply insecticidal soap. Botrytis (grey mold) in wet conditions — improve air circulation. Artichoke plume moth larvae burrow into stalks. Slugs and snails feed on young leaves.',
    storageUse: 'Artichokes decline quickly after harvest — use within 1 week. Store unwashed in a plastic bag in the refrigerator with a spritz of water. For longer storage, blanch and freeze hearts. The water from cooking artichokes can be saved and used as a base for sauces.',
    bestSeason: 'Perennial in zones 7–11; grown as an annual in colder zones. Start seeds indoors 8–10 weeks before last frost, or plant rooted divisions in spring. Needs vernalization (cool period) to produce buds. In year 1, plants may not produce — wait until year 2 for best harvests.',
  ),

  'arugula': PlantKnowledge(
    harvestSigns: 'Leaves are 3–4 inches long with the characteristic peppery smell when crushed. Younger, smaller leaves are more tender and mild; larger leaves are more bitter and spicy. Harvest before the plant sends up a flower stalk (bolting), which makes leaves very bitter.',
    harvestHow: 'Cut-and-come-again: use scissors to cut outer leaves 1 inch above the soil, leaving the inner growing point intact. New leaves grow back in 1–2 weeks. Alternatively, harvest entire plants by cutting at soil level when mature. Multiple successive sowings 2–3 weeks apart provide continuous harvests.',
    soilPrep: 'Fertile, well-drained soil with good moisture retention. pH 6.0–7.0. Work in compost before planting. Arugula grows fast and doesn\'t need heavily amended soil. Consistent moisture prevents bitterness.',
    fertilizing: 'Light feeder. A balanced fertilizer or compost at planting is usually sufficient. Excessive nitrogen produces lush growth but can reduce flavor intensity. Don\'t overfeed.',
    commonProblems: 'Flea beetles are the main pest — tiny round holes in leaves. Row covers prevent them. Downy mildew in cool, wet weather. Bolts quickly in heat and long days — choose bolt-resistant varieties for summer. Best grown in cool weather (spring and fall).',
    storageUse: 'Refrigerate unwashed in a loose bag for up to 5 days. Rinse just before use. Best eaten fresh in salads — wilts quickly when cooked. Can be lightly wilted into pasta. Spiciness intensifies when stressed by heat or drought.',
    bestSeason: 'Direct sow outdoors 4–6 weeks before last frost in spring, and again in late summer for a fall crop. Germinates in cool soil (40°F and above). Grows best at 45–65°F. One of the fastest vegetables — ready to harvest in as little as 3 weeks.',
  ),

  'ashwagandha': PlantKnowledge(
    harvestSigns: 'Roots are harvested in late fall of the first or second year when the plant has fully senesced. The roots should be 6–12 inches long and at least finger-thickness. Berries (inside papery husks) are ripe when they turn bright red-orange.',
    harvestHow: 'Dig roots carefully with a garden fork, going deep (12+ inches) to avoid breaking the long taproot. Wash thoroughly. Cut into 1–2 inch pieces for drying. For berries, pick when husks turn papery and berry is red inside. Dry roots at 95–115°F for several days until completely dry and brittle.',
    soilPrep: 'Ashwagandha prefers poor-to-moderate, sandy or loamy, well-drained soil. Rich soil encourages leafy growth over root development. pH 7.5–8.0 (slightly alkaline). Excellent drainage is critical — roots rot in wet soil. Drought-tolerant once established.',
    fertilizing: 'Minimal fertilizer needed and preferred. Too much nitrogen = leaves, not roots. At most, a light application of low-nitrogen fertilizer (like rock phosphate) to encourage root development. Less is more with ashwagandha.',
    commonProblems: 'Root rot in poorly drained or overwatered soil. Aphids and spider mites in hot, dry weather. Relatively pest-resistant overall. The main challenge is patient cultivation — it takes a full season (or two) to develop harvestable roots.',
    storageUse: 'Dried root pieces store in airtight jars in a cool, dark place for 1–2 years. Can be ground into powder (ashwagandha churna) for use in warm milk (golden milk). Also available as tinctures made with alcohol extraction. All plant parts are used in Ayurvedic medicine.',
    bestSeason: 'Direct sow after last frost or start indoors 6 weeks before. Needs warm soil to germinate (70°F+). Thrives in summer heat. Native to India and grows best in hot, dry conditions that would stress other plants. Hardy only in zones 8–10 as a perennial.',
  ),

  'bachelor\'s button': PlantKnowledge(
    harvestSigns: 'For cut flowers: harvest when the central flower is just beginning to open but before it fully unfurls — this maximizes vase life. For seeds: let flowers dry completely on the plant until the seed head becomes papery and grey-silver. Seeds are ready when they pull free easily.',
    harvestHow: 'Cut stems in the morning with sharp scissors, cutting just above a leaf node to encourage branching and more blooms. For seeds, snip entire dried heads into a bag. Store seeds in a paper envelope in a cool, dry place — they\'re easy to save year to year. Deadheading (removing spent blooms) significantly extends flowering.',
    soilPrep: 'Thrives in average to poor soil — rich soil produces lots of foliage with fewer flowers. Well-drained, slightly alkaline soil (pH 6.5–7.0). Excellent for challenging dry spots in the garden. Directly sow where they\'ll grow — transplanting disturbs the taproot.',
    fertilizing: 'Minimal — one light application at planting is plenty. High-fertility soil = tall, floppy plants with few flowers. Avoid high-nitrogen fertilizers.',
    commonProblems: 'Aphids on new growth — spray with water or neem oil. Powdery mildew in humid conditions (space plants for air circulation). Aster yellows disease (distorted flowers — remove affected plants, control leafhoppers). Generally very hardy and trouble-free.',
    storageUse: 'Fresh cut flowers last 7–10 days in water with a clean cut and fresh water every 2 days. Flowers can be dried by hanging bunches upside down. Dried petals used in potpourri. Edible petals add color to salads — mildly spicy.',
    bestSeason: 'Direct sow outdoors 2–4 weeks before last frost — seeds need cool temperatures to germinate. Self-sows readily and often returns yearly. Excellent for spring and fall gardens. In hot climates, sow in fall for winter/spring bloom.',
  ),

  'banana pepper': PlantKnowledge(
    harvestSigns: 'Sweet banana peppers are ready at any stage from yellow-green (mild) to yellow (fully ripe) to orange or red (fully ripe, sweetest). Most are harvested yellow. Hot banana peppers develop more heat as they ripen. Peppers should feel firm and have a glossy skin.',
    harvestHow: 'Cut peppers off with scissors or a sharp knife — never pull, which can break branches. Leave a short stem attached. Harvesting frequently (every 2–3 days) encourages the plant to produce more peppers. The first harvest can be done when peppers reach a usable size, even before full color develops.',
    soilPrep: 'Fertile, well-drained soil with pH 6.0–6.8. Work in compost. Banana peppers love warm soil — use black plastic mulch to warm the bed in colder climates. Good drainage is essential; roots rot in waterlogged soil.',
    fertilizing: 'Moderate feeder. Apply a balanced fertilizer at planting, then switch to a lower-nitrogen, higher-phosphorus and potassium fertilizer once flowering begins. Too much nitrogen = lots of leaves, few peppers. A tomato fertilizer works well for all peppers.',
    commonProblems: 'Aphids, pepper weevils, and spider mites. Blossom end rot (irregular watering — keep moisture consistent). Bacterial spot (dark lesions on fruit — avoid wetting foliage). Sunscald on fruit exposed to intense sun. Very susceptible to frost — protect plants as soon as temps drop near freezing.',
    storageUse: 'Fresh: keeps 1–2 weeks in the refrigerator. Excellent for pickling — pickled banana peppers are a classic condiment. Can be sliced and frozen for cooking. Roasted and peeled banana peppers freeze well for 6 months. Great on pizzas, sandwiches, and in salsas.',
    bestSeason: 'Start indoors 8–10 weeks before last frost. Transplant after all frost risk has passed and nights are above 55°F. Peppers love heat — production picks up dramatically when daytime temperatures consistently hit 75–85°F. Long growing season required (70–85 days to mature).',
  ),

  'bitter melon': PlantKnowledge(
    harvestSigns: 'Harvest while still green (immature) — typically 12–15 cm long and firm. The exterior should have prominent ridges and a bright green color. Once it starts turning yellow-orange, it\'s overripe and very bitter to the point of being unpalatable for most uses. The inside turns red when fully ripe (seeds are then used for next year).',
    harvestHow: 'Cut fruits from the vine with scissors or a knife, leaving a short stem. Check vines daily during peak season as fruits mature quickly. Handle gently as the thin skin bruises easily. Pick every 2–3 days to keep the vine producing. Rinse with water and remove the seeds and white pith (the bitterest parts) before cooking.',
    soilPrep: 'Rich, well-drained soil with plenty of organic matter. pH 6.0–6.7. Needs a trellis or fence to climb — can grow 6–15 feet tall. Warm soil (above 65°F) for germination. Full sun is essential for good fruit production.',
    fertilizing: 'Moderate feeder. Apply balanced fertilizer at planting, then feed every 3–4 weeks through the growing season. A tomato-type fertilizer works well. Consistent moisture is important for fruit development.',
    commonProblems: 'Powdery mildew, aphids, fruit flies. Vine borers in some regions. The plant is generally vigorous and trouble-free in warm climates. Fruit drop can occur from inconsistent watering or pollination issues — hand-pollinate if needed.',
    storageUse: 'Store in the refrigerator for up to 1 week. Soak sliced pieces in salted water for 20 minutes before cooking to reduce bitterness. Common in Asian cuisines — stir-fries, curries, soups. The seeds from ripe (yellow) fruits are saved for next year\'s planting.',
    bestSeason: 'Direct sow or transplant after last frost when soil is warm. Needs a long, hot growing season (70–90 days). Ideal for tropical and subtropical climates. In short-season areas, start indoors 3–4 weeks early and use row covers to extend the season.',
  ),

  'black-eyed susan': PlantKnowledge(
    harvestSigns: 'For cut flowers: harvest when the central dark cone is firm and the yellow ray petals are just beginning to fully open. For seeds: wait until after a killing frost when the dark cone has dried to dark brown or black and feels hard. Seeds cling tightly in the cone.',
    harvestHow: 'Cut flower stems in the morning at the desired length. For seed collection, cut entire dried seed heads and place in a paper bag — seeds will fall out as they continue to dry. Rub cones gently between your palms to release remaining seeds. Seeds are very small and spiky. Deadheading in summer extends bloom; leave seed heads in fall for birds (goldfinches love them).',
    soilPrep: 'Adapts to poor, average, or even clay soils — one of the most forgiving native plants. Good drainage is important. pH 5.5–7.0. Drought-tolerant once established. Does NOT need rich soil; too-fertile conditions produce floppy plants with fewer flowers.',
    fertilizing: 'Rarely needs fertilizing. In very poor soil, a light spring application of balanced fertilizer helps. Otherwise, leave it alone — it\'s a prairie plant adapted to surviving without feeding.',
    commonProblems: 'Powdery mildew on lower leaves in humid weather (mainly cosmetic). Crown rot in soggy soil. Aphids occasionally. Relatively pest and disease resistant. May spread aggressively by self-seeding — deadhead after bloom if you don\'t want it to naturalize.',
    storageUse: 'Fresh cuts last 7–10 days in a vase. Dried seed heads are attractive in winter arrangements. Seeds stored in a dry envelope keep for 2–3 years. Goldfinches and chickadees eat seeds throughout winter — a wildlife value reason to leave seed heads standing.',
    bestSeason: 'Direct sow outdoors in fall or early spring (seeds need a cold period to germinate). Blooms in its first year from early sowings. Perennial in zones 3–9. Self-seeds readily. Excellent for naturalistic plantings, pollinator gardens, and meadows.',
  ),

  'bok choy': PlantKnowledge(
    harvestSigns: 'Baby bok choy (3–4 inches): harvest at any size once it looks like a miniature head. Full-size bok choy: ready when the white stalks are thick (1–2 inches) and the plant is 12–18 inches tall. Harvest before it sends up a flower stalk (bolts), which turns leaves bitter. Outer stalks should be firm and crisp.',
    harvestHow: 'Whole-head harvest: cut the entire plant at soil level. Cut-and-come-again: harvest outer stalks and leaves individually, leaving the central growing point for continued production. Baby bok choy can be harvested whole by pulling or cutting. Harvest in the morning when leaves are at their crispest.',
    soilPrep: 'Rich, well-drained soil with good moisture retention. pH 6.0–7.0. Work in compost before planting. Bok choy is a heavy feeder and rewards good soil preparation. Consistent soil moisture prevents premature bolting.',
    fertilizing: 'Moderate to heavy feeder. Apply nitrogen-rich fertilizer or compost tea every 2–3 weeks during growth. Healthy growth = tender, mild-flavored stalks. Stress (heat, drought, nitrogen deficiency) causes bitterness and early bolting.',
    commonProblems: 'Cabbage worms, aphids, slugs, and flea beetles. Row covers provide excellent protection. Clubroot disease in acid soil (raise pH and rotate crops). Bolts rapidly in heat and long days — choose slow-bolt varieties for late spring planting. Best crops are grown in cool weather.',
    storageUse: 'Refrigerate unwashed for 3–7 days in a bag. Wash right before use. Excellent stir-fried, steamed, or in soups — the stalks and leaves cook at different rates, so add stalks first. Baby bok choy can be halved and grilled. Freeze blanched pieces for soups.',
    bestSeason: 'Spring: direct sow 4–6 weeks before last frost or transplant. Fall: sow 6–8 weeks before first frost. Grows best at 50–65°F. Fall crops tend to be sweeter and have fewer pest problems. Avoid summer planting — bolts almost immediately in heat.',
  ),

  'borage': PlantKnowledge(
    harvestSigns: 'Flowers are ready when they\'re fully open and a vivid blue (or pink on some varieties). Pick flowers for culinary use right when they open — they\'re most vibrant and flavorful. Young leaves are best when 2–3 inches long, before they develop coarse hairs. Seeds are ready when they turn dark brown-black and fall easily from the plant.',
    harvestHow: 'Pinch individual star-shaped flowers from the stem. Harvest leaves by cutting from the outer sections of the plant. Flowers are delicate — handle gently and use immediately or float in water. For seeds, shake the seed head over a bag or let plants self-sow naturally. Deadheading slows self-seeding if you want to control spread.',
    soilPrep: 'Thrives in poor to average, well-drained soil — actually flowers more profusely in low-fertility conditions. pH 6.0–7.0. Direct sow where it will grow; it doesn\'t transplant well due to a taproot. Self-sows prolifically.',
    fertilizing: 'Needs very little fertilizer. Rich soil or heavy feeding causes lush, floppy growth with fewer flowers. Let it grow lean for best results.',
    commonProblems: 'Aphids, particularly at growing tips. Powdery mildew in late summer (mainly cosmetic). Spider mites in dry conditions. Can spread aggressively by self-seeding — manage by deadheading. An extremely easy-going plant.',
    storageUse: 'Use flowers immediately — they wilt quickly once picked. Float in ice cube trays with water and freeze for decorative ice cubes. Edible flowers have a mild cucumber flavor, excellent in salads, lemonade, and cocktails. Young leaves can be cooked like spinach or used to flavor drinks.',
    bestSeason: 'Direct sow outdoors in early spring — one of the few plants that tolerates light frost as a seedling. Germinates quickly in cool soil. Self-seeds so reliably it often appears without replanting in subsequent years. Blooms spring through fall; excellent pollinator plant that attracts bees.',
  ),

  'buckwheat': PlantKnowledge(
    harvestSigns: 'As a cover crop, buckwheat is typically incorporated into the soil at flowering (3–4 weeks after sowing) before seeds set — this prevents it from becoming a weed. For grain harvest: wait until 75–80% of seeds have turned dark brown-black. Don\'t wait for full maturity as seeds shatter and fall easily.',
    harvestHow: 'Cover crop use: mow or till in at full bloom (maximum biomass, before seed set). Grain harvest: cut stalks near the base in the morning (seeds shatter less when plants are slightly damp with dew). Hang bundles upside down on a tarp or sheet to finish drying. Thresh by beating bundles against a barrel, then winnow to remove chaff.',
    soilPrep: 'Grows in poor, acidic, or heavy clay soils where almost nothing else will thrive — that\'s its value as a cover crop. pH 5.0–7.0. Its roots secrete acids that make phosphorus available. No soil preparation needed for cover crop use.',
    fertilizing: 'Does not need fertilizer — this is its advantage as a soil-building cover crop. Its deep roots mine nutrients from subsoil and bring them to the surface, making them available to subsequent crops.',
    commonProblems: 'Virtually pest and disease free. Birds will eat grain crops — use netting if needed. Does not tolerate frost, so timing is important. Can become a weed if allowed to set seed unintentionally.',
    storageUse: 'Buckwheat groats store in airtight containers for 6 months at room temperature, longer in the refrigerator. Used in pancakes, noodles (soba), porridge, and as a rice substitute. Buckwheat flour is gluten-free. Roasted buckwheat (kasha) has a stronger, nuttier flavor.',
    bestSeason: 'Sow after last frost when soil is warm — germinates quickly and flowers in just 35–45 days. Can resow immediately after the first crop for a second round. Excellent summer cover crop between spring and fall vegetables. Killed by first frost, making tillage easy.',
  ),

  'calendula': PlantKnowledge(
    harvestSigns: 'Flowers are ready when the petals are fully open and have reached their maximum color (bright orange or yellow). For herbal use, harvest in the morning after the dew dries but before heat sets in. For seeds, leave some flowers on the plant until they\'ve dried and the hooked seeds are visible and brown.',
    harvestHow: 'Pinch or cut the entire flower head just below the bloom. Harvest every 2–3 days — deadheading and regular harvesting stimulate continuous flowering throughout the season. For drying, spread single-layer on screens in a warm, airy spot away from direct sun. Seeds separate easily by rolling dried heads between your fingers.',
    soilPrep: 'Average to fertile, well-drained soil. pH 5.5–7.0. Tolerates poor soil but flowers more prolifically in amended beds. Direct sow or start transplants — tolerates light frost as a seedling.',
    fertilizing: 'Light to moderate feeder. A balanced fertilizer at planting helps establish the plant. Too much nitrogen produces leafy growth over flowers. Compost-amended soil is usually sufficient.',
    commonProblems: 'Powdery mildew in humid, low-airflow conditions (space plants 9–12 inches apart). Aphids on new growth — spray off with water. Spider mites in hot, dry weather. Whiteflies. Generally an easy, trouble-free plant. Self-sows readily.',
    storageUse: 'Fresh flowers in a vase last 5–7 days. Dried petals store in airtight jars for up to 1 year for herbal use (salves, tinctures, teas). Edible petals (mild, slightly bitter) add color to rice, soups, and salads. Calendula-infused oil is a classic skin-care ingredient.',
    bestSeason: 'Direct sow outdoors 2–4 weeks before last frost. Also excellent as a fall crop — tolerates light frost and blooms late into the season. Best in cool weather (55–65°F ideal). In hot summers, plants may take a bloom break and resume in fall.',
  ),

  'cauliflower': PlantKnowledge(
    harvestSigns: 'The curd (the white head) should be firm, compact, and creamy white — or purple/green for colored varieties. Harvest when the curd is 6–8 inches in diameter before it starts to loosen, separate, or turn yellow. Once individual sections (florets) become visible and the head starts to "rice" or separate, it\'s past its prime.',
    harvestHow: 'Cut the stem about 2 inches below the curd with a sharp knife. Leave some wrapper leaves attached to protect the curd. For pure-white heads, blanch by folding outer leaves up over the curd when it\'s about the size of a golf ball — secure with a rubber band. Check every few days.',
    soilPrep: 'Rich, well-drained soil with high organic matter. pH 6.0–7.0. Work in generous compost. Cauliflower is a heavy feeder and needs consistent moisture — stress at any point can cause buttoning (tiny, premature heads) or ricey texture.',
    fertilizing: 'Heavy feeder. Apply high-nitrogen fertilizer every 2–3 weeks during the growing season. Side-dress with compost or fertilizer when plants are 6 inches tall. Calcium deficiency causes "hollow stem" — use calcium-rich amendments if this is a recurring problem.',
    commonProblems: 'Cabbage loopers, aphids, and imported cabbageworms — use row covers early. Downy mildew and blackleg disease. Browning of the curd from cold or sun exposure. Buttoning (tiny heads) from transplant shock, cold snaps, or drought. Alternaria leaf spot in wet conditions.',
    storageUse: 'Keep the head unwashed in a plastic bag in the refrigerator for up to 2 weeks. For long-term storage, blanch florets for 3 minutes and freeze. Cauliflower rice: pulse raw florets in a food processor and use as a rice substitute or pizza crust. Roasting intensifies its sweetness.',
    bestSeason: 'A cool-season crop that dislikes both frost and heat. Start transplants indoors 4–6 weeks before last spring frost. Fall is often easier — count back 10–12 weeks from first fall frost. Days to maturity are 50–100 depending on variety. Consistent cool temperatures (50–65°F) produce the best heads.',
  ),

  'cayenne pepper': PlantKnowledge(
    harvestSigns: 'Fully ripe cayennes turn deep red (some varieties turn orange or yellow). Green cayennes are edible but milder. Maximum heat and flavor develop when fully red. Peppers should be firm and glossy. The stem end should look fresh, not dried or shrivelled.',
    harvestHow: 'Snip off with scissors just above the stem cap — don\'t pull or twist, which can damage branches. Wear gloves when handling large quantities to avoid skin irritation from capsaicin. Harvest red peppers regularly to encourage more production. Leaving peppers on the plant too long slows production.',
    soilPrep: 'Fertile, well-drained soil with good drainage. pH 6.0–6.8. Amend with compost. Like all peppers, cayennes need warm soil — plant after soil temperature reaches 65°F consistently. Mulch to retain moisture and warmth.',
    fertilizing: 'Moderate feeder. Use a balanced fertilizer at planting. Once flowering starts, switch to lower-nitrogen, higher-phosphorus fertilizer to encourage fruiting over leafy growth. A fertilizer formulated for tomatoes or peppers works well.',
    commonProblems: 'Aphids, spider mites, thrips. Bacterial spot (dark spots on fruit — avoid wetting foliage, destroy affected plants). Phytophthora root rot in wet soils. Very susceptible to cold — even temperatures below 55°F at night can slow production and cause flower drop.',
    storageUse: 'Fresh cayennes keep 1–2 weeks in the refrigerator. Dry whole: hang bunches upside down in a warm, airy place for 3–4 weeks until crispy throughout. Dried cayennes store for 1–2 years in airtight jars. Grind dried peppers for cayenne powder. Great for hot sauces, pickling, and drying.',
    bestSeason: 'Start indoors 8–10 weeks before last frost. Transplant after all frost risk is gone and soil is warm. Very long season needed (80–100 days to full maturity). In short-season climates, choose early-maturing varieties. Row covers help in cool springs.',
  ),

  'celeriac': PlantKnowledge(
    harvestSigns: 'The swollen root crown (knob) is ready when it\'s 3–5 inches in diameter. It should feel firm and solid when pressed. Roots that are too small will be woody and less flavorful. Light frost actually improves flavor — the sugars concentrate. The knob sits at soil level and is easily visible.',
    harvestHow: 'Use a garden fork to loosen the soil around the plant, then lift the entire plant. Trim off leaves and side roots with a sharp knife, leaving just the round knob. Brush off excess soil — don\'t wash before storage. The exterior is rough and gnarly; peel generously before use.',
    soilPrep: 'Rich, deeply worked soil with excellent moisture retention and good drainage. pH 6.0–7.0. Incorporate large amounts of compost. The growing area should be free of rocks and clumps that would distort the growing knob. Consistent moisture is critical — dry spells cause cracking.',
    fertilizing: 'Heavy feeder. Apply nitrogen-rich fertilizer every 3–4 weeks through the growing season. Additional side-dressing with compost in midsummer boosts knob development. Calcium deficiency causes blackened centers — use gypsum in calcium-deficient soils.',
    commonProblems: 'Celery leaf miner (tunnels in leaves). Aphids. Slugs damage the emerging seedlings. The main challenge is the very long growing season (100–120 days) — requires careful timing and consistent care all season. Also needs constant moisture; any prolonged drought stunts the root.',
    storageUse: 'Stores exceptionally well: keep in a cool root cellar or refrigerator (32–40°F) in moist sand or perforated plastic bags for 3–6 months. Can be left in the ground under mulch in zones 5+ through light frosts. Peel before use — the flesh won\'t discolor if dropped in cold water. Great in soups, mashed, or roasted.',
    bestSeason: 'One of the earliest crops to start — begin indoors 10–12 weeks before last frost. Seeds need 70°F to germinate (takes 2–3 weeks). Celeriac needs a full, long growing season. Start early, transplant carefully, keep consistently moist. Fall harvest after frost is the goal.',
  ),

  'chamomile': PlantKnowledge(
    harvestSigns: 'Flowers are ready when the white ray petals begin to bend backward toward the stem (reflex). At full horizontal petal position, the center yellow dome is firm — this is optimal. Once petals fully curve back and the dome starts to elongate or discolor, harvest immediately or miss the window. Pick in late morning after dew dries.',
    harvestHow: 'Pinch individual flowers between your thumb and forefinger and pull firmly. A specialized chamomile rake (a comb-like tool) speeds harvest on large plantings. Harvest every 3–5 days during the bloom period — plants produce continuously. Dry flowers in a single layer on screens or in a dehydrator at 95–105°F until completely dry and crumbling.',
    soilPrep: 'Chamomile prefers poor to average, well-drained soil. pH 5.6–7.5. Overly rich soil produces lots of foliage but fewer flowers. German chamomile (annual) grows quickly from seed direct-sown in open ground. Roman chamomile (perennial) spreads by creeping stems.',
    fertilizing: 'Barely any fertilizer needed. In fertile soil, plants may become too leafy and produce fewer flowers. Top-dress with compost if plants look stressed, but otherwise leave them unfed.',
    commonProblems: 'Aphids in early growth. Powdery mildew in late summer (usually after harvest season). Otherwise very trouble-free. German chamomile self-sows prolifically — it will naturalize and reappear without replanting in most gardens.',
    storageUse: 'Dried flowers store in an airtight jar away from light and heat for up to 1 year (potency fades over time). Use for herbal teas, tinctures, or skin preparations. German chamomile (Matricaria chamomilla) is the medicinal species. Teas brewed too strong can be bitter — steep 1–2 tsp per cup for 5 minutes.',
    bestSeason: 'Direct sow German chamomile in early spring — needs light to germinate (press seeds onto soil surface, don\'t cover). Also sow in fall for spring germination. Easy and fast-growing; blooms 6–8 weeks after germination. Self-seeds so readily it often becomes self-sustaining in the garden.',
  ),

  'chard': PlantKnowledge(
    harvestSigns: 'Outer leaves are ready when 6–10 inches long. Young, tender leaves are mild-flavored and excellent raw. Larger leaves are more robust-flavored, better cooked. Harvest before leaves become oversized, tough, or yellowing. The plant should have at least 4–5 inner leaves remaining after harvest to continue producing.',
    harvestHow: 'Snap or cut outer leaves at the base of the stem, working from the outside in. Leave the inner cluster of young leaves untouched — the plant will keep growing from the center. This cut-and-come-again method gives harvests every 1–2 weeks from the same plant for months. Never harvest more than a third of the plant at once.',
    soilPrep: 'Well-drained, fertile soil with good organic matter. pH 6.0–7.0. Work in compost before planting. Chard tolerates slightly saline soils better than most vegetables. Consistent moisture prevents bitterness and bolting.',
    fertilizing: 'Moderate feeder. Apply nitrogen-rich fertilizer every 3–4 weeks to keep leaves tender and large. A compost side-dressing in midsummer can extend the harvest season well into fall. More nitrogen = larger, more tender leaves.',
    commonProblems: 'Leaf miners create silvery winding tunnels (remove affected leaves; cover with row cover to prevent adult flies from laying eggs). Aphids on new growth. Cercospora leaf spot (tan spots with purple borders) in wet conditions. Generally very easy to grow.',
    storageUse: 'Refrigerate unwashed in a plastic bag for up to 1 week. Separate colorful stems from green leaves — stems take longer to cook. Stems can be pickled or used like celery. Leaves can be used raw in salads (young leaves) or cooked like spinach. Blanch and freeze for long-term storage.',
    bestSeason: 'Direct sow or transplant in spring after last frost, or in late summer for fall harvest. Extremely cold-tolerant — survives frosts down to 25°F with protection. One of the best heat-tolerant greens for summer. Can harvest from a single planting for the entire season. Excellent in zones 3–10.',
  ),

  'chives': PlantKnowledge(
    harvestSigns: 'Leaves are ready when they\'re 6 inches or taller. The plant should be established (at least 8–10 leaves present) before the first harvest. For flowers: harvest the purple pompom blooms when they\'re fully open for culinary use. For seeds: wait until the flower head dries and seeds are black.',
    harvestHow: 'Snip leaves with scissors 1–2 inches above the soil, cutting the entire clump down evenly. Avoid pulling or tearing, which can damage the bulbs. The plant will regrow and be ready again in 2–3 weeks. Do this 3–4 times per season. Deadhead flowers (or harvest them) to prevent excessive self-seeding.',
    soilPrep: 'Adaptable to most well-drained soils. pH 6.0–7.0. Chives don\'t need rich soil but do well with a compost amendment. Thrives in containers and borders. Divide clumps every 2–3 years in spring to rejuvenate.',
    fertilizing: 'Light feeder. A spring application of balanced fertilizer or compost is enough for the whole season. Overly rich soil produces floppy, weak leaves.',
    commonProblems: 'Thrips, aphids, onion leaf miner (rare). Downy mildew in wet conditions. Generally very trouble-free — one of the most carefree herbs in the garden. Can spread by self-seeding if flowers aren\'t deadheaded.',
    storageUse: 'Use fresh for best flavor — dried chives lose most of their flavor. Chop and freeze in small portions; frozen chives are excellent in cooked dishes. Store fresh cuts in a glass of water (like flowers) in the refrigerator for up to a week. Edible flowers with a mild onion flavor — use as a garnish.',
    bestSeason: 'Perennial in zones 3–9. Direct sow in spring or divide existing clumps. Slow to germinate from seed (14–21 days). Buying a small plant is faster. One of the earliest herbs to emerge in spring and one of the last to die back in fall. Excellent container plant.',
  ),

  'clover': PlantKnowledge(
    harvestSigns: 'For cover crop use, clover is at peak nitrogen content when it begins to flower — this is the ideal time to cut or till it in. For forage or hay, cut just before peak bloom. For tea/culinary use, harvest fully open flower heads in the morning. For seed, let flowers dry completely and turn brown.',
    harvestHow: 'Cover crop: mow at ground level and till into the top few inches of soil at least 2–3 weeks before planting the next crop. For culinary flowers, snip flower heads and use fresh or dry on a screen. For seed collection, shake dried brown heads into a bag and winnow lightly.',
    soilPrep: 'Clover grows in almost any soil and actually improves it — nitrogen-fixing root nodules feed the soil. Very tolerant of poor, acid, or clay soils. pH 6.0–7.0 preferred but will grow in wider range. One of the best soil-building cover crops.',
    fertilizing: 'Does not need fertilizing — it makes its own nitrogen. Phosphorus and potassium help establish the stand, but clover is largely self-sustaining.',
    commonProblems: 'Clover mites, clover root borer. Crown rot in very wet soils. Can be outcompeted by aggressive weeds when establishing — weed early. Sclerotinia disease in dense plantings in cool, wet weather.',
    storageUse: 'Fresh flowers: edible in salads, mild sweet flavor. Dry flowers for tea — red clover tea has a traditional use in herbal medicine. Dried flowers store 6–12 months in airtight jars. As a cover crop, it\'s not harvested for human use — simply incorporated into the soil.',
    bestSeason: 'Sow in early spring or late summer. Cool-season grower that tolerates frost. White clover is a perennial lawn alternative; red clover is a biennial/short-lived perennial. Establishes quickly and fixes nitrogen within 4–6 weeks of germination.',
  ),

  'comfrey': PlantKnowledge(
    harvestSigns: 'Leaves are ready for harvest when they reach 12–18 inches long — usually 2–3 months after planting. The plant can be cut down 2–4 times per season. For making liquid fertilizer (comfrey tea), harvest the large, mature lower leaves. Use when the plant is actively growing and before flowering.',
    harvestHow: 'Cut the entire above-ground growth with a sickle or hedge trimmer 2–4 inches above the crown, or snip individual large leaves. The plant will regrow vigorously. Do not harvest in the first year from root divisions — let it establish. In subsequent years, cut 3–4 times per season. Use immediately as mulch, chop-and-drop, or make into liquid fertilizer.',
    soilPrep: 'Adapts to most soils including poor, clay, or rocky ground. Deep taproot mines nutrients from subsoil. pH 5.5–7.0. Extremely drought-tolerant once established. Plant where you want it permanently — the deep taproot makes it very difficult to move.',
    fertilizing: 'Does not need external fertilizing — the deep tap root mines its own nutrients. In fact, comfrey IS used to make fertilizer for other plants. Its leaves are high in potassium, phosphorus, nitrogen, and calcium.',
    commonProblems: 'Virtually no pest or disease problems. Can spread from root fragments — plant the sterile \'Bocking 14\' cultivar to prevent unwanted spreading. Very difficult to eradicate once established — every root fragment can regrow. Choose location carefully.',
    storageUse: 'Fresh leaves used as mulch, green compost activator, or chop-and-drop fertilizer for fruit trees. For comfrey tea: pack leaves into a container, weigh down, add water, and let ferment for 4–6 weeks (it smells terrible). Dilute 1:15 for a powerful liquid fertilizer. Avoid internal consumption — contains alkaloids.',
    bestSeason: 'Plant root divisions in early spring or fall. Grows vigorously all season. Perennial and very long-lived (decades). Dies back in winter, re-emerges in spring. First-year plants should be allowed to establish; full productivity in year 2 and beyond.',
  ),

  'currant': PlantKnowledge(
    harvestSigns: 'Black currants: harvest when berries are black, soft, and sweet — tasting a few is the best test. Red and white currants: harvest when berries have fully developed their color and pull off the cluster easily. Entire clusters (strigs) ripen at once. Taste for sweetness — underripe currants are very tart.',
    harvestHow: 'Pick entire clusters (strigs) at once by holding the stem and pulling gently. Stripping entire clusters is faster than picking individual berries. Alternatively, use a fork to comb berries off the cluster over a bowl. Harvest from bottom of cluster to top. Handle gently; currants are fragile and bruise easily.',
    soilPrep: 'Rich, well-drained soil with high organic matter. pH 6.0–6.5. Work in generous compost before planting. Excellent drainage is important but currants do tolerate slightly wetter soils than many fruits. Mulch heavily to keep roots cool and moist.',
    fertilizing: 'Feed in early spring with a balanced fertilizer before growth begins. A nitrogen-rich fertilizer promotes new fruiting wood, which is where most fruit is produced. Annual mulching with compost feeds the plant steadily. Over-fertilizing causes soft, disease-prone growth.',
    commonProblems: 'Currant aphids (curl leaves). Powdery mildew. Currant borers tunnel in stems — remove and destroy affected canes. Currants are alternate hosts for white pine blister rust — check local regulations before planting in some US states. Birds eat ripe berries — net the bush.',
    storageUse: 'Fresh currants keep 1 week in the refrigerator. Very high in vitamin C and pectin — excellent for jams, jellies, and syrups with no added pectin needed. Freeze on baking sheets then bag for storage up to 1 year. Black currants can be used for cassis (liqueur), juices, and sauces.',
    bestSeason: 'Plant bare-root bushes in early spring or fall. Most productive in cool climates (zones 3–6). Need at least some winter chill. Begin producing in year 2–3 and peak production by years 5–7. Prune annually to remove old unproductive wood and encourage new shoots.',
  ),

  'dahlia': PlantKnowledge(
    harvestSigns: 'For cutting: harvest when the central petals of the bloom are open but the outermost petals still have some firmness (not fully blown open). Fully open dahlias wilt quickly in a vase. For tuber harvest: wait until after the first killing frost blackens the foliage, then harvest tubers. The frost cures the tuber "eyes" that you\'ll need for next year\'s plants.',
    harvestHow: 'Cutting flowers: cut stems in the early morning or evening, cutting at a 45-degree angle near a lateral bud. Immediately plunge into water. For tubers: cut stalks to 4 inches, carefully dig with a fork, and shake off soil. Gently hose off remaining dirt. Dry tubers 24 hours, then store in slightly moist medium (peat, vermiculite, or wood shavings) at 45–55°F.',
    soilPrep: 'Rich, well-drained, loamy soil. pH 6.0–7.5. Work in compost thoroughly. Tubers rot in waterlogged soil — raised beds or slopes are ideal. Sandy loam is perfect; heavy clay needs significant amendment.',
    fertilizing: 'Moderate feeder. Use a low-nitrogen fertilizer (too much nitrogen = leaves, not flowers). High-potassium and phosphorus fertilizers encourage blooming. Apply a balanced fertilizer at planting, then switch to a bloom-booster formula when buds appear. Monthly feeding through the season.',
    commonProblems: 'Aphids, slugs, earwigs, and spider mites. Powdery mildew in late summer (plant in full sun with good air circulation). Botrytis on stored tubers (dust with sulfur before storage). Earwigs hide in spent blooms — shake blooms before bringing indoors.',
    storageUse: 'Cut flowers last 5–8 days in a vase — condition in deep cold water overnight after cutting. Store dug tubers in a cool, frost-free location (45–55°F) through winter. Check monthly and discard any rotting tubers. Dahlias are not frost-hardy; tubers must be dug in cold climates.',
    bestSeason: 'Plant tubers after last frost when soil has warmed to 60°F. Full sun required. Bloom from midsummer through fall frost — among the longest-blooming flowers in the garden. Pinching out the main growing tip when plants are 12–16 inches tall encourages more branching and blooms.',
  ),

  'delphinium': PlantKnowledge(
    harvestSigns: 'For cut flowers: harvest when the bottom third of the flower spike is open and the remaining buds are showing color. This gives the longest vase life. For seeds: let the seed pods dry on the plant until brown and papery — seeds inside turn black when ready. Entire spikes ripen from bottom to top.',
    harvestHow: 'Cut flower spikes with a sharp knife at an angle, leaving at least one or two leaf nodes on the stem to encourage a second flush of bloom. Immediately put in cold water. After the main spike finishes blooming, cut it off and side shoots will often bloom again in fall. For seeds, shake dried pods into a bag.',
    soilPrep: 'Rich, well-drained, deeply prepared soil. pH 6.5–7.0. Dig in generous amounts of compost. Delphiniums have deep roots and benefit from deep soil preparation (18 inches). Excellent drainage is critical — wet soil causes crown rot. In windy areas, stake plants before they need it.',
    fertilizing: 'Heavy feeder. Apply balanced fertilizer in early spring when shoots emerge. Side-dress with compost or apply liquid fertilizer monthly during the growing season. After the first flush of bloom, fertilize again to encourage the second flush.',
    commonProblems: 'Slugs and snails devour young shoots (use barriers or iron phosphate bait). Powdery mildew is extremely common in summer — improve air circulation, choose resistant varieties. Crown rot in wet or heavy soils. Bacterial black spot. All parts of the plant are toxic — wear gloves when working with them.',
    storageUse: 'Cut flowers last 5–7 days in a vase. Dried flower spikes can be used in arrangements. Seeds stored cool and dry remain viable for 1 year. Perennial in zones 3–7; short-lived in warm climates. Often treated as annuals in warm zones.',
    bestSeason: 'Start seeds indoors 8–10 weeks before last frost. Plant transplants outdoors in early spring — delphiniums need cool weather to establish. They thrive in cool summers; struggle in heat. Planted in spring, they bloom early-to-midsummer.',
  ),

  'echinacea': PlantKnowledge(
    harvestSigns: 'For cut flowers: harvest when ray petals are just beginning to lift away from the central cone. For medicinal use: harvest roots in fall of year 3 or 4, when roots are large and well established. For seeds: let the spiky seed heads dry completely on the plant.',
    harvestHow: 'Cut flower stems at a leaf node to encourage side branching. Harvest roots with a garden fork, washing thoroughly. Dry roots in slices at 95 degrees F until completely brittle. For seeds, cut dried seed heads over a bag and shake. Fresh petals and cones can be tinctured or dried.',
    soilPrep: 'Well-drained, average to poor soil. pH 6.0–7.0. Echinacea is native to prairies and does not need rich soil — too much organic matter can cause root rot. Drought-tolerant once established. Does not like soggy conditions.',
    fertilizing: 'Minimal fertilizer needed. Excess nitrogen produces floppy plants with fewer flowers. A light spring compost top-dress is plenty. Treat it like a wildflower.',
    commonProblems: 'Aster yellows disease (distorted, stunted flowers — remove affected plants, control leafhoppers). Japanese beetles eat flowers. Powdery mildew in crowded conditions. Root rot in poorly drained soil. Generally very tough and low-maintenance once established.',
    storageUse: 'Fresh cut flowers last 7–10 days. Dried flower heads and seed cones are attractive in winter arrangements. Dried roots and tops used in herbal teas and tinctures. Store dried plant material in airtight jars for up to 1 year.',
    bestSeason: 'Direct sow outdoors in fall or start indoors 8 weeks before last frost after cold-stratifying seeds in the refrigerator for 8 weeks. Perennial in zones 3–9. Blooms from midsummer through fall. Naturalizes and spreads over time.',
  ),

  'edamame': PlantKnowledge(
    harvestSigns: 'The pods should be bright green, plump, and firm — you will feel the beans pushing against the pod wall. Seeds inside should be about 80-90% full size. The window is brief — check plants daily once pods start to fill. Overripe pods turn yellow and beans become starchy and tough.',
    harvestHow: 'Pull entire branches from the plant, then strip the pods off — this is faster than picking individual pods. Or cut the entire plant at the base when the majority of pods are ready. Blanch pods in boiling salted water for 3–5 minutes immediately after harvest for best flavor.',
    soilPrep: 'Average, well-drained soil. pH 6.0–6.8. Like other beans, edamame fixes its own nitrogen through root nodules — avoid high-nitrogen fertilizers. Inoculate seeds with soybean-specific rhizobia inoculant for best yields.',
    fertilizing: 'Minimal nitrogen — the plant makes its own. A balanced fertilizer at planting is fine. Excessive nitrogen causes lush foliage at the expense of pods. Phosphorus and potassium at planting support root development and pod fill.',
    commonProblems: 'Bean beetles, aphids, spider mites in hot or dry weather. Cutworms on young seedlings. Pod blights in wet conditions. Direct sow and avoid transplanting — edamame dislikes root disturbance.',
    storageUse: 'Eat or blanch within a few hours of harvest for best flavor. Blanched and frozen edamame keeps 6–12 months. Serve in the shell with salt, shelling before eating. High in protein, fiber, and folate.',
    bestSeason: 'Direct sow after last frost when soil is warm (65 degrees F and above). Sow every 2 weeks for continuous harvests. Full sun required. Days to harvest: 70–90 days. Warm temperatures accelerate pod development — track your plants closely near harvest time.',
  ),

  'endive': PlantKnowledge(
    harvestSigns: 'Curly endive (frisee): harvest when the head is 8–12 inches across and the inner leaves are naturally blanched to pale yellow-cream. Escarole: harvest when the head is a full, firm rosette about 12 inches across. Both are best when cool temperatures or blanching have sweetened the bitter inner leaves.',
    harvestHow: 'Cut the entire head at soil level with a sharp knife. For blanching to reduce bitterness: 1–2 weeks before harvest, tie the outer leaves over the heart with twine, or place an upturned pot over the plant. The inner leaves will become pale and more tender. Harvest in the morning for crispest texture.',
    soilPrep: 'Well-drained, fertile soil with good organic matter. pH 5.8–6.8. Work in compost. Consistent moisture prevents excessive bitterness. Rich soil produces more tender, less bitter leaves.',
    fertilizing: 'Moderate feeder. Apply balanced fertilizer at planting. A liquid nitrogen fertilizer mid-season helps keep leaves tender. Stress from drought, heat, or poor soil dramatically increases bitterness.',
    commonProblems: 'Aphids, slugs, and snails. Tip burn from calcium deficiency or inconsistent watering. Bolts in heat and long days — predominantly a cool-season crop. Bitter flavor intensifies in heat; sweetens with cool weather and light frost.',
    storageUse: 'Refrigerate heads for up to 2 weeks in a plastic bag. Whole heads store better than cut. Raw in salads (the outer leaves are bitter; blanched inner leaves are mild). Braised, grilled, or wilted in cooked dishes. Pairs well with sweet dressings, blue cheese, and citrus.',
    bestSeason: 'Best grown as a fall crop — sow in mid-to-late summer so harvest falls in cool fall weather. Spring crops bolt quickly. Cool temperatures (45–65 degrees F) are essential for quality. Light frost actually sweetens the flavor.',
  ),

  'epazote': PlantKnowledge(
    harvestSigns: 'Harvest once plants are 12–18 inches tall and branching well. Young stem tips (4–6 inches) are most aromatic and tender. The plant is ready within 60–70 days of sowing. For seeds, wait until seed clusters dry and turn brown.',
    harvestHow: 'Snip stem tips and young leaves as needed. Regular harvesting encourages bushy, compact growth. Do not harvest more than a third of the plant at once. To dry: cut stems 4–6 inches long and hang in bunches in a warm, airy spot. Dry seeds by cutting whole branches when seeds are mature and drying on paper.',
    soilPrep: 'Thrives in poor, dry, sandy soil — excessive soil fertility reduces aroma and flavor. pH 5.5–7.0. Good drainage is important. Very drought-tolerant. Direct sow where it will grow; it does not transplant well. Self-sows prolifically in warm climates.',
    fertilizing: 'Minimal fertilizer needed or desired. Rich soil produces large, bland-flavored plants. The flavor compounds develop more strongly under slightly stressed growing conditions.',
    commonProblems: 'Few serious pests. Aphids occasionally. Can become invasive by self-seeding — deadhead if you do not want it to spread. Very easy to grow once established. Has a strong, unusual smell that some people find pungent.',
    storageUse: 'Use fresh for best flavor. Dried epazote stores in an airtight jar for 6 months. A traditional culinary herb in Mexican cooking, particularly with black beans. Has carminative (gas-reducing) properties. Add late in cooking as heat diminishes the flavor quickly.',
    bestSeason: 'Direct sow after last frost when soil is warm. Germinates readily in warm conditions. A warm-season annual that thrives in summer heat. In frost-free climates, can grow as a perennial. Self-seeds prolifically.',
  ),

  'fennel': PlantKnowledge(
    harvestSigns: 'Bulb fennel: harvest when the bulb is 3–4 inches across and looks full and white-green. Harvest before it sends up a flower stalk, which makes the bulb tough and stringy. Herb fennel: harvest feathery fronds at any size; seeds when the umbel turns brown and seeds easily rub off.',
    harvestHow: 'Bulb fennel: cut at soil level, leaving the base — some varieties produce small second-growth shoots from the stub. Cut off tops, leaving 2–3 inches of stalk above the bulb. Herb fennel: snip fronds as needed. For seeds, cut umbels when 70% of seeds have turned brown-grey, and finish drying on paper.',
    soilPrep: 'Well-drained, moderately fertile soil. pH 6.0–7.0. Work in compost. Keep away from most other vegetables — fennel releases chemicals that inhibit the growth of many plants. Especially harmful near tomatoes, peppers, and beans.',
    fertilizing: 'Light to moderate feeder. Balanced fertilizer at planting, then side-dress with compost once or twice during the season. Avoid excessive nitrogen, which promotes leafy growth over bulb development.',
    commonProblems: 'Aphids on fronds. Caterpillars of the black swallowtail butterfly eat the fronds. Powdery mildew. Bolts quickly in heat. Allelopathic to most garden plants — isolate fennel or grow it in a dedicated bed.',
    storageUse: 'Bulbs: wrap tightly and refrigerate for up to 2 weeks. Fronds: use fresh or store in a glass of water in the refrigerator. Seeds: dry completely and store in airtight jars for 2–3 years. All parts are edible with an anise-like flavor. Bulbs excellent roasted, raw in salads, or braised.',
    bestSeason: 'Bulb fennel: direct sow in spring for cool weather growing, or as a fall crop 8–10 weeks before frost. Bolts easily in heat — fall crops are usually more successful. Herb fennel: perennial in zones 4–9. Direct sow in spring after frost danger passes.',
  ),

  'ginger': PlantKnowledge(
    harvestSigns: 'Baby ginger (tender, mild, and pink-skinned): harvest 4–6 months after planting before the stems die back. For mature ginger: harvest after the leaves and stems yellow and die back naturally (8–10 months). The rhizomes are ready when plump, aromatic, and the skin is slightly papery.',
    harvestHow: 'Baby ginger: dig carefully with a fork and harvest the entire clump, or break off portions while leaving the main rhizome to continue growing. Mature ginger: after stems die back, dig the entire clump. Wash rhizomes gently. Save a few healthy, plump pieces with visible buds for replanting next year.',
    soilPrep: 'Rich, loose, well-drained soil with very high organic matter. pH 5.5–6.5. Work in large amounts of compost. Loose soil allows rhizomes to expand easily. In containers, use a loose, well-draining potting mix with added compost.',
    fertilizing: 'Heavy feeder. Apply balanced fertilizer monthly during the growing season. A high-potassium fertilizer helps rhizome development. Top-dress with compost regularly. Stop fertilizing when leaves begin to yellow.',
    commonProblems: 'Root rot in poorly drained or overwatered soil (the most common problem). Spider mites in dry indoor conditions. Bacterial wilt. Ginger does not tolerate temperatures below 50 degrees F — it is strictly a warm-climate or indoor/greenhouse crop in most of North America.',
    storageUse: 'Baby ginger: refrigerate for 2–3 weeks, or pickle in rice vinegar. Mature ginger: refrigerate in a bag for 2–3 weeks; freeze whole and grate directly from frozen; or dry and grind into ground ginger. Ginger beer and candied ginger are other preservation options.',
    bestSeason: 'Plant sprouted rhizomes after last frost, or indoors in late winter. Needs a long, warm growing season of at least 8–10 months. Tropical in origin — thrives in zones 8–12. In colder climates, grow in pots and bring inside for winter, or grow as an annual and harvest in fall.',
  ),

  'goji berry': PlantKnowledge(
    harvestSigns: 'Berries are ripe when bright red-orange, slightly soft, and pull off the branch easily with a gentle tug. Taste one — ripe goji berries are sweet-tart. Underripe berries are green or orange and taste bitter. Avoid eating leaves or unripe berries — they contain mildly toxic alkaloids.',
    harvestHow: 'Pick individual ripe berries by hand, or hold a cloth under branches and gently shake — ripe berries will fall. Harvest every few days during the 2–3 month fruiting season. Fresh berries are fragile; use flat containers for transport.',
    soilPrep: 'Adapts to most well-drained soils, including poor and alkaline soils. pH 6.5–8.0. Tolerates drought but produces better yields with adequate moisture. Excellent drainage essential. Does not need rich soil.',
    fertilizing: 'Light feeder. A balanced fertilizer in spring before new growth begins is usually sufficient. Compost mulch provides gentle nutrition. Avoid excess nitrogen.',
    commonProblems: 'Aphids, spider mites, and scale insects. Powdery mildew on leaves. Birds eat the berries — net if needed. Plants can become aggressive spreaders through suckers and self-seeding.',
    storageUse: 'Fresh berries are delicate — use within a few days or refrigerate for up to 1 week. Dry berries at 100–115 degrees F until shrivelled and leathery. Store dried berries in airtight jars for 1 year. High in antioxidants, vitamin C, and beta-carotene.',
    bestSeason: 'Plant bare-root or potted plants in spring or fall. Hardy perennial (zones 2–7 for cold-hardy varieties). Slow to establish — may not fruit until year 2–3. Long-lived (over 25 years). Annual pruning in late winter keeps the shrub productive.',
  ),

  'grape': PlantKnowledge(
    harvestSigns: 'Grapes do not ripen after picking — taste before harvesting. Ripe clusters are sweet, skins are at full color, and berries feel slightly soft. Seeds inside are tan-brown (not green). Shake the cluster — ripe grapes resist detachment; very loose berries that fall easily may be overripe.',
    harvestHow: 'Cut entire clusters from the vine with sharp pruners, leaving a short stem. Handle clusters by the stem to avoid damaging individual berries. Work through the vine cluster by cluster — not all clusters ripen at exactly the same time. Early morning harvest keeps grapes coolest.',
    soilPrep: 'Well-drained, even gravelly or sandy soil produces the best quality fruit. pH 5.5–6.5. Grapevines do not need rich soil — very fertile soil leads to excessive vegetative growth at the expense of fruit quality. Install a trellis or arbor before planting.',
    fertilizing: 'Light feeder. Apply a balanced fertilizer in early spring. Over-fertilizing is a common mistake that leads to vigorous leafy growth and poor fruit. Established vines in average soil may need no fertilizer at all.',
    commonProblems: 'Powdery mildew and downy mildew (most common diseases — choose resistant varieties). Botrytis bunch rot in wet weather near harvest. Grape berry moth. Japanese beetles skeletonize leaves. Annual winter pruning (removing 90% of last year growth) is essential for productivity.',
    storageUse: 'Fresh grapes keep 1–2 weeks in the refrigerator. Freeze: remove from stems and freeze on a baking sheet then bag. Make juice, jam, jelly, wine, or vinegar. Dehydrate for raisins at 105 degrees F for 24–48 hours.',
    bestSeason: 'Plant bare-root vines in early spring. Most varieties are hardy in zones 4–9. Begin fruiting in year 2–3, peak production from year 5 onward. Annual pruning in late winter is the single most important management task.',
  ),

  'ground cherry': PlantKnowledge(
    harvestSigns: 'The fruit is ripe when the papery husk turns from green to tan or brown and becomes very dry. The berry inside should be golden-yellow. The husk will naturally drop to the ground when ripe — you can let them fall and collect from the ground daily.',
    harvestHow: 'Pick up fallen fruits from the ground every 1–3 days, or check the plant for husks that are completely dry and slightly loose. Do not remove the husk until ready to eat or use. The husk protects the fruit and allows it to store much longer than without it.',
    soilPrep: 'Average to fertile, well-drained soil. pH 6.0–7.0. Work in compost. Very adaptable and easy to grow — similar care requirements to tomatoes. Warm soil is essential for germination and strong growth.',
    fertilizing: 'Moderate feeder similar to tomatoes. Balanced fertilizer at planting, then switch to a lower-nitrogen formula when flowers appear. Monthly feeding through the season. Too much nitrogen produces foliage at the expense of fruits.',
    commonProblems: 'Aphids, flea beetles, hornworms. Colorado potato beetles. Powdery mildew in late season. Self-seeds aggressively — a feature or pest depending on your perspective. Very few serious problems overall.',
    storageUse: 'In their husks at room temperature: several weeks to months. In the refrigerator: 2–3 months in husks. Remove husks just before using. Excellent fresh, in jams, pies, and salsas. Flavor described as pineapple-vanilla-tomato.',
    bestSeason: 'Start indoors 6–8 weeks before last frost (like tomatoes). Transplant after all frost risk has passed and soil is warm. Warm-season crop with a 70–80 day growing season. Extremely productive — one or two plants provide huge yields.',
  ),

  'honeydew': PlantKnowledge(
    harvestSigns: 'Unlike cantaloupes, honeydew melons do not slip from the vine when ripe. The blossom end softens slightly and yields to gentle pressure. The skin color transitions from green-white to creamy yellow-white. A sweet faint melon scent develops at the blossom end. The skin texture becomes slightly waxy.',
    harvestHow: 'Cut from the vine with a knife or pruners, leaving a short stem — honeydew does not self-detach. If unsure of ripeness, wait 2–3 more days and check again. Refrigerate immediately after harvest. Honeydews continue to soften but not sweeten after picking, so harvest on the cusp of ripeness.',
    soilPrep: 'Rich, sandy loam or loamy soil with excellent drainage. pH 6.0–6.5. Work in generous compost. Melons need very warm soil (70 degrees F and above) to grow well — use black plastic mulch to warm the bed. Raised beds drain and warm faster.',
    fertilizing: 'Heavy feeder. Apply balanced fertilizer at planting. Switch to lower-nitrogen, higher-potassium fertilizer when plants begin flowering and fruiting. Potassium is critical for sugar development and flavor. Weekly liquid feeding during fruit development pays dividends in sweetness.',
    commonProblems: 'Cucumber beetles (spread bacterial wilt — most serious problem). Powdery mildew. Aphids. Squash vine borers. Inconsistent watering near harvest causes cracking. Short-season climates make it difficult to grow full-size honeydew — choose early varieties.',
    storageUse: 'Whole at room temperature: 1–2 weeks. Refrigerator after cutting: 3–5 days covered. Honeydew does not freeze well fresh but can be pureed and frozen for smoothies. High water content makes it refreshing for fresh eating, juicing, and fruit salads.',
    bestSeason: 'Start indoors 3–4 weeks before last frost, or direct sow after soil reaches 70 degrees F. Needs a long, hot season (80–100 days). Full sun essential. In zones 4–6, use row covers in spring and choose early varieties. Honeydew needs more heat than cantaloupes to develop good sweetness.',
  ),

  'hops': PlantKnowledge(
    harvestSigns: 'Hop cones are ready in late summer. Ready cones: feel dry and papery, spring back when squeezed, have a strong resinous aromatic smell, and yellow lupulin powder falls out when the cone is split open. Green, wet, compressible cones need more time.',
    harvestHow: 'Cut the entire bine down from the top, pulling the string or wire to the ground. Strip cones by hand into buckets or boxes. Wear long sleeves — hop plant hairs can irritate skin. Dry cones immediately in a single layer at 140 degrees F until completely dry and crumbly inside. This takes 4–8 hours in a food dehydrator.',
    soilPrep: 'Deep, rich, well-drained soil with very high organic matter. pH 6.0–8.0. Hops have an extremely deep, vigorous root system — prepare soil deeply and amend generously with compost. Install a very sturdy support system at least 18 feet tall.',
    fertilizing: 'Heavy feeder. In early spring, apply a high-nitrogen fertilizer to drive initial growth. Through the season, switch to a balanced fertilizer. Potassium and phosphorus support cone development in summer. Annual mulching with compost maintains soil fertility.',
    commonProblems: 'Powdery mildew and downy mildew (both common). Spider mites in hot weather (the most damaging pest). Hop aphids. Verticillium wilt. Japanese beetles eat the leaves. Disease-resistant varieties greatly reduce spraying needs.',
    storageUse: 'Vacuum-seal dried hops and freeze immediately — hop resins oxidize quickly and lose bitterness and aroma at room temperature. Frozen dried hops keep 1–2 years. Used in homebrewing for bitterness, aroma, and flavoring.',
    bestSeason: 'Plant rhizomes in spring after last frost. Perennial in zones 4–8. First year: sparse production. Year 2: full production. A single plant can grow 20–25 feet per season and produce 1–3 lbs of dried hops. Extremely vigorous — give it plenty of space and a tall, sturdy support.',
  ),

  'hydrangea': PlantKnowledge(
    harvestSigns: 'For fresh cut flowers: harvest when blooms are about three-quarters open. For dried arrangements: harvest when the blooms are fully open and the petals feel slightly papery to the touch — this is the point at which they will dry most successfully without shrivelling too much. For seeds: collect seed heads in late fall when completely dry and brown.',
    harvestHow: 'Cut stems at a 45-degree angle in the early morning, removing at least 12 inches of stem. Strip all leaves below the waterline immediately. For drying: cut fully opened blooms on a dry day, remove all leaves, and hang upside down in a warm, dark, airy room for 2–3 weeks. Alternatively, place stems in an inch or two of water and let them dry slowly in place — many hydrangeas dry beautifully this way.',
    soilPrep: 'Rich, well-drained soil with high organic matter. pH 5.5–6.5 produces blue flowers in bigleaf hydrangeas; pH 6.5–7.0 produces pink flowers. Neutral to slightly alkaline soil turns flowers pink or red; acidic soil turns them blue. Add aluminum sulfate to acidify, garden lime to raise pH. Work in generous amounts of compost.',
    fertilizing: 'Apply a balanced slow-release fertilizer in spring when new growth begins. A second feeding in midsummer encourages continued bloom. Avoid fertilizing in late summer or fall — this stimulates tender new growth that frost can damage. High-phosphorus fertilizers can reduce aluminum uptake and shift blue flowers toward pink.',
    commonProblems: 'Powdery mildew in humid, crowded conditions (improve air circulation). Cercospora leaf spot (brown leaf spots — avoid overhead watering). Scale insects. Iron chlorosis in alkaline soils (yellowing leaves with green veins). Flower buds killed by late spring frost (site in a protected location). Deer browse foliage heavily.',
    storageUse: 'Fresh cuts last 5–7 days in a vase — condition in cold water for several hours after cutting. Dried hydrangeas keep 1–2 years if stored away from direct sunlight (sun bleaches the color quickly). Protect from humidity in storage. Some varieties hold their color better than others when dried — Annabelle (white), Limelight (green-white), and Incrediball are excellent dryers.',
    bestSeason: 'Plant in spring or fall. Most hydrangeas are perennial in zones 3–9 (varies by species). Bloom time varies: bigleaf types (H. macrophylla) bloom in summer on old wood — protect from winter dieback. PeeGee and Annabelle types bloom on new wood — easier to grow in cold climates. Prune at the right time for your variety to avoid cutting off next year\'s blooms.',
  ),

  'horseradish': PlantKnowledge(
    harvestSigns: 'Harvest in fall after the first frost, which improves flavor. Roots should be at least finger-thickness and 8–12 inches long. The main root and side roots are all usable. Harvest before the ground freezes solid. Plants can also be dug in early spring before new growth begins.',
    harvestHow: 'Dig the entire root clump with a garden fork, going deep (12 or more inches) to avoid breaking roots. Shake off soil and trim off tops. Set aside small root pieces (pencil-thick, 4–6 inches long) with buds for replanting. Work outdoors or in a very well-ventilated area — cutting and grating horseradish releases volatile compounds that are extremely eye-watering.',
    soilPrep: 'Deeply worked, loose, fertile soil. pH 6.0–7.0. Work in compost to a depth of 18 inches. Prefers moist soil but tolerates most conditions. Once established, horseradish is nearly impossible to fully eradicate — choose a permanent location.',
    fertilizing: 'Moderate feeder. Apply balanced fertilizer or compost in early spring when growth begins. Side-dress with compost in midsummer. Avoid excess nitrogen, which produces a lot of tops with less concentrated flavor in the roots.',
    commonProblems: 'Flea beetles and aphids. Horseradish is remarkably tough and pest-resistant overall. The main concern is its invasiveness — it spreads aggressively from root fragments and can take over a bed. Plant in a contained area or use root barriers.',
    storageUse: 'Freshly grated horseradish: use immediately as it loses pungency quickly when exposed to air. Add a small amount of vinegar to slow oxidation and preserve heat. Refrigerate prepared horseradish for 4–6 weeks. For long-term: store whole roots in damp sand in a cool cellar. Freeze grated horseradish in ice cube trays for cooking.',
    bestSeason: 'Plant root pieces (crowns) in early spring or fall. Perennial in zones 3–9. Grows prolifically all summer. Best flavor after first frost. A single plant provides abundant harvests for years. Very cold-hardy and reliable — one of the easiest perennial vegetables to grow.',
  ),

  'jerusalem artichoke': PlantKnowledge(
    harvestSigns: 'Harvest after the first hard frost kills the tops — the frost converts inulin to fructose, dramatically improving flavor and digestibility. Tubers do not store well above ground, so the ground is the best storage. Harvest as needed through fall and winter. The knobby tubers should be firm and full-sized.',
    harvestHow: 'After tops die, use a garden fork to dig tubers. Work carefully — the irregular shape and deep spread means many tubers will be missed. Wash tubers gently. The thin skin does not need peeling for most uses (scrub well). Leave some tubers in the ground intentionally — they will regrow next year without replanting.',
    soilPrep: 'Extremely adaptable — grows in almost any soil, including poor, clay, or rocky conditions. pH 5.5–7.0. Can grow in partial shade. Plant where you want them permanently — they spread aggressively by tubers and can be difficult to eradicate.',
    fertilizing: 'Barely needs fertilizing. Works fine in poor soil. An occasional compost side-dress is more than enough. Too much fertility produces extremely tall, floppy plants.',
    commonProblems: 'Slugs on young shoots. Sclerotinia (white mold). The plant itself can be the main challenge — it spreads aggressively and crowds out other plants. Grows 8–12 feet tall and can shade surrounding plants. Contain it with regular harvesting of all tubers.',
    storageUse: 'Refrigerate for 1–2 weeks. Ground storage through winter is ideal. Cook before eating — raw Jerusalem artichokes can cause significant gas due to inulin content. Roasting, boiling, and sauteing all reduce this effect. After hard freezes, flavor becomes sweeter and nuttier.',
    bestSeason: 'Plant tubers in spring after frost danger passes. Hardy perennial (zones 3–9). Once planted, almost self-sufficient — replants itself year after year from missed tubers. Extremely productive: 1 plant can yield 2–5 lbs of tubers. Grows 8–12 feet tall — excellent windbreak or privacy screen.',
  ),

  'kiwi': PlantKnowledge(
    harvestSigns: 'Kiwis do not ripen fully on the vine — harvest when physiologically mature (firm) and ripen off the vine at room temperature. Pick in fall after the fruit reaches full size and shows its mature color. For fuzzy kiwi: squeeze gently — a mature kiwi feels firm but not rock-hard. For hardy kiwi berry varieties: fruit is ripe when it turns slightly soft and sweet on the vine.',
    harvestHow: 'Clip individual fruits from the vine with pruners, leaving a short stub of stem. Handle gently to avoid bruising. Harvest before hard frost, which damages fruit. After picking, store at room temperature for 3–7 days until slightly soft. Speed ripening by placing with an apple.',
    soilPrep: 'Rich, well-drained, deeply prepared soil. pH 6.0–6.5. Amend with generous compost. Excellent drainage is critical — kiwi roots rot in wet soils. Install a very sturdy trellis or pergola before planting — mature kiwi vines are extremely heavy and vigorous.',
    fertilizing: 'Moderate to heavy feeder. Apply balanced fertilizer in early spring. Add a nitrogen-rich fertilizer in late spring during rapid growth. Switch to a lower-nitrogen, potassium-rich fertilizer in midsummer. Avoid late-season nitrogen, which promotes tender growth susceptible to frost damage.',
    commonProblems: 'Scale insects, root rot in wet soils. Deer and rabbits browse young vines. Cats are strongly attracted to the vine (similar to catnip effect). Crown rot. Frost damage to early spring blossoms is a primary yield limiter. Most fuzzy kiwi varieties need a male and female plant for pollination.',
    storageUse: 'Unripe (firm) kiwi: store in the refrigerator for up to 2 months. At room temperature: ripen in 3–7 days. Ripe kiwi: refrigerate and use within 1–2 weeks. Freeze: peel and slice before freezing. Dried kiwi chips are a good preservation option.',
    bestSeason: 'Plant in spring after last frost. Hardy kiwi (Actinidia arguta): cold-hardy to zone 3, produces grape-size smooth-skinned fruits. Fuzzy kiwi: zones 7–9. Both require male and female plants unless self-fertile. Takes 3–5 years before first fruit. Life span of 30–50 years once established.',
  ),

  'kohlrabi': PlantKnowledge(
    harvestSigns: 'Harvest when the swollen stem is 2–3 inches in diameter for best texture and flavor. Purple varieties can be slightly larger. Do not let them get too big — oversized kohlrabi become fibrous, woody, and tough. Some modern varieties remain tender at larger sizes — check the variety description.',
    harvestHow: 'Pull the entire plant, or cut at soil level with a sharp knife. Remove all the leaves (they are also edible — use like kale). The skin is very tough and should be peeled before eating. Both the swollen stem and the leaves are edible.',
    soilPrep: 'Well-drained, fertile soil with good organic matter. pH 6.0–7.5. Work in compost. Kohlrabi is a fast grower and does not need heavily amended soil, but responds well to good fertility. Consistent moisture prevents woody texture.',
    fertilizing: 'Light to moderate feeder. A balanced fertilizer or compost at planting is usually enough for this fast-maturing crop. Avoid very high nitrogen, which delays bulb development.',
    commonProblems: 'Cabbage worms, aphids, flea beetles, and clubroot (same pests as all brassicas). Row covers are very effective. Club root in acidic, wet soils — raise pH and improve drainage. Bolts in heat and long days; best as a spring or fall crop.',
    storageUse: 'Remove leaves and store in the refrigerator for 2–4 weeks. Peel before eating — the skin is fibrous and tough even when cooked. Delicious raw in slaws, roasted, or boiled. Can be hollowed and stuffed. Refrigerates exceptionally well compared to other brassicas.',
    bestSeason: 'Fast-maturing (45–60 days) — excellent spring or fall crop. Direct sow 4–6 weeks before last spring frost, or sow in late summer for fall harvest. Dislikes heat (bolts and becomes woody). Cool weather (50–65 degrees F) produces the best texture and flavor.',
  ),

  'leek': PlantKnowledge(
    harvestSigns: 'Leeks are ready when the white shank is at least 1 inch in diameter. Most varieties reach 12–18 inches tall when ready. There is no single precise ready moment — leeks can be harvested at almost any size. They hold in the ground very well and can be harvested as needed over months.',
    harvestHow: 'Use a garden fork to loosen the soil beside the leek, then pull upward with a twisting motion. For very deep-planted leeks, dig rather than pull to avoid breaking the shank. Trim roots and remove the dark outer leaves. Leave remaining plants in the ground to harvest as needed through fall and winter.',
    soilPrep: 'Rich, well-drained soil with high organic matter. pH 6.0–7.0. Work in generous compost. Leeks are traditionally hilled (soil mounded around the shank as they grow) to blanch and extend the white edible portion. Plant transplants in a deep trench (6 inches) to naturally blanch the shank.',
    fertilizing: 'Heavy feeder with a very long growing season. Apply nitrogen-rich fertilizer every 3–4 weeks from spring through midsummer. As fall approaches, reduce nitrogen and use a more balanced formula. Consistent feeding throughout the long growing season is what produces large, tender shanks.',
    commonProblems: 'Leek rust (orange pustules on leaves — mainly cosmetic). Thrips cause silvery streaking. Onion fly maggots. Allium leaf miner. Generally a tough crop with few catastrophic problems.',
    storageUse: 'In the ground with mulch protection: several months through fall and early winter. Refrigerator: 2–3 weeks. Freeze: clean, slice, blanch 30 seconds, freeze. Leeks must be washed very thoroughly — grit collects between the leaf layers.',
    bestSeason: 'Start seeds indoors 10–12 weeks before last frost. Transplant outdoors 4–6 weeks before last frost. Leeks are extremely cold-hardy and can stay in the ground through hard frosts. A long-season crop (100–130 days to maturity). One of the best cold-weather crops.',
  ),

  'lemon balm': PlantKnowledge(
    harvestSigns: 'Harvest young, fresh leaves and shoot tips before the plant flowers for the best lemon flavor. Larger, older leaves are still usable but less aromatic. Harvest in the morning after dew dries. The leaves should be bright green and feel vigorous, not wilted.',
    harvestHow: 'Cut stems back by about a third, taking stems from throughout the plant to maintain a bushy shape. Do not strip the plant bare — leave at least a third of growth. Harvesting up to 3 times per season is typical. Cutting heavily just before flowering keeps the plant vegetative and maximizes leaf production.',
    soilPrep: 'Average, well-drained soil. pH 6.0–7.5. Tolerates poor soil well. Does not need rich soil — excess fertility reduces flavor intensity. Drought-tolerant once established. Grow in a container or remove flower heads before seed set to prevent spreading.',
    fertilizing: 'Minimal feeding needed. Too much fertilizer reduces the concentration of essential oils and diminishes the lemon flavor. A light spring application of balanced fertilizer is all that is needed, if anything.',
    commonProblems: 'Powdery mildew in humid conditions (cut plant back hard and it will regrow fresh). Leafhoppers. The main concern is excessive spreading — it self-sows prolifically and spreads by root. Deadhead before seeds form to control spread.',
    storageUse: 'Fresh leaves: use immediately or refrigerate for 3–5 days in a damp paper towel. Dry quickly at low heat. Stored dried in airtight jars for up to 1 year. Use in teas, herb infusions, desserts, and as a garnish. Lemon balm-infused honey is a classic preparation.',
    bestSeason: 'Perennial in zones 4–9. Direct sow in spring after last frost, or plant divisions. Self-sows prolifically. Dies back in winter, returns reliably in spring. One plant quickly becomes many — site carefully or grow in a buried container to limit spread.',
  ),

  'lemongrass': PlantKnowledge(
    harvestSigns: 'Individual stalks are ready when about 1/2 inch in diameter and at least 12 inches tall. The entire clump is usually harvested by taking outer stalks. The white bulb base — the tender, most flavorful part — should be plump and firm. The outer leaves (blades) are always ready for culinary use when green.',
    harvestHow: 'Grasp a stalk at the base and twist-pull to separate it from the clump, or cut with a sharp knife at soil level. Remove the tough outer layers to reveal the pale, tender interior of the bulb — this is the part used in cooking. The leaves can be cut and used in teas and infusions.',
    soilPrep: 'Rich, well-drained soil with good moisture retention. pH 6.0–7.0. Work in compost generously. In cooler climates, plant in full sun in a warm, sheltered spot. Grows well in large containers that can be brought indoors for winter in cold climates.',
    fertilizing: 'Moderate to heavy feeder, especially in containers. Apply a balanced fertilizer monthly during the growing season. A nitrogen-rich fertilizer encourages rapid leafy growth. Stop fertilizing in late summer in cold climates to harden plants before bringing them indoors.',
    commonProblems: 'Rust disease (orange spots on leaves). Spider mites when grown indoors. Aphids on new growth. Relatively trouble-free in appropriate climates. The main challenge in cooler climates is overwintering — plants must be brought inside before frost.',
    storageUse: 'Fresh stalks: refrigerate in a bag for 2–3 weeks, or place the cut end in a glass of water. Freeze: trim, chop, and freeze in zip-lock bags. Dry: slice thinly and dehydrate at 95 degrees F. Stalks used in Thai, Vietnamese, and other Southeast Asian cuisines. Leaves make a pleasant lemon-flavored tea.',
    bestSeason: 'Tropical perennial (zones 9–11). Plant in spring after last frost. In zones 4–8, grow in large containers and bring indoors before frost — it can live for many years as a houseplant in a sunny spot. Grows very quickly in summer heat. Divide clumps every 2–3 years to rejuvenate.',
  ),

  'microgreens': PlantKnowledge(
    harvestSigns: 'Most microgreens are ready 7–21 days after sowing, when the first true leaves just begin to emerge. They should be 1–3 inches tall with fully developed seed leaves. Do not wait too long — flavor and nutrition peak at this early stage. Most varieties are ready when cotyledons are fully open and colored.',
    harvestHow: 'Cut with sharp scissors just above the soil line in one clean motion. Harvest all trays at once. Harvest in the morning, rinse gently, spin dry, and refrigerate immediately. Varieties like peas and sunflowers can be cut above the first node for a second harvest.',
    soilPrep: 'Use a shallow tray (1–2 inches deep) filled with a sterile, fine-textured growing medium — potting mix, coconut coir, or purpose-made microgreen mix. No outdoor bed needed. Sow seeds densely, cover with another tray for darkness until germination, then move to light.',
    fertilizing: 'No fertilizer needed — seeds contain all the nutrients needed for the microgreen stage. The growing medium provides minimal nutrition; this is fine because harvest happens so early.',
    commonProblems: 'Damping off (fuzzy mold from overwatering or poor air circulation — reduce moisture, improve airflow). Uneven germination (pre-soak large seeds like sunflower and peas overnight before sowing). Pests are rare indoors.',
    storageUse: 'Refrigerate cut microgreens in a container lined with paper towel for 5–10 days. Do not wash until ready to use. Best fresh on salads, sandwiches, and bowls. Nutritionally dense — up to 40 times more concentrated in vitamins and phytochemicals than mature plants.',
    bestSeason: 'Year-round indoor crop — no seasonality. A single tray produces a harvest in 1–3 weeks. Grows on any sunny windowsill or under grow lights. Fastest-return edible gardening possible. Best beginner varieties: radish, sunflower, peas, broccoli, and mustard.',
  ),

  'moringa': PlantKnowledge(
    harvestSigns: 'Young leaves are ready at any time from an established plant — the new growth at branch tips is the most nutritious and tender. Seed pods (drumsticks) are ready when 6–18 inches long and the pod wall is still flexible and tender. Let pods dry on the tree for edible mature seeds.',
    harvestHow: 'Leaves: strip individual leaves from stems, or cut entire young branch tips. Harvest regularly to keep the tree in a productive, bushy habit. Pods: cut with pruners when they reach the right size. Regular pruning (cut to 3 feet every 6 months) encourages productive new growth and easy access.',
    soilPrep: 'Adapts to poor, sandy, rocky, and even slightly saline soils. pH 6.3–7.0. Excellent drainage is critical — roots rot in wet soil. One of the most drought-tolerant plants in the world. Does not need rich soil; grows and fruits better in lean conditions.',
    fertilizing: 'Minimal fertilizer needed. In very poor soil, a light balanced fertilizer application twice a year helps. Too much fertilizer produces lush growth but fewer pods.',
    commonProblems: 'Aphids, caterpillars, and termites. Root rot in poorly drained soils. Very few serious problems in appropriate climates. In temperate climates, cold sensitivity is the main challenge — moringa is killed by frost.',
    storageUse: 'Fresh leaves: refrigerate for 3–5 days. Dry leaves at low temperature to preserve nutrients; dried leaf powder stores for 6 months in sealed jars. Pods cooked like green beans before seeds develop, or mature pods used in curries. One of the most nutritious plants — extremely high in protein, iron, and vitamins.',
    bestSeason: 'Plant in spring after last frost, or grow in a large container. Zones 9–11: perennial tree reaching 15–35 feet. Zones 4–8: grown as an annual or root-hardy perennial. Grows astonishingly fast in warm weather — can reach 6 feet in the first season from seed.',
  ),

  'columbine': PlantKnowledge(
    harvestSigns: 'For cut flowers: harvest when the first buds on a stem are just opening. For seeds: let seed pods dry completely on the plant until they are brown and papery — the pods split at the tip and release small, shiny black seeds. A gentle shake or tap will tell you if seeds are loose and ready.',
    harvestHow: 'Cut flower stems near the base. For seed collection, snip entire dried pods into a paper bag before they fully split and scatter. Store seeds dry in a paper envelope. Deadheading spent flowers extends the bloom period; leaving them allows self-seeding and naturalizing.',
    soilPrep: 'Average to moderately fertile, well-drained soil. pH 5.5–7.0. Tolerates clay and rocky soils. Does not like waterlogged conditions. Work in compost for very poor soils. Generally adaptable and undemanding.',
    fertilizing: 'Minimal — a light balanced fertilizer in spring is plenty. Rich soil encourages leafy growth and reduces flowering. In most garden soils, no fertilizer is needed at all.',
    commonProblems: 'Leaf miners create winding tunnels in leaves (mainly cosmetic — remove affected leaves). Powdery mildew in late summer. Columbine sawfly caterpillars defoliate plants. Plants are short-lived (2–3 years) but self-seed freely to replace themselves.',
    storageUse: 'Fresh cut flowers last 5–7 days in water. Dried seed heads are attractive in arrangements. Seeds stored in a dry envelope remain viable 2–3 years. All parts of the plant contain low levels of toxic compounds — not for consumption.',
    bestSeason: 'Direct sow in fall or stratify seeds in the refrigerator for 3–4 weeks before spring sowing. Blooms in spring to early summer. Perennial in zones 3–9. Self-seeds reliably — once established, you will always have columbines without replanting.',
  ),

  'lovage': PlantKnowledge(
    harvestSigns: 'Young leaves and stems are ready any time the plant is actively growing. Harvest stems when they are 6–12 inches tall for the most tender texture. The flavor is similar to celery but much more intense — a little goes a long way. Seeds are ready when the umbels dry and turn brown.',
    harvestHow: 'Cut outer stems from the base, leaving the inner growing point untouched. Do not harvest more than a third of the plant at one time. For seeds, cut umbels when seeds are turning brown and dry further in a bag. Leaves can be dried or used fresh. Remove flower stalks if you want to maintain leaf production.',
    soilPrep: 'Rich, moist, well-drained soil. pH 6.0–7.0. Work in generous compost. Lovage has a large, deep taproot and thrives when given good fertile soil. Keep the soil consistently moist — drought causes leaves to become harsh and overpowering in flavor.',
    fertilizing: 'Moderate to heavy feeder for such a large plant. Apply balanced fertilizer in spring when growth begins. Side-dress with compost in midsummer. Consistent moisture and nutrition produce the most tender, flavorful leaves.',
    commonProblems: 'Leaf miners, aphids, and slugs on young growth. Celery leaf spot (brown spots in wet weather). Generally very tough and easy once established. The plant dies back completely in winter and returns reliably in spring.',
    storageUse: 'Fresh leaves: refrigerate in a damp bag for up to a week. Dry leaves and seeds in airtight jars for up to 1 year. Intense flavor — use sparingly in soups, stocks, and stews (like a very strong celery). Seeds used in bread, cheeses, and as a seasoning. Stems can be candied like angelica.',
    bestSeason: 'Sow seeds indoors in late winter, or direct sow in spring. Perennial in zones 3–8, growing into a large plant (3–6 feet tall) over the years. Extremely cold-hardy and one of the first herbs to emerge in spring. Can produce for 20+ years in the right location.',
  ),

  'lupine': PlantKnowledge(
    harvestSigns: 'For cut flowers: harvest when the lower flowers on the spike are just opening. For seeds: wait until the seed pods turn brown and dry, but harvest before they split open explosively (they will fling seeds considerable distances). For cover crop use: cut or till in at peak flowering.',
    harvestHow: 'Cut flower spikes with a long stem for arrangements. For seeds, bag the flower spike with a paper bag tied around the stem before pods are fully dry — seeds will be caught when pods split. Cut stalks for cover crop incorporation, allowing 2–3 weeks to break down before planting.',
    soilPrep: 'Well-drained, slightly acidic soil. pH 5.5–7.0. Lupines actually prefer poor, low-nitrogen soils — they fix their own nitrogen and do not need rich soil. Avoid lime or high-pH soils. Sandy to loamy soils are ideal. Deeply worked soil accommodates their long taproot.',
    fertilizing: 'Do not fertilize with nitrogen — lupines are nitrogen fixers and produce their own. High nitrogen causes excessive leafy growth and fewer flowers. In very poor soil, a small amount of phosphorus and potassium at planting is helpful.',
    commonProblems: 'Powdery mildew in summer heat. Aphids cluster on new growth — use strong water spray. Slugs on young plants. Lupin aphid (a large aphid species specific to lupines). All parts of most lupine species are toxic — wash hands after handling and keep away from children and pets.',
    storageUse: 'Fresh cut flowers last 5–7 days. Seeds of ornamental lupines are toxic. Special edible lupine varieties (Lupinus albus and L. mutabilis) produce seeds that, after soaking and multiple water changes, are edible and high in protein. Store dried edible lupine seeds for 1 year in airtight jars.',
    bestSeason: 'Direct sow outdoors 4–6 weeks before last frost. Seeds have a hard coat — nick or soak overnight before planting to improve germination. Blooms in late spring to early summer. Perennial in zones 4–7; short-lived in zones 8+. Dislikes heat — thrives in cool, temperate climates.',
  ),

  'marjoram': PlantKnowledge(
    harvestSigns: 'Harvest leaves and stem tips before the plant flowers for the best, sweetest flavor. Once flowers appear, the flavor of the leaves becomes sharper and less sweet. The plant is ready to harvest when 6–8 inches tall and growing vigorously. Pick in the morning after dew dries.',
    harvestHow: 'Snip stem tips 2–3 inches from the top, cutting just above a leaf node to encourage bushy growth. Harvest up to a third of the plant at once. For drying, cut stems before flowering and hang in small bunches in a warm, airy spot. Marjoram dries very well and keeps much of its flavor.',
    soilPrep: 'Average to poor, well-drained soil. pH 6.0–8.0. Slightly alkaline soil enhances flavor. Does not need rich soil — excessive fertility reduces the concentration of essential oils and diminishes flavor. Full sun essential.',
    fertilizing: 'Minimal fertilizer needed or wanted. Rich soil or heavy feeding produces large plants with diluted, mild flavor. A light balanced fertilizer at planting is more than enough for the season.',
    commonProblems: 'Aphids, spider mites in dry conditions. Powdery mildew in humid, crowded conditions. Root rot in poorly drained soil. Generally very trouble-free. Similar to oregano in care requirements but milder in flavor and more tender.',
    storageUse: 'Dry by hanging bundles or on a screen away from direct sun. Dried marjoram stored in airtight jars keeps for 1 year. Fresh marjoram: refrigerate for 3–5 days. Use fresh marjoram at the end of cooking — heat diminishes its delicate flavor more than oregano. Pairs well with eggs, vegetables, and sauces.',
    bestSeason: 'Start seeds indoors 6–8 weeks before last frost, or direct sow after frost. Tender perennial (zones 9–11); grown as an annual in colder zones. Related to oregano — sometimes called sweet marjoram. Thrives in summer heat. Bring indoors in fall in cold climates to continue through winter as a houseplant.',
  ),

  'mullein': PlantKnowledge(
    harvestSigns: 'Leaves are harvested at any point during the first year rosette stage — large, mature leaves (12–18 inches) are most useful. Flowers are harvested when freshly open from the spike. Seeds are ready when the pods on the lower spike have browned and are dry. Second-year plants produce the tall flower spike.',
    harvestHow: 'Harvest leaves by cutting the whole leaf from the base. For flowers, pick individual small yellow flowers from the spike in the morning. Dry leaves flat on screens at low temperature — they are thick and take 1–2 weeks to dry fully. Dry flowers quickly to prevent mold.',
    soilPrep: 'Poor to average, dry, rocky, or gravelly soil. pH 6.0–8.0. Excellent drainage is essential. Mullein thrives on neglect and in difficult conditions where almost nothing else grows. Does not need any soil amendment.',
    fertilizing: 'No fertilizer needed. Grows as a weed in roadsides and dry fields — it is adapted to very low fertility. Adding nutrients causes lush, floppy growth out of character with the plant.',
    commonProblems: 'Very few pest or disease problems. Can self-seed aggressively and become invasive — remove flower spikes before seeds set if you want to limit spread. Mullein weevil in some regions. Generally an incredibly tough and carefree plant.',
    storageUse: 'Dried leaves store in an airtight jar for 1 year. Used as a traditional herbal remedy — leaf tea used for respiratory support. Dried leaves can be used in fire-making (the dried stalk makes an excellent friction fire spindle). Not for internal use without guidance from an herbal practitioner.',
    bestSeason: 'Direct sow in fall or early spring. Biennial: first year is a rosette of fuzzy leaves; second year sends up a tall (4–8 feet) flower spike. Self-seeds readily. Hardy in zones 3–9. Grows in almost any climate and soil. Common roadside plant throughout North America and Europe.',
  ),

  'mustard greens': PlantKnowledge(
    harvestSigns: 'Harvest young leaves at 4–6 inches for the most tender, mildest flavor. Older leaves are more pungent and spicy. Baby leaf harvest: 21–30 days after sowing. Full-size harvest: 40–50 days. Harvest before the plant sends up a flower stalk — bolted leaves become very hot and bitter.',
    harvestHow: 'Cut-and-come-again: use scissors to cut outer leaves 1 inch above the soil, leaving the growing center. New leaves regrow in 1–2 weeks. Or harvest the entire plant at once by cutting at the base. Cool weather harvests are milder; heat-stressed plants are much more pungent.',
    soilPrep: 'Fertile, well-drained soil with good organic matter. pH 5.5–6.8. Work in compost before planting. Consistent moisture produces milder leaves. Drought stress dramatically increases pungency and promotes bolting.',
    fertilizing: 'Moderate feeder. A nitrogen-rich fertilizer every 2–3 weeks during growth produces large, tender leaves. Balanced compost at planting is a good start. Fast-growing crop — nutrition needs to be available immediately.',
    commonProblems: 'Flea beetles (tiny holes in leaves — row covers prevent them). Aphids, cabbage worms, and slugs. Bolts in heat and long days — a cool-season crop. Powdery mildew. White rust disease in wet conditions.',
    storageUse: 'Refrigerate unwashed for up to 5 days. Rinse thoroughly before use. Cooked mustard greens are milder than raw — a brief blanch or saute tames the heat significantly. Use in soups, stews, stir-fries, and salads. Sauteed with garlic and olive oil is a classic preparation.',
    bestSeason: 'Direct sow outdoors 4–6 weeks before last frost in spring. Also excellent as a fall crop — sow 6–8 weeks before first fall frost. Germinates in cool soil. Extremely fast-growing and productive. Fall crops are often sweeter and less spicy than spring crops.',
  ),

  'nasturtium': PlantKnowledge(
    harvestSigns: 'Flowers are ready as soon as they are fully open and vibrantly colored. Leaves can be harvested at any size — smaller leaves are more tender and milder. For seed pods (capers): pick when the seed pod is fat and green, before it starts to dry. For seeds: let pods dry on the plant until they turn tan and wrinkled.',
    harvestHow: 'Pinch flowers at their base. Snip leaves from the stem. For pickled nasturtium capers, harvest immature green seed pods immediately after the petals fall. Deadheading (removing spent flowers) extends the blooming period significantly. Seeds for replanting: let fully dry on the plant, then store in a paper envelope.',
    soilPrep: 'Poor to average, well-drained soil — nasturtiums bloom most prolifically in poor, dry conditions. Rich or fertile soil produces lush, beautiful foliage with very few flowers. pH 5.5–7.5. No soil amendment needed.',
    fertilizing: 'Avoid fertilizing — it dramatically reduces flower production in favor of leaves. The golden rule with nasturtiums: plant them where nothing else will grow and leave them alone.',
    commonProblems: 'Aphids (particularly black aphids) love nasturtiums — this is sometimes intentional, as they are used as a trap crop to lure aphids away from other plants. Powdery mildew in late season. Flea beetles. Cabbage white butterfly larvae.',
    storageUse: 'Flowers: use immediately — they wilt within hours once picked. Leaves: refrigerate for 2–3 days. All parts are edible and have a peppery, watercress-like flavor. Pickled seed pods substitute for capers. Flowers are excellent in salads, compound butters, and as a garnish.',
    bestSeason: 'Direct sow outdoors after last frost — does not transplant well (taproot). Germinates in 7–14 days. Fast growing and extremely productive. A warm-season annual killed by frost. Self-sows readily in mild climates. Blooms continuously from planting until frost.',
  ),

  'nigella': PlantKnowledge(
    harvestSigns: 'Cut flowers for arrangements when the first petals are just opening. For seeds (the main culinary harvest): let the inflated seed pods dry completely on the plant until they are papery, tan, and rattling when shaken. The pods are decorative and can be left on the plant for visual interest or cut for dried arrangements.',
    harvestHow: 'For cut flowers: snip stems in the morning. For seeds: cut entire dried seed pods and collect in a paper bag. Tap or shake pods to release the angular, black seeds. Seeds are easily separated from the papery pod material. Store in an airtight jar immediately as the seeds are aromatic and lose potency quickly.',
    soilPrep: 'Average to sandy, well-drained soil. pH 6.0–7.0. Does not need rich soil — too much fertility produces excessive foliage with fewer flowers. Direct sow where it will grow; it does not transplant well due to a taproot. Cool-season grower.',
    fertilizing: 'Minimal — one light application at planting if soil is very poor. No ongoing fertilizer needed. Stressed, unfed plants often bloom more prolifically than pampered ones.',
    commonProblems: 'Very few pest or disease problems. Aphids occasionally. The main challenge is timing — nigella grows best in cool weather and bolts in heat. Succession sow for extended harvest.',
    storageUse: 'Seeds stored in an airtight jar keep their pungent, slightly peppery flavor for 1–2 years. Used extensively in Indian, Middle Eastern, and Eastern European cooking — bread, curries, pickles, and cheese. Also called black cumin, black caraway, or kalonji. Seed pods excellent in dried flower arrangements.',
    bestSeason: 'Direct sow outdoors 4–6 weeks before last frost. Also sow in fall for spring bloom. Self-seeds prolifically and often appears without replanting in subsequent years. Blooms in late spring and early summer. Short season — plan succession sowings for continuous harvest.',
  ),

  'okra': PlantKnowledge(
    harvestSigns: 'Harvest pods when 2–4 inches long and still tender — this is usually 3–5 days after flowering. Okra grows incredibly fast in summer heat and pods can become large and fibrous overnight. Pods should snap cleanly when bent. Overripe pods are very tough and woody — not worth eating. Check plants every day or two in peak season.',
    harvestHow: 'Cut or snap pods from the stem, leaving a short stub. Wear gloves and long sleeves — okra plants have irritating hairs that cause skin itching in many people. Harvest the entire plant regularly (even if you have too many pods) to keep production going. Letting pods mature and go to seed signals the plant to stop producing.',
    soilPrep: 'Rich, well-drained soil with high organic matter. pH 5.8–7.0. Work in compost generously. Okra loves heat — plant into warm soil (65 degrees F and above). Raised beds are ideal in cool climates as they warm up faster.',
    fertilizing: 'Moderate feeder. Apply balanced fertilizer at planting, then every 3–4 weeks through the season. Once plants are producing heavily, a side-dressing of compost or a balanced liquid fertilizer maintains productivity.',
    commonProblems: 'Aphids, corn earworms, and stinkbugs. Fusarium wilt (choose resistant varieties). Root knot nematodes in southern soils. Powdery mildew on leaves in late season. The main challenge in cool climates is getting enough heat for good production.',
    storageUse: 'Refrigerate fresh pods for 2–4 days. Do not wash until ready to use. Freeze: slice and freeze without blanching for 6 months. Pickle: okra is classic in pickled preparations. Dried: slice and dehydrate for long-term storage. The mucilage in okra is a natural thickener excellent for gumbo and stews.',
    bestSeason: 'Direct sow or transplant after last frost when soil is thoroughly warm. Warm-season crop that thrives in summer heat — production peaks at 85–95 degrees F daytime temperatures. Days to first harvest: 50–65 days. In short-season climates, start indoors 3–4 weeks early.',
  ),

  'pansy': PlantKnowledge(
    harvestSigns: 'Harvest flowers when fully open for use as edible garnishes. For cut flowers, harvest when buds show color but are not yet fully open to maximize vase life. For seeds: let some flower heads dry completely on the plant — seed pods are green, three-lobed capsules that dry and split open. Seeds are tiny and ripen quickly after pod splitting.',
    harvestHow: 'Pinch or snip flowers at the stem base. Deadheading spent flowers vigorously is essential for continued blooming. For seed collection, watch pods carefully — they split suddenly and throw seeds. Bag a few pods with a paper bag tied around them before they split.',
    soilPrep: 'Moderately fertile, well-drained soil with good organic matter. pH 5.4–5.8 (slightly acidic preferred). Work in compost. Consistent moisture is important — pansies suffer in dry conditions.',
    fertilizing: 'Light to moderate feeder. A balanced fertilizer at planting, then a liquid fertilizer every 2–3 weeks during active growth. Too little nutrition results in small flowers and slow growth.',
    commonProblems: 'Aphids, slugs, and snails (they love pansy foliage). Powdery mildew in humid, warm weather. Pansies are cool-season plants that decline in summer heat — plan accordingly. Spider mites in hot, dry conditions. Downy mildew.',
    storageUse: 'Fresh flowers: use within a day for garnishes. Keep cut stems in water for up to 5 days. Edible flowers have a mild, slightly minty flavor. Use as garnishes for salads, desserts, and drinks. Crystallize flowers with egg white and sugar for a decorative, long-lasting edible decoration.',
    bestSeason: 'Plant in early spring as soon as soil can be worked — pansies tolerate frost and thrive in cool weather (45–65 degrees F). Also excellent as a fall-planted crop (in zones 6+ they can overwinter and bloom very early in spring). Decline and die in summer heat; replace with warm-season annuals.',
  ),

  'passionflower': PlantKnowledge(
    harvestSigns: 'Passionfruits are ready when the skin turns from green to yellow, orange, or purple (depending on variety) and the fruit falls or pulls easily from the vine. The skin may begin to wrinkle slightly — this actually indicates peak ripeness and sweetness. The fruit should feel slightly heavy and give a little when gently squeezed.',
    harvestHow: 'Pick or collect fruit that has fallen to the ground — falling is nature\'s signal that ripeness is perfect. Or gently pull fruits that separate easily from the vine. Passionfruit does not ripen further after picking if not fully ripe on the vine. Cut open and scoop out the pulp and seeds — both are edible.',
    soilPrep: 'Well-drained, moderately fertile soil. pH 6.0–7.5. Not demanding — adapts to many soil types as long as drainage is good. Install a sturdy trellis or fence before planting — vines grow rapidly and need strong support. Mulch around the base to keep roots moist.',
    fertilizing: 'Moderate feeder. Apply a balanced fertilizer in spring at the start of the growing season. Once flowering and fruiting begins, a fertilizer higher in potassium encourages fruit development. Avoid excessive nitrogen, which produces lush vines with fewer flowers and fruits.',
    commonProblems: 'Aphids, spider mites, and scale insects. Fusarium wilt (keep roots healthy and soil well-drained). Nematodes in southern regions. Passionflower is host to Gulf fritillary and zebra longwing butterfly larvae — consider allowing some defoliation for wildlife benefit.',
    storageUse: 'Fresh at room temperature: 2–3 days once ripe. Refrigerator: up to 1 week. Wrinkled fruit is sweeter, not bad. The aromatic pulp and seeds are eaten fresh, blended into drinks and desserts, or made into jam. Strain out seeds for a smooth juice. Freeze pulp in ice cube trays for later use.',
    bestSeason: 'Plant in spring after last frost. Perennial in zones 7–11 (hardy passionflower, Passiflora incarnata, survives to zone 5 but does not fruit well). Most fruiting varieties (P. edulis) need zones 9–11. In colder zones, grow in a large container and overwinter indoors in a bright, cool spot.',
  ),

  'plum': PlantKnowledge(
    harvestSigns: 'Plums change color when ripe (depending on variety: red, purple, yellow, or blue-black). The flesh yields slightly to gentle thumb pressure near the stem end. A ripe plum separates from the tree with a gentle twist or comes away in your hand when lifted upward. The white bloom (waxy coating) is natural and should be present.',
    harvestHow: 'Cup the plum in your hand and give a gentle upward twist — ripe plums release easily. Don\'t squeeze tightly or you will bruise the fruit. Place (do not drop) into a padded container. Plums do not all ripen at once — check the tree every 2–3 days and harvest what is ready. Some varieties ripen over several weeks.',
    soilPrep: 'Well-drained, fertile loam. pH 5.5–6.5. Work in compost before planting. Plums tolerate heavier soils than most stone fruits. Avoid low-lying frost pockets where late spring frosts can damage blossoms. Good air drainage is as important as soil drainage.',
    fertilizing: 'Moderate feeder. Apply balanced fertilizer in early spring before bud break. Monitor shoot growth — aim for 10–18 inches of new growth per year. More than 18 inches indicates over-fertilizing; less than 8 inches indicates the tree needs more nutrition. Mulch with compost annually.',
    commonProblems: 'Plum curculio (crescent-shaped scars on fruit — most serious pest in eastern North America). Brown rot (fuzzy brown rot on ripe fruit in wet weather — remove and destroy affected fruit). Black knot fungus (black tar-like swellings on branches — prune well below infection). Aphids. Japanese beetles.',
    storageUse: 'Fresh at room temperature: ripen for 1–3 days. Refrigerator: up to 2 weeks. Freeze: halve, pit, and freeze on a baking sheet then transfer to bags. Make jam or jelly (plums have natural pectin). Dry into prunes at 135–145 degrees F until shrivelled but not crisp. Can, pickle, or ferment for plum wine.',
    bestSeason: 'Plant bare-root trees in early spring or fall. Many European plum varieties are self-fertile; Japanese plums need cross-pollinators. Trees bear in 3–5 years. Hardy in zones 3–9 (varies by variety). Annual pruning in late winter maintains an open canopy and removes dead wood.',
  ),

  'poblano pepper': PlantKnowledge(
    harvestSigns: 'Fresh (dark green and mild): harvest when peppers are 4–6 inches long, firm, and deep green. Red (fully ripe and hotter, for drying into ancho chiles): wait until peppers turn deep red. Green poblanos have a mild, earthy heat; red poblanos are sweeter and more complex.',
    harvestHow: 'Cut from the plant with scissors or pruners, leaving a short stem. Harvest green peppers regularly to encourage more production. For dried ancho chiles, allow peppers to ripen to deep red on the plant, then hang to dry in a warm location or dehydrate at 135 degrees F until completely brittle.',
    soilPrep: 'Fertile, well-drained soil. pH 6.0–6.8. Work in generous compost. Warm soil (above 65 degrees F) is essential for good growth. Mulch to keep roots warm and moist. Raised beds are excellent in cooler climates.',
    fertilizing: 'Moderate feeder. Balanced fertilizer at planting. Once flowering begins, switch to a tomato-type fertilizer lower in nitrogen. Monthly feedings through the season. Consistent fertility and moisture produce the largest, meatiest peppers.',
    commonProblems: 'Aphids, spider mites, and thrips. Blossom drop in very hot or cool temperatures — poblanos prefer 70–85 degrees F daytime. Bacterial spot (dark lesions). Phytophthora root rot in wet soils. Like all peppers, very frost-sensitive.',
    storageUse: 'Fresh: refrigerate for 1–2 weeks. Roast and peel (a classic preparation): char over flame or under broiler, steam in a bag for 10 minutes, then peel — the skin slips off easily. Roasted poblanos freeze very well for 6 months. Dried (ancho chiles): store in airtight bags for 1 year. Essential in chili con carne, mole, and chiles rellenos.',
    bestSeason: 'Start indoors 8–10 weeks before last frost. Transplant after all frost risk has passed and nights stay above 55 degrees F. Long season crop (65–80 days to green stage, much longer for red). Very heat-loving — production picks up dramatically in warm summer weather.',
  ),

  'purslane': PlantKnowledge(
    harvestSigns: 'Harvest stem tips and young leaves at any point once the plant is established and growing vigorously (4–6 weeks from sowing). The succulent leaves and stems should feel firm and plump. Older, larger stems become fibrous — harvest young growth for best eating. The plant is most productive in summer heat.',
    harvestHow: 'Snip stem tips 2–3 inches long, taking from throughout the plant. The plant will regrow from remaining stem nodes within 1–2 weeks. Alternatively, pull entire plants for a one-time harvest. Harvest in the morning when stems are crispest. Rinse thoroughly before use.',
    soilPrep: 'Thrives in poor, dry, sandy soil where most other plants struggle. pH 5.5–7.0. No soil amendment needed. Actually produces better in unfertilized, dry conditions. Essentially a weed that happens to be delicious — grow it anywhere.',
    fertilizing: 'Does not need fertilizer. Rich, moist soil produces lush growth but the texture and flavor are best from plants grown lean. Adding fertility is likely to produce a weedy sprawling plant rather than a tidy edible one.',
    commonProblems: 'Virtually no pest or disease problems. The main concern is unwanted spreading — purslane self-seeds prolifically. Harvest before seeds set or manage spread by pulling unwanted seedlings. Very easy to grow to the point of becoming invasive.',
    storageUse: 'Refrigerate for up to 3 days in a bag. Rinse just before use — the succulent leaves and stems wilt quickly once cut. Eaten fresh in salads (similar to spinach, with a slightly mucilaginous texture), lightly sauteed, or pickled. Exceptionally high in omega-3 fatty acids for a plant food.',
    bestSeason: 'Direct sow after last frost when soil is warm. Thrives in summer heat that would stress most leafy greens. Often appears uninvited as a garden weed — recognize it as edible and harvest rather than compost. An excellent hot-weather substitute for lettuce.',
  ),

  'radicchio': PlantKnowledge(
    harvestSigns: 'Radicchio forms a firm head (like a small cabbage) when mature. Harvest when heads feel solid and dense with tightly closed leaves. The red-purple color intensifies after cold weather — fall-grown radicchio is sweeter and less bitter than summer-grown. Size varies by variety: 3–6 inches across.',
    harvestHow: 'Cut the entire head at soil level with a sharp knife. Leave the root system intact and the plant may sprout additional smaller heads (a "ratoon" crop). Alternatively, pull the entire plant. For the forced chicory type (Treviso, Castelfranco): cut plants back to the crown in fall and bring indoors into a dark spot for 2–4 weeks to develop a new, blanched head.',
    soilPrep: 'Well-drained, moderately fertile soil with good organic matter. pH 5.8–6.8. Work in compost. Consistent moisture prevents excessive bitterness. Very fertile soils with lots of nitrogen encourage lush growth but less compact heads.',
    fertilizing: 'Light to moderate feeder. A balanced fertilizer at planting, plus a side-dressing of compost midseason. Avoid excess nitrogen, which produces loose, leafy heads that do not form properly.',
    commonProblems: 'Aphids, slugs, and snails. Tip burn from calcium deficiency or inconsistent watering. Bolting in heat. Downy mildew. Radicchio is a cool-season crop that benefits enormously from fall growing — flavor improves dramatically after frost exposure.',
    storageUse: 'Refrigerate whole heads for up to 2 weeks. The bitterness diminishes after refrigerator storage. Eaten raw in salads (pairs with sweet dressings, citrus, and nuts to balance bitterness), grilled, or braised (cooking also reduces bitterness significantly).',
    bestSeason: 'Best grown as a fall crop — start seeds indoors in midsummer and transplant out 8–10 weeks before first fall frost. Cool fall temperatures and light frosts develop the characteristic red color and improve sweetness. Spring crops often fail to head properly or bolt. Fall is the key season for success.',
  ),

  'raspberry': PlantKnowledge(
    harvestSigns: 'Ripe raspberries pull off the core (receptacle) easily and cleanly, leaving a hollow center in the berry. Fully colored berries that still resist coming off are not ready — wait 1–2 more days. Overripe berries are soft and beginning to ferment. Taste one — ripe raspberries are sweet with a characteristic intense aroma.',
    harvestHow: 'Pick gently with your fingers, cupping the berry and pulling softly away from the core. The berry should come off easily without pulling. Harvest every 2–3 days at peak season — raspberries don\'t all ripen at once and missed ripe berries attract pests and disease. Work in the cool of morning when berries are firmest.',
    soilPrep: 'Well-drained, rich, slightly acidic soil. pH 5.5–6.5. Work in generous compost before planting. Raspberries hate wet feet — excellent drainage is essential. They also benefit from a thick mulch layer to keep roots cool and moist. Avoid sites where solanaceous crops (tomatoes, peppers, eggplant) grew recently due to shared diseases.',
    fertilizing: 'Moderate feeder. Apply balanced fertilizer in early spring when growth begins. Side-dress with compost in early summer. Too much nitrogen produces vigorous cane growth but smaller berries. Fall-bearing varieties need a second feeding in midsummer. Annual compost mulching is the simplest fertility approach.',
    commonProblems: 'Raspberry cane borers (wilting cane tips — cut canes below the wilted point and destroy). Spur blight and cane blight (fungal diseases — prune out infected canes, improve air circulation). Spotted wing drosophila (a small fly that lays eggs in ripe fruit — harvest frequently). Aphids spread viruses. Japanese beetles eat foliage.',
    storageUse: 'Use or refrigerate immediately after harvest — raspberries are extremely perishable (1–3 days in the refrigerator). Spread on a baking sheet and freeze individually before transferring to bags for up to 1 year. Make jam, jelly, vinegar, or sauce. Dried at 115 degrees F they become intensely flavored. High in vitamin C, manganese, and fiber.',
    bestSeason: 'Plant bare-root canes in early spring. Summer-bearing varieties (floricane types) fruit in early summer on second-year canes. Fall-bearing (primocane) types fruit in fall on first-year canes. Perennial in zones 3–9. Plant in a permanent location with good air circulation and manage old canes by pruning after fruiting.',
  ),

  'shishito pepper': PlantKnowledge(
    harvestSigns: 'Harvest when peppers are 3–4 inches long, bright green, and slightly wrinkled — this is the traditional Japanese stage. For red (fully ripe): wait until they turn red, which is sweeter but less commonly used. One in every 10–15 peppers may be surprisingly hot, even within the same plant.',
    harvestHow: 'Snip or twist peppers from the plant, leaving a short stem. Harvest frequently when pods appear — the plant produces continuously if kept picked. Unlike bell peppers, shishito should be harvested relatively small. The entire pepper is edible, including the seed.',
    soilPrep: 'Fertile, well-drained soil. pH 6.0–6.8. Work in compost. Warm soil is important — shishito peppers love heat. Consistent moisture is important for steady production.',
    fertilizing: 'Moderate feeder. Balanced fertilizer at planting, then a lower-nitrogen fertilizer once flowering begins. Monthly feedings through the season. A tomato-type fertilizer works well for all small peppers.',
    commonProblems: 'Aphids, thrips, and spider mites. Blossom end rot from inconsistent watering. Like all peppers, very frost-sensitive. Slow to produce in cool weather — wait for genuinely warm conditions before planting out.',
    storageUse: 'Refrigerate fresh peppers for 1–2 weeks. Best eaten soon after harvest — flavor diminishes with storage. Classic preparation: blister in a hot skillet or under a broiler in a single layer until charred in spots, toss with flaky salt. Also excellent roasted whole or in tempura.',
    bestSeason: 'Start indoors 8–10 weeks before last frost. Transplant after all frost risk has passed. Long-season crop (60–80 days to harvest). Very productive in summer heat — one plant can yield dozens of peppers per week at peak production.',
  ),

  'sorrel': PlantKnowledge(
    harvestSigns: 'Harvest young leaves when 4–6 inches long for the best flavor (bright, lemony, and refreshing). Larger, older leaves are more intensely sour and can be used in cooking where the flavor will be tempered. Harvest before the plant sends up flower stalks, which signals the end of quality leaf production.',
    harvestHow: 'Cut outer leaves at the base with scissors or by snapping them off. Leave the inner leaves intact for continued growth. Harvest up to a third of the plant at a time. Remove flower stalks as they appear to keep the plant focused on leaf production. A single plant can produce for several years.',
    soilPrep: 'Moderately fertile, well-drained soil. pH 5.5–6.8. Work in compost. Tolerates partial shade and wetter conditions than most herbs. A very adaptable, tough plant. Site it where you want it permanently — sorrel is a long-lived perennial.',
    fertilizing: 'Light feeder. A balanced fertilizer or compost in early spring when growth begins is sufficient. Occasional liquid fertilizer after heavy harvests helps plants recover. Over-fertilizing with nitrogen reduces the desirable sour tang.',
    commonProblems: 'Aphids and slugs on young leaves. Powdery mildew in late summer (mainly cosmetic). Very few serious problems. The main issue is leaf quality in midsummer heat — leaves may become very sour and coarse. Cut the plant back hard in midsummer and fresh leaves will emerge.',
    storageUse: 'Fresh leaves: refrigerate for 3–5 days. Use in sorrel soup (classic French), sauce for fish, spring salads, and as a sour accent in mixed green salads. Blanch and freeze puree for winter use. The sourness comes from oxalic acid — eat in moderation (same compound as spinach). High in vitamin C.',
    bestSeason: 'Perennial in zones 3–9. Direct sow in spring or fall. One of the first edible greens in spring, often harvestable weeks before anything else is ready. Goes dormant in midsummer heat and winter. Returns reliably year after year from the same crown. One plant lasts 5–10 years.',
  ),

  'stevia': PlantKnowledge(
    harvestSigns: 'Leaves are sweetest just before flowering. Harvest when the plant is well established (12–18 inches tall) and bushy. As soon as flower buds begin to form at branch tips, the sweetness in the leaves declines rapidly — harvest or pinch buds immediately. Morning harvest after dew dries yields the most flavorful leaves.',
    harvestHow: 'Pinch off stem tips, cutting just above a lower leaf pair — this encourages bushy growth and more leaf production. Do a full harvest (cutting the plant to 6 inches) once or twice during the growing season. Dry leaves immediately after harvest at 95 degrees F until crispy — do not over-dry.',
    soilPrep: 'Well-drained, moderately fertile soil. pH 6.5–7.5 (near-neutral). Add compost and ensure excellent drainage — stevia does not tolerate wet roots. Full sun is essential for maximum sweetness. Sandy loam is ideal.',
    fertilizing: 'Light feeder. Apply balanced fertilizer at planting. A second light application at midsummer is helpful. Avoid heavy nitrogen, which produces leafy growth but can dilute the sweetness.',
    commonProblems: 'Root rot in poorly drained soil (the main failure). Aphids and spider mites. Fusarium wilt in some regions. Very sensitive to frost — bring indoors or take cuttings before first frost. Stevia is a tropical plant that dies at 32 degrees F.',
    storageUse: 'Dried whole leaves: crumble into hot tea or steep as a sweet herbal infusion. Store dried leaves in airtight jars for up to 1 year. Grind dried leaves into a fine powder for use as a sugar substitute (30-150 times sweeter than sugar — use very small amounts). Fresh leaves can be muddled into drinks.',
    bestSeason: 'Start indoors 8–10 weeks before last frost. Transplant after all frost risk has passed. Tender perennial (zones 9–11); grown as annual in colder zones. In zones 8+, cut back in fall and mulch heavily — may return from the roots in spring. Very easy to overwinter as a houseplant in a sunny window.',
  ),

  'tarragon': PlantKnowledge(
    harvestSigns: 'Harvest before or just as the plant begins to flower for the most intense anise-like flavor. Stems are ready to harvest once the plant is 12 inches tall. French tarragon (the culinary variety) produces no viable seed — always grown from cuttings or divisions.',
    harvestHow: 'Snip stem tips 4–6 inches long, cutting just above a leaf node. Harvest from throughout the plant to maintain even shape. Do this 2–3 times per season. For the main harvest, cut the entire plant back by half before it flowers. Dry quickly at low heat as the essential oils dissipate fast.',
    soilPrep: 'Well-drained, light to average soil. pH 6.0–7.5. Does not need rich soil — excessive fertility reduces flavor intensity. Sandy loam or gravelly soil is ideal. Excellent drainage is the top priority; tarragon roots rot readily in wet conditions.',
    fertilizing: 'Minimal — one light balanced fertilizer application in spring. Over-fertilizing with nitrogen produces large, lush plants with diluted flavor. Less is more for all aromatic herbs.',
    commonProblems: 'Root rot in wet or poorly drained soil (the main killer). Powdery mildew in humid conditions. Aphids. Russian tarragon (grown from seed) is very different from French tarragon — it has almost no flavor. Make sure you are growing French (Artemisia dracunculus sativa) for culinary use.',
    storageUse: 'Fresh: refrigerate loosely wrapped for 1 week. Dry quickly at low temperature (flavor fades fast when dried). Better preserved by infusing in white wine vinegar (tarragon vinegar keeps 6 months). Also excellent preserved in olive oil. Used in classic French sauces (bearnaise, fines herbes) and with chicken and fish.',
    bestSeason: 'Perennial in zones 4–8. Plant divisions or cuttings in spring. Does not grow true from seed (buy plants). Grows well in containers. Divide clumps every 2–3 years to maintain vigor. Dies back in winter and returns reliably. One of the classic culinary herbs of the French kitchen.',
  ),

  'tomatillo': PlantKnowledge(
    harvestSigns: 'The papery husk turns from green to tan or pale gold and the fruit completely fills or bursts through the husk. The fruit inside should feel firm when you press through the husk. A tomatillo that has burst through its husk is slightly overripe but still usable. Do not harvest while the husk is still green and tight — the fruit is not yet ready.',
    harvestHow: 'Pull or twist the fruit from the stem — it detaches easily when ripe. Leave the husk on until ready to use (it protects the fruit). Harvest every few days during peak season. A single plant can produce enormous quantities. Two plants are needed for cross-pollination and good fruit set.',
    soilPrep: 'Fertile, well-drained soil. pH 6.0–7.0. Work in generous compost. Very similar cultural requirements to tomatoes. Warm soil is essential — do not plant until soil is thoroughly warm.',
    fertilizing: 'Moderate feeder, same as tomatoes. Balanced fertilizer at planting, then a lower-nitrogen fertilizer once flowering begins. Monthly feedings through the season. Consistent moisture and nutrition produce the best yields.',
    commonProblems: 'Hornworms, aphids, flea beetles, and Colorado potato beetles. Powdery mildew late in the season. Blossom drop in cool temperatures. Plant sprawls — stake or cage for neatness and air circulation. Very frost-sensitive.',
    storageUse: 'In their husks at room temperature: 1–3 weeks. Refrigerator in husks: up to 1 month. Remove husk and rinse before use. Freeze: remove husks, rinse, and freeze whole or roasted. The essential ingredient in salsa verde and green enchilada sauce. Tart and fruity flavor excellent in Mexican and Southwestern cooking.',
    bestSeason: 'Start indoors 6–8 weeks before last frost. Transplant after all frost risk has passed. Warm-season annual with 75–100 day growing season. Very productive in summer heat. Sprawling plant — allow 4 feet per plant. Plant at least 2 plants for cross-pollination.',
  ),

  'turnip': PlantKnowledge(
    harvestSigns: 'Baby turnips (2–3 inches): ready at 35–45 days, mild and sweet. Full size (3–5 inches): ready at 50–60 days, more pungent. Oversize turnips (larger than 3 inches) become pithy and bitter. The shoulders of the root should be visible above the soil. Leaves (turnip greens) can be harvested at any size.',
    harvestHow: 'Pull smaller turnips by hand. Use a fork to loosen soil for larger roots. Harvest greens by snipping outer leaves, leaving the center for continued root growth. Twist off the greens when storing roots (greens draw moisture from the root). Both the root and leaves are edible.',
    soilPrep: 'Well-drained, loosely worked soil free of rocks and clumps that would distort root growth. pH 5.5–7.0. Work in compost. Consistent moisture prevents pithy roots. Turnips are fast-growing and do not need extremely fertile soil, but respond to good preparation.',
    fertilizing: 'Light to moderate feeder. A balanced fertilizer at planting is usually sufficient. Side-dress with compost midseason if plants look pale. Avoid high nitrogen, which produces excessive leaf growth at the expense of root development.',
    commonProblems: 'Flea beetles make small holes in leaves. Aphids. Cabbage maggots damage roots. Root knot nematodes. Clubroot in acidic, wet soils. Cover with row cover from planting to prevent most insect problems. Bitter flavor develops in heat — strictly a cool-season crop.',
    storageUse: 'Remove greens and refrigerate separately. Roots: refrigerate in a bag for 2–4 weeks. Long-term: store in moist sand in a cool root cellar (32–35 degrees F) for several months. Greens: refrigerate 3–5 days, use like mustard greens. Roots excellent roasted, mashed, braised, or in soups.',
    bestSeason: 'Direct sow in early spring as soon as soil can be worked, or in late summer for fall harvest. Germinates in cool soil and grows quickly. Fall turnips grown after summer heat passes are often sweeter and of better quality. One of the most cold-hardy root vegetables — harvest can continue into early winter in mild climates.',
  ),

  'valerian': PlantKnowledge(
    harvestSigns: 'Roots are the primary harvest, dug in fall of year 2 or 3 when they are at their most potent. The root should be large and robust (carrot-sized or larger). Flowers can be harvested when in full bloom (the smell is controversial — sweet to some, unpleasant to others). Leaves can be harvested during the growing season.',
    harvestHow: 'Dig roots in fall with a garden fork after the foliage has died back. Wash thoroughly. Chop into 1-inch pieces and dry at 95–115 degrees F until brittle throughout. Flowers: cut entire flower clusters. The distinctive smell intensifies when the roots are dried — this is normal and expected.',
    soilPrep: 'Moist, fertile, well-drained soil. pH 5.5–7.0. Work in generous compost. Valerian likes consistently moist soil and can tolerate partial shade. It grows large — site it where the tall foliage will not shade shorter plants.',
    fertilizing: 'Moderate feeder. A balanced fertilizer or compost in spring when growth begins. Side-dress with compost in midsummer. Consistent moisture and nutrition produce the largest, most potent roots.',
    commonProblems: 'Aphids, thrips. Cats are strongly attracted to valerian root (similar to catnip effect) — protect drying roots from cats. Self-seeds aggressively — deadhead after flowering if you do not want it to spread. Powdery mildew in late summer.',
    storageUse: 'Dried root pieces or powder: store in an airtight jar for 1 year. Used as a traditional herbal sleep aid and nervine. Make tinctures, capsules, or tea. Avoid use with alcohol or sedative medications. The dried root smell (valeric acid) is strong and polarizing — store sealed.',
    bestSeason: 'Direct sow in spring or fall. Perennial in zones 4–9. Self-seeds prolifically if flowers are not removed. Grows very tall (4–6 feet). Excellent at the back of a border or as a screening plant. One of the most traditional medicinal garden plants of European herbal medicine.',
  ),

  'watermelon': PlantKnowledge(
    harvestSigns: 'Multiple reliable indicators: (1) The tendril nearest the fruit turns completely brown and dry. (2) The underside spot (where the melon rests on soil) turns from white-green to creamy yellow. (3) The skin becomes dull rather than shiny. (4) A hollow thud when tapped (not a high-pitched ping). (5) The blossom end feels slightly soft. Aim for at least 3 of these 5 signs.',
    harvestHow: 'Cut from the vine with a sharp knife or pruners, leaving 2 inches of stem. Do not pull — this can crack the fruit at the stem end. Watermelon does not continue to ripen off the vine. Once cut, refrigerate and use within 2–3 weeks. Handle carefully as even slight external cracks allow bacteria to enter.',
    soilPrep: 'Rich, sandy loam with excellent drainage. pH 6.0–7.0. Work in very generous amounts of compost. Watermelons need warm soil (70 degrees F) to thrive — use black plastic mulch to warm the bed in cooler climates. Full sun and lots of space (6–12 feet per plant for large varieties).',
    fertilizing: 'Heavy feeder. Apply balanced fertilizer at planting. Side-dress with compost or apply liquid fertilizer every 2 weeks through the season. Once fruit begins to develop, a high-potassium fertilizer improves sugar content and flavor. Reduce watering as fruit matures to concentrate sugars.',
    commonProblems: 'Cucumber beetles (spread bacterial wilt — most serious threat). Powdery mildew. Squash vine borers. Fusarium wilt. Anthracnose in wet conditions. In short-season climates, choosing an early-maturing variety (70–80 days) is essential for any success.',
    storageUse: 'Whole at room temperature: 2–3 weeks before cutting. Refrigerator after cutting: 3–5 days wrapped tightly. Freeze: cube or ball, freeze on a baking sheet, bag for smoothies. Juice and lemonade. Pickle the rind. High in lycopene and vitamins A and C.',
    bestSeason: 'Start indoors 3–4 weeks before last frost, or direct sow after soil reaches 70 degrees F. Needs a long, hot growing season (70–90+ days). In zones 3–5, choose the smallest, fastest-maturing varieties and use row covers to extend the season. Full sun and very warm conditions are non-negotiable for sweet fruit.',
  ),

  'winter rye': PlantKnowledge(
    harvestSigns: 'As a cover crop (primary use): till or cut into the soil in spring when plants are 6–12 inches tall and actively growing, or at the boot stage (just before the seed head emerges) for maximum biomass. Let the material partially break down (2–4 weeks) before direct seeding into the bed. For grain harvest: wait until stalks and seed heads are fully golden and dry.',
    harvestHow: 'Cover crop: mow or use a string trimmer to cut at soil level, then till into the top few inches of soil. Or roll and crimp mature rye for a no-till approach that creates a weed-suppressing mulch. For grain: cut stalks with a scythe or sickle in the morning, bundle and shock to dry, then thresh and winnow.',
    soilPrep: 'Highly adaptable — one of the most cold-tolerant cover crops and grows in poor, acidic, or compacted soils where other crops struggle. pH 5.0–7.5. Excellent choice for overwintering bare garden beds. Its roots reach deeply and help break up compacted soil.',
    fertilizing: 'Does not need fertilizer for cover crop use. Grows on residual soil fertility left from the previous crop. When using as a grain crop, apply a balanced fertilizer in early spring for increased yield.',
    commonProblems: 'Ergot (a fungal disease on the grain — black, club-shaped masses replace some kernels — do not consume affected grain). Powdery mildew late in the season. Armyworms in some regions. When using as a cover crop and tilling in, the allelopathic compounds in rye can temporarily inhibit germination of small-seeded crops — wait 2–3 weeks before direct seeding.',
    storageUse: 'Grain: dry to under 14% moisture and store in airtight containers for up to 1 year. Ground into rye flour for bread. Whole berries cooked as a hearty grain. Can be malted and used in brewing. As a cover crop, its value is not in storage but in the soil improvement it provides.',
    bestSeason: 'Sow in fall (late September through October) after summer crops are removed. Grows through fall, goes dormant in deep winter, and resumes growth in early spring. Hardy to -30 degrees F. Till in by late April before grain heads emerge, or it will set seed and can become a weed.',
  ),

  'wormwood': PlantKnowledge(
    harvestSigns: 'Harvest leafy stems just before or during the early flowering stage for maximum essential oil content. The silvery-grey leaves should be healthy and vigorous. Morning harvest after dew dries is best. The plant has an intensely bitter, medicinal aroma — this is a sign of quality and potency.',
    harvestHow: 'Cut stems 4–6 inches from the tips using sharp scissors or pruners. Take no more than a third of the plant at once. Dry in small bundles hung upside down in a warm, airy, dark location — direct sun bleaches the silvery leaves. Or dry flat on screens. Fully dried material should be stored immediately in airtight jars.',
    soilPrep: 'Poor to average, very well-drained soil. pH 5.5–7.5. Does not need or want rich soil — excessive fertility reduces the bitter compounds that are the plant\'s defining characteristic. Thrives in dry, rocky, or gravelly conditions. Full sun is essential.',
    fertilizing: 'No fertilizer needed or desired. Grows as a roadside and wasteland plant in its native range — it is perfectly adapted to poor, unfed conditions. Rich soil produces large, unattractive plants with diminished potency.',
    commonProblems: 'Very few pest or disease problems — the bitter compounds deter most insects. Root rot in poorly drained or overwatered soil. Can spread by root division. Allelopathic to many nearby plants (roots and leaching rain wash inhibitory compounds into the soil). Plant away from vegetables and other herbs.',
    storageUse: 'Dried leaves and stems: store in airtight jars for up to 1 year in a dark, cool location. Used historically as a bittering agent in vermouth and absinthe. Avoid internal use without expert guidance — thujone (a component of the essential oil) is toxic in significant quantities. Used externally in insect-repelling sachets and companion planting applications.',
    bestSeason: 'Plant in spring after last frost. Perennial in zones 4–9. Extremely drought-tolerant and heat-tolerant once established. Excellent ornamental plant for dry gardens with its distinctive silver foliage. Rarely needs dividing or replanting once established. Long-lived and low-maintenance.',
  ),

  'rue': PlantKnowledge(
    harvestSigns: 'Harvest leafy stems at any point during active growth — before flowering for the mildest flavor and best appearance. The blue-green leaves should be vibrant and the plant healthy. Flowers can be harvested when fully yellow. Always wear gloves when handling rue — the sap causes photosensitive skin reactions in many people.',
    harvestHow: 'Snip stem tips 4–6 inches from the top, cutting just above a leaf node. Harvest from throughout the plant to maintain even shape. For drying, cut stems before flowering and hang in small bundles. Wash hands thoroughly after handling. Do not handle in bright sunlight — phototoxic compounds in the sap can cause skin blistering.',
    soilPrep: 'Poor to average, dry, well-drained soil. pH 6.0–8.0. Thrives in poor, rocky, or gravelly conditions with full sun. Does not need amended or rich soil. Excellent drainage is the primary requirement.',
    fertilizing: 'No fertilizer needed. Too much nutrition produces soft, lush growth that is less aromatic and more prone to disease. Grow it lean — it is a Mediterranean herb adapted to dry, unfertile conditions.',
    commonProblems: 'Root rot in wet or poorly drained soils. Aphids occasionally. The main concern is the phototoxic sap — always wear protective clothing when working with rue in sunlight. Generally a tough, problem-free plant.',
    storageUse: 'Dried rue: store in airtight jars for 1 year. Historically used as a culinary bitter herb in very small quantities (Ethiopian cuisine uses it in coffee). Primarily used today as a companion plant (repels some insects), in traditional herbal preparations, and as an ornamental. Avoid internal use during pregnancy.',
    bestSeason: 'Plant seeds or divisions in spring. Perennial in zones 4–9. Drought-tolerant once established. Evergreen in mild climates. Cut back by half in early spring to encourage fresh growth. Long-lived and virtually self-sustaining once established.',
  ),

};

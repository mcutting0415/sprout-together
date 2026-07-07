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
  'corn': PlantKnowledge(
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

};

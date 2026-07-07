import '/final_app_pages/final_header/final_header_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'garden_tips_page_model.dart';
export 'garden_tips_page_model.dart';

// ─────────────────────────────────────────────────────────────────────────────
// FULL TIPS DATABASE
// ─────────────────────────────────────────────────────────────────────────────

class _Tip {
  final IconData icon;
  final Color color;
  final String title;
  final String detail;
  final String category;
  final List<String> levels; // 'Beginner', 'Intermediate', 'Advanced', or all

  const _Tip({
    required this.icon,
    required this.color,
    required this.title,
    required this.detail,
    required this.category,
    required this.levels,
  });
}

const _allTips = [
  // ── WATERING ──────────────────────────────────────────────────────────────
  _Tip(
    icon: Icons.water_drop_rounded,
    color: Color(0xFF4A90A4),
    title: 'Water in the morning so leaves dry before nighttime.',
    detail:
        'Wet foliage overnight creates ideal conditions for powdery mildew, botrytis, and other fungal diseases. Morning watering gives leaves the whole day to dry. Aim water at the base of the plant — a soaker hose or watering can keeps leaves completely dry.',
    category: 'Watering',
    levels: ['Beginner', 'Intermediate', 'Advanced'],
  ),
  _Tip(
    icon: Icons.water_drop_outlined,
    color: Color(0xFF4A90A4),
    title: 'Check soil moisture before watering — a wet finger test beats a schedule.',
    detail:
        'Push your finger 2 inches into the soil. If it\'s moist, skip watering. If it\'s dry, water deeply. Most gardeners overwater rather than underwater. Consistent shallow watering encourages shallow roots; deep, infrequent watering grows deeper, more drought-tolerant root systems.',
    category: 'Watering',
    levels: ['Beginner', 'Intermediate'],
  ),
  _Tip(
    icon: Icons.opacity_rounded,
    color: Color(0xFF4A90A4),
    title: 'Use drip irrigation to save water and reduce fungal disease.',
    detail:
        'Drip systems deliver water directly to roots, reducing evaporation by up to 50% compared to overhead sprinklers. They also keep foliage dry, cutting fungal disease risk dramatically. Even a simple soaker hose looped around your beds is a major upgrade over a sprinkler.',
    category: 'Watering',
    levels: ['Intermediate', 'Advanced'],
  ),
  _Tip(
    icon: Icons.thermostat_rounded,
    color: Color(0xFF4A90A4),
    title: 'Water more frequently in heat waves — check plants daily over 90°F.',
    detail:
        'High heat dramatically increases plant transpiration (water loss through leaves). During a heat wave, containers may need watering twice a day. Look for wilting in the early morning (not midday) — if plants are wilted at dawn, they\'re genuinely stressed and need water.',
    category: 'Watering',
    levels: ['Beginner', 'Intermediate', 'Advanced'],
  ),

  // ── SOIL ──────────────────────────────────────────────────────────────────
  _Tip(
    icon: Icons.layers_rounded,
    color: Color(0xFFE0A43A),
    title: 'Mulch 2–3 inches deep to retain moisture and suppress weeds.',
    detail:
        'Apply straw, wood chips, or shredded leaves around (not touching) plant stems. Mulch halves your watering frequency, keeps roots 10°F cooler on hot days, and smothers weed seeds before they sprout. Refresh mid-season as it breaks down.',
    category: 'Soil',
    levels: ['Beginner', 'Intermediate', 'Advanced'],
  ),
  _Tip(
    icon: Icons.compost_rounded,
    color: Color(0xFFE0A43A),
    title: 'Add compost every season to build rich, living soil.',
    detail:
        'Compost adds essential nutrients, improves drainage in clay soils, and helps sandy soils retain water. Work 2–4 inches of finished compost into your beds each spring. Over 3–5 years, consistent composting builds deep, rich soil that dramatically outperforms fertilizer-only approaches.',
    category: 'Soil',
    levels: ['Beginner', 'Intermediate'],
  ),
  _Tip(
    icon: Icons.science_rounded,
    color: Color(0xFFE0A43A),
    title: 'Test soil pH — most vegetables thrive between 6.0 and 7.0.',
    detail:
        'Use a digital pH meter or test strips. If pH is too low (acidic), add garden lime. If too high (alkaline), add sulfur or peat moss. Check after heavy rains which can leach lime. Record readings in your journal to spot seasonal trends.',
    category: 'Soil',
    levels: ['Intermediate', 'Advanced'],
  ),
  _Tip(
    icon: Icons.layers_rounded,
    color: Color(0xFFE0A43A),
    title: 'Layer green and brown compost 1:2 to speed decomposition.',
    detail:
        'Greens: kitchen scraps, fresh grass clippings, coffee grounds. Browns: dry leaves, cardboard, straw. The 1:2 ratio keeps nitrogen and carbon balanced so microbes thrive. Turn the pile every 3–5 days to introduce oxygen. At 55–65°C, weed seeds and most pathogens are destroyed.',
    category: 'Soil',
    levels: ['Advanced'],
  ),
  _Tip(
    icon: Icons.grass_rounded,
    color: Color(0xFFE0A43A),
    title: 'Never till wet soil — it destroys structure and compacts root zones.',
    detail:
        'Working wet soil breaks up the natural aggregates that create pore spaces for air and water. Squeeze a handful of soil — if it crumbles when you open your fist, it\'s ready. If it stays in a ball, wait. For no-till beds, top-dress with compost instead of digging it in.',
    category: 'Soil',
    levels: ['Intermediate', 'Advanced'],
  ),

  // ── PLANTING ──────────────────────────────────────────────────────────────
  _Tip(
    icon: Icons.wb_sunny_rounded,
    color: Color(0xFF4E7A2E),
    title: 'Most vegetables need 6–8 hours of direct sun per day.',
    detail:
        'Walk your yard at 10am, 12pm, 2pm, and 4pm and note which spots are sunny vs. shaded. Tall fences, trees, and the house cast moving shadows throughout the day. "Full sun" = 6+ hours. "Part shade" = 3–6 hours. Knowing your sun patterns lets you place the right plants in the right spots.',
    category: 'Planting',
    levels: ['Beginner'],
  ),
  _Tip(
    icon: Icons.eco_rounded,
    color: Color(0xFF4E7A2E),
    title: 'Start with easy wins: lettuce, radishes, and zucchini grow fast.',
    detail:
        'Radishes are ready in 25–30 days. Lettuce can be harvested leaf by leaf in 30–45 days. Zucchini grows so vigorously that beginners often have more than they can eat. These plants give you quick feedback and confidence before moving on to tomatoes and peppers.',
    category: 'Planting',
    levels: ['Beginner'],
  ),
  _Tip(
    icon: Icons.spa_rounded,
    color: Color(0xFF4E7A2E),
    title: 'Harden off seedlings 7–10 days before transplanting outdoors.',
    detail:
        'Seedlings grown indoors aren\'t used to direct sun, wind, or temperature swings. Start by placing them outside in shade for 1–2 hours a day. Over 7–10 days gradually increase sun exposure. By day 10 they should be outside most of the day. This prevents wilting, sunscald, and root stress.',
    category: 'Planting',
    levels: ['Beginner', 'Intermediate'],
  ),
  _Tip(
    icon: Icons.swap_horiz_rounded,
    color: Color(0xFF4E7A2E),
    title: 'Rotate plant families each season to break pest and disease cycles.',
    detail:
        'Divide plants into families: nightshades (tomato, pepper, eggplant), brassicas (cabbage, broccoli, kale), alliums (onion, garlic), and cucurbits (cucumber, squash). Move each family to a new bed each season. After 3–4 rotations many soil-borne diseases are starved out.',
    category: 'Planting',
    levels: ['Intermediate', 'Advanced'],
  ),
  _Tip(
    icon: Icons.calendar_month_rounded,
    color: Color(0xFF4E7A2E),
    title: 'Succession plant every 2 weeks for continuous harvests all season.',
    detail:
        'Rather than planting all your lettuce at once, plant a small row every 2 weeks. This staggers maturity so you\'re harvesting continuously instead of having a glut then nothing. Works especially well for lettuce, radishes, cilantro, green onions, and beans.',
    category: 'Planting',
    levels: ['Intermediate', 'Advanced'],
  ),
  _Tip(
    icon: Icons.people_rounded,
    color: Color(0xFF4E7A2E),
    title: 'Use companion planting to naturally boost growth and deter pests.',
    detail:
        'Classic pairs: tomatoes + basil (basil may repel aphids and whiteflies), carrots + onions (each masks the scent that attracts the other\'s pests), squash + nasturtiums (nasturtiums trap aphids away from squash). Use the Companion Guide in the app for detailed pairings.',
    category: 'Planting',
    levels: ['Beginner', 'Intermediate', 'Advanced'],
  ),

  // ── PESTS & DISEASE ───────────────────────────────────────────────────────
  _Tip(
    icon: Icons.pest_control_rounded,
    color: Color(0xFFD9534F),
    title: 'Check leaf undersides weekly — that\'s where pests hide first.',
    detail:
        'Aphids, spider mites, and whiteflies all congregate on leaf undersides where they\'re protected from rain and predators. A weekly check with a hand lens lets you catch infestations early when a blast of water or neem oil can still handle them easily.',
    category: 'Pests',
    levels: ['Beginner', 'Intermediate', 'Advanced'],
  ),
  _Tip(
    icon: Icons.water_rounded,
    color: Color(0xFFD9534F),
    title: 'A strong blast of water dislodges most soft-bodied pest colonies.',
    detail:
        'For aphids, spider mites, and whiteflies, a forceful water spray removes 90% of them without chemicals. Spray in the morning so plants dry quickly. Repeat every 2–3 days for 2 weeks to break the lifecycle. For persistent infestations, follow with neem oil in the evening.',
    category: 'Pests',
    levels: ['Beginner', 'Intermediate'],
  ),
  _Tip(
    icon: Icons.bug_report_rounded,
    color: Color(0xFFD9534F),
    title: 'Introduce beneficial insects — lacewings and parasitic wasps eat pests.',
    detail:
        'Lacewings eat aphids, whiteflies, and small caterpillars. Parasitic wasps lay eggs inside hornworms and aphids, killing them from within. Attract them by planting dill, fennel, yarrow, or sweet alyssum near your vegetables. Avoid broad-spectrum pesticides which kill beneficials too.',
    category: 'Pests',
    levels: ['Advanced'],
  ),
  _Tip(
    icon: Icons.shield_rounded,
    color: Color(0xFFD9534F),
    title: 'Use row cover fabric as a physical pest barrier — no chemicals needed.',
    detail:
        'Floating row cover (spunbond polypropylene) lets in light, air, and rain while blocking flying insects like cabbage moths, carrot flies, and cucumber beetles. Drape loosely over plants and secure edges with soil or rocks. Remove when plants flower to allow pollination.',
    category: 'Pests',
    levels: ['Intermediate', 'Advanced'],
  ),

  // ── HARVESTING ────────────────────────────────────────────────────────────
  _Tip(
    icon: Icons.grass_rounded,
    color: Color(0xFF7BA05B),
    title: 'Harvest regularly — the more you pick, the more plants produce.',
    detail:
        'Many vegetables (zucchini, cucumbers, beans, peppers) slow or stop producing if fruits are left to mature on the vine. Check every 2–3 days during peak season and harvest at the ideal size. A zucchini left 3 days can go from perfect to baseball-bat-sized — check daily in summer.',
    category: 'Harvesting',
    levels: ['Beginner', 'Intermediate', 'Advanced'],
  ),
  _Tip(
    icon: Icons.sunny_snowing,
    color: Color(0xFF7BA05B),
    title: 'Harvest leafy greens in the morning for best flavor and longest shelf life.',
    detail:
        'Plants accumulate sugars overnight that make them taste sweeter. Heat and sunlight during the day cause wilting. Harvest lettuce, spinach, kale, and herbs first thing in the morning, then immediately refrigerate or place in water to maintain crispness.',
    category: 'Harvesting',
    levels: ['Beginner', 'Intermediate'],
  ),
  _Tip(
    icon: Icons.content_cut_rounded,
    color: Color(0xFF7BA05B),
    title: 'Pinch tomato suckers weekly to redirect energy into fruit production.',
    detail:
        'Suckers grow in the "V" between the main stem and a branch. Left unchecked they become full branches and dilute the plant\'s energy. Pinch when small (under 2 inches) with clean fingers. Focus on suckers below the first flower cluster. Indeterminate varieties benefit most from this.',
    category: 'Harvesting',
    levels: ['Intermediate', 'Advanced'],
  ),

  // ── SEASON & TIMING ───────────────────────────────────────────────────────
  _Tip(
    icon: Icons.ac_unit_rounded,
    color: Color(0xFF9C6EA3),
    title: 'Frost cloth can extend your season by 4–6 weeks in spring and fall.',
    detail:
        'A single layer of frost cloth (also called row cover) can protect plants down to 28°F, giving you extra weeks at each end of the season. For harder freezes, use two layers or add a water-filled "Wall O Water" around individual plants for protection to 16°F.',
    category: 'Season',
    levels: ['Intermediate', 'Advanced'],
  ),
  _Tip(
    icon: Icons.wb_sunny_rounded,
    color: Color(0xFF9C6EA3),
    title: 'Cool-season crops (lettuce, kale, peas) thrive in spring and fall, not summer.',
    detail:
        'Most cool-season crops bolt (go to seed) when temperatures consistently hit 75°F+. Plant spinach, lettuce, and peas 4–6 weeks before your last frost in spring, or time a fall planting so they mature before first frost. Shade cloth can extend cool-season crops 2–3 weeks into summer.',
    category: 'Season',
    levels: ['Beginner', 'Intermediate'],
  ),
  _Tip(
    icon: Icons.thermostat_auto_rounded,
    color: Color(0xFF9C6EA3),
    title: 'Cold stratify seeds that need a winter chill to germinate.',
    detail:
        'Some perennial seeds (lavender, echinacea, many wildflowers) require a cold, moist period before they\'ll germinate — mimicking winter. Mix seeds with damp sand or paper towels in a sealed bag and refrigerate for 4–12 weeks. Then sow them normally. Skip this and they may just sit dormant.',
    category: 'Season',
    levels: ['Advanced'],
  ),

  // ── TOOLS & TECHNIQUES ────────────────────────────────────────────────────
  _Tip(
    icon: Icons.build_rounded,
    color: Color(0xFF888888),
    title: 'Clean and sharpen tools at the end of each season — they\'ll last decades.',
    detail:
        'Remove soil from metal parts, sand off any rust with fine-grit sandpaper, apply a light coat of linseed oil to metal and wooden handles, and sharpen hoe and trowel edges with a file. Sharp tools take less effort and make cleaner cuts that reduce disease entry points in plants.',
    category: 'Tools',
    levels: ['Beginner', 'Intermediate', 'Advanced'],
  ),
  _Tip(
    icon: Icons.menu_book_rounded,
    color: Color(0xFF888888),
    title: 'Keep a garden journal — your notes from last year are your best reference.',
    detail:
        'Record planting dates, first harvest dates, pest problems, what worked, and what didn\'t. After two or three seasons you\'ll have a highly personalized guide to your specific microclimate, soil, and conditions. No gardening book can replace your own tracked data.',
    category: 'Tools',
    levels: ['Beginner', 'Intermediate', 'Advanced'],
  ),
  _Tip(
    icon: Icons.photo_camera_rounded,
    color: Color(0xFF888888),
    title: 'Take weekly photos of your garden to track progress and spot problems early.',
    detail:
        'Photographs reveal subtle changes — yellowing leaves, slow growth, pest damage — that you might miss while standing in the garden. Take photos from the same spot and angle each week. Compare side by side to see trends. Use your journal to attach notes to key photos.',
    category: 'Tools',
    levels: ['Beginner', 'Intermediate', 'Advanced'],
  ),
  _Tip(
    icon: Icons.grain_rounded,
    color: Color(0xFF888888),
    title: 'Save seeds from your best plants to adapt varieties to your local conditions.',
    detail:
        'Open-pollinated (non-hybrid) varieties reproduce true from seed. Save seeds from your most productive, disease-resistant plants and, over generations, they\'ll become increasingly adapted to your specific soil and climate. Let a few fruits fully mature on the vine, extract and dry seeds for 2 weeks, then store in a cool dry place.',
    category: 'Tools',
    levels: ['Advanced'],
  ),

  // ── COMPOSTING ────────────────────────────────────────────────────────────
  _Tip(
    icon: Icons.recycling_rounded,
    color: Color(0xFF795548),
    title: 'A compost pile needs four things: greens, browns, moisture, and air.',
    detail:
        'Greens (nitrogen-rich): vegetable scraps, coffee grounds, fresh grass clippings, plant trimmings. Browns (carbon-rich): cardboard, dry leaves, straw, paper towels. Aim for a 1:2 or 1:3 green-to-brown ratio by volume. Keep the pile as moist as a wrung-out sponge and turn it every 5–7 days to introduce oxygen. Without air, the pile goes anaerobic and smells foul.',
    category: 'Composting',
    levels: ['Beginner', 'Intermediate', 'Advanced'],
  ),
  _Tip(
    icon: Icons.thermostat_rounded,
    color: Color(0xFF795548),
    title: 'A hot compost pile (55–65°C) kills weed seeds and pathogens in 2–3 weeks.',
    detail:
        'A pile that reaches 55–65°C (130–150°F) in its core will kill most weed seeds, plant diseases, and harmful bacteria. Measure with a compost thermometer. If the pile isn\'t heating up, it likely needs more greens (nitrogen) or more moisture. Turn it to re-aerate and it should reheat within 24–48 hours.',
    category: 'Composting',
    levels: ['Intermediate', 'Advanced'],
  ),
  _Tip(
    icon: Icons.do_not_disturb_on_rounded,
    color: Color(0xFF795548),
    title: 'Never compost meat, dairy, or diseased plants — they cause problems.',
    detail:
        'Meat and dairy attract rodents and create odours. Diseased plant material (tomato blight, powdery mildew) may survive in a cold pile and re-infect your garden. Also avoid: pet waste (contains pathogens), treated wood products, and plants that went to seed if your pile doesn\'t get hot enough to kill them.',
    category: 'Composting',
    levels: ['Beginner', 'Intermediate', 'Advanced'],
  ),
  _Tip(
    icon: Icons.access_time_rounded,
    color: Color(0xFF795548),
    title: 'Finished compost smells like earth and crumbles in your hand — use it before it\'s "done".',
    detail:
        'Mature compost is dark brown, crumbly, and earthy-smelling with no recognisable original materials. If you see chunks still decomposing, it\'s not ready. But "almost finished" compost can still be used: dig it into beds where it will finish breaking down. Only apply truly finished compost directly to seedling roots — unfinished compost can temporarily lock up nitrogen.',
    category: 'Composting',
    levels: ['Intermediate', 'Advanced'],
  ),
  _Tip(
    icon: Icons.bug_report_rounded,
    color: Color(0xFF795548),
    title: 'Vermicomposting (worm bins) produces the richest compost of all — indoors year-round.',
    detail:
        'Red wigglers (Eisenia fetida) eat kitchen scraps and produce castings that are 5–7× more nutrient-rich than standard compost. A bin needs: bedding (shredded cardboard), food scraps in small pieces, and moisture. Keep it in a dark location between 15–25°C. Harvest castings every 2–3 months. A 1 sq ft bin can process 0.5 kg of scraps per week.',
    category: 'Composting',
    levels: ['Beginner', 'Intermediate', 'Advanced'],
  ),

  // ── ORGANIC GARDENING ─────────────────────────────────────────────────────
  _Tip(
    icon: Icons.eco_rounded,
    color: Color(0xFF2E7D32),
    title: 'Build healthy soil and you\'ll need far fewer pesticides and fertilizers.',
    detail:
        'Healthy soil teems with bacteria, fungi, nematodes, and earthworms that suppress disease, fix nutrients, and break down organic matter. Adding compost, minimizing tillage, and avoiding synthetic pesticides builds this ecosystem over time. Plants growing in biologically active soil are inherently more pest- and disease-resistant.',
    category: 'Organic',
    levels: ['Beginner', 'Intermediate', 'Advanced'],
  ),
  _Tip(
    icon: Icons.spa_rounded,
    color: Color(0xFF2E7D32),
    title: 'Neem oil is a broad-spectrum organic spray that works on over 200 pest species.',
    detail:
        'Cold-pressed neem oil disrupts the hormone system of insects at the larval stage, preventing them from maturing and reproducing. It also has antifungal properties. Mix 2 tsp neem oil + 1 tsp dish soap per litre of water. Spray at dusk (to protect bees) on the entire plant including leaf undersides. Reapply every 7 days and after rain.',
    category: 'Organic',
    levels: ['Beginner', 'Intermediate', 'Advanced'],
  ),
  _Tip(
    icon: Icons.pest_control_rounded,
    color: Color(0xFF2E7D32),
    title: 'Diatomaceous earth (food grade) kills crawling insects without chemicals.',
    detail:
        'DE is made from fossilised diatoms with microscopic sharp edges that damage the waxy outer layer of crawling insects (slugs, beetles, earwigs), causing them to dehydrate. Dust around the base of plants and on foliage. Reapply after rain. Use only food-grade DE — pool-grade DE is dangerous to inhale. Wear a mask when applying since it can irritate lungs.',
    category: 'Organic',
    levels: ['Intermediate', 'Advanced'],
  ),
  _Tip(
    icon: Icons.grass_rounded,
    color: Color(0xFF2E7D32),
    title: 'Plant "banker plants" to keep a permanent population of beneficial insects.',
    detail:
        'Banker plants host beneficial insects (predatory wasps, lacewings, hoverflies) throughout the season so they\'re present when pests appear. Good banker plants: dill, fennel, yarrow, sweet alyssum, and phacelia. Plant them in permanent patches throughout your garden, not just next to problem crops. Once established, beneficials will patrol your whole garden.',
    category: 'Organic',
    levels: ['Advanced'],
  ),
  _Tip(
    icon: Icons.water_drop_rounded,
    color: Color(0xFF2E7D32),
    title: 'Compost tea amplifies the beneficial microbes in your soil with each watering.',
    detail:
        'Brew compost tea by aerating finished compost in water for 24–48 hours. The aeration multiplies beneficial bacteria and fungi. Apply it as a soil drench or foliar spray. Use within 4 hours of brewing. Compost tea can suppress some foliar diseases and inoculate new beds with a microbial community faster than compost alone.',
    category: 'Organic',
    levels: ['Advanced'],
  ),

  // ── FERTILIZING ──────────────────────────────────────────────────────────
  _Tip(
    icon: Icons.science_outlined,
    color: Color(0xFF6B8E6B),
    title: 'Feed plants during active growth — fertilizing dormant plants wastes money.',
    detail:
        'Plants can only absorb nutrients when they\'re actively growing. Apply fertilizer in spring when new growth begins and through midsummer. Stop feeding 6–8 weeks before your first expected frost so plants can harden off properly. Fertilizing late in the season pushes tender new growth that\'s easily damaged by cold.',
    category: 'Fertilizing',
    levels: ['Beginner', 'Intermediate'],
  ),
  _Tip(
    icon: Icons.eco_outlined,
    color: Color(0xFF6B8E6B),
    title: 'Organic fertilizers feed soil life; synthetic fertilizers feed plants directly.',
    detail:
        'Fish emulsion, bone meal, and kelp meal break down slowly and feed the microbes that build healthy soil long-term. Synthetic fertilizers (like 10-10-10) deliver nutrients immediately but don\'t improve soil structure. Beginners often get better long-term results combining both: organic as a base, synthetic for a quick boost when plants struggle.',
    category: 'Fertilizing',
    levels: ['Beginner', 'Intermediate', 'Advanced'],
  ),
  _Tip(
    icon: Icons.warning_amber_rounded,
    color: Color(0xFF6B8E6B),
    title: 'Yellow leaves usually mean nitrogen deficiency — but don\'t guess, diagnose first.',
    detail:
        'Yellowing starting from lower, older leaves is classic nitrogen deficiency. Yellowing between leaf veins (veins stay green) points to iron or magnesium deficiency. Yellowing from the tips inward suggests potassium or salt stress. Applying the wrong fix can make things worse — check soil pH first, since nutrients become unavailable outside the 6.0–7.0 range regardless of what you add.',
    category: 'Fertilizing',
    levels: ['Intermediate', 'Advanced'],
  ),
  _Tip(
    icon: Icons.block_rounded,
    color: Color(0xFF6B8E6B),
    title: 'More fertilizer is not better — over-fertilizing burns roots and attracts pests.',
    detail:
        'Salt build-up from excess fertilizer draws water out of roots (osmotic stress), causing brown leaf edges and wilting that looks like drought. High nitrogen also produces lush, soft growth that aphids and mites love. Always follow label rates. When in doubt, use half the recommended dose and watch the plant\'s response before adding more.',
    category: 'Fertilizing',
    levels: ['Beginner', 'Intermediate', 'Advanced'],
  ),
  _Tip(
    icon: Icons.local_drink_rounded,
    color: Color(0xFF6B8E6B),
    title: 'Liquid fertilizer works twice as fast as granular — use it for quick correction.',
    detail:
        'Liquid fertilizers (fish emulsion, liquid kelp, or diluted synthetic) are absorbed through both roots and leaves within hours. Use them when you spot a deficiency and need a fast response. Granular fertilizers feed over weeks as they break down. Use granulars as a steady background feed and liquids for targeted rescue.',
    category: 'Fertilizing',
    levels: ['Intermediate', 'Advanced'],
  ),

  // ── CONTAINER GARDENING ──────────────────────────────────────────────────
  _Tip(
    icon: Icons.inventory_2_rounded,
    color: Color(0xFF9E7B4A),
    title: 'Drainage holes are non-negotiable — roots sitting in water rot within days.',
    detail:
        'Even "drought-tolerant" plants die quickly in waterlogged soil. Every container must have drainage holes. If you\'re using a decorative pot without holes, use it as a cachepot: grow in a smaller plastic pot with drainage inside the decorative one, and empty collected water within 30 minutes of watering.',
    category: 'Containers',
    levels: ['Beginner', 'Intermediate', 'Advanced'],
  ),
  _Tip(
    icon: Icons.thermostat_rounded,
    color: Color(0xFF9E7B4A),
    title: 'Containers dry out 2× faster than ground beds — check daily in summer.',
    detail:
        'Terracotta dries even faster than plastic or glazed ceramic because moisture evaporates through the walls. On hot summer days, a large container may need watering twice. Lift the pot — if it feels light, it needs water. Push a finger 2 inches in. Mulching the top of a container cuts moisture loss significantly.',
    category: 'Containers',
    levels: ['Beginner', 'Intermediate'],
  ),
  _Tip(
    icon: Icons.open_with_rounded,
    color: Color(0xFF9E7B4A),
    title: 'Go bigger than you think — most vegetables need at least 12 inches of depth.',
    detail:
        'Root vegetables (carrots, beets) need 12–18 inches deep. Tomatoes and peppers do best in 15-gallon (or larger) containers. Herbs are happy in 6–8 inch pots. Small containers stress roots, dry out constantly, and limit yield. If your tomatoes are struggling in containers, pot size is often the first thing to check.',
    category: 'Containers',
    levels: ['Beginner', 'Intermediate'],
  ),
  _Tip(
    icon: Icons.wb_shade_rounded,
    color: Color(0xFF9E7B4A),
    title: 'Dark-colored pots absorb heat and can cook roots — choose light colors in hot climates.',
    detail:
        'Black or dark brown pots in full sun can reach soil temperatures of 130°F+ in summer, which kills roots and beneficial microbes. In hot climates, choose white, cream, or light gray containers. Alternatively, double-pot (place a smaller pot inside a larger one with an air gap) or wrap pots in burlap to insulate roots.',
    category: 'Containers',
    levels: ['Intermediate', 'Advanced'],
  ),
  _Tip(
    icon: Icons.water_drop_rounded,
    color: Color(0xFF9E7B4A),
    title: 'Self-watering containers cut watering frequency by half — great for busy gardeners.',
    detail:
        'Self-watering pots have a water reservoir at the bottom; plants draw up what they need via a wicking system. Fill the reservoir every 5–7 days instead of watering daily. They also prevent both overwatering and underwatering, which is the main cause of container plant failure. Ideal for tomatoes, peppers, and herbs.',
    category: 'Containers',
    levels: ['Beginner', 'Intermediate', 'Advanced'],
  ),

  // ── WEEDS ─────────────────────────────────────────────────────────────────
  _Tip(
    icon: Icons.grass_rounded,
    color: Color(0xFFB5651D),
    title: 'Weed when small — a 30-second pull now prevents 30 minutes of work later.',
    detail:
        'Young weeds have shallow roots and pull out cleanly. Wait until they\'re established and you\'re digging out deep taproots (dandelion, dock) or untangling runners (bindweed, quackgrass). A quick 10-minute pass through your garden every few days keeps weeds from ever getting established.',
    category: 'Weeds',
    levels: ['Beginner', 'Intermediate', 'Advanced'],
  ),
  _Tip(
    icon: Icons.emergency_rounded,
    color: Color(0xFFB5651D),
    title: 'Never let a weed go to seed — one plant can produce 10,000+ seeds.',
    detail:
        'A single dandelion produces up to 15,000 seeds; a pigweed can produce 100,000. If you can\'t pull a weed before it flowers, cut off the seed head immediately and bag it — don\'t compost it unless you have a hot pile. "One year\'s seeding = seven years\' weeding" is a real phenomenon.',
    category: 'Weeds',
    levels: ['Beginner', 'Intermediate', 'Advanced'],
  ),
  _Tip(
    icon: Icons.cut_rounded,
    color: Color(0xFFB5651D),
    title: 'Cultivate the top inch of soil in dry weather to kill germinating weed seeds.',
    detail:
        'Weed seeds in the top inch of soil need light and contact with moist soil to germinate. A quick scrape with a hoe on a dry, sunny day kills germinating seeds before they emerge. This "stale seedbed" technique, done every 5–7 days, dramatically reduces the weed seedbank over a season. Don\'t dig deep — you\'ll expose more buried seeds.',
    category: 'Weeds',
    levels: ['Intermediate', 'Advanced'],
  ),

  // ── MORE PLANTING ─────────────────────────────────────────────────────────
  _Tip(
    icon: Icons.access_time_rounded,
    color: Color(0xFF4E7A2E),
    title: 'Transplant in the evening or on a cloudy day to reduce transplant shock.',
    detail:
        'Moving a plant severs some roots and disrupts water uptake. Planting in the cool of the evening or on an overcast day gives plants 12–18 hours to settle before facing full sun. Water in thoroughly, and if possible shade new transplants with a cloth or pot for the first 2–3 days during extreme heat.',
    category: 'Planting',
    levels: ['Beginner', 'Intermediate'],
  ),
  _Tip(
    icon: Icons.straighten_rounded,
    color: Color(0xFF4E7A2E),
    title: 'Spacing matters more than most beginners expect — crowded plants underperform.',
    detail:
        'Crowded plants compete for water, nutrients, and light. They also trap humidity between leaves, creating ideal conditions for fungal disease. Spacing guidelines on seed packets are minimums, not targets. In raised beds with rich soil you can plant 10–20% closer, but in typical garden soil, follow or exceed them.',
    category: 'Planting',
    levels: ['Beginner', 'Intermediate'],
  ),

  // ── MORE HARVESTING ───────────────────────────────────────────────────────
  _Tip(
    icon: Icons.content_cut_rounded,
    color: Color(0xFF7BA05B),
    title: 'Use clean scissors or pruners to harvest — tearing damages plants and spreads disease.',
    detail:
        'Ragged cuts from pulling or tearing are entry points for bacteria and fungi. Clean, sharp cuts heal quickly. Wipe blades with isopropyl alcohol between plants when harvesting from a bed with any sign of disease. This simple habit can prevent an isolated problem from spreading across your entire garden.',
    category: 'Harvesting',
    levels: ['Beginner', 'Intermediate', 'Advanced'],
  ),
  _Tip(
    icon: Icons.local_florist_rounded,
    color: Color(0xFF7BA05B),
    title: 'Deadhead flowers regularly to extend blooming by weeks or months.',
    detail:
        'Once a flower sets seed, the plant\'s energy shifts to seed production and blooming slows or stops. Removing spent flowers (deadheading) tricks the plant into continuing to flower. Pinch or cut just below the spent flower back to a leaf node. Works especially well with zinnias, cosmos, marigolds, and basil.',
    category: 'Harvesting',
    levels: ['Beginner', 'Intermediate'],
  ),

  // ── MORE SOIL ─────────────────────────────────────────────────────────────
  _Tip(
    icon: Icons.recycling_rounded,
    color: Color(0xFFE0A43A),
    title: 'Plant cover crops in fall to protect and improve soil over winter.',
    detail:
        'Cover crops like winter rye, clover, or hairy vetch prevent erosion, suppress weeds, and fix nitrogen. Legume covers (clover, vetch) feed soil bacteria that convert atmospheric nitrogen into plant-available nutrients — a free fertilizer boost. Till them in 2–3 weeks before planting, giving them time to break down.',
    category: 'Soil',
    levels: ['Intermediate', 'Advanced'],
  ),
  _Tip(
    icon: Icons.pest_control_rounded,
    color: Color(0xFFE0A43A),
    title: 'Worm castings are the single best soil amendment — use them sparingly, they\'re potent.',
    detail:
        'Worm castings (vermicompost) improve soil structure, suppress certain plant diseases, and contain plant-growth hormones not found in regular compost. A little goes a long way — mix 10–20% castings into potting mix or top-dress a tablespoon around each transplant. You can make your own with a worm bin using kitchen scraps year-round.',
    category: 'Soil',
    levels: ['Intermediate', 'Advanced'],
  ),
];

// Tips shown on the Garden Insights page (top 4, relevant to level)
List<Map<String, dynamic>> insightsTipsForLevel(String level) {
  final tips = _allTips.where((t) => t.levels.contains(level)).toList();
  // Return first 4, which are the most fundamental for the level
  return tips.take(4).map((t) => {
    'icon': t.icon,
    'color': t.color,
    'text': t.title,
    'detail': t.detail,
    'category': t.category,
    'action': null,
  }).toList();
}

// ─────────────────────────────────────────────────────────────────────────────

class GardenTipsPageWidget extends StatefulWidget {
  const GardenTipsPageWidget({super.key, this.experienceLevel});

  final String? experienceLevel;

  static String routeName = 'GardenTipsPage';
  static String routePath = '/gardenTipsPage';

  @override
  State<GardenTipsPageWidget> createState() => _GardenTipsPageWidgetState();
}

class _GardenTipsPageWidgetState extends State<GardenTipsPageWidget> {
  late GardenTipsPageModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final _searchController = TextEditingController();
  String _searchQuery = '';
  String? _selectedCategory;

  static const _categories = [
    'All', 'Watering', 'Soil', 'Composting', 'Planting', 'Fertilizing', 'Containers', 'Pests', 'Harvesting', 'Weeds', 'Season', 'Organic', 'Tools'
  ];

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GardenTipsPageModel());
  }

  @override
  void dispose() {
    _model.dispose();
    _searchController.dispose();
    super.dispose();
  }

  String get _level =>
      widget.experienceLevel?.isNotEmpty == true
          ? widget.experienceLevel!
          : 'Beginner';

  List<_Tip> get _filteredTips {
    // Show tips for user's level first, then others
    final myLevelTips =
        _allTips.where((t) => t.levels.contains(_level)).toList();
    final otherTips =
        _allTips.where((t) => !t.levels.contains(_level)).toList();
    final ordered = [...myLevelTips, ...otherTips];

    return ordered.where((t) {
      final matchesCategory = _selectedCategory == null ||
          _selectedCategory == 'All' ||
          t.category == _selectedCategory;
      final matchesSearch = _searchQuery.isEmpty ||
          t.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          t.detail.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          t.category.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  void _showTipDetail(BuildContext context, _Tip tip) {
    final theme = FlutterFlowTheme.of(context);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        margin: const EdgeInsets.only(top: 80.0),
        decoration: BoxDecoration(
          color: theme.secondaryBackground,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24.0)),
          border: Border.all(color: theme.alternate),
        ),
        child: SafeArea(
          top: false,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40, height: 4,
                    decoration: BoxDecoration(
                      color: theme.secondaryText.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 44.0, height: 44.0,
                      decoration: BoxDecoration(
                        color: tip.color.withOpacity(0.15),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(tip.icon, color: tip.color, size: 22.0),
                    ),
                    const SizedBox(width: 14.0),
                    Expanded(
                      child: Text(
                        tip.title,
                        style: GoogleFonts.poppins(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w600,
                          color: theme.primaryText,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: tip.color.withOpacity(0.07),
                    borderRadius: BorderRadius.circular(16.0),
                    border: Border.all(color: tip.color.withOpacity(0.15)),
                  ),
                  child: Text(
                    tip.detail,
                    style: GoogleFonts.poppins(
                      fontSize: 14.0,
                      height: 1.6,
                      color: theme.primaryText,
                    ),
                  ),
                ),
                const SizedBox(height: 12.0),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 4.0),
                  decoration: BoxDecoration(
                    color: tip.color.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Text(tip.category,
                      style: GoogleFonts.poppins(
                          fontSize: 11.0,
                          fontWeight: FontWeight.w600,
                          color: tip.color)),
                ),
                const SizedBox(height: 8.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();
    final theme = FlutterFlowTheme.of(context);
    final tips = _filteredTips;

    final levelColor = _level == 'Advanced'
        ? const Color(0xFF9C6EA3)
        : _level == 'Intermediate'
            ? const Color(0xFFE0A43A)
            : const Color(0xFF4A90A4);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: theme.primaryBackground,
        body: Column(
          children: [
            wrapWithModel(
              model: _model.finalHeaderModel,
              updateCallback: () => safeSetState(() {}),
              child: FinalHeaderWidget(
                pageTitle: 'Tips & Hacks',
                menuReplaceBackAction: () => context.pop(),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  // Search bar
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
                    child: TextField(
                      controller: _searchController,
                      onChanged: (v) =>
                          setState(() => _searchQuery = v),
                      decoration: InputDecoration(
                        hintText: 'Search tips…',
                        hintStyle: GoogleFonts.poppins(
                            color: theme.secondaryText),
                        prefixIcon: Icon(Icons.search_rounded,
                            color: theme.secondaryText),
                        suffixIcon: _searchQuery.isNotEmpty
                            ? IconButton(
                                icon: Icon(Icons.clear_rounded,
                                    color: theme.secondaryText),
                                onPressed: () {
                                  _searchController.clear();
                                  setState(() => _searchQuery = '');
                                },
                              )
                            : null,
                        filled: true,
                        fillColor: theme.secondaryBackground,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 12.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                          borderSide:
                              BorderSide(color: theme.alternate),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                          borderSide:
                              BorderSide(color: theme.alternate),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                          borderSide: BorderSide(
                              color: theme.primary, width: 1.5),
                        ),
                      ),
                      style: GoogleFonts.poppins(color: theme.primaryText),
                    ),
                  ),
                  // Level badge + category filter
                  Padding(
                    padding:
                        const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 8.0),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 4.0),
                          decoration: BoxDecoration(
                            color: levelColor.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.person_rounded,
                                  color: levelColor, size: 13.0),
                              const SizedBox(width: 4.0),
                              Text(_level,
                                  style: GoogleFonts.poppins(
                                      fontSize: 11.0,
                                      fontWeight: FontWeight.w600,
                                      color: levelColor)),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        Text('level tips shown first',
                            style: GoogleFonts.poppins(
                                fontSize: 11.0,
                                color: theme.secondaryText)),
                      ],
                    ),
                  ),
                  // Category chips
                  SizedBox(
                    height: 36.0,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding:
                          const EdgeInsets.symmetric(horizontal: 16.0),
                      itemCount: _categories.length,
                      separatorBuilder: (_, __) =>
                          const SizedBox(width: 6.0),
                      itemBuilder: (context, i) {
                        final cat = _categories[i];
                        final selected = (_selectedCategory ?? 'All') == cat;
                        return GestureDetector(
                          onTap: () => setState(() =>
                              _selectedCategory = cat == 'All' ? null : cat),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 6.0),
                            decoration: BoxDecoration(
                              color: selected
                                  ? theme.primary
                                  : theme.secondaryBackground,
                              borderRadius: BorderRadius.circular(16.0),
                              border: Border.all(
                                color: selected
                                    ? theme.primary
                                    : theme.alternate,
                              ),
                            ),
                            child: Text(
                              cat,
                              style: GoogleFonts.poppins(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500,
                                color: selected
                                    ? Colors.white
                                    : theme.primaryText,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  // Tip count
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        Text(
                          '${tips.length} tip${tips.length == 1 ? '' : 's'}',
                          style: GoogleFonts.poppins(
                              fontSize: 12.0,
                              color: theme.secondaryText),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 6.0),
                  // Tips list
                  Expanded(
                    child: tips.isEmpty
                        ? Center(
                            child: Text('No tips match your search.',
                                style: GoogleFonts.poppins(
                                    color: theme.secondaryText)),
                          )
                        : ListView.separated(
                            padding: const EdgeInsets.fromLTRB(
                                16.0, 0.0, 16.0, 40.0),
                            itemCount: tips.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(height: 8.0),
                            itemBuilder: (context, i) {
                              final tip = tips[i];
                              final isMyLevel = tip.levels.contains(_level);
                              return GestureDetector(
                                onTap: () =>
                                    _showTipDetail(context, tip),
                                child: Container(
                                  padding: const EdgeInsets.all(14.0),
                                  decoration: BoxDecoration(
                                    color: tip.color.withOpacity(0.07),
                                    borderRadius:
                                        BorderRadius.circular(14.0),
                                    border: Border.all(
                                        color: tip.color.withOpacity(0.2)),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 36.0,
                                        height: 36.0,
                                        decoration: BoxDecoration(
                                          color: tip.color.withOpacity(0.15),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(tip.icon,
                                            color: tip.color, size: 18.0),
                                      ),
                                      const SizedBox(width: 12.0),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              tip.title,
                                              style: GoogleFonts.poppins(
                                                fontSize: 13.0,
                                                height: 1.4,
                                                fontWeight: FontWeight.w500,
                                                color: theme.primaryText,
                                              ),
                                            ),
                                            const SizedBox(height: 4.0),
                                            Row(
                                              children: [
                                                Container(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                          horizontal: 7.0,
                                                          vertical: 2.0),
                                                  decoration: BoxDecoration(
                                                    color: tip.color
                                                        .withOpacity(0.12),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                  child: Text(tip.category,
                                                      style:
                                                          GoogleFonts.poppins(
                                                        fontSize: 10.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: tip.color,
                                                      )),
                                                ),
                                                if (!isMyLevel) ...[
                                                  const SizedBox(width: 5.0),
                                                  Text(
                                                    tip.levels.first,
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 10.0,
                                                        color:
                                                            theme.secondaryText),
                                                  ),
                                                ],
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Icon(Icons.chevron_right_rounded,
                                          color: tip.color, size: 18.0),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Plant image helper
//
// All 154 plants in the Supabase database have unique, plant-specific Unsplash
// image URLs in the image_url column.  We use those directly — no local
// fallback map is needed.
//
// Unsplash allows hotlinking from Flutter iOS/Android apps (no browser
// User-Agent/Referer required), so these load fine on-device.
// ─────────────────────────────────────────────────────────────────────────────

/// Returns the best image URL for a plant card.
///
/// Uses the plant's own [supabaseUrl] from the DB (always an Unsplash URL for
/// all current plants).  Falls back to a generic plant photo only if the DB
/// value is missing or from an unrecognised host.
String? bestPlantImageUrl(String? supabaseUrl, String? plantName) {
  // Use the plant's own DB image (Unsplash — loads fine in Flutter apps).
  if (supabaseUrl != null &&
      supabaseUrl.isNotEmpty &&
      (supabaseUrl.contains('images.unsplash.com') ||
       supabaseUrl.contains('supabase.co/storage'))) {
    return supabaseUrl;
  }

  // Generic plant fallback — ensures no card ever shows an emoji placeholder.
  return 'https://images.unsplash.com/photo-1416879595882-3373a0480b5b'
      '?w=600&auto=format&fit=crop&q=80';
}

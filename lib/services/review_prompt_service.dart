import 'package:flutter/foundation.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Asks for an App Store rating, but only after the app has actually done
/// something useful for this person.
///
/// iOS decides for itself whether to show the sheet and silently caps it at
/// three prompts per year per device, so a request that lands at a bad moment
/// is a wasted one out of three. The gate below spends them carefully:
///
///   * only after [_delightsNeeded] good moments (a successful scan, a garden
///     built) - never on first launch, never after an error or a paywall;
///   * not in the first [_minDaysInstalled] days;
///   * at most once every [_cooldownDays].
///
/// Call [registerDelight] at the moment something goes right. It records the
/// moment and asks only when every condition above is met.
class ReviewPromptService {
  ReviewPromptService._();
  static final ReviewPromptService instance = ReviewPromptService._();

  static const _kFirstSeen = 'review_first_seen';
  static const _kDelights = 'review_delight_count';
  static const _kLastAsked = 'review_last_asked';

  static const _delightsNeeded = 3;
  static const _minDaysInstalled = 2;
  static const _cooldownDays = 120;

  final _review = InAppReview.instance;

  /// Records a moment that went well and asks for a review if it's time.
  ///
  /// [settleDelay] holds the request back until the screen has finished
  /// animating - the native sheet is dismissed as an accident if it lands
  /// mid-transition.
  Future<void> registerDelight({
    Duration settleDelay = const Duration(milliseconds: 1200),
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final now = DateTime.now();

      final firstSeen =
          DateTime.tryParse(prefs.getString(_kFirstSeen) ?? '') ?? now;
      if (prefs.getString(_kFirstSeen) == null) {
        await prefs.setString(_kFirstSeen, now.toIso8601String());
      }

      final delights = (prefs.getInt(_kDelights) ?? 0) + 1;
      await prefs.setInt(_kDelights, delights);

      if (delights < _delightsNeeded) return;
      if (now.difference(firstSeen).inDays < _minDaysInstalled) return;

      final lastAsked = DateTime.tryParse(prefs.getString(_kLastAsked) ?? '');
      if (lastAsked != null &&
          now.difference(lastAsked).inDays < _cooldownDays) {
        return;
      }

      if (!await _review.isAvailable()) return;

      await Future.delayed(settleDelay);
      await _review.requestReview();
      await prefs.setString(_kLastAsked, now.toIso8601String());
    } catch (e) {
      // A rating prompt is never worth interrupting the app for.
      debugPrint('ReviewPromptService: $e');
    }
  }

  /// Opens the App Store review sheet directly. For an explicit "Rate us"
  /// tap, where the person has already chosen to leave a review.
  Future<void> openStoreListing() async {
    try {
      await _review.openStoreListing(appStoreId: '6785081475');
    } catch (e) {
      debugPrint('ReviewPromptService: $e');
    }
  }
}

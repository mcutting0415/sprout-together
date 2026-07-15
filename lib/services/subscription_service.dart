import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

/// Central service for managing RevenueCat subscriptions.
///
/// SETUP REQUIRED (one-time, before going live):
/// 1. Create a RevenueCat account at https://app.revenuecat.com
/// 2. Add your iOS app and copy the Public SDK Key into [_iosApiKey] below.
/// 3. In App Store Connect create two auto-renewable subscription products:
///      - Product ID: com.sprout.together.premium.monthly  ($7.99/month)
///      - Product ID: com.sprout.together.premium.annual   ($49.99/year)
/// 4. In RevenueCat:
///      - Create an Entitlement named "premium" containing both products.
///      - Create a default Offering that includes a monthly and annual Package.
class SubscriptionService {
  // ── Replace with your RevenueCat iOS Public SDK Key ──────────────────
  static const String _iosApiKey = 'appl_XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX';
  // ─────────────────────────────────────────────────────────────────────

  /// The RevenueCat entitlement identifier to check for premium access.
  static const String entitlementId = 'premium';

  static SubscriptionService? _instance;
  static SubscriptionService get instance =>
      _instance ??= SubscriptionService._();
  SubscriptionService._();

  bool _initialized = false;

  /// Call once from main() after SupaFlow.initialize().
  Future<void> initialize() async {
    if (_initialized) return;
    if (kIsWeb) return; // RevenueCat is not supported on web

    await Purchases.setLogLevel(LogLevel.debug);

    if (Platform.isIOS || Platform.isMacOS) {
      await Purchases.configure(PurchasesConfiguration(_iosApiKey));
    } else {
      // Android key can be added here when targeting Google Play
      return;
    }

    _initialized = true;
  }

  /// Returns true if the current user has an active premium entitlement.
  Future<bool> isPremium() async {
    if (!_initialized) return false;
    try {
      final info = await Purchases.getCustomerInfo();
      return info.entitlements.active.containsKey(entitlementId);
    } catch (e) {
      debugPrint('SubscriptionService.isPremium error: $e');
      return false;
    }
  }

  /// Fetches the current RevenueCat Offerings (subscription packages).
  Future<Offerings?> getOfferings() async {
    if (!_initialized) return null;
    try {
      return await Purchases.getOfferings();
    } catch (e) {
      debugPrint('SubscriptionService.getOfferings error: $e');
      return null;
    }
  }

  /// Initiates a purchase for [package]. Returns true on success.
  Future<bool> purchasePackage(Package package) async {
    if (!_initialized) return false;
    try {
      final info = await Purchases.purchasePackage(package);
      return info.entitlements.active.containsKey(entitlementId);
    } on PurchasesErrorCode catch (e) {
      if (e == PurchasesErrorCode.purchaseCancelledError) return false;
      debugPrint('SubscriptionService.purchasePackage error: $e');
      return false;
    } catch (e) {
      debugPrint('SubscriptionService.purchasePackage error: $e');
      return false;
    }
  }

  /// Restores previous App Store purchases.
  /// Returns true if the user now has an active premium entitlement.
  Future<bool> restorePurchases() async {
    if (!_initialized) return false;
    try {
      final info = await Purchases.restorePurchases();
      return info.entitlements.active.containsKey(entitlementId);
    } catch (e) {
      debugPrint('SubscriptionService.restorePurchases error: $e');
      return false;
    }
  }
}

<<<<<<< HEAD
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

/// Entitlement and product IDs — must match App Store Connect & RevenueCat exactly.
const String _entitlementId = 'SproutTogether Pro';
const String _monthlyProductId = 'com.sprouttogether.app.monthly';
const String _yearlyProductId = 'com.sprouttogether.app.yearly';

/// Replace with your RevenueCat iOS Public App-Specific API Key.
/// Found in RevenueCat dashboard → Project → API Keys → Public app-specific key.
const String _revenueCatApiKey = 'appl_vIKJsNFleJMSDrVpsrtQfinKQDy';

class SubscriptionService extends ChangeNotifier {
  static final SubscriptionService _instance = SubscriptionService._();
  static SubscriptionService get instance => _instance;
  SubscriptionService._();

  bool _isPro = false;
  CustomerInfo? _customerInfo;
  List<Package> _packages = [];
  bool _isLoading = false;
  String? _errorMessage;

  bool get isPro => _isPro;
  CustomerInfo? get customerInfo => _customerInfo;
  List<Package> get packages => _packages;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Package? get monthlyPackage => _packages.firstWhereOrNull(
      (p) => p.storeProduct.productIdentifier == _monthlyProductId);

  Package? get yearlyPackage => _packages.firstWhereOrNull(
      (p) => p.storeProduct.productIdentifier == _yearlyProductId);

  /// Call once in main() before runApp.
  Future<void> initialize() async {
    try {
      await Purchases.setLogLevel(LogLevel.warn);

      final config = PurchasesConfiguration(_revenueCatApiKey);
      await Purchases.configure(config);

      // Listen for updates in real-time
      Purchases.addCustomerInfoUpdateListener((info) {
        _updateFromCustomerInfo(info);
        notifyListeners();
      });

      // Fetch current status
      final info = await Purchases.getCustomerInfo();
      _updateFromCustomerInfo(info);
    } catch (e) {
      debugPrint('[SubscriptionService] init error: $e');
    }
  }

  void _updateFromCustomerInfo(CustomerInfo info) {
    _customerInfo = info;
    _isPro = info.entitlements.active.containsKey(_entitlementId);
  }

  /// Load available packages from RevenueCat (stores result internally).
  Future<void> loadOfferings() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final offerings = await Purchases.getOfferings();
      final current = offerings.current;
      if (current != null) {
        _packages = current.availablePackages;
      }
    } catch (e) {
      _errorMessage = 'Unable to load subscription options. Please try again.';
      debugPrint('[SubscriptionService] loadOfferings error: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Fetch and return the full Offerings object directly (used by PaywallWidget).
  Future<Offerings?> getOfferings() async {
    try {
      return await Purchases.getOfferings();
    } catch (e) {
      debugPrint('[SubscriptionService] getOfferings error: $e');
      return null;
    }
  }

  /// Purchase a package by direct reference (alias used by PaywallWidget).
  Future<bool> purchasePackage(Package package) => purchase(package);

  /// Purchase a package. Returns true on success.
  Future<bool> purchase(Package package) async {
    try {
      final result = await Purchases.purchasePackage(package);
      _updateFromCustomerInfo(result.customerInfo);
      notifyListeners();
      return _isPro;
    } on PurchasesErrorCode catch (e) {
      if (e == PurchasesErrorCode.purchaseCancelledError) {
        // User cancelled — not an error
        return false;
      }
      _errorMessage = 'Purchase failed. Please try again.';
      notifyListeners();
      return false;
    } catch (e) {
      _errorMessage = 'Purchase failed. Please try again.';
      notifyListeners();
=======
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
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
  // ── Replace with your RevenueCat iOS Public SDK Key ────────────────────
  static const String _iosApiKey = 'appl_vIKJsNFleJMSDrVpsrtQfinKQDy';
  // ────────────────────────────────────────────────────────────────────

  /// The RevenueCat entitlement identifier to check for premium access.
  static const String entitlementId = 'SproutTogether Pro';

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
      Purchases.addCustomerInfoUpdateListener((info) {
        // Subscription status changed in background (renewal, expiry, cancellation)
        debugPrint('[SubscriptionService] CustomerInfo updated: ${info.entitlements.active.keys}');
      });
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
      // ignore: deprecated_member_use
      await Purchases.purchasePackage(package);
      final info = await Purchases.getCustomerInfo();
      return info.entitlements.active.containsKey(entitlementId);
    } on PlatformException catch (e) {
      if (PurchasesErrorHelper.getErrorCode(e) ==
          PurchasesErrorCode.purchaseCancelledError) {
        return false;
      }
      debugPrint('SubscriptionService.purchasePackage error: $e');
      return false;
    } catch (e) {
      debugPrint('SubscriptionService.purchasePackage error: $e');
>>>>>>> 7515dc7ca32fe6b8f2fa1a4d979590646dab74c5
      return false;
    }
  }

<<<<<<< HEAD
  /// Restore previous purchases.
  Future<bool> restorePurchases() async {
    try {
      final info = await Purchases.restorePurchases();
      _updateFromCustomerInfo(info);
      notifyListeners();
      return _isPro;
    } catch (e) {
      _errorMessage = 'Restore failed. Please try again.';
      notifyListeners();
=======
  /// Restores previous App Store purchases.
  /// Returns true if the user now has an active premium entitlement.
  Future<bool> restorePurchases() async {
    if (!_initialized) return false;
    try {
      final info = await Purchases.restorePurchases();
      return info.entitlements.active.containsKey(entitlementId);
    } catch (e) {
      debugPrint('SubscriptionService.restorePurchases error: $e');
>>>>>>> 7515dc7ca32fe6b8f2fa1a4d979590646dab74c5
      return false;
    }
  }

<<<<<<< HEAD
  /// Refresh customer info from RevenueCat.
  Future<void> refresh() async {
    try {
      final info = await Purchases.getCustomerInfo();
      _updateFromCustomerInfo(info);
      notifyListeners();
    } catch (e) {
      debugPrint('[SubscriptionService] refresh error: $e');
    }
  }
}

extension _ListExtension<T> on List<T> {
  T? firstWhereOrNull(bool Function(T) test) {
    for (final element in this) {
      if (test(element)) return element;
    }
    return null;
=======
  /// Links the RevenueCat anonymous identity to the authenticated Supabase user.
  Future<void> loginUser(String userId) async {
    try {
      await Purchases.logIn(userId);
      debugPrint('[SubscriptionService] Logged in user: $userId');
    } catch (e) {
      debugPrint('[SubscriptionService] Error logging in user: $e');
    }
  }

  /// Resets RevenueCat identity on Supabase sign-out.
  Future<void> logoutUser() async {
    try {
      await Purchases.logOut();
      debugPrint('[SubscriptionService] Logged out RevenueCat user');
    } catch (e) {
      debugPrint('[SubscriptionService] Error logging out user: $e');
    }
>>>>>>> 7515dc7ca32fe6b8f2fa1a4d979590646dab74c5
  }
}

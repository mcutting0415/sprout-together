import '/backend/supabase/supabase.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
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
      (p) => p.storeProduct.identifier == _monthlyProductId);

  Package? get yearlyPackage => _packages.firstWhereOrNull(
      (p) => p.storeProduct.identifier == _yearlyProductId);

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

      // Re-link the RevenueCat identity to the signed-in Supabase user.
      //
      // loginUser() is otherwise only called from the login and sign-up pages,
      // so a restored session — which is what happens on almost every launch —
      // left RevenueCat on its anonymous id. Anything keyed on the Supabase
      // user id then failed to find the customer, including the server-side
      // entitlement check in the plant-scan edge function, which would deny a
      // paying subscriber. Purchases.logIn is a no-op when the id already
      // matches, so this is safe to run on every start.
      final currentUserId = SupaFlow.client.auth.currentUser?.id;
      if (currentUserId != null && currentUserId.isNotEmpty) {
        await Purchases.logIn(currentUserId);
      }

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
      _updateFromCustomerInfo(result);
      notifyListeners();
      return _isPro;
    } on PlatformException catch (e) {
      final code = PurchasesErrorHelper.getErrorCode(e);
      if (code == PurchasesErrorCode.purchaseCancelledError) {
        // User cancelled — not an error, don't show a message.
        return false;
      }
      _errorMessage = 'Purchase failed. Please try again.';
      notifyListeners();
      return false;
    } catch (e) {
      _errorMessage = 'Purchase failed. Please try again.';
      notifyListeners();
      return false;
    }
  }

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
      return false;
    }
  }

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

  /// Links the RevenueCat anonymous identity to the authenticated Supabase user.
  /// Call this after a successful sign-in.
  Future<void> loginUser(String userId) async {
    try {
      await Purchases.logIn(userId);
      await refresh();
      debugPrint('[SubscriptionService] Logged in RevenueCat user: $userId');
    } catch (e) {
      debugPrint('[SubscriptionService] loginUser error: $e');
    }
  }

  /// Resets RevenueCat identity on sign-out.
  Future<void> logoutUser() async {
    try {
      await Purchases.logOut();
      _isPro = false;
      notifyListeners();
      debugPrint('[SubscriptionService] Logged out RevenueCat user');
    } catch (e) {
      debugPrint('[SubscriptionService] logoutUser error: $e');
    }
  }
}

extension _ListExtension<T> on List<T> {
  T? firstWhereOrNull(bool Function(T) test) {
    for (final element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}

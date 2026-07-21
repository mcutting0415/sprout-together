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

  /// Load available packages from RevenueCat.
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
}

extension _ListExtension<T> on List<T> {
  T? firstWhereOrNull(bool Function(T) test) {
    for (final element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}

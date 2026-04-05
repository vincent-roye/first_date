import 'package:purchases_flutter/purchases_flutter.dart';

class RevenueCatService {
  static const String _apiKey = "YOUR_REVENUECAT_API_KEY";
  static const String _entitlementId = "premium";
  
  static const String _productIdOneTime = "first_date_lifetime";
  static const String _productIdSubscription = "first_date_monthly";

  static Future<void> init() async {
    await Purchases.setLogLevel(LogLevel.debug);
    await Purchases.configure(PurchasesConfiguration(_apiKey));
  }

  static Future<bool> isPremium() async {
    try {
      final customerInfo = await Purchases.getCustomerInfo();
      return customerInfo.entitlements.active.containsKey(_entitlementId);
    } catch (e) {
      return false;
    }
  }

  static Future<void> purchaseOneTime() async {
    try {
      final package = await _getPackage(_productIdOneTime);
      if (package != null) {
        await Purchases.purchasePackage(package);
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> purchaseSubscription() async {
    try {
      final package = await _getPackage(_productIdSubscription);
      if (package != null) {
        await Purchases.purchasePackage(package);
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<Package?> _getPackage(String productId) async {
    try {
      final offerings = await Purchases.getOfferings();
      final current = offerings.current;
      if (current != null) {
        return current.availablePackages.firstWhere(
          (p) => p.storeProduct.identifier == productId,
          orElse: () => current.availablePackages.first,
        );
      }
    } catch (e) {
      // ignore
    }
    return null;
  }

  static Future<void> restorePurchases() async {
    await Purchases.restorePurchases();
  }
}

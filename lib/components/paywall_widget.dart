import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/services/subscription_service.dart';

/// Full-screen paywall shown when user taps "Upgrade to Pro" or tries to
/// access a premium feature. Displays monthly and yearly plans side-by-side.
class PaywallWidget extends StatefulWidget {
  /// Optional callback after a successful purchase.
  final VoidCallback? onSuccess;

  const PaywallWidget({super.key, this.onSuccess});

  @override
  State<PaywallWidget> createState() => _PaywallWidgetState();
}

class _PaywallWidgetState extends State<PaywallWidget> {
  bool _selectedYearly = true; // Default to yearly (best value)
  bool _purchasing = false;
  bool _restoring = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadOfferings();
  }

  Future<void> _loadOfferings() async {
    await SubscriptionService.instance.loadOfferings();
    if (mounted) setState(() {});
  }

  Package? get _selectedPackage => _selectedYearly
      ? SubscriptionService.instance.yearlyPackage
      : SubscriptionService.instance.monthlyPackage;

  Future<void> _handlePurchase() async {
    final pkg = _selectedPackage;
    if (pkg == null) return;

    setState(() {
      _purchasing = true;
      _error = null;
    });

    final success = await SubscriptionService.instance.purchase(pkg);

    if (!mounted) return;
    setState(() => _purchasing = false);

    if (success) {
      widget.onSuccess?.call();
      Navigator.of(context).pop(true);
    } else {
      final err = SubscriptionService.instance.errorMessage;
      if (err != null) setState(() => _error = err);
    }
  }

  Future<void> _handleRestore() async {
    setState(() {
      _restoring = true;
      _error = null;
    });

    final success = await SubscriptionService.instance.restorePurchases();

    if (!mounted) return;
    setState(() => _restoring = false);

    if (success) {
      widget.onSuccess?.call();
      Navigator.of(context).pop(true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('No previous purchases found.',
              style: GoogleFonts.poppins()),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final service = SubscriptionService.instance;
    final monthlyPkg = service.monthlyPackage;
    final yearlyPkg = service.yearlyPackage;

    // Monthly price string
    final monthlyPrice = monthlyPkg != null
        ? monthlyPkg.storeProduct.priceString
        : '\$7.99';

    // Yearly price string and per-month equivalent
    final yearlyPrice = yearlyPkg != null
        ? yearlyPkg.storeProduct.priceString
        : '\$49.99';

    // Calculate monthly equivalent for yearly (divide by 12)
    final yearlyMonthlyEquiv = yearlyPkg != null
        ? '\$${(yearlyPkg.storeProduct.price / 12).toStringAsFixed(2)}/mo'
        : '\$4.17/mo';

    // Savings percentage
    final monthlyCostPerYear = monthlyPkg != null
        ? monthlyPkg.storeProduct.price * 12
        : 95.88;
    final yearlyActual = yearlyPkg != null ? yearlyPkg.storeProduct.price : 49.99;
    final savingsPct = monthlyCostPerYear > 0
        ? (((monthlyCostPerYear - yearlyActual) / monthlyCostPerYear) * 100)
            .round()
        : 48;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F8F0),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // ── Header ──────────────────────────────────────────────────
              _buildHeader(context),

              // ── Hero ─────────────────────────────────────────────────────
              _buildHero(context),

              // ── Features ─────────────────────────────────────────────────
              _buildFeatureList(context),

              const SizedBox(height: 24),

              // ── Plan Selector ─────────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    _buildPlanCard(
                      context,
                      label: 'Yearly',
                      sublabel: yearlyMonthlyEquiv,
                      price: yearlyPrice,
                      badge: 'Save $savingsPct%',
                      selected: _selectedYearly,
                      onTap: () => setState(() => _selectedYearly = true),
                    ),
                    const SizedBox(height: 12),
                    _buildPlanCard(
                      context,
                      label: 'Monthly',
                      sublabel: 'Billed monthly',
                      price: '$monthlyPrice/mo',
                      selected: !_selectedYearly,
                      onTap: () => setState(() => _selectedYearly = false),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // ── Error ─────────────────────────────────────────────────────
              if (_error != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(_error!,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          color: Colors.red, fontSize: 13)),
                ),

              // ── CTA Button ────────────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    onPressed: _purchasing || service.isLoading
                        ? null
                        : _handlePurchase,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6F8F72),
                      foregroundColor: Colors.white,
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                    ),
                    child: _purchasing
                        ? const SizedBox(
                            height: 22,
                            width: 22,
                            child: CircularProgressIndicator(
                                color: Colors.white, strokeWidth: 2.5))
                        : Text(
                            _selectedYearly
                                ? 'Start Growing — $yearlyPrice/year'
                                : 'Start Growing — $monthlyPrice/month',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // ── Restore & Fine Print ──────────────────────────────────────
              TextButton(
                onPressed: _restoring ? null : _handleRestore,
                child: _restoring
                    ? const SizedBox(
                        height: 16,
                        width: 16,
                        child: CircularProgressIndicator(
                            color: Color(0xFF6F8F72), strokeWidth: 2))
                    : Text('Restore Purchases',
                        style: GoogleFonts.poppins(
                            color: const Color(0xFF6F8F72),
                            fontSize: 13,
                            fontWeight: FontWeight.w500)),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                child: Text(
                  'Subscriptions auto-renew unless cancelled at least 24 hours before the period ends. '
                  'Manage or cancel anytime in App Store Settings.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontSize: 11,
                      color: Colors.grey.shade500),
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.close_rounded),
            color: Colors.grey.shade600,
            onPressed: () => Navigator.of(context).pop(false),
          ),
        ],
      ),
    );
  }

  Widget _buildHero(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
      child: Column(
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: const Color(0x1A6F8F72),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(Icons.eco_rounded,
                color: Color(0xFF6F8F72), size: 40),
          ),
          const SizedBox(height: 16),
          Text(
            'SproutTogether Pro',
            style: GoogleFonts.poppins(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF2D4A2D)),
          ),
          const SizedBox(height: 8),
          Text(
            'Everything you need to grow a thriving garden, all season long.',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureList(BuildContext context) {
    final features = [
      (Icons.calendar_today_rounded, 'Personalized Planting Calendar',
          'Get frost-date-aware schedules for your exact location'),
      (Icons.local_florist_rounded, 'Full Plant Library',
          'Access 200+ plants with deep growing guides'),
      (Icons.swap_horiz_rounded, 'Companion Planting AI',
          'Know exactly which plants help — and hurt — each other'),
      (Icons.notifications_active_rounded, 'Smart Garden Reminders',
          'Watering, harvest, frost warnings & more'),
      (Icons.inventory_2_rounded, 'Seed Inventory Tracker',
          'Manage your seed collection and plan next season'),
      (Icons.book_rounded, 'Garden Journal',
          'Track progress, photos, and notes season-by-season'),
    ];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 12,
              offset: const Offset(0, 4))
        ],
      ),
      child: Column(
        children: features
            .map((f) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: const Color(0x1A6F8F72),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(f.$1,
                            color: const Color(0xFF6F8F72), size: 18),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(f.$2,
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13.5)),
                            Text(f.$3,
                                style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: Colors.grey.shade600)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildPlanCard(
    BuildContext context, {
    required String label,
    required String sublabel,
    required String price,
    String? badge,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFE8F0E9) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected ? const Color(0xFF6F8F72) : Colors.grey.shade300,
            width: selected ? 2 : 1,
          ),
          boxShadow: selected
              ? [
                  BoxShadow(
                      color: const Color(0xFF6F8F72).withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 2))
                ]
              : [],
        ),
        child: Row(
          children: [
            // Radio circle
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected
                      ? const Color(0xFF6F8F72)
                      : Colors.grey.shade400,
                  width: 2,
                ),
              ),
              child: selected
                  ? Center(
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF6F8F72),
                        ),
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 14),

            // Plan name & sublabel
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label,
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: const Color(0xFF2D4A2D))),
                  Text(sublabel,
                      style: GoogleFonts.poppins(
                          fontSize: 12, color: Colors.grey.shade600)),
                ],
              ),
            ),

            // Badge + price
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (badge != null)
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFF6F8F72),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(badge,
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold)),
                  ),
                if (badge != null) const SizedBox(height: 4),
                Text(price,
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: const Color(0xFF2D4A2D))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

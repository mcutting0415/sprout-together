import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/services/subscription_service.dart';

/// Full-screen paywall shown when a user tries to access a premium feature
/// or taps "Manage Subscription" in Settings.
///
/// Returns true via Navigator.pop if the user successfully subscribes.
class PaywallWidget extends StatefulWidget {
  const PaywallWidget({super.key});

  static const String routeName = 'Paywall';
  static const String routePath = '/paywall';

  @override
  State<PaywallWidget> createState() => _PaywallWidgetState();
}

class _PaywallWidgetState extends State<PaywallWidget> {
  Offerings? _offerings;
  bool _loading = true;
  bool _busy = false;
  Package? _selected;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final offerings = await SubscriptionService.instance.getOfferings();
    if (!mounted) return;
    setState(() {
      _offerings = offerings;
      _loading = false;
      final cur = offerings?.current;
      _selected = cur?.annual ?? cur?.availablePackages.firstOrNull;
    });
  }

  Future<void> _buy() async {
    if (_selected == null || _busy) return;
    setState(() => _busy = true);
    final ok = await SubscriptionService.instance.purchasePackage(_selected!);
    if (!mounted) return;
    setState(() => _busy = false);
    if (ok) {
      _showSnack('Welcome to SproutTogether Premium! 🌱', success: true);
      Navigator.of(context).pop(true);
    }
  }

  Future<void> _restore() async {
    if (_busy) return;
    setState(() => _busy = true);
    final ok = await SubscriptionService.instance.restorePurchases();
    if (!mounted) return;
    setState(() => _busy = false);
    if (ok) {
      _showSnack('Purchases restored! Welcome back. 🌿', success: true);
      Navigator.of(context).pop(true);
    } else {
      _showSnack('No purchases found to restore.', success: false);
    }
  }

  void _showSnack(String msg, {required bool success}) {
    final theme = FlutterFlowTheme.of(context);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg, style: GoogleFonts.poppins()),
      backgroundColor: success ? theme.primary : theme.secondaryText,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    final cur = _offerings?.current;
    final monthly = cur?.monthly;
    final annual = cur?.annual;

    return Scaffold(
      backgroundColor: theme.primaryBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Close
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: Icon(Icons.close_rounded, color: theme.secondaryText),
                    onPressed: () => Navigator.of(context).pop(false),
                  ),
                ),
                // Hero icon
                Center(
                  child: Container(
                    width: 88,
                    height: 88,
                    decoration: BoxDecoration(
                      color: const Color(0x206F8F72),
                      borderRadius: BorderRadius.circular(28),
                    ),
                    child: Icon(Icons.eco_rounded, color: theme.primary, size: 48),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'SproutTogether Premium',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: theme.primaryText,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Unlock the full gardening experience',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: theme.secondaryText,
                  ),
                ),
                const SizedBox(height: 28),

                // Feature list
                ..._kFeatures.map((f) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 7),
                      child: Row(
                        children: [
                          Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: const Color(0x206F8F72),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(f.icon, color: theme.primary, size: 20),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Text(f.label,
                                style: GoogleFonts.poppins(
                                    fontSize: 14, color: theme.primaryText)),
                          ),
                        ],
                      ),
                    )),
                const SizedBox(height: 28),

                // Plan cards
                if (_loading)
                  const Center(child: CircularProgressIndicator())
                else if (cur == null)
                  Text(
                    'Subscriptions unavailable. Please try again later.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(color: theme.secondaryText),
                  )
                else ...[
                  if (annual != null)
                    _PlanTile(
                      pkg: annual,
                      isSelected: _selected == annual,
                      badge: 'BEST VALUE',
                      subtitle: _annualSub(annual),
                      onTap: () => setState(() => _selected = annual),
                    ),
                  const SizedBox(height: 12),
                  if (monthly != null)
                    _PlanTile(
                      pkg: monthly,
                      isSelected: _selected == monthly,
                      badge: null,
                      subtitle: 'Billed monthly',
                      onTap: () => setState(() => _selected = monthly),
                    ),
                  const SizedBox(height: 28),

                  // CTA
                  SizedBox(
                    height: 54,
                    child: ElevatedButton(
                      onPressed: _busy ? null : _buy,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.primary,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                      ),
                      child: _busy
                          ? const SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(
                                  color: Colors.white, strokeWidth: 2))
                          : Text(
                              _selected == annual
                                  ? 'Start Growing — $49.99 / year'
                                  : 'Start Growing — $7.99 / month',
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600, fontSize: 16)),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: TextButton(
                      onPressed: _busy ? null : _restore,
                      child: Text('Restore Purchases',
                          style: GoogleFonts.poppins(
                              color: theme.secondaryText, fontSize: 13)),
                    ),
                  ),
                ],
                const SizedBox(height: 16),
                Text(
                  'Cancel anytime. Subscription renews automatically. '
                  'Payment charged to your Apple ID at confirmation of purchase.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontSize: 11, color: theme.secondaryText),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _annualSub(Package p) {
    final monthly = p.storeProduct.price / 12;
    return 'Just $${monthly.toStringAsFixed(2)}/mo · billed annually';
  }
}

// ── Plan tile ──────────────────────────────────────────────────────────────

class _PlanTile extends StatelessWidget {
  final Package pkg;
  final bool isSelected;
  final String? badge;
  final String subtitle;
  final VoidCallback onTap;

  const _PlanTile({
    required this.pkg,
    required this.isSelected,
    required this.badge,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        decoration: BoxDecoration(
          color: theme.secondaryBackground,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? theme.primary : theme.alternate,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                      color: theme.primary.withOpacity(0.15),
                      blurRadius: 8,
                      offset: const Offset(0, 2))
                ]
              : [],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 160),
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                    color: isSelected ? theme.primary : theme.secondaryText,
                    width: 2),
                color: isSelected ? theme.primary : Colors.transparent,
              ),
              child: isSelected
                  ? const Icon(Icons.check, color: Colors.white, size: 14)
                  : null,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        pkg.storeProduct.title
                            .replaceAll(RegExp(r'\s*\(.*\)'), ''),
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: theme.primaryText),
                      ),
                      if (badge != null) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: theme.primary,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(badge!,
                              style: GoogleFonts.poppins(
                                  fontSize: 9,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ),
                      ],
                    ],
                  ),
                  Text(subtitle,
                      style: GoogleFonts.poppins(
                          fontSize: 12, color: theme.secondaryText)),
                ],
              ),
            ),
            Text(
              pkg.storeProduct.priceString,
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: theme.primaryText),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Premium features ──────────────────────────────────────────────────────

class _Feat {
  final IconData icon;
  final String label;
  const _Feat(this.icon, this.label);
}

const _kFeatures = [
  _Feat(Icons.yard_rounded, 'Unlimited gardens & planting beds'),
  _Feat(Icons.insights_rounded, 'Advanced plant health insights'),
  _Feat(Icons.calendar_month_rounded, 'Full planting calendar & smart reminders'),
  _Feat(Icons.people_alt_rounded, 'Companion planting recommendations'),
  _Feat(Icons.download_rounded, 'Export & backup your garden data'),
  _Feat(Icons.support_agent_rounded, 'Priority support'),
];

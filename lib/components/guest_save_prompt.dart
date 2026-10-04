import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/final_app_pages/sign_up_page/sign_up_page_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/services/guest_session_service.dart';

/// Invites a guest to put an email on the work they have just done.
///
/// Shown at the moment someone has something worth losing - not on launch,
/// where it would be the signup wall again in a nicer jumper. Dismissing it
/// costs nothing: their garden is already saved to their anonymous account,
/// and an email only protects it across devices and reinstalls.
class GuestSavePrompt extends StatelessWidget {
  const GuestSavePrompt({super.key, required this.reason});

  /// What they just made, e.g. "garden". Used in the body copy.
  final String reason;

  static const _kShownKey = 'guest_save_prompt_shown';

  /// Shows the sheet once per install, and only to a guest.
  ///
  /// Returns true if it was shown, so callers can avoid stacking another
  /// sheet (the rating prompt) on top of it.
  static Future<bool> showOnce(BuildContext context,
      {String reason = 'garden'}) async {
    if (!GuestSessionService.isGuest) return false;
    try {
      final prefs = await SharedPreferences.getInstance();
      if (prefs.getBool(_kShownKey) ?? false) return false;
      await prefs.setBool(_kShownKey, true);
    } catch (_) {
      // If preferences are unavailable, better to ask once than never.
    }
    if (!context.mounted) return false;

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => GuestSavePrompt(reason: reason),
    );
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.primaryBackground,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(22.0)),
      ),
      padding: const EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 28.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40.0,
              height: 4.0,
              margin: const EdgeInsets.only(bottom: 22.0),
              decoration: BoxDecoration(
                color: theme.alternate,
                borderRadius: BorderRadius.circular(2.0),
              ),
            ),
          ),
          Text(
            'Keep your $reason safe',
            style: GoogleFonts.poppins(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
              color: theme.primaryText,
            ),
          ),
          const SizedBox(height: 10.0),
          Text(
            "Your $reason is saved on this phone. Add an email and it follows "
            "you to a new device, survives reinstalling, and can't be lost.",
            style: GoogleFonts.poppins(
              fontSize: 14.5,
              height: 1.5,
              color: theme.secondaryText,
            ),
          ),
          const SizedBox(height: 22.0),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: theme.primary,
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                context.pushNamed(SignUpPageWidget.routeName);
              },
              child: Text(
                'Save my account',
                style: GoogleFonts.poppins(
                  fontSize: 15.5,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 6.0),
          Center(
            child: TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Not now',
                style: GoogleFonts.poppins(
                  fontSize: 14.0,
                  color: theme.secondaryText,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

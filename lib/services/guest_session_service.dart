import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/backend/supabase/supabase.dart';

/// Lets someone use the app before they have an account.
///
/// On first launch we create an *anonymous* Supabase user. It is a real row in
/// `auth.users` with a real uuid and no email, so every query in the app that
/// filters on `currentUserUid` keeps working untouched — there is genuinely a
/// user, they just haven't told us who they are yet.
///
/// When they later add an email we call `updateUser` on that same account
/// rather than signing up a fresh one. Supabase keeps the uuid, so their
/// gardens, plants and journal come with them, and the RevenueCat identity
/// (which is keyed on that uuid) stays correct across the upgrade.
///
/// Requires anonymous sign-ins to be enabled in the Supabase dashboard under
/// Authentication -> Sign In / Providers. If it is off, [ensureSession] fails
/// quietly and the app falls back to showing the sign-up page, which is the
/// behaviour it had before guests existed.
class GuestSessionService {
  GuestSessionService._();

  /// True when someone is signed in but has not given us an email yet.
  ///
  /// Deliberately tested on the email rather than `User.isAnonymous`: it means
  /// exactly what the UI wants to know ("can we still prompt them to save?"),
  /// and it stays correct the moment `updateUser` lands.
  static bool get isGuest {
    final user = SupaFlow.client.auth.currentUser;
    return user != null && (user.email == null || user.email!.isEmpty);
  }

  /// Signs in anonymously if there is no session at all.
  ///
  /// A no-op when a session already exists, so it is safe on every launch.
  /// Returns false if no session could be established - the caller should
  /// then fall back to asking for a real account.
  static Future<bool> ensureSession() async {
    final auth = SupaFlow.client.auth;
    if (auth.currentUser != null) return true;

    // Someone who deliberately signed out wants the sign-in screen on the next
    // launch, not to be quietly dropped into a brand new guest account where
    // their gardens have vanished.
    if (await _guestSessionsSuppressed()) return false;

    try {
      final res = await auth.signInAnonymously();
      final user = res.user;
      if (user == null) return false;

      // Give the guest a profile row so the rest of the app's profile lookups
      // behave the same for them as for a registered user.
      try {
        await ProfilesTable().insert({
          'id': user.id,
          'has_completed_setup': false,
        });
      } catch (e) {
        // A profile may already exist from an earlier launch; not fatal.
        debugPrint('[GuestSession] profile insert skipped: $e');
      }
      return true;
    } catch (e) {
      debugPrint('[GuestSession] anonymous sign-in failed: $e');
      return false;
    }
  }

  static const _kSuppressed = 'guest_session_suppressed';

  static Future<bool> _guestSessionsSuppressed() async {
    try {
      return (await SharedPreferences.getInstance()).getBool(_kSuppressed) ??
          false;
    } catch (_) {
      return false;
    }
  }

  /// Call on an explicit sign-out, so the next launch asks who they are
  /// instead of starting a fresh guest session.
  static Future<void> suppressNextGuestSession() async {
    try {
      await (await SharedPreferences.getInstance())
          .setBool(_kSuppressed, true);
    } catch (e) {
      debugPrint('[GuestSession] could not suppress: $e');
    }
  }

  /// Call after any successful sign-in or sign-up. Once someone is identified,
  /// a later first launch on this device can start as a guest again.
  static Future<void> allowGuestSessions() async {
    try {
      await (await SharedPreferences.getInstance())
          .remove(_kSuppressed);
    } catch (e) {
      debugPrint('[GuestSession] could not clear suppression: $e');
    }
  }

  /// Turns the current guest into a real account, keeping their uuid and
  /// everything attached to it.
  ///
  /// Returns null on success, or a message to show the person on failure.
  static Future<String?> upgrade({
    required String email,
    required String password,
  }) async {
    if (!isGuest) return 'This account already has an email address.';
    try {
      final res = await SupaFlow.client.auth.updateUser(
        UserAttributes(email: email, password: password),
      );
      return res.user == null ? 'Could not save your account. Try again.' : null;
    } on AuthException catch (e) {
      return e.message;
    } catch (e) {
      debugPrint('[GuestSession] upgrade failed: $e');
      return 'Could not save your account. Try again.';
    }
  }
}

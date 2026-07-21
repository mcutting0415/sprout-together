import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '/backend/supabase/supabase.dart';

import '/auth/base_auth_user_provider.dart';

import '/main.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/lat_lng.dart';
import '/flutter_flow/place.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'serialization_util.dart';

import '/index.dart';

export 'package:go_router/go_router.dart';
export 'serialization_util.dart';

const kTransitionInfoKey = '__transition_info__';

GlobalKey<NavigatorState> appNavigatorKey = GlobalKey<NavigatorState>();

class AppStateNotifier extends ChangeNotifier {
  AppStateNotifier._();

  static AppStateNotifier? _instance;
  static AppStateNotifier get instance => _instance ??= AppStateNotifier._();

  BaseAuthUser? initialUser;
  BaseAuthUser? user;
  bool showSplashImage = true;
  String? _redirectLocation;

  /// Determines whether the app will refresh and build again when a sign
  /// in or sign out happens. This is useful when the app is launched or
  /// on an unexpected logout. However, this must be turned off when we
  /// intend to sign in/out and then navigate or perform any actions after.
  /// Otherwise, this will trigger a refresh and interrupt the action(s).
  bool notifyOnAuthChange = true;

  bool get loading => user == null || showSplashImage;
  bool get loggedIn => user?.loggedIn ?? false;
  bool get initiallyLoggedIn => initialUser?.loggedIn ?? false;
  bool get shouldRedirect => loggedIn && _redirectLocation != null;

  String getRedirectLocation() => _redirectLocation!;
  bool hasRedirect() => _redirectLocation != null;
  void setRedirectLocationIfUnset(String loc) => _redirectLocation ??= loc;
  void clearRedirectLocation() => _redirectLocation = null;

  /// Mark as not needing to notify on a sign in / out when we intend
  /// to perform subsequent actions (such as navigation) afterwards.
  void updateNotifyOnAuthChange(bool notify) => notifyOnAuthChange = notify;

  void update(BaseAuthUser newUser) {
    final shouldUpdate =
        user?.uid == null || newUser.uid == null || user?.uid != newUser.uid;
    initialUser ??= newUser;
    user = newUser;
    // Refresh the app on auth change unless explicitly marked otherwise.
    // No need to update unless the user has changed.
    if (notifyOnAuthChange && shouldUpdate) {
      notifyListeners();
    }
    // Once again mark the notifier as needing to update on auth change
    // (in order to catch sign in / out events).
    updateNotifyOnAuthChange(true);
  }

  void stopShowingSplashImage() {
    showSplashImage = false;
    notifyListeners();
  }
}

GoRouter createRouter(AppStateNotifier appStateNotifier) => GoRouter(
      initialLocation: '/',
      debugLogDiagnostics: true,
      refreshListenable: appStateNotifier,
      navigatorKey: appNavigatorKey,
      errorBuilder: (context, state) => appStateNotifier.loggedIn
          ? PlannerOverviewPageWidget()
          : SignUpPageWidget(),
      routes: [
        FFRoute(
          name: '_initialize',
          path: '/',
          builder: (context, _) => appStateNotifier.loggedIn
              ? PlannerOverviewPageWidget()
              : SignUpPageWidget(),
        ),
        FFRoute(
          name: PlannerOverviewPageWidget.routeName,
          path: PlannerOverviewPageWidget.routePath,
          builder: (context, params) => PlannerOverviewPageWidget(),
        ),
        FFRoute(
          name: PlantLibraryPageWidget.routeName,
          path: PlantLibraryPageWidget.routePath,
          builder: (context, params) => PlantLibraryPageWidget(
            plotNumber: params.getParam(
              'plotNumber',
              ParamType.int,
            ),
            gardenID: params.getParam(
              'gardenID',
              ParamType.String,
            ),
            plantID: params.getParam(
              'plantID',
              ParamType.String,
            ),
            addMode: params.getParam('addMode', ParamType.bool) ?? false,
          ),
        ),
        FFRoute(
          name: GrowingCalendarWidget.routeName,
          path: GrowingCalendarWidget.routePath,
          builder: (context, params) => GrowingCalendarWidget(),
        ),
        FFRoute(
          name: SignUpPageWidget.routeName,
          path: SignUpPageWidget.routePath,
          builder: (context, params) => SignUpPageWidget(),
        ),
        FFRoute(
          name: LoginPageWidget.routeName,
          path: LoginPageWidget.routePath,
          builder: (context, params) => LoginPageWidget(),
        ),
        FFRoute(
          name: AccountSetupPage2Widget.routeName,
          path: AccountSetupPage2Widget.routePath,
          builder: (context, params) => AccountSetupPage2Widget(),
        ),
        FFRoute(
          name: CompanionGuidePage2Widget.routeName,
          path: CompanionGuidePage2Widget.routePath,
          builder: (context, params) => CompanionGuidePage2Widget(
            plantID: params.getParam(
              'plantID',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: CreateGardenPageWidget.routeName,
          path: CreateGardenPageWidget.routePath,
          builder: (context, params) => CreateGardenPageWidget(
            title: params.getParam(
              'title',
              ParamType.String,
            ),
            raisedBeds: params.getParam(
              'raisedBeds',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: CurrentGardens3Widget.routeName,
          path: CurrentGardens3Widget.routePath,
          builder: (context, params) => CurrentGardens3Widget(
            fromPlanner: params.getParam('fromPlanner', ParamType.bool) ?? false,
          ),
        ),
        FFRoute(
          name: GardenBuilderPageWidget.routeName,
          path: GardenBuilderPageWidget.routePath,
          builder: (context, params) => GardenBuilderPageWidget(
            gardenID: params.getParam(
              'gardenID',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: GardenJournalPage2Widget.routeName,
          path: GardenJournalPage2Widget.routePath,
          builder: (context, params) => GardenJournalPage2Widget(
            fromInsights: params.getParam('fromInsights', ParamType.bool) ?? false,
          ),
        ),
        FFRoute(
          name: PlantDetailsPageWidget.routeName,
          path: PlantDetailsPageWidget.routePath,
          builder: (context, params) => PlantDetailsPageWidget(
            plantID: params.getParam(
              'plantID',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: ShopPageWidget.routeName,
          path: ShopPageWidget.routePath,
          builder: (context, params) => ShopPageWidget(),
        ),
        FFRoute(
          name: SettingsPage2Widget.routeName,
          path: SettingsPage2Widget.routePath,
          builder: (context, params) => SettingsPage2Widget(),
        ),
        FFRoute(
          name: ProfilePage2Widget.routeName,
          path: ProfilePage2Widget.routePath,
          builder: (context, params) => ProfilePage2Widget(),
        ),
        FFRoute(
          name: PreviousGardensPage2Widget.routeName,
          path: PreviousGardensPage2Widget.routePath,
          builder: (context, params) => PreviousGardensPage2Widget(),
        ),
        FFRoute(
          name: PasswordResetPageWidget.routeName,
          path: PasswordResetPageWidget.routePath,
          builder: (context, params) => PasswordResetPageWidget(),
        ),
        FFRoute(
          name: HelpPageWidget.routeName,
          path: HelpPageWidget.routePath,
          builder: (context, params) => HelpPageWidget(),
        ),
        FFRoute(
          name: CommonQuestionsPageWidget.routeName,
          path: CommonQuestionsPageWidget.routePath,
          builder: (context, params) => CommonQuestionsPageWidget(),
        ),
        FFRoute(
          name: UpdatePasswordPageWidget.routeName,
          path: UpdatePasswordPageWidget.routePath,
          builder: (context, params) => UpdatePasswordPageWidget(),
        ),
        FFRoute(
          name: GardenGoalsPageWidget.routeName,
          path: GardenGoalsPageWidget.routePath,
          builder: (context, params) => GardenGoalsPageWidget(),
        ),
        FFRoute(
          name: PaywallWidget.routeName,
          path: PaywallWidget.routePath,
          builder: (context, params) => const PaywallWidget(),
        ),
        FFRoute(
          name: GardenTipsPageWidget.routeName,
          path: GardenTipsPageWidget.routePath,
          builder: (context, params) => GardenTipsPageWidget(
            experienceLevel: params.getParam('experienceLevel', ParamType.String),
          ),
        ),
        FFRoute(
          name: SeedInventoryPageWidget.routeName,
          path: SeedInventoryPageWidget.routePath,
          builder: (context, params) => const SeedInventoryPageWidget(),
        ),
        FFRoute(
          name: SeedStartingGuideWidget.routeName,
          path: SeedStartingGuideWidget.routePath,
          builder: (context, params) => const SeedStartingGuideWidget(),
        ),
      ].map((r) => r.toRoute(appStateNotifier)).toList(),
    );

extension NavParamExtensions on Map<String, String?> {
  Map<String, String> get withoutNulls => Map.fromEntries(
        entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
}

extension NavigationExtensions on BuildContext {
  void goNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : goNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void pushNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : pushNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void safePop() {
    // If there is only one route on the stack, navigate to the initial
    // page instead of popping.
    if (canPop()) {
      pop();
    } else {
      go('/');
    }
  }
}

extension GoRouterExtensions on GoRouter {
  AppStateNotifier get appState => AppStateNotifier.instance;
  void prepareAuthEvent([bool ignoreRedirect = false]) =>
      appState.hasRedirect() && !ignoreRedirect
          ? null
          : appState.updateNotifyOnAuthChange(false);
  bool shouldRedirect(bool ignoreRedirect) =>
      !ignoreRedirect && appState.hasRedirect();
  void clearRedirectLocation() => appState.clearRedirectLocation();
  void setRedirectLocationIfUnset(String location) =>
      appState.updateNotifyOnAuthChange(false);
}

extension _GoRouterStateExtensions on GoRouterState {
  Map<String, dynamic> get extraMap =>
      extra != null ? extra as Map<String, dynamic> : {};
  Map<String, dynamic> get allParams => <String, dynamic>{}
    ..addAll(pathParameters)
    ..addAll(uri.queryParameters)
    ..addAll(extraMap);
  TransitionInfo get transitionInfo => extraMap.containsKey(kTransitionInfoKey)
      ? extraMap[kTransitionInfoKey] as TransitionInfo
      : TransitionInfo.appDefault();
}

class FFParameters {
  FFParameters(this.state, [this.asyncParams = const {}]);

  final GoRouterState state;
  final Map<String, Future<dynamic> Function(String)> asyncParams;

  Map<String, dynamic> futureParamValues = {};

  // Parameters are empty if the params map is empty or if the only parameter
  // present is the special extra parameter reserved for the transition info.
  bool get isEmpty =>
      state.allParams.isEmpty ||
      (state.allParams.length == 1 &&
          state.extraMap.containsKey(kTransitionInfoKey));
  bool isAsyncParam(MapEntry<String, dynamic> param) =>
      asyncParams.containsKey(param.key) && param.value is String;
  bool get hasFutures => state.allParams.entries.any(isAsyncParam);
  Future<bool> completeFutures() => Future.wait(
        state.allParams.entries.where(isAsyncParam).map(
          (param) async {
            final doc = await asyncParams[param.key]!(param.value)
                .onError((_, __) => null);
            if (doc != null) {
              futureParamValues[param.key] = doc;
              return true;
            }
            return false;
          },
        ),
      ).onError((_, __) => [false]).then((v) => v.every((e) => e));

  dynamic getParam<T>(
    String paramName,
    ParamType type, {
    bool isList = false,
  }) {
    if (futureParamValues.containsKey(paramName)) {
      return futureParamValues[paramName];
    }
    if (!state.allParams.containsKey(paramName)) {
      return null;
    }
    final param = state.allParams[paramName];
    // Got parameter from `extras`, so just directly return it.
    if (param is! String) {
      return param;
    }
    // Return serialized value.
    return deserializeParam<T>(
      param,
      type,
      isList,
    );
  }
}

class FFRoute {
  const FFRoute({
    required this.name,
    required this.path,
    required this.builder,
    this.requireAuth = false,
    this.asyncParams = const {},
    this.routes = const [],
  });

  final String name;
  final String path;
  final bool requireAuth;
  final Map<String, Future<dynamic> Function(String)> asyncParams;
  final Widget Function(BuildContext, FFParameters) builder;
  final List<GoRoute> routes;

  GoRoute toRoute(AppStateNotifier appStateNotifier) => GoRoute(
        name: name,
        path: path,
        redirect: (context, state) {
          if (appStateNotifier.shouldRedirect) {
            final redirectLocation = appStateNotifier.getRedirectLocation();
            appStateNotifier.clearRedirectLocation();
            return redirectLocation;
          }

          if (requireAuth && !appStateNotifier.loggedIn) {
            appStateNotifier.setRedirectLocationIfUnset(state.uri.toString());
            return '/signUpPage';
          }
          return null;
        },
        pageBuilder: (context, state) {
          fixStatusBarOniOS16AndBelow(context);
          final ffParams = FFParameters(state, asyncParams);
          final page = ffParams.hasFutures
              ? FutureBuilder(
                  future: ffParams.completeFutures(),
                  builder: (context, _) => builder(context, ffParams),
                )
              : builder(context, ffParams);
          final child = appStateNotifier.loading
              ? Center(
                  child: SizedBox(
                    width: 50.0,
                    height: 50.0,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        FlutterFlowTheme.of(context).primary,
                      ),
                    ),
                  ),
                )
              : page;

          final transitionInfo = state.transitionInfo;
          return transitionInfo.hasTransition
              ? CustomTransitionPage(
                  key: state.pageKey,
                  name: state.name,
                  child: child,
                  transitionDuration: transitionInfo.duration,
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) =>
                          PageTransition(
                    type: transitionInfo.transitionType,
                    duration: transitionInfo.duration,
                    reverseDuration: transitionInfo.duration,
                    alignment: transitionInfo.alignment,
                    child: child,
                  ).buildTransitions(
                    context,
                    animation,
                    secondaryAnimation,
                    child,
                  ),
                )
              : MaterialPage(
                  key: state.pageKey, name: state.name, child: child);
        },
        routes: routes,
      );
}

class TransitionInfo {
  const TransitionInfo({
    required this.hasTransition,
    this.transitionType = PageTransitionType.fade,
    this.duration = const Duration(milliseconds: 300),
    this.alignment,
  });

  final bool hasTransition;
  final PageTransitionType transitionType;
  final Duration duration;
  final Alignment? alignment;

  static TransitionInfo appDefault() => TransitionInfo(hasTransition: false);
}

class RootPageContext {
  const RootPageContext(this.isRootPage, [this.errorRoute]);
  final bool isRootPage;
  final String? errorRoute;

  static bool isInactiveRootPage(BuildContext context) {
    final rootPageContext = context.read<RootPageContext?>();
    final isRootPage = rootPageContext?.isRootPage ?? false;
    final location = GoRouterState.of(context).uri.toString();
    return isRootPage &&
        location != '/' &&
        location != rootPageContext?.errorRoute;
  }

  static Widget wrap(Widget child, {String? errorRoute}) => Provider.value(
        value: RootPageContext(true, errorRoute),
        child: child,
      );
}

extension GoRouterLocationExtension on GoRouter {
  String getCurrentLocation() {
    final RouteMatch lastMatch = routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : routerDelegate.currentConfiguration;
    return matchList.uri.toString();
  }
}

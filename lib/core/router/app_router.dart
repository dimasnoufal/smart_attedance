import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:smart_attedance/features/face_detection_rounded_box/presentation/pages/gate_detection_page.dart';
import 'package:smart_attedance/features/face_detection/presentation/pages/face_detection_page.dart';
import 'package:smart_attedance/features/auth/presentation/pages/login_page.dart';
import 'package:smart_attedance/core/services/auth_local_storage_service.dart';
import 'package:smart_attedance/core/di/injection.dart';

/// Application router configuration using go_router.
/// Declarative routing with named routes for type-safe navigation.
class AppRouter {
  AppRouter._();

  static const String home = '/';
  static const String login = '/login';
  static const String faceDetectionOld = '/face-detection-old';

  static final GoRouter router = GoRouter(
    initialLocation: home,
    debugLogDiagnostics: true,
    redirect: (BuildContext context, GoRouterState state) async {
      final authStorage = getIt<AuthLocalStorageService>();
      final isLoggedIn = await authStorage.isLoggedIn();
      
      final isLoggingIn = state.matchedLocation == login;

      if (!isLoggedIn && !isLoggingIn) {
        return login;
      }
      
      if (isLoggedIn && isLoggingIn) {
        return home;
      }

      return null;
    },
    routes: <RouteBase>[
      GoRoute(
        path: login,
        name: 'login',
        builder: (BuildContext context, GoRouterState state) {
          return const LoginPage();
        },
      ),
      GoRoute(
        path: home,
        name: 'gateDetection',
        builder: (BuildContext context, GoRouterState state) {
          return const GateDetectionPage();
        },
      ),
      GoRoute(
        path: faceDetectionOld,
        name: 'faceDetectionOld',
        builder: (BuildContext context, GoRouterState state) {
          return const FaceDetectionPage();
        },
      ),
    ],
  );
}

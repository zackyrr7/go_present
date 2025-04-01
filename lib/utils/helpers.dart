import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';

class AuthHelper {
  static final FlutterSecureStorage storage = const FlutterSecureStorage();

  /// Handle token expired (401) and navigate to login
  static Future<void> handleUnauthorized(
      BuildContext? context, GlobalKey<NavigatorState> navigatorKey) async {
    await storage.delete(key: "token");

    if (context != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        navigatorKey.currentState?.pushNamedAndRemoveUntil(
          "/login",
          (route) => false,
        );
      });
    }
  }
}

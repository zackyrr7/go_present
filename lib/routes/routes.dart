import 'package:flutter/material.dart';
import 'package:go_present/screens/login/login_page.dart';
import 'package:go_present/screens/homePage/amal_screen.dart';
import 'package:go_present/screens/homePage/cuti_screen.dart';
import 'package:go_present/screens/homePage/izin_screen.dart';
import 'package:go_present/screens/homePage/sakit_screen.dart';
import 'package:go_present/screens/homePage/slip_screen.dart';
import 'package:go_present/screens/homePage/task_screen.dart';

class AppRoutes {
  static const String izin = "/izin";
  static const String sakit = "/sakit";
  static const String cuti = "/cuti";
  static const String task = "/task";
  static const String amal = "/amal";
  static const String aktivitas = "/aktivitas";
  static const String slip = "/slip";
  static const String login = "/login"; // Menambahkan route login

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case izin:
        return MaterialPageRoute(builder: (_) => const IzinScreen());
      case sakit:
        return MaterialPageRoute(builder: (_) => const SakitScreen());
      case cuti:
        return MaterialPageRoute(builder: (_) => const CutiScreen());
      case task:
        return MaterialPageRoute(builder: (_) => const TaskScreen());
      case amal:
        return MaterialPageRoute(builder: (_) => const AmalScreen());
      case slip:
        return MaterialPageRoute(builder: (_) => const SlipScreen());
      case login: // Route untuk halaman login
        return MaterialPageRoute(builder: (_) => const Loginscreen());
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text("Page not found")),
          ),
        );
    }
  }
}

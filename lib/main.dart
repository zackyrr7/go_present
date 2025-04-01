import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_present/bloc/darkmode/theme_bloc.dart';
import 'package:go_present/bloc/homePage/grid_bloc.dart';
import 'package:go_present/bloc/homePage/list_bloc.dart';
import 'package:go_present/bloc/homePage/list_event.dart';
import 'package:go_present/bloc/homePage/notification_bloc.dart';
import 'package:go_present/bloc/homePage/notification_event.dart';
import 'package:go_present/bloc/homePage/user_bloc.dart';
import 'package:go_present/bloc/homePage/user_event.dart';
import 'package:go_present/bloc/loginPage/login_bloc.dart';
import 'package:go_present/bloc/riwayat/riwayat_bloc.dart';
import 'package:go_present/bloc/riwayat/riwayat_event.dart';
import 'package:go_present/routes/routes.dart';
import 'package:go_present/screens/login/login_page.dart';
import 'package:go_present/screens/navbar/navbar.dart';
import 'package:go_present/screens/navbar/navigation_bloc.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(const AppInitializer());
}

class AppInitializer extends StatefulWidget {
  const AppInitializer({super.key});

  @override
  _AppInitializerState createState() => _AppInitializerState();
}

class _AppInitializerState extends State<AppInitializer> {
  late Future<bool> _tokenCheckFuture;

  @override
  void initState() {
    super.initState();
    _tokenCheckFuture = _checkToken();
  }

  Future<bool> _checkToken() async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');
    return token != null && token.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NavigationBloc()),
        BlocProvider(create: (context) => GridBloc()),
        BlocProvider(create: (context) => LoginBloc()),
        BlocProvider(create: (context) => ThemeBloc()),
        BlocProvider(create: (context) => UserBloc()),
        BlocProvider(create: (context) => ListBloc(context)),
        BlocProvider(create: (context) => RiwayatBloc(context)),
        BlocProvider(
            create: (context) =>
                NotificationBloc(context)..add(FetchNotification())),
      ],
      child: FutureBuilder<bool>(
        future: _tokenCheckFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MaterialApp(
              home: Scaffold(
                body: Center(child: CircularProgressIndicator()),
              ),
            );
          }

          final bool hasToken = snapshot.data ?? false;

          DateTime now = DateTime.now();
          int month = now.month;

          // Fetch user data sekali saja ketika ada token
          if (hasToken) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context
                  .read<RiwayatBloc>()
                  .add(FetchRiwayatProfile(bulan: month));
              context.read<UserBloc>().add(FetchUserProfile());
              context.read<ListBloc>().add(FetchListProfile());
              context.read<NotificationBloc>().add(FetchNotification());
            });
          }

          return BlocBuilder<ThemeBloc, ThemeData>(
            builder: (context, themeData) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: themeData,
                onGenerateRoute: AppRoutes.generateRoute,
                navigatorKey: navigatorKey, // Menetapkan navigatorKey di sini
                home: hasToken ? WidgetNavbar() : const Loginscreen(),
              );
            },
          );
        },
      ),
    );
  }
}

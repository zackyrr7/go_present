import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_present/bloc/darkmode/theme_bloc.dart';
import 'package:go_present/bloc/homePage/grid_bloc.dart';
import 'package:go_present/bloc/homePage/grid_event.dart';
import 'package:go_present/bloc/homePage/grid_state.dart';
import 'package:go_present/bloc/homePage/notifaction_state.dart';
import 'package:go_present/bloc/homePage/notification_bloc.dart';
import 'package:go_present/bloc/homePage/user_bloc.dart';
// import 'package:go_present/bloc/homePage/user_event.dart';
import 'package:go_present/bloc/homePage/user_state.dart';
import 'package:go_present/routes/routes.dart';
import 'package:go_present/screens/homePage/notification_screen.dart';
import 'package:go_present/widget/homePage/card_absen.dart';
import 'package:go_present/widget/homePage/card_presensi.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> gridItems = [
      {
        "image": "assets/icon/izin.png",
        "text": "Izin",
        "route": AppRoutes.izin
      },
      {
        "image": "assets/icon/sakit.png",
        "text": "Sakit",
        "route": AppRoutes.sakit
      },
      {
        "image": "assets/icon/cuti.png",
        "text": "Cuti",
        "route": AppRoutes.cuti
      },
      {
        "image": "assets/icon/task.png",
        "text": "Task",
        "route": AppRoutes.task
      },
      {
        "image": "assets/icon/amal-yaumi.png",
        "text": "Amal Yaumi",
        "route": AppRoutes.amal
      },
      {
        "image": "assets/icon/lapker.png",
        "text": "Aktivitas",
        "route": AppRoutes.aktivitas
      },
      {
        "image": "assets/icon/slip.png",
        "text": "Slip Gaji",
        "route": AppRoutes.slip
      },
      {
        "image": "assets/icon/lainnya.png",
        "text": "Lainnya",
        // "route": AppRoutes.slip
      },
    ];

    return BlocListener<GridBloc, GridState>(
      listener: (context, state) {
        if (state is NavigateToPageState) {
          Navigator.pushNamed(context, state.route);
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: _buildAppBar(context),
        body: SingleChildScrollView(
          child: Column(
            children: [
              _buildUserProfile(context),
              const CardAbsen(),
              _buildGridMenu(context, gridItems),
              Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: const CardPresensi()),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      toolbarHeight: 40,
      backgroundColor: Colors.blue,
      actions: [
        BlocSelector<ThemeBloc, ThemeData, Brightness>(
          selector: (theme) => theme.brightness,
          builder: (context, brightness) {
            return IconButton(
              alignment: Alignment.topRight,
              onPressed: () {
                context.read<ThemeBloc>().add(ToggleThemeEvent());
              },
              icon: Icon(
                brightness == Brightness.dark
                    ? Icons.light_mode_outlined
                    : Icons.dark_mode_outlined,
                color: Colors.white,
              ),
            );
          },
        ),
        BlocBuilder<NotificationBloc, NotificationState>(
          builder: (context, state) {
            return Stack(children: [
              IconButton(
                onPressed: () {
                  // Tambahkan logika notifikasi jika diperlukan
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NotificationScreen()));
                },
                icon: const Icon(Icons.notifications_outlined,
                    color: Colors.white),
              ),
              if (state.unreadCount > 0)
                Positioned(
                    right: 5,
                    // top: 15,
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                          color: Colors.red, shape: BoxShape.circle),
                      child: Text(
                        state.unreadCount.toString(),
                        style:
                            const TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ))
            ]);
          },
        ),
      ],
    );
  }

  Widget _buildUserProfile(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserLoading) {
          return Center(
            child: LoadingAnimationWidget.progressiveDots(
                color: Theme.of(context).colorScheme.primary, size: 12),
          );
        } else if (state is UserLoaded) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 0, 0),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  child: const Icon(Icons.person,
                      color: Colors.blueGrey, size: 30),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(state.userProfile.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    Row(
                      children: [
                        const Icon(Icons.shopping_bag,
                            color: Colors.blueGrey, size: 15),
                        const SizedBox(width: 2),
                        Text(state.userProfile.company,
                            style: TextStyle(
                                fontSize: 12, color: Colors.blueGrey[200])),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        } else if (state is UserError) {
          return Center(
            child: Text("Error: ${state.message}"),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildGridMenu(
      BuildContext context, List<Map<String, dynamic>> gridItems) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.3,
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: gridItems.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 2,
            mainAxisSpacing: 2,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                if (gridItems[index]["text"] == "Lainnya") {
                  _showPopup(context);
                } else {
                  context
                      .read<GridBloc>()
                      .add(GridItemTapped(route: gridItems[index]["route"]));
                }
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      height: 50,
                      child: Image.asset(
                        gridItems[index]["image"],
                        fit: BoxFit.cover,
                      )),
                  const SizedBox(height: 5),
                  Text(gridItems[index]["text"],
                      style: const TextStyle(fontSize: 12)),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

void _showPopup(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Menu Lainnya"),
        // content: const Text("Ini adalah popup untuk menu Lainnya."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Tutup"),
          ),
        ],
      );
    },
  );
}

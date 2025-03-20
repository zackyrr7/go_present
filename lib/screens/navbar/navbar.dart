import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_present/screens/absenPage/absen_page.dart';
import 'package:go_present/screens/homePage/home_screen.dart';
import 'package:go_present/screens/lapkerPage/lapker_page.dart';
import 'package:go_present/screens/navbar/navigation_bloc.dart';
import 'package:go_present/screens/profilPage/profil_page.dart';
import 'package:go_present/screens/riwayatPage/riwayat_page.dart';

class WidgetNavbar extends StatelessWidget {
  WidgetNavbar({super.key});

  final List<Widget> _screens = [
    const HomeScreen(),
    const RiwayatScreen(),
    const SizedBox(), // Kosong, karena Absen akan menggunakan FloatingActionButton
    const LapkerScreen(),
    const ProfilScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, state) {
          return _screens[state.selectedIndex];
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).colorScheme.secondary,
        shape: const CircularNotchedRectangle(),
        clipBehavior: Clip.antiAlias,
        notchMargin: 2.0,
        child: BlocBuilder<NavigationBloc, NavigationState>(
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(
                    context, Icons.home, "Home", 0, state.selectedIndex),
                _buildNavItem(context, Icons.history_toggle_off, "Riwayat", 1,
                    state.selectedIndex),
                const SizedBox(width: 48), // Beri ruang untuk FAB
                _buildNavItem(context, Icons.art_track_sharp, "Lapker", 3,
                    state.selectedIndex),
                _buildNavItem(
                    context, Icons.person, "Profil", 4, state.selectedIndex),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<NavigationBloc>().add(selectTab(index: 2));
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AbsenScreen()),
          );
        },
        backgroundColor: Colors.blue,
        elevation: 5,
        // mini: true,
        shape: const CircleBorder(),
        // ignore: prefer_const_constructors
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.camera_alt, color: Colors.white, size: 20),
            // Text(
            //   'Absen',
            //   style: TextStyle(fontSize: 12),
            // )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  /// Widget untuk item navigasi
  Widget _buildNavItem(BuildContext context, IconData icon, String label,
      int index, int selectedIndex) {
    return InkWell(
      onTap: () {
        context.read<NavigationBloc>().add(selectTab(index: index));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon,
                color: index == selectedIndex ? Colors.blue : Colors.grey),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: index == selectedIndex ? Colors.blue : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

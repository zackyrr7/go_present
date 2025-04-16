import 'package:flutter/material.dart';
import 'package:go_present/screens/homePage/tambah_izin.dart';

class IzinScreen extends StatelessWidget {
  const IzinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // iconTheme: IconThemeData(color: Theme.of(context).colorScheme.primary),
        title: Text(
          "Izin Pegawai",
        ),
        centerTitle: true,
        toolbarHeight: 40,
      ),
      body: Center(
        child: Text("Izin Pegawai"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => TambahIzin()));
        },
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
    );
  }
}

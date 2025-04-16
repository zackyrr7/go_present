import 'package:flutter/material.dart';
import 'package:go_present/bloc/darkmode/theme_bloc.dart';
import 'package:go_present/bloc/datepicker/date_picker_block.dart';
import 'package:go_present/bloc/datepicker/date_picker_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TambahIzin extends StatelessWidget {
  const TambahIzin({super.key});
  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101));
    if (picked != null) {
      context.read<DatePickerBloc>().add(DateSelected(picked));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        toolbarHeight: 40,
        centerTitle: true,
        title: Text("Tambah Izin"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(image: AssetImage("assets/image/izin.png")),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Super Admin",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              child: Column(
                children: [
                  Text('Tanggal'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

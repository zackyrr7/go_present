import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_present/bloc/riwayat/riwayat_event.dart';
import 'package:go_present/bloc/riwayat/riwayat_state.dart';
import 'package:go_present/constant.dart';
import 'package:go_present/main.dart';
import 'package:go_present/model/riwayat_list.dart';
import 'package:go_present/routes/routes.dart';
import 'package:http/http.dart' as http;

class RiwayatBloc extends Bloc<RiwayatEvent, RiwayatState> {
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  final BuildContext context;

  RiwayatBloc(this.context) : super(RiwayatInitial()) {
    on<FetchRiwayatProfile>((event, emit) async {
      print('FetchRiwayatProfile Event Diterima: Bulan ${event.bulan}');
      emit(RiwayatLoading());

      try {
        String? token = await storage.read(key: 'token');
        if (token == null) {
          emit(RiwayatError(message: 'Token Tidak ditemukan'));
          return;
        }

        final response = await http.post(
          Uri.parse('$url/history'),
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "application/json",
          },
          body: jsonEncode(
              {"bulan": event.bulan}), // Pastikan JSON dikirim dengan benar
        );

        print('Response Status Code: ${response.statusCode}');
        print('token: $token');

        // Pengecekan status 401 Unauthorized
        if (response.statusCode == 401) {
          // Menghapus token
          await storage.delete(key: "token");

          // Menavigasi ke halaman login
          if (navigatorKey.currentState != null) {
            navigatorKey.currentState?.pushReplacementNamed(AppRoutes.login);
          }

          // Menampilkan dialog untuk memberi tahu sesi sudah habis
          showDialog(
            context: navigatorKey.currentContext!,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Sesi Telah Habis"),
                content: const Text(
                    "Token sesi Anda telah kedaluwarsa, silakan login kembali."),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      // Menutup dialog setelah pengguna menekan tombol OK
                      Navigator.of(context).pop();
                    },
                    child: const Text("OK"),
                  ),
                ],
              );
            },
          );

          return; // Menghentikan eksekusi lebih lanjut setelah 401
        }

        // Status 200 berarti berhasil
        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          print('Data dari API: $data'); // Debugging tambahan

          if (data["status"] == true) {
            List<ListRiwayat> listRiwayat =
                ListRiwayat.fromJsonList(data["data"]);
            print('Data berhasil diubah menjadi list');
            emit(RiwayatLoaded(listRiwayat: listRiwayat));
          } else {
            print('Status dari API false');
            emit(RiwayatError(message: "Gagal memuat data"));
          }
        } else {
          emit(RiwayatError(message: "Gagal Menghubungi server"));
        }
      } catch (e) {
        // Jika ada kesalahan lain (misalnya kesalahan jaringan)
        print('Error terjadi: $e');
        emit(RiwayatError(message: "Terjadi Kesalahan"));
      }
    });
  }
}

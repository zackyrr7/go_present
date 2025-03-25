import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_present/bloc/riwayat/riwayat_event.dart';
import 'package:go_present/bloc/riwayat/riwayat_state.dart';
import 'package:go_present/constant.dart';
import 'package:go_present/model/riwayat_list.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RiwayatBloc extends Bloc<RiwayatEvent, RiwayatState> {
  final FlutterSecureStorage storage = FlutterSecureStorage();
  late DateTime now;
  late int moth;
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
        print('Response Body: ${response.body}');

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
        } else if (response.statusCode == 401) {
          await storage.delete(key: "token");
          Navigator.pushReplacementNamed(context, "/login");
          emit(RiwayatError(message: "Sesi habis, silahkan Login Kembali"));
        } else {
          emit(RiwayatError(message: "Gagal Menghubungi server"));
        }
      } catch (e) {
        print('Error terjadi: $e');
        emit(RiwayatError(message: "Terjadi Kesalahan"));
      }
    });
  }
}

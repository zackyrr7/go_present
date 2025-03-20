import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_present/model/home_user.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  final BuildContext context; // Tambahkan context untuk navigasi

  UserBloc(this.context) : super(UserInitial()) {
    on<FetchUserProfile>((event, emit) async {
      emit(UserLoading());
      try {
        // Ambil token dari Flutter Secure Storage
        String? token = await storage.read(key: "token");

        if (token == null) {
          emit(UserError("Token tidak ditemukan"));
          return;
        }

        // Kirim request ke API
        final response = await http.post(
          Uri.parse("http://192.168.1.67:82/api2/api/home/today"),
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "application/json",
          },
        );

        if (response.statusCode == 200) {
          final data = json.decode(response.body);

          if (data["status"] == true) {
            UserProfile userProfile = UserProfile.fromJson(data["data"]);
            emit(UserLoaded(userProfile));
          } else {
            emit(UserError("Gagal mengambil data"));
          }
        } else if (response.statusCode == 401) {
          await storage.delete(key: "token");

          // Navigasi ke halaman login
          // ignore: use_build_context_synchronously
          Navigator.pushReplacementNamed(context, "/login");

          emit(UserError("Sesi habis, silakan login kembali"));
        } else {
          emit(UserError("Gagal menghubungi server"));
        }
      } catch (e) {
        emit(UserError("Terjadi kesalahan: $e"));
      }
    });
  }
}

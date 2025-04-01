import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_present/constant.dart';
import 'package:go_present/model/home_user.dart';
import 'package:go_present/utils/helpers.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_present/main.dart'; // Import untuk navigatorKey
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  UserBloc() : super(UserInitial()) {
    on<FetchUserProfile>((event, emit) async {
      emit(UserLoading());
      try {
        String? token = await storage.read(key: "token");

        if (token == null) {
          emit(UserError("Token tidak ditemukan"));
          return;
        }

        final response = await http.post(
          Uri.parse("$url/home/today"),
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

          // Navigasi ke halaman login dengan navigatorKey
          // navigatorKey.currentState?.pushReplacementNamed("/login");
          await AuthHelper.handleUnauthorized(
              navigatorKey.currentContext, navigatorKey);

          // emit(UserError("Sesi habis, silakan login kembali"));
        } else {
          emit(UserError("Gagal menghubungi server"));
        }
      } catch (e) {
        navigatorKey.currentState?.pushReplacementNamed("/login");
      }
    });
  }
}

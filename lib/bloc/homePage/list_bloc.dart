import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_present/bloc/homePage/list_event.dart';
import 'package:go_present/bloc/homePage/list_state.dart';
import 'package:go_present/constant.dart';
import 'package:go_present/model/home_list.dart';
import 'package:go_present/screens/login/login_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ListBloc extends Bloc<ListEvent, ListState> {
  final FlutterSecureStorage storage = FlutterSecureStorage();
  final BuildContext context;

  ListBloc(this.context) : super(ListInitial()) {
    on<FetchListProfile>((event, emit) async {
      emit(ListLoading());
      try {
        String? token = await storage.read(key: 'token');

        if (token == null) {
          _redirectToLogin();
          emit(ListError("Token tidak ditemukan"));
          return;
        }

        final response = await http.post(
          Uri.parse('$url/home/all-today'),
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "application/json",
          },
        );

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          if (data["status"] == true) {
            List<ListAbsens> listAbsens = ListAbsens.fromJsonList(data["data"]);
            emit(ListLoaded(listAbsens));
          } else {
            emit(ListError("Gagal memuat data"));
          }
        } else if (response.statusCode == 401) {
          await storage.delete(key: "token");
          _redirectToLogin();
          emit(ListError("Sesi habis, silahkan login kembali"));
        } else {
          emit(ListError("Gagal menghubungi server"));
        }
      } catch (e) {
        emit(ListError("Terjadi kesalahan: $e"));
      }
    });
  }

  void _redirectToLogin() {
    Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Loginscreen()));
  }
}

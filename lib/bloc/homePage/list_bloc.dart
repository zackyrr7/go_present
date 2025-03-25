import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_present/bloc/homePage/list_event.dart';
import 'package:go_present/bloc/homePage/list_state.dart';
import 'package:go_present/bloc/homePage/user_state.dart';
import 'package:go_present/constant.dart';
import 'package:go_present/model/home_list.dart';
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
        print('$url/home/all-today');
        print(response.statusCode);
        if (response.statusCode == 200) {
          final data = json.decode(response.body);

          if (data["status"] == true) {
            List<ListAbsens> listAbsens = ListAbsens.fromJsonList(data["data"]);
            // ListAbsens listAbsens = ListAbsens.fromJson(data["data"]);

            emit(ListLoaded(listAbsens));
            print('dapat');
          } else {
            emit(ListError("Gagal memuat data"));
            print('error1');
          }
        } else if (response.statusCode == 401) {
          await storage.delete(key: "token");
          Navigator.pushReplacementNamed(context, "/login");
          emit(ListError("Sesi habis, silahkan Login Kembali"));
          print('error4');
        } else {
          emit(ListError("Gagal Menghubungi Server"));
          print('errro2');
        }
      } catch (e) {
        emit(ListError("Terjadi Kesalahan: $e"));
        print('error3');
      }
    });
  }
}

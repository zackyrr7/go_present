import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_present/bloc/loginPage/login_event.dart';
import 'package:go_present/bloc/loginPage/login_state.dart';
import 'package:go_present/constant.dart';
import 'package:http/http.dart' as http;

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final storage = const FlutterSecureStorage();
  LoginBloc() : super(LoginInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  Future<void> _onLoginSubmitted(
      LoginSubmitted event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    try {
      final response = await http.post(Uri.parse('$url/login'),
          body: {'username': event.username, 'password': event.password});

      final data = jsonDecode(response.body);
      if (data['status'] == true && response.statusCode == 200) {
        await storage.write(key: 'token', value: data['token']);
        emit(LoginSucces(token: data['token']));
        // ignore: avoid_print
        print(storage.read(key: 'token'));
      } else {
        emit(LoginFailure(error: 'Username atau Password Salah'));
      }
    } catch (e) {
      emit(LoginFailure(error: 'Terjadi Kesalahan, Coba Lagi'));
    }
  }
}

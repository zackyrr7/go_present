import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_present/theme.dart';
// Pastikan path benar

// Event untuk ThemeBloc
abstract class ThemeEvent {}

class ToggleThemeEvent extends ThemeEvent {}

// Bloc untuk mengelola tema
class ThemeBloc extends Bloc<ThemeEvent, ThemeData> {
  ThemeBloc() : super(AppThemes.lightTheme) {
    on<ToggleThemeEvent>((event, emit) {
      emit(state.brightness == Brightness.light
          ? AppThemes.darkTheme
          : AppThemes.lightTheme);
    });
  }
}

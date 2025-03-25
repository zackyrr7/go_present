import 'package:go_present/model/home_list.dart';

abstract class ListState {}

class ListInitial extends ListState {}

class ListLoading extends ListState {}

class ListLoaded extends ListState {
  final List<ListAbsens> listAbsens;

  ListLoaded(this.listAbsens);
}

class ListError extends ListState {
  final String message;

  ListError(this.message);
}

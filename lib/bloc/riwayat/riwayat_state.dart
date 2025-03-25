import 'package:go_present/model/riwayat_list.dart';

abstract class RiwayatState {}

class RiwayatInitial extends RiwayatState {}

class RiwayatLoading extends RiwayatState {}

class RiwayatLoaded extends RiwayatState {
  final List<ListRiwayat> listRiwayat;

  RiwayatLoaded({required this.listRiwayat});
}

class RiwayatError extends RiwayatState {
  final String message;

  RiwayatError({required this.message});
}

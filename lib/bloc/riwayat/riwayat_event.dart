abstract class RiwayatEvent {}

class FetchRiwayatProfile extends RiwayatEvent {
  final int bulan;

  FetchRiwayatProfile({required this.bulan});
}

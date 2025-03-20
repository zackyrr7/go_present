class UserProfile {
  final String id;
  final String name;
  final String company;
  final String photo;
  final String position;
  final String jamMasuk;
  final String jamKeluar;
  final String tanggal;

  UserProfile({
    required this.id,
    required this.name,
    required this.company,
    required this.photo,
    required this.position,
    required this.jamMasuk,
    required this.jamKeluar,
    required this.tanggal,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['idpegawai'],
      name: json['nmpegawai'],
      company: json['perusahaan'],
      photo: json['foto'],
      position: json['jabatan'],
      jamMasuk: json['jammasuk'],
      jamKeluar: json['jampulang'],
      tanggal: json['tanggal'],
    );
  }
}

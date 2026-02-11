class Api {
  // GANTI sesuai environment lo
  static const String baseUrl = "http://localhost:8000/api";

  static const String login = "$baseUrl/login";
  static const String kategori = "$baseUrl/kategori";
  static const String ruangan = "$baseUrl/ruangan";
  static const String barang = "$baseUrl/barang";
  static const String barangMasuk = "$baseUrl/barang-masuk";
  static const String barangKeluar = "$baseUrl/barang-keluar";

  static const String refreshToken = "$baseUrl/refresh-token";
}
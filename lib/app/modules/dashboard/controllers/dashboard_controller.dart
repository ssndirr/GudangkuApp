import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:gudangku/app/utils/api.dart';

class DashboardController extends GetxController {
  final box = GetStorage();

  // ===== STATE =====
  var totalKategori = 0.obs;
  var totalRuangan = 0.obs;
  var totalBarang = 0.obs;
  RxInt totalStok = 0.obs;   
  var totalBarangMasuk = 0.obs;
  var totalBarangKeluar = 0.obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadDashboard();
  }

  // ===== HEADER =====
  Map<String, String> get headers => {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${box.read('token')}',
      };

  // ===== LOAD SEMUA =====
  Future<void> loadDashboard() async {
    try {
      isLoading.value = true;

      await Future.wait([
        fetchKategori(),
        fetchRuangan(),
        fetchBarang(),
        fetchBarangMasuk(),
        fetchBarangKeluar(),
      ]);
    } catch (e) {
      print("ERROR DASHBOARD: $e");
      Get.snackbar("Error", "Gagal memuat dashboard");
    } finally {
      isLoading.value = false;
    }
  }

  // ===== HELPER COUNT =====
  int extractCount(dynamic responseBody) {
    final decoded = jsonDecode(responseBody);

    if (decoded is List) {
      return decoded.length;
    }

    if (decoded is Map && decoded['data'] is List) {
      return decoded['data'].length;
    }

    return 0;
  }

  // ===== KATEGORI =====
  Future<void> fetchKategori() async {
    final response =
        await http.get(Uri.parse(Api.kategori), headers: headers);

    print("Kategori Response: ${response.body}");

    if (response.statusCode == 200) {
      totalKategori.value = extractCount(response.body);
    }
  }

  // ===== RUANGAN =====
  Future<void> fetchRuangan() async {
    final response =
        await http.get(Uri.parse(Api.ruangan), headers: headers);

    print("Ruangan Response: ${response.body}");

    if (response.statusCode == 200) {
      totalRuangan.value = extractCount(response.body);
    }
  }

  // ===== BARANG =====
    Future<void> fetchBarang() async {
    final response =
        await http.get(Uri.parse(Api.barang), headers: headers);

    print("Barang Response: ${response.body}");

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      // 1️⃣ Hitung jumlah barang
      totalBarang.value = (data['data'] as List).length;

      // 2️⃣ Hitung total stok
      int jumlahStok = 0;
      for (var item in data['data']) {
        jumlahStok += int.tryParse(item['stok'].toString()) ?? 0;
      }

      totalStok.value = jumlahStok;
    }
  }

  // ===== BARANG MASUK =====
  Future<void> fetchBarangMasuk() async {
    final response =
        await http.get(Uri.parse(Api.barangMasuk), headers: headers);

    print("Barang Masuk Response: ${response.body}");

    if (response.statusCode == 200) {
      totalBarangMasuk.value = extractCount(response.body);
    } else {
      totalBarangMasuk.value = 0;
    }
  }

  // ===== BARANG KELUAR =====
  Future<void> fetchBarangKeluar() async {
    final response =
        await http.get(Uri.parse(Api.barangKeluar), headers: headers);

    print("Barang Keluar Response: ${response.body}");

    if (response.statusCode == 200) {
      totalBarangKeluar.value = extractCount(response.body);
    } else {
      totalBarangKeluar.value = 0;
    }
  }

  // ===== REFRESH =====
  Future<void> refreshDashboard() async {
    await loadDashboard();
  }
}

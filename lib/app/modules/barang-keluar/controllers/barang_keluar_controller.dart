import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../../../utils/api.dart';

class BarangKeluarController extends GetxController {
  final box = GetStorage();

  final isLoading = false.obs;
  final barangKeluarList = <dynamic>[].obs;
  
  // Tambahan state agar sama dengan Barang Masuk
  final ruanganList = <dynamic>[].obs;
  final barangList = <dynamic>[].obs;
  final filteredBarangList = <dynamic>[].obs;
  final selectedRuanganId = Rxn<int>();
  final selectedBarangId = Rxn<int>();
  final selectedTanggal = Rxn<DateTime>();

  String get token => box.read('token') ?? '';

  @override
  void onInit() {
    fetchBarangKeluar();
    fetchRuanganDanBarang(); // Memanggil data pendukung
    super.onInit();
  }

  // ================= FETCH RUANGAN & BARANG (Sama dengan Barang Masuk) =================
  Future<void> fetchRuanganDanBarang() async {
    try {
      final ruanganResponse = await http.get(
        Uri.parse(Api.ruangan),
        headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
      );
      final ruanganData = jsonDecode(ruanganResponse.body);
      if (ruanganResponse.statusCode == 200 && ruanganData['status'] == true) {
        ruanganList.value = ruanganData['data'];
      }

      final barangResponse = await http.get(
        Uri.parse(Api.barang),
        headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
      );
      final barangData = jsonDecode(barangResponse.body);
      if (barangResponse.statusCode == 200) {
        barangList.value = barangData['data'];
      }
    } catch (e) {
      Get.snackbar("Error", "Gagal mengambil data ruangan/barang");
    }
  }

  // ================= HELPER METHODS =================
  void pilihRuangan(int ruanganId) {
    selectedRuanganId.value = ruanganId;
    selectedBarangId.value = null; // Reset barang jika ruangan berubah
    filteredBarangList.value =
        barangList.where((b) => b['ruangan_id'] == ruanganId).toList();
  }

  void resetForm() {
    selectedRuanganId.value = null;
    selectedBarangId.value = null;
    selectedTanggal.value = null;
    filteredBarangList.clear();
  }

  void preloadEdit(dynamic data) {
    final barang = barangList.firstWhereOrNull((b) => b['id'] == data['barang_id']);
    if (barang != null) {
      pilihRuangan(barang['ruangan_id']);
      selectedBarangId.value = data['barang_id'];
    }
    if (data['tanggal_keluar'] != null) {
      selectedTanggal.value = DateTime.tryParse(data['tanggal_keluar']);
    }
  }

  String get formattedTanggal {
    if (selectedTanggal.value == null) return '';
    final d = selectedTanggal.value!;
    return "${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}";
  }

  // ================= GET ALL =================
  Future<void> fetchBarangKeluar() async {
    try {
      isLoading.value = true;
      final response = await http.get(
        Uri.parse(Api.barangKeluar),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        barangKeluarList.value = jsonDecode(response.body);
      } else {
        Get.snackbar("Error", "Gagal mengambil data");
      }
    } catch (e) {
      Get.snackbar("Error", "Tidak dapat terhubung ke server");
    } finally {
      isLoading.value = false;
    }
  }

  // ================= TAMBAH =================
  Future<void> tambahBarangKeluar(String barangId, String tanggal, String jumlah) async {
    if (barangId.isEmpty || tanggal.isEmpty || jumlah.isEmpty) {
      Get.snackbar("Validasi", "Semua field wajib diisi");
      return;
    }

    try {
      isLoading.value = true;
      final response = await http.post(
        Uri.parse(Api.barangKeluar),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'barang_id': barangId,
          'tanggal_keluar': tanggal,
          'jumlah': jumlah,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 201) {
        Get.snackbar("Berhasil", data['message']);
        fetchBarangKeluar();
      } 
      else if (response.statusCode == 422) {
        // Khusus Barang Keluar: Handling Stok Tidak Cukup
        Get.snackbar(
          "Stok Tidak Cukup",
          "${data['message']} (Sisa stok: ${data['stok']})",
        );
      } 
      else {
        Get.snackbar("Gagal", data['message'] ?? "Gagal menambah data");
      }
    } catch (e) {
      Get.snackbar("Error", "Terjadi kesalahan");
    } finally {
      isLoading.value = false;
    }
  }

  // ================= UPDATE =================
  Future<void> updateBarangKeluar(int id, String barangId, String tanggal, String jumlah) async {
    try {
      isLoading.value = true;
      final response = await http.put(
        Uri.parse("${Api.barangKeluar}/$id"),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'barang_id': barangId,
          'tanggal_keluar': tanggal,
          'jumlah': jumlah,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        Get.snackbar("Berhasil", data['message']);
        fetchBarangKeluar();
      } 
      else if (response.statusCode == 422) {
        Get.snackbar(
          "Stok Tidak Cukup",
          "${data['message']} (Sisa stok: ${data['stok']})",
        );
      }
      else {
        Get.snackbar("Gagal", data['message'] ?? "Gagal update");
      }
    } catch (e) {
      Get.snackbar("Error", "Terjadi kesalahan");
    } finally {
      isLoading.value = false;
    }
  }

  // ================= DELETE =================
  Future<void> deleteBarangKeluar(int id) async {
    try {
      isLoading.value = true;
      final response = await http.delete(
        Uri.parse("${Api.barangKeluar}/$id"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        Get.snackbar("Berhasil", data['message']);
        fetchBarangKeluar();
      } else {
        Get.snackbar("Gagal", data['message']);
      }
    } catch (e) {
      Get.snackbar("Error", "Terjadi kesalahan");
    } finally {
      isLoading.value = false;
    }
  }
}
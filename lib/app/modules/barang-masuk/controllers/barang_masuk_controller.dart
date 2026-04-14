import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../../../utils/api.dart';

class BarangMasukController extends GetxController {
  final box = GetStorage();

  final isLoading = false.obs;
  final barangMasukList = <dynamic>[].obs;
  final ruanganList = <dynamic>[].obs;
  final barangList = <dynamic>[].obs;
  final filteredBarangList = <dynamic>[].obs;
  final selectedRuanganId = Rxn<int>();
  final selectedBarangId = Rxn<int>();
  final selectedTanggal = Rxn<DateTime>();

  String get token => box.read('token') ?? '';

  @override
  void onInit() {
    fetchBarangMasuk();
    fetchRuanganDanBarang();
    super.onInit();
  }

  // ================= FETCH RUANGAN & BARANG =================
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

  void pilihRuangan(int ruanganId) {
    selectedRuanganId.value = ruanganId;
    selectedBarangId.value = null;
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
    if (data['tanggal_masuk'] != null) {
      selectedTanggal.value = DateTime.tryParse(data['tanggal_masuk']);
    }
  }

  String get formattedTanggal {
    if (selectedTanggal.value == null) return '';
    final d = selectedTanggal.value!;
    return "${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}";
  }

  // ================= GET ALL =================
  Future<void> fetchBarangMasuk() async {
    try {
      isLoading.value = true;
      final response = await http.get(
        Uri.parse(Api.barangMasuk),
        headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        barangMasukList.value = jsonDecode(response.body);
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
  Future<void> tambahBarangMasuk(String barangId, String tanggal, String jumlah) async {
    if (barangId.isEmpty || tanggal.isEmpty || jumlah.isEmpty) {
      Get.snackbar("Validasi", "Semua field wajib diisi");
      return;
    }
    try {
      isLoading.value = true;
      final response = await http.post(
        Uri.parse(Api.barangMasuk),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'barang_id': barangId, 'tanggal_masuk': tanggal, 'jumlah': jumlah}),
      );
      final data = jsonDecode(response.body);
      if (response.statusCode == 201) {
        Get.snackbar("Berhasil", data['message']);
        fetchBarangMasuk();
      } else {
        Get.snackbar("Gagal", data['message'] ?? 'Gagal menambah data');
      }
    } catch (e) {
      Get.snackbar("Error", "Terjadi kesalahan");
    } finally {
      isLoading.value = false;
    }
  }

  // ================= UPDATE =================
  Future<void> updateBarangMasuk(int id, String barangId, String tanggal, String jumlah) async {
    try {
      isLoading.value = true;
      final response = await http.put(
        Uri.parse("${Api.barangMasuk}/$id"),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'barang_id': barangId, 'tanggal_masuk': tanggal, 'jumlah': jumlah}),
      );
      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        Get.snackbar("Berhasil", data['message']);
        fetchBarangMasuk();
      } else {
        Get.snackbar("Gagal", data['message'] ?? 'Gagal update');
      }
    } catch (e) {
      Get.snackbar("Error", "Terjadi kesalahan");
    } finally {
      isLoading.value = false;
    }
  }

  // ================= DELETE =================
  Future<void> deleteBarangMasuk(int id) async {
    try {
      isLoading.value = true;
      final response = await http.delete(
        Uri.parse("${Api.barangMasuk}/$id"),
        headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
      );
      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        Get.snackbar("Berhasil", data['message']);
        fetchBarangMasuk();
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
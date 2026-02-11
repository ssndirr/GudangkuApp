import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../../../utils/api.dart';

class BarangMasukController extends GetxController {
  final box = GetStorage();

  final isLoading = false.obs;
  final barangMasukList = <dynamic>[].obs;

  String get token => box.read('token') ?? '';

  @override
  void onInit() {
    fetchBarangMasuk();
    super.onInit();
  }

  // ================= GET ALL =================
  Future<void> fetchBarangMasuk() async {
    try {
      isLoading.value = true;

      final response = await http.get(
        Uri.parse(Api.barangMasuk),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
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
  Future<void> tambahBarangMasuk(
      String barangId, String tanggal, String jumlah) async {
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
        body: jsonEncode({
          'barang_id': barangId,
          'tanggal_masuk': tanggal,
          'jumlah': jumlah,
        }),
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
  Future<void> updateBarangMasuk(
      int id, String barangId, String tanggal, String jumlah) async {
    try {
      isLoading.value = true;

      final response = await http.put(
        Uri.parse("${Api.barangMasuk}/$id"),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'barang_id': barangId,
          'tanggal_masuk': tanggal,
          'jumlah': jumlah,
        }),
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
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
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

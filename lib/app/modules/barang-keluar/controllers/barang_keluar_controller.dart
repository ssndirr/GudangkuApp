import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../../../utils/api.dart';

class BarangKeluarController extends GetxController {
  final box = GetStorage();

  final isLoading = false.obs;
  final barangKeluarList = <dynamic>[].obs;

  String get token => box.read('token') ?? '';

  @override
  void onInit() {
    fetchBarangKeluar();
    super.onInit();
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
  Future<void> tambahBarangKeluar(
      String barangId, String tanggal, String jumlah) async {

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
  Future<void> updateBarangKeluar(
      int id, String barangId, String tanggal, String jumlah) async {

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

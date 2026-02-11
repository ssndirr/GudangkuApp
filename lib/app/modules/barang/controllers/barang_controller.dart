import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../../../utils/api.dart';

class BarangController extends GetxController {
  final box = GetStorage();

  var barangList = [].obs;
  var isLoading = false.obs;

  String get token => box.read('token') ?? '';

  // ================= GET DATA =================
  Future<void> getBarang() async {
    try {
      isLoading.value = true;

      final response = await http.get(
        Uri.parse(Api.barang),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        barangList.value = data['data'];
      }
    } catch (e) {
      Get.snackbar("Error", "Gagal mengambil data");
    } finally {
      isLoading.value = false;
    }
  }

  // ================= TAMBAH =================
  Future<void> tambahBarang(
      String nama, String kategoriId, String ruanganId) async {
    try {
      isLoading.value = true;

      final response = await http.post(
        Uri.parse(Api.barang),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: {
          "nama_barang": nama,
          "kategori_id": kategoriId,
          "ruangan_id": ruanganId,
        },
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 201) {
        Get.snackbar("Sukses", data['message']);
        getBarang();
      } else {
        Get.snackbar("Gagal", data['message'] ?? "Gagal tambah");
      }
    } catch (e) {
      Get.snackbar("Error", "Terjadi kesalahan");
    } finally {
      isLoading.value = false;
    }
  }

  // ================= UPDATE =================
  Future<void> updateBarang(
      int id, String nama, String kategoriId, String ruanganId) async {
    try {
      isLoading.value = true;

      final response = await http.put(
        Uri.parse("${Api.barang}/$id"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: {
          "nama_barang": nama,
          "kategori_id": kategoriId,
          "ruangan_id": ruanganId,
        },
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        Get.snackbar("Sukses", data['message']);
        getBarang();
      } else {
        Get.snackbar("Gagal", data['message'] ?? "Gagal update");
      }
    } catch (e) {
      Get.snackbar("Error", "Terjadi kesalahan");
    } finally {
      isLoading.value = false;
    }
  }

  // ================= DELETE =================
  Future<void> hapusBarang(int id) async {
    try {
      isLoading.value = true;

      final response = await http.delete(
        Uri.parse("${Api.barang}/$id"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        Get.snackbar("Sukses", data['message']);
        getBarang();
      } else {
        Get.snackbar("Gagal", data['message']);
      }
    } catch (e) {
      Get.snackbar("Error", "Terjadi kesalahan");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    getBarang();
    super.onInit();
  }
}

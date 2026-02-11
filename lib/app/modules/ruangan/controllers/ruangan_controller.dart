import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../../../utils/api.dart';

class RuanganController extends GetxController {
  final box = GetStorage();

  final ruanganList = <dynamic>[].obs;
  final ruanganDetail = {}.obs;
  final isLoading = false.obs;

  String get token => box.read('token') ?? '';

  @override
  void onInit() {
    fetchRuangan();
    super.onInit();
  }

  // ==============================
  // GET ALL RUANGAN
  // ==============================
  Future<void> fetchRuangan() async {
    try {
      isLoading.value = true;

      final response = await http.get(
        Uri.parse(Api.ruangan),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['status'] == true) {
        ruanganList.value = data['data'];
      } else {
        Get.snackbar('Error', data['message'] ?? 'Gagal mengambil data');
      }
    } catch (e) {
      Get.snackbar('Error', 'Tidak dapat terhubung ke server');
    } finally {
      isLoading.value = false;
    }
  }

  // ==============================
  // TAMBAH RUANGAN
  // ==============================
  Future<void> tambahRuangan(String namaRuangan, String lokasi) async {
    try {
      isLoading.value = true;

      final response = await http.post(
        Uri.parse(Api.ruangan),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'nama_ruangan': namaRuangan,
          'lokasi': lokasi,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 201 && data['status'] == true) {
        Get.snackbar('Berhasil', data['message']);
        fetchRuangan();
      } else {
        Get.snackbar('Gagal', data['message'] ?? 'Gagal menambahkan');
      }
    } catch (e) {
      Get.snackbar('Error', 'Terjadi kesalahan');
    } finally {
      isLoading.value = false;
    }
  }

  // ==============================
  // UPDATE RUANGAN
  // ==============================
  Future<void> updateRuangan(
      int id, String namaRuangan, String lokasi) async {
    try {
      isLoading.value = true;

      final response = await http.put(
        Uri.parse("${Api.ruangan}/$id"),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'nama_ruangan': namaRuangan,
          'lokasi': lokasi,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['status'] == true) {
        Get.snackbar('Berhasil', data['message']);
        fetchRuangan();
      } else {
        Get.snackbar('Gagal', data['message'] ?? 'Gagal update');
      }
    } catch (e) {
      Get.snackbar('Error', 'Terjadi kesalahan');
    } finally {
      isLoading.value = false;
    }
  }

  // ==============================
  // DELETE RUANGAN
  // ==============================
  Future<void> deleteRuangan(int id) async {
    try {
      isLoading.value = true;

      final response = await http.delete(
        Uri.parse("${Api.ruangan}/$id"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['status'] == true) {
        Get.snackbar('Berhasil', data['message']);
        fetchRuangan();
      } else if (response.statusCode == 409) {
        Get.snackbar('Gagal', data['message']);
      } else {
        Get.snackbar('Error', data['message'] ?? 'Gagal menghapus');
      }
    } catch (e) {
      Get.snackbar('Error', 'Terjadi kesalahan');
    } finally {
      isLoading.value = false;
    }
  }
}

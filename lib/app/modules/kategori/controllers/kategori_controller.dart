import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../../../utils/api.dart';

class KategoriController extends GetxController {
  final box = GetStorage();

  final kategoriList = <dynamic>[].obs;
  final isLoading = false.obs;

  String get token => box.read('token') ?? '';

  @override
  void onInit() {
    fetchKategori();
    super.onInit();
  }

  // ==============================
  // GET DATA
  // ==============================
  Future<void> fetchKategori() async {
    try {
      isLoading.value = true;

      final response = await http.get(
        Uri.parse(Api.kategori),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        kategoriList.value = data['data'];
      } else {
        Get.snackbar(
          'Error',
          data['message'] ?? 'Gagal mengambil data',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Tidak dapat terhubung ke server',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // ==============================
  // TAMBAH
  // ==============================
  Future<void> tambahKategori(String namaKategori) async {
    try {
      isLoading.value = true;

      final response = await http.post(
        Uri.parse(Api.kategori),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'nama_kategori': namaKategori,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 201 && data['status'] == true) {
        Get.snackbar(
          'Berhasil',
          data['message'],
          snackPosition: SnackPosition.BOTTOM,
        );
        fetchKategori();
      } else {
        Get.snackbar(
          'Gagal',
          data['message'] ?? 'Gagal menambahkan',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Terjadi kesalahan',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // ==============================
  // UPDATE
  // ==============================
  Future<void> updateKategori(int id, String namaKategori) async {
    try {
      isLoading.value = true;

      final response = await http.put(
        Uri.parse("${Api.kategori}/$id"),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'nama_kategori': namaKategori,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['status'] == true) {
        Get.snackbar(
          'Berhasil',
          data['message'],
          snackPosition: SnackPosition.BOTTOM,
        );
        fetchKategori();
      } else {
        Get.snackbar(
          'Gagal',
          data['message'] ?? 'Gagal update',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Terjadi kesalahan',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // ==============================
  // DELETE
  // ==============================
  Future<void> deleteKategori(int id) async {
    try {
      isLoading.value = true;

      final response = await http.delete(
        Uri.parse("${Api.kategori}/$id"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['status'] == true) {
        Get.snackbar(
          'Berhasil',
          data['message'],
          snackPosition: SnackPosition.BOTTOM,
        );
        fetchKategori();
      } else if (response.statusCode == 409) {
        Get.snackbar(
          'Gagal',
          data['message'],
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        Get.snackbar(
          'Error',
          data['message'] ?? 'Gagal menghapus',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Terjadi kesalahan',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }
}

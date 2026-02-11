import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../../../utils/api.dart';

class HomeController extends GetxController {
  final box = GetStorage();

  var ruanganList = [].obs;
  var barangList = [].obs;
  var filteredBarang = [].obs;

  var selectedRuanganId = 0.obs;
  var isLoading = false.obs;

  String get token => box.read('token') ?? '';

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  Future<void> fetchData() async {
    try {
      isLoading.value = true;

      // GET RUANGAN
      final ruanganResponse = await http.get(
        Uri.parse(Api.ruangan),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      final ruanganData = jsonDecode(ruanganResponse.body);

      if (ruanganResponse.statusCode == 200 &&
          ruanganData['status'] == true) {
        ruanganList.value = ruanganData['data'];

        if (ruanganList.isNotEmpty) {
          selectedRuanganId.value = ruanganList.first['id'];
        }
      }

      // GET BARANG
      final barangResponse = await http.get(
        Uri.parse(Api.barang),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      final barangData = jsonDecode(barangResponse.body);

      if (barangResponse.statusCode == 200) {
        barangList.value = barangData['data'];
      }

      filterBarang();
    } catch (e) {
      Get.snackbar('Error', 'Gagal mengambil data');
    } finally {
      isLoading.value = false;
    }
  }

  void pilihRuangan(int id) {
    selectedRuanganId.value = id;
    filterBarang();
  }

  void filterBarang() {
    filteredBarang.value = barangList
        .where((barang) =>
            barang['ruangan_id'] == selectedRuanganId.value)
        .toList();
  }

  void searchBarang(String keyword) {
    if (keyword.isEmpty) {
      filterBarang();
    } else {
      filteredBarang.value = barangList.where((barang) {
        return barang['nama_barang']
                .toString()
                .toLowerCase()
                .contains(keyword.toLowerCase()) &&
            barang['ruangan_id'] == selectedRuanganId.value;
      }).toList();
    }
  }
}

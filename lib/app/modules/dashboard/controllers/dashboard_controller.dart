import 'package:get/get.dart';

class DashboardController extends GetxController {

  var totalKategori = 0.obs;
  var totalRuangan = 0.obs;
  var totalBarang = 0.obs;
  var totalBarangMasuk = 0.obs;
  var totalBarangKeluar = 0.obs;

  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadDashboard();
  }

  void loadDashboard() async {
    await Future.delayed(const Duration(seconds: 1));

    // TODO: ganti dengan API call
    totalKategori.value = 5;
    totalRuangan.value = 3;
    totalBarang.value = 120;
    totalBarangMasuk.value = 50;
    totalBarangKeluar.value = 30;

    isLoading.value = false;
  }

  Future<void> fetchDashboardData() async {}
}

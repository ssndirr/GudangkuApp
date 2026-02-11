import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gudangku/app/routes/app_pages.dart';
import 'package:gudangku/app/utils/api.dart';
import 'package:http/http.dart' as http;

// import '../../utils/api.dart';
// import '../../routes/app_pages.dart';

class AuthController extends GetxController {
  final box = GetStorage();

  // ===== STATE =====
  final isLoading = false.obs;
  final isPasswordHidden = true.obs;

  // ===== TOGGLE PASSWORD =====
  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  // ===== LOGIN =====
  Future<void> login(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      Get.snackbar(
        'Validasi',
        'Email dan password wajib diisi',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      isLoading.value = true;

      final response = await http.post(
        Uri.parse(Api.login),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['status'] == true) {
        // ===== SIMPAN KE STORAGE =====
        box.write('token', data['token']);
        box.write('user', data['user']);

        // ===== REDIRECT BERDASARKAN ROLE =====
        final redirect = data['redirect'];

        Get.snackbar(
          'Berhasil',
          data['message'],
          snackPosition: SnackPosition.BOTTOM,
        );

        if (redirect == 'dashboard') {
          Get.offAllNamed(Routes.DASHBOARD);
        } else {
          Get.offAllNamed(Routes.HOME);
        }
      } else {
        Get.snackbar(
          'Gagal',
          data['message'] ?? 'Login gagal',
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

  // ===== LOGOUT =====
  void logout() {
    box.erase();
    Get.offAllNamed(Routes.LOGIN);
  }
}

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProfileController extends GetxController {
  final box = GetStorage();
  
  // ===== STATE =====
  var userName = ''.obs;
  var userEmail = ''.obs;
  var userRole = ''.obs;
  var userPhone = ''.obs;
  var userAvatar = ''.obs;
  var userId = ''.obs;
  
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // ===== LOAD USER DATA FROM STORAGE =====
  void loadUserData() {
    try {
      final user = box.read('user');
      
      if (user != null) {
        // Jika user adalah Map
        if (user is Map) {
          userName.value = user['name']?.toString() ?? 'User';
          userEmail.value = user['email']?.toString() ?? '-';
          userRole.value = user['role']?.toString() ?? 'User';
          userPhone.value = user['phone']?.toString() ?? '-';
          userAvatar.value = user['avatar']?.toString() ?? '';
          userId.value = user['id']?.toString() ?? '';
        } else {
          userName.value = 'User';
          userEmail.value = '-';
          userRole.value = 'User';
        }
      } else {
        // Data default jika tidak ada user
        userName.value = 'Guest';
        userEmail.value = '-';
        userRole.value = 'Guest';
      }
    } catch (e) {
      print('Error loading user data: $e');
      userName.value = 'Error';
      userEmail.value = '-';
      userRole.value = '-';
    }
  }

  // ===== REFRESH DATA =====
  void refreshData() {
    loadUserData();
    Get.snackbar(
      'Berhasil',
      'Data profil diperbarui',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  // ===== GET USER TOKEN =====
  String? getToken() {
    return box.read('token');
  }

  // ===== CHECK IF USER LOGGED IN =====
  bool isLoggedIn() {
    return box.read('token') != null;
  }
}
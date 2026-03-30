import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';
import '../../auth/controllers/auth_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  // Premium Color Palette
  static const Color primaryBrown = Color(0xFF3E2723);
  static const Color accentGold = Color(0xFFD4AF37);
  static const Color lightGold = Color(0xFFFFD700);
  static const Color softBeige = Color(0xFFFDFBF7);

  @override
  Widget build(BuildContext context) {
    final authC = Get.find<AuthController>();

    return Scaffold(
      backgroundColor: softBeige,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 70,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [primaryBrown, Color(0xFF5D4037)],
            ),
          ),
        ),
        title: const Text(
          'Profil Saya',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            fontSize: 20,
            letterSpacing: 0.5,
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 20),

              // Profile Avatar Section
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [accentGold, lightGold],
                  ),
                  border: Border.all(
                    color: Colors.white,
                    width: 5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: accentGold.withOpacity(0.4),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.person,
                  size: 56,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 24),

              // User Name
              Text(
                controller.userName.value,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: primaryBrown,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 12),

              // User Email Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                decoration: BoxDecoration(
                  color: accentGold.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: accentGold.withOpacity(0.3),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.email_outlined,
                      size: 18,
                      color: accentGold,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      controller.userEmail.value,
                      style: const TextStyle(
                        color: primaryBrown,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // User Role Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [accentGold, lightGold],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: accentGold.withOpacity(0.4),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Text(
                  controller.userRole.value.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
              ),

              const SizedBox(height: 36),

              // User Info Card
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: primaryBrown.withOpacity(0.08),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Icon(
                          Icons.info_outline_rounded,
                          color: accentGold,
                          size: 24,
                        ),
                        SizedBox(width: 12),
                        Text(
                          'Informasi Akun',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: primaryBrown,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    _buildInfoRow(
                      icon: Icons.person_outline_rounded,
                      label: 'Nama Lengkap',
                      value: controller.userName.value,
                    ),
                    const SizedBox(height: 18),
                    Divider(height: 1, color: Colors.grey[200]),
                    const SizedBox(height: 18),
                    _buildInfoRow(
                      icon: Icons.email_outlined,
                      label: 'Email',
                      value: controller.userEmail.value,
                    ),
                    const SizedBox(height: 18),
                    Divider(height: 1, color: Colors.grey[200]),
                    const SizedBox(height: 18),
                    _buildInfoRow(
                      icon: Icons.badge_outlined,
                      label: 'Status',
                      value: controller.userRole.value,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // Logout Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    Get.defaultDialog(
                      title: 'Konfirmasi Logout',
                      titleStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: primaryBrown,
                        fontSize: 20,
                      ),
                      middleText: 'Apakah Anda yakin ingin keluar dari akun?',
                      middleTextStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                      ),
                      textConfirm: 'Ya, Keluar',
                      textCancel: 'Batal',
                      confirmTextColor: Colors.white,
                      buttonColor: const Color(0xFFE53935),
                      cancelTextColor: accentGold,
                      radius: 14,
                      onConfirm: () {
                        Get.back();
                        authC.logout();
                        Get.snackbar(
                          'Berhasil',
                          'Anda telah keluar dari aplikasi',
                          backgroundColor: const Color(0xFF43A047),
                          colorText: Colors.white,
                          snackPosition: SnackPosition.BOTTOM,
                          icon: const Icon(
                            Icons.check_circle_rounded,
                            color: Colors.white,
                          ),
                          margin: const EdgeInsets.all(16),
                          borderRadius: 14,
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE53935),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 4,
                    shadowColor: const Color(0xFFE53935).withOpacity(0.4),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.logout_rounded,
                        color: Colors.white,
                        size: 22,
                      ),
                      SizedBox(width: 12),
                      Text(
                        'Keluar dari Akun',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        );
      }),
      bottomNavigationBar: _buildBottomNavBar(2),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [accentGold.withOpacity(0.2), accentGold.withOpacity(0.1)],
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: accentGold, size: 22),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: primaryBrown,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNavBar(int currentIndex) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      decoration: BoxDecoration(
        color: primaryBrown,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: primaryBrown.withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          currentIndex: currentIndex,
          selectedItemColor: lightGold,
          unselectedItemColor: Colors.white.withOpacity(0.5),
          showSelectedLabels: true,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            if (index == 0) Get.offAllNamed('/home');
            if (index == 1) Get.offAllNamed('/dashboard');
            if (index == 2) Get.offAllNamed('/profile');
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_max_rounded), label: 'Beranda'),
            BottomNavigationBarItem(icon: Icon(Icons.analytics_outlined), label: 'Stats'),
            BottomNavigationBarItem(icon: Icon(Icons.account_circle_outlined), label: 'Profil'),
          ],
        ),
      ),
    );
  }
}
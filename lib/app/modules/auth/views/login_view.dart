import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gudangku/app/modules/auth/controllers/auth_controller.dart';

class LoginView extends GetView<AuthController> {
  LoginView({super.key});

  // Premium Color Palette
  static const Color primaryBrown = Color(0xFF3E2723);
  static const Color accentGold = Color(0xFFD4AF37);
  static const Color lightGold = Color(0xFFFFD700);
  static const Color softBeige = Color(0xFFFDFBF7);

  final AuthController c = Get.put(AuthController());
  final emailC = TextEditingController();
  final passwordC = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: softBeige,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              primaryBrown,
              Color(0xFF5D4037),
              Color(0xFF6B4423),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  // Logo Premium
                  Hero(
                    tag: 'mebel_logo',
                    child: Container(
                      padding: const EdgeInsets.all(22),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: accentGold.withOpacity(0.5),
                            blurRadius: 30,
                            spreadRadius: 8,
                          ),
                        ],
                      ),
                      child: Container(
                        width: 90,
                        height: 90,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              accentGold,
                              lightGold,
                            ],
                          ),
                        ),
                        child: const Icon(
                          Icons.warehouse_outlined,
                          size: 48,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 36),
                  // Title & Subtitle
                  const Text(
                    'GudangKu Mebel',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: 2.0,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 3,
                    width: 60,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [accentGold, lightGold],
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'SISTEM MANAJEMEN INVENTORI',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: accentGold,
                      letterSpacing: 2.0,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Kelola stok furniture & mebel dengan sistem terpadu',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 44),
                  // Login Form Card
                  Container(
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(28),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 30,
                          offset: const Offset(0, 15),
                        ),
                      ],
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [accentGold, lightGold],
                                  ),
                                  borderRadius: BorderRadius.circular(14),
                                  boxShadow: [
                                    BoxShadow(
                                      color: accentGold.withOpacity(0.3),
                                      blurRadius: 10,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: const Icon(
                                  Icons.login_rounded,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ),
                              const SizedBox(width: 14),
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Login Gudang',
                                    style: TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold,
                                      color: primaryBrown,
                                    ),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    'Akses sistem manajemen inventori',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 36),
                          // Email Field
                          Container(
                            decoration: BoxDecoration(
                              color: softBeige,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: accentGold.withOpacity(0.3),
                                width: 2,
                              ),
                            ),
                            child: TextFormField(
                              controller: emailC,
                              keyboardType: TextInputType.emailAddress,
                              style: const TextStyle(fontSize: 15),
                              decoration: const InputDecoration(
                                labelText: 'Email / Username',
                                hintText: 'Masukkan email atau username',
                                prefixIcon: Icon(
                                  Icons.person_outline_rounded,
                                  color: accentGold,
                                  size: 22,
                                ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.all(18),
                                labelStyle: TextStyle(
                                  color: primaryBrown,
                                  fontWeight: FontWeight.w600,
                                ),
                                hintStyle: TextStyle(color: Colors.grey),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Masukkan email atau username';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(height: 20),
                          // Password Field
                          Obx(
                            () => Container(
                              decoration: BoxDecoration(
                                color: softBeige,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: accentGold.withOpacity(0.3),
                                  width: 2,
                                ),
                              ),
                              child: TextFormField(
                                controller: passwordC,
                                obscureText: c.isPasswordHidden.value,
                                style: const TextStyle(fontSize: 15),
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  hintText: 'Masukkan password',
                                  prefixIcon: const Icon(
                                    Icons.lock_outline_rounded,
                                    color: accentGold,
                                    size: 22,
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      c.isPasswordHidden.value
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                      color: accentGold,
                                    ),
                                    onPressed: c.togglePasswordVisibility,
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.all(18),
                                  labelStyle: const TextStyle(
                                    color: primaryBrown,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  hintStyle: const TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Masukkan password';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 18),
                          // Forgot Password
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                Get.snackbar(
                                  'Lupa Password',
                                  'Hubungi admin untuk reset password',
                                  backgroundColor: accentGold,
                                  colorText: Colors.white,
                                  icon: const Icon(
                                    Icons.info_outline,
                                    color: Colors.white,
                                  ),
                                  borderRadius: 14,
                                  margin: const EdgeInsets.all(16),
                                );
                              },
                              child: const Text(
                                'Lupa Password?',
                                style: TextStyle(
                                  color: accentGold,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 32),
                          // Login Button
                          Obx(
                            () => Container(
                              width: double.infinity,
                              height: 58,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [accentGold, lightGold],
                                ),
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: accentGold.withOpacity(0.5),
                                    blurRadius: 20,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(16),
                                  onTap: c.isLoading.value
                                      ? null
                                      : () {
                                          if (_formKey.currentState!.validate()) {
                                            c.login(
                                              emailC.text,
                                              passwordC.text,
                                            );
                                          }
                                        },
                                  child: Center(
                                    child: c.isLoading.value
                                        ? const SizedBox(
                                            width: 26,
                                            height: 26,
                                            child: CircularProgressIndicator(
                                              valueColor: AlwaysStoppedAnimation(
                                                Colors.white,
                                              ),
                                              strokeWidth: 3,
                                            ),
                                          )
                                        : const Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.login_rounded,
                                                color: Colors.white,
                                                size: 24,
                                              ),
                                              SizedBox(width: 14),
                                              Text(
                                                'Masuk ke Sistem',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold,
                                                  letterSpacing: 0.5,
                                                ),
                                              ),
                                            ],
                                          ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 32),
                          // Info Box
                          Container(
                            padding: const EdgeInsets.all(18),
                            decoration: BoxDecoration(
                              color: accentGold.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: accentGold.withOpacity(0.3),
                                width: 1.5,
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: accentGold.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Icon(
                                    Icons.security_rounded,
                                    color: accentGold,
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(width: 14),
                                const Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Akses Terbatas',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: primaryBrown,
                                          fontSize: 13,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        'Login hanya untuk staff dan admin berwenang',
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: Colors.grey,
                                          height: 1.3,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 36),
                  // Warehouse Badge
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.3),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(
                          Icons.verified_outlined,
                          color: accentGold,
                          size: 22,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'SISTEM TERPERCAYA',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Footer
                  const Text(
                    'Butuh bantuan? Hubungi admin gudang',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
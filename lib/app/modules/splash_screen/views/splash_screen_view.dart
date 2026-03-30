import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gudangku/app/modules/splash_screen/controllers/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  SplashScreenView({Key? key}) : super(key: key);

  // Premium Color Palette
  static const Color primaryBrown = Color(0xFF3E2723);
  static const Color mediumBrown = Color(0xFF5D4037);
  static const Color accentGold = Color(0xFFD4AF37);
  static const Color lightGold = Color(0xFFFFD700);
  static const Color softBeige = Color(0xFFFDFBF7);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 360 || size.height < 640;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              primaryBrown,
              mediumBrown,
              Color(0xFF6B4423),
            ],
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isSmallScreen ? 16 : 20,
                        vertical: 16,
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            flex: isSmallScreen ? 6 : 7,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _buildAnimatedLogo(isSmallScreen),
                                  SizedBox(height: isSmallScreen ? 20 : 30),
                                  _buildTitleSection(isSmallScreen),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: _buildLoadingSection(),
                          ),
                          Expanded(
                            flex: 1,
                            child: _buildBottomSection(isSmallScreen),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedLogo(bool isSmallScreen) {
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 1500),
      tween: Tween<double>(begin: 0.0, end: 1.0),
      curve: Curves.elasticOut,
      builder: (context, double value, child) {
        return Transform.scale(
          scale: value,
          child: Transform.rotate(
            angle: (1 - value) * 1.5,
            child: Hero(
              tag: 'gudang_logo',
              child: Container(
                padding: EdgeInsets.all(isSmallScreen ? 18 : 22),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: accentGold.withOpacity(0.5),
                      blurRadius: 30,
                      offset: const Offset(0, 15),
                    ),
                  ],
                ),
                child: Container(
                  width: isSmallScreen ? 80 : 100,
                  height: isSmallScreen ? 80 : 100,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        mediumBrown,
                        accentGold,
                      ],
                    ),
                  ),
                  child: Icon(
                    Icons.warehouse_outlined,
                    size: isSmallScreen ? 40 : 50,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTitleSection(bool isSmallScreen) {
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 1200),
      tween: Tween<Offset>(begin: const Offset(0, 50), end: const Offset(0, 0)),
      curve: Curves.easeOutBack,
      builder: (context, Offset offset, child) {
        return Transform.translate(
          offset: offset,
          child: Opacity(
            opacity: offset == const Offset(0, 0) ? 1.0 : 0.0,
            child: Column(
              children: [
                Text(
                  'GudangKu',
                  style: TextStyle(
                    fontSize: isSmallScreen ? 32 : 40,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    letterSpacing: 2.0,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Sistem Manajemen Mebel',
                  style: TextStyle(
                    fontSize: isSmallScreen ? 16 : 20,
                    color: accentGold,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: isSmallScreen ? 14 : 20,
                    vertical: isSmallScreen ? 8 : 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: accentGold.withOpacity(0.5),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.inventory_2_outlined,
                        color: accentGold,
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Kelola inventori dengan mudah',
                        style: TextStyle(
                          fontSize: isSmallScreen ? 12 : 14,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLoadingSection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.chair_outlined,
              color: accentGold,
              size: 20,
            ),
            SizedBox(width: 8),
            Text(
              'Memuat data gudang...',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Container(
          width: double.infinity,
          constraints: const BoxConstraints(maxWidth: 280),
          height: 6,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Obx(
            () => Align(
              alignment: Alignment.centerLeft,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 100),
                width: 280 * controller.progress.value,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      accentGold,
                      lightGold,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: accentGold.withOpacity(0.5),
                      blurRadius: 8,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Obx(
          () => Text(
            '${(controller.progress.value * 100).toInt()}%',
            style: const TextStyle(
              color: accentGold,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomSection(bool isSmallScreen) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(
                Icons.verified_outlined,
                color: accentGold,
                size: 16,
              ),
              SizedBox(width: 6),
              Text(
                'Terpercaya & Aman',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Version 1.0.0',
          style: TextStyle(
            color: Colors.white54,
            fontSize: isSmallScreen ? 10 : 12,
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
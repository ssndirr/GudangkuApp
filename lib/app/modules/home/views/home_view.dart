import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  // Skema Warna Premium (Cokelat & Emas/Kuning)
  static const Color primaryBrown = Color(0xFF3E2723); // Cokelat Tua Ebony
  static const Color accentGold = Color(0xFFD4AF37);  // Emas Klasik
  static const Color lightGold = Color(0xFFFFD700);   // Kuning Emas Cerah
  static const Color softBeige = Color(0xFFFDFBF7);  // Background Putih Gading
  static const Color surfaceWhite = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: softBeige,
      
      // ================= CUSTOM APPBAR =================
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
        title: Column(
          children: [
            const Text(
              'GudangKu Mebel',
              style: TextStyle(
                color: accentGold,
                fontWeight: FontWeight.w900,
                fontSize: 22,
                letterSpacing: 1.2,
              ),
            ),
            Container(
              height: 2,
              width: 40,
              decoration: BoxDecoration(
                color: lightGold,
                borderRadius: BorderRadius.circular(10),
              ),
            )
          ],
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: PopupMenuButton<String>(
              icon: const Icon(Icons.tune_rounded, color: lightGold, size: 28),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              onSelected: (value) {
                if (value == 'masuk') Get.toNamed('/barang-masuk');
                if (value == 'keluar') Get.toNamed('/barang-keluar');
              },
              itemBuilder: (context) => [
                _buildPopupItem('masuk', Icons.add_circle_outline, "Barang Masuk", Colors.green),
                _buildPopupItem('keluar', Icons.remove_circle_outline, "Barang Keluar", Colors.redAccent),
              ],
            ),
          ),
        ],
      ),

      // ================= BODY =================
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(accentGold),
            ),
          );
        }

        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Decoration
              Stack(
                children: [
                  Container(
                    height: 80,
                    decoration: const BoxDecoration(
                      color: primaryBrown,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                  ),
                  _buildSearchBar(),
                ],
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Katalog barang",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: primaryBrown,
                      ),
                    ),
                    Text(
                      "${controller.ruanganList.length} Ruang",
                      style: TextStyle(color: accentGold, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),

              // ================= TAB RUANGAN =================
              _buildRuanganTabs(),

              const Padding(
                padding: EdgeInsets.fromLTRB(20, 24, 20, 12),
                child: Text(
                  "Koleksi Inventaris",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: primaryBrown,
                  ),
                ),
              ),

              // ================= LIST BARANG =================
              _buildBarangList(),
              
              const SizedBox(height: 100), // Spacing for BottomNav
            ],
          ),
        );
      }),

      extendBody: true,
      bottomNavigationBar: _buildBottomNavBar(0),
    );
  }

  // --- WIDGET HELPER: SEARCH BAR ---
  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          color: surfaceWhite,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: primaryBrown.withOpacity(0.15),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: TextField(
          onChanged: controller.searchBarang,
          decoration: InputDecoration(
            hintText: "Cari furniture eksklusif...",
            hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 15),
            prefixIcon: const Icon(Icons.search_rounded, color: accentGold),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 15),
          ),
        ),
      ),
    );
  }

  // --- WIDGET HELPER: TABS ---
  Widget _buildRuanganTabs() {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        scrollDirection: Axis.horizontal,
        itemCount: controller.ruanganList.length,
        itemBuilder: (context, index) {
          final ruangan = controller.ruanganList[index];
          final isActive = controller.selectedRuanganId.value == ruangan['id'];

          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            child: InkWell(
              onTap: () => controller.pilihRuangan(ruangan['id']),
              borderRadius: BorderRadius.circular(14),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                  gradient: isActive 
                    ? const LinearGradient(colors: [accentGold, lightGold])
                    : null,
                  color: isActive ? null : surfaceWhite,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: isActive ? [
                    BoxShadow(
                      color: accentGold.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    )
                  ] : null,
                  border: Border.all(
                    color: isActive ? Colors.transparent : Colors.grey.shade200,
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  ruangan['nama_ruangan'],
                  style: TextStyle(
                    color: isActive ? primaryBrown : Colors.grey.shade600,
                    fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // --- WIDGET HELPER: BARANG LIST ---
  Widget _buildBarangList() {
    if (controller.filteredBarang.isEmpty) {
      return Center(
        child: Column(
          children: [
            const SizedBox(height: 50),
            Icon(Icons.inventory_2_outlined, size: 80, color: Colors.grey.shade300),
            const SizedBox(height: 16),
            Text("Tidak ada barang ditemukan", 
              style: TextStyle(color: Colors.grey.shade500, fontSize: 16)),
          ],
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: controller.filteredBarang.length,
      itemBuilder: (context, index) {
        final barang = controller.filteredBarang[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: surfaceWhite,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: IntrinsicHeight(
            child: Row(
              children: [
                // Gold Accent Side Decor
                Container(
                  width: 6,
                  decoration: const BoxDecoration(
                    color: accentGold,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // Text Info
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          barang['nama_barang'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryBrown,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Text(
                              "Tersedia:",
                              style: TextStyle(color: Colors.grey.shade500, fontSize: 13),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              "${barang['stok']} Unit",
                              style: const TextStyle(
                                color: primaryBrown,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                // Detail Button
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: TextButton(
                    onPressed: () => Get.toNamed('/homeshow', arguments: {
                      'nama_barang': barang['nama_barang'],
                      'kategori'   : barang['kategori']?['nama_kategori'] ?? '-',
                      'ruangan'    : barang['ruangan']?['nama_ruangan'] ?? '-',
                      'lokasi'     : barang['ruangan']?['lokasi'] ?? '-',
                      'stok'       : barang['stok'] ?? 0,
                    }),
                    child: const Text("DETAIL", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // --- WIDGET HELPER: POPUP ITEM ---
  PopupMenuItem<String> _buildPopupItem(String value, IconData icon, String title, Color color) {
    return PopupMenuItem(
      value: value,
      child: Row(
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(width: 12),
          Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  // --- WIDGET HELPER: BOTTOM NAV ---
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
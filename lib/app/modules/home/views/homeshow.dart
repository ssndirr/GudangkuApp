import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeShowView extends StatelessWidget {
  // Skema Warna (sama dengan HomeView)
  static const Color primaryBrown = Color(0xFF3E2723);
  static const Color accentGold = Color(0xFFD4AF37);
  static const Color lightGold = Color(0xFFFFD700);
  static const Color softBeige = Color(0xFFFDFBF7);
  static const Color surfaceWhite = Colors.white;

  const HomeShowView({super.key});

  @override
  Widget build(BuildContext context) {
    // Data dikirim via Get.toNamed('/home-show', arguments: barang)
    final Map<String, dynamic> barang =
        Get.arguments ?? {};

    final String namaBarang = barang['nama_barang'] ?? '-';
    final String kategori = barang['kategori'] ?? '-';
    final String ruangan = barang['ruangan'] ?? '-';
    final String lokasi = barang['lokasi'] ?? '-';
    final int stok = barang['stok'] ?? 0;

    return Scaffold(
      backgroundColor: softBeige,

      // ================= APPBAR =================
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: lightGold),
          onPressed: () => Get.back(),
        ),
        title: const Column(
          children: [
            Text(
              'Detail Barang',
              style: TextStyle(
                color: accentGold,
                fontWeight: FontWeight.w900,
                fontSize: 20,
                letterSpacing: 1.1,
              ),
            ),
            SizedBox(height: 4),
            SizedBox(
              height: 2,
              width: 40,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: lightGold,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),

      // ================= BODY =================
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            // Header Banner (mirip card-header Laravel)
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: primaryBrown,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: accentGold.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: accentGold.withOpacity(0.5)),
                    ),
                    child: const Icon(
                      Icons.inventory_2_rounded,
                      color: accentGold,
                      size: 32,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      namaBarang,
                      style: const TextStyle(
                        color: softBeige,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ================= INFO CARDS =================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  // Subtitle (mirip sub-header Laravel)
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Informasi lengkap tentang barang',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Card container (mirip card Laravel)
                  Container(
                    decoration: BoxDecoration(
                      color: surfaceWhite,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: primaryBrown.withOpacity(0.08),
                          blurRadius: 20,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Kategori
                        _buildInfoItem(
                          icon: Icons.label_rounded,
                          iconColor: const Color(0xFF0891b2),
                          label: 'Kategori',
                          value: kategori,
                          isFirst: true,
                        ),

                        _buildDivider(),

                        // Ruangan
                        _buildInfoItem(
                          icon: Icons.meeting_room_rounded,
                          iconColor: accentGold,
                          label: 'Ruangan',
                          value: ruangan,
                        ),

                        _buildDivider(),

                        // Lokasi
                        _buildInfoItem(
                          icon: Icons.location_on_rounded,
                          iconColor: Colors.redAccent,
                          label: 'Alamat Lokasi',
                          value: lokasi,
                        ),

                        _buildDivider(),

                        // Stok
                        _buildStokItem(stok),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // ================= TOMBOL KEMBALI =================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () => Get.back(),
                  icon: const Icon(Icons.arrow_back_rounded),
                  label: const Text(
                    'Kembali ke Katalog',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: primaryBrown,
                    side: const BorderSide(color: primaryBrown, width: 1.5),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // --- HELPER: Info Item biasa ---
  Widget _buildInfoItem({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
    bool isFirst = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: primaryBrown,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- HELPER: Stok Item dengan badge warna ---
  Widget _buildStokItem(int stok) {
    Color badgeColor;
    String badgeText;
    IconData badgeIcon;

    if (stok > 10) {
      badgeColor = const Color(0xFF1e40af);
      badgeText = '$stok Unit';
      badgeIcon = Icons.check_circle_rounded;
    } else if (stok > 0) {
      badgeColor = const Color(0xFF1e40af);
      badgeText = '$stok Unit';
      badgeIcon = Icons.warning_amber_rounded;
    } else {
      badgeColor = const Color(0xFF1e40af);
      badgeText = '$stok Unit - Habis';
      badgeIcon = Icons.cancel_rounded;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF16a34a).withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.inventory_2_rounded,
                color: Color(0xFF16a34a), size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Stok Tersedia',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: badgeColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(badgeIcon, color: Colors.white, size: 14),
                      const SizedBox(width: 6),
                      Text(
                        badgeText,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
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
    );
  }

  // --- HELPER: Divider ---
  Widget _buildDivider() {
    return const Divider(height: 1, indent: 20, endIndent: 20);
  }
}
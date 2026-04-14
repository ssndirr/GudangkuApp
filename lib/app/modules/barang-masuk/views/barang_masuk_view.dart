import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/barang_masuk_controller.dart';

class BarangMasukView extends GetView<BarangMasukController> {
  const BarangMasukView({super.key});

  static const Color primaryBrown = Color(0xFF3E2723);
  static const Color softBeige = Color(0xFFFDFBF7);
  static const Color successGreen = Color(0xFF43A047);
  static const Color lightGreen = Color(0xFF66BB6A);

  @override
  Widget build(BuildContext context) {
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
              colors: [successGreen, lightGreen],
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          "Barang Masuk",
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
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(successGreen),
            ),
          );
        }

        if (controller.barangMasukList.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: successGreen.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.arrow_downward_rounded,
                      size: 60, color: successGreen.withOpacity(0.5)),
                ),
                const SizedBox(height: 20),
                Text(
                  "Belum ada transaksi",
                  style: TextStyle(
                      fontSize: 18,
                      color: primaryBrown.withOpacity(0.7),
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                Text(
                  "Tap tombol + untuk menambah",
                  style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: controller.barangMasukList.length,
          itemBuilder: (context, index) {
            final data = controller.barangMasukList[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 16),
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
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            colors: [successGreen, lightGreen]),
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                              color: successGreen.withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 4))
                        ],
                      ),
                      child: const Icon(Icons.arrow_downward_rounded,
                          color: Colors.white, size: 26),
                    ),
                    const SizedBox(width: 18),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data['barang']['nama_barang'] ?? '',
                            style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: primaryBrown),
                          ),
                          const SizedBox(height: 6),
                          if (data['barang']['ruangan'] != null)
                            Row(
                              children: [
                                Icon(Icons.room_outlined,
                                    size: 14, color: Colors.grey[500]),
                                const SizedBox(width: 4),
                                Text(
                                  data['barang']['ruangan']['nama_ruangan'] ?? '',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey[500]),
                                ),
                              ],
                            ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              Icon(Icons.calendar_today_outlined,
                                  size: 14, color: Colors.grey[600]),
                              const SizedBox(width: 6),
                              Text(
                                data['tanggal_masuk'] ?? '-',
                                style: TextStyle(
                                    fontSize: 13, color: Colors.grey[600]),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                successGreen.withOpacity(0.2),
                                successGreen.withOpacity(0.1)
                              ]),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              "Jumlah: ${data['jumlah']}",
                              style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: successGreen),
                            ),
                          ),
                        ],
                      ),
                    ),
                    PopupMenuButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                      icon: Icon(Icons.more_vert_rounded,
                          color: Colors.grey[600]),
                      onSelected: (value) {
                        if (value == 'edit') {
                          _showForm(data: data);
                        } else if (value == 'hapus') {
                          _confirmDelete(data['id']);
                        }
                      },
                      itemBuilder: (context) => const [
                        PopupMenuItem(
                          value: 'edit',
                          child: Row(children: [
                            Icon(Icons.edit_rounded,
                                color: Colors.blue, size: 20),
                            SizedBox(width: 12),
                            Text("Edit",
                                style:
                                    TextStyle(fontWeight: FontWeight.w500)),
                          ]),
                        ),
                        PopupMenuItem(
                          value: 'hapus',
                          child: Row(children: [
                            Icon(Icons.delete_rounded,
                                color: Colors.red, size: 20),
                            SizedBox(width: 12),
                            Text("Hapus",
                                style:
                                    TextStyle(fontWeight: FontWeight.w500)),
                          ]),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: successGreen,
        onPressed: () => _showForm(),
        icon: const Icon(Icons.add_rounded, color: Colors.white),
        label: const Text('Tambah',
            style:
                TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        elevation: 6,
      ),
    );
  }

  // ===================== FORM DIALOG =====================
  void _showForm({dynamic data}) {
    if (data != null) {
      controller.preloadEdit(data);
    } else {
      controller.resetForm();
    }

    final jumlahC = TextEditingController(
        text: data != null ? data['jumlah'].toString() : '');

    Get.dialog(
      Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Container(
          padding: const EdgeInsets.all(28),
          constraints: const BoxConstraints(maxWidth: 500),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24)),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Header ──
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            colors: [successGreen, lightGreen]),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.arrow_downward_rounded,
                          color: Colors.white, size: 24),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        data == null
                            ? "Tambah Barang Masuk"
                            : "Edit Barang Masuk",
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: primaryBrown),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // ── Dropdown Ruangan ──
                const Text("Ruangan",
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: primaryBrown)),
                const SizedBox(height: 8),
                Obx(() => _buildDropdown<int>(
                      value: controller.selectedRuanganId.value,
                      hint: "Pilih Ruangan",
                      icon: Icons.room_outlined,
                      items: controller.ruanganList
                          .map<DropdownMenuItem<int>>((r) => DropdownMenuItem(
                                value: r['id'] as int,
                                child: Text(r['nama_ruangan'] ?? ''),
                              ))
                          .toList(),
                      onChanged: (val) {
                        if (val != null) controller.pilihRuangan(val);
                      },
                    )),
                const SizedBox(height: 16),

                // ── Dropdown Barang ──
                const Text("Barang",
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: primaryBrown)),
                const SizedBox(height: 8),
                Obx(() => _buildDropdown<int>(
                      value: controller.selectedBarangId.value,
                      hint: controller.selectedRuanganId.value == null
                          ? "Pilih ruangan dulu"
                          : controller.filteredBarangList.isEmpty
                              ? "Tidak ada barang"
                              : "Pilih Barang",
                      icon: Icons.inventory_2_outlined,
                      items: controller.filteredBarangList
                          .map<DropdownMenuItem<int>>((b) => DropdownMenuItem(
                                value: b['id'] as int,
                                child: Text(b['nama_barang'] ?? ''),
                              ))
                          .toList(),
                      onChanged: controller.selectedRuanganId.value == null
                          ? null
                          : (val) =>
                              controller.selectedBarangId.value = val,
                    )),
                const SizedBox(height: 16),

                // ── Date Picker Tanggal ──
                const Text("Tanggal",
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: primaryBrown)),
                const SizedBox(height: 8),
                Obx(() => GestureDetector(
                      onTap: () async {
                        final picked = await showDatePicker(
                          context: Get.context!,
                          initialDate:
                              controller.selectedTanggal.value ??
                                  DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                          builder: (context, child) => Theme(
                            data: Theme.of(context).copyWith(
                              colorScheme: const ColorScheme.light(
                                primary: successGreen,
                                onPrimary: Colors.white,
                                onSurface: primaryBrown,
                              ),
                            ),
                            child: child!,
                          ),
                        );
                        if (picked != null) {
                          controller.selectedTanggal.value = picked;
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 16),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: controller.selectedTanggal.value != null
                                ? successGreen
                                : Colors.grey[300]!,
                            width: controller.selectedTanggal.value != null
                                ? 2
                                : 1,
                          ),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.calendar_today_outlined,
                              color: controller.selectedTanggal.value != null
                                  ? successGreen
                                  : Colors.grey,
                              size: 22,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              controller.selectedTanggal.value != null
                                  ? controller.formattedTanggal
                                  : "Pilih Tanggal",
                              style: TextStyle(
                                fontSize: 15,
                                color: controller.selectedTanggal.value != null
                                    ? primaryBrown
                                    : Colors.grey[500],
                              ),
                            ),
                            const Spacer(),
                            Icon(Icons.arrow_drop_down_rounded,
                                color: Colors.grey[400]),
                          ],
                        ),
                      ),
                    )),
                const SizedBox(height: 16),

                // ── Jumlah ──
                const Text("Jumlah",
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: primaryBrown)),
                const SizedBox(height: 8),
                _buildTextField(jumlahC, "Masukkan jumlah",
                    Icons.numbers_rounded, TextInputType.number),
                const SizedBox(height: 28),

                // ── Tombol ──
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Get.back(),
                        style: OutlinedButton.styleFrom(
                          padding:
                              const EdgeInsets.symmetric(vertical: 16),
                          side: BorderSide(color: Colors.grey[300]!),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14)),
                        ),
                        child: const Text("Batal",
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 15)),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          final barangId = controller
                                  .selectedBarangId.value
                                  ?.toString() ??
                              '';
                          final tanggal = controller.formattedTanggal;
                          if (data == null) {
                            controller.tambahBarangMasuk(
                                barangId, tanggal, jumlahC.text);
                          } else {
                            controller.updateBarangMasuk(data['id'],
                                barangId, tanggal, jumlahC.text);
                          }
                          Get.back();
                        },
                        style: ElevatedButton.styleFrom(
                          padding:
                              const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: successGreen,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14)),
                          elevation: 3,
                        ),
                        child: Text(
                          data == null ? "Simpan" : "Update",
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ── Helper: Dropdown ──
  Widget _buildDropdown<T>({
    required T? value,
    required String hint,
    required IconData icon,
    required List<DropdownMenuItem<T>> items,
    required ValueChanged<T?>? onChanged,
  }) {
    return DropdownButtonFormField<T>(
      value: value,
      isExpanded: true,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: successGreen),
        hintText: hint,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: Colors.grey[300]!)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: Colors.grey[300]!)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide:
                const BorderSide(color: successGreen, width: 2)),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: Colors.grey[200]!)),
        filled: onChanged == null,
        fillColor: Colors.grey[100],
      ),
      items: items,
      onChanged: onChanged,
    );
  }

  // ── Helper: TextField ──
  Widget _buildTextField(TextEditingController ctrl, String hint,
      IconData icon, TextInputType type) {
    return TextField(
      controller: ctrl,
      keyboardType: type,
      style: const TextStyle(fontSize: 15),
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon, color: successGreen),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: Colors.grey[300]!)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: Colors.grey[300]!)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide:
                const BorderSide(color: successGreen, width: 2)),
      ),
    );
  }

  // ===================== CONFIRM DELETE =====================
  void _confirmDelete(int id) {
    Get.dialog(
      Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Container(
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    shape: BoxShape.circle),
                child: const Icon(Icons.delete_rounded,
                    color: Colors.red, size: 44),
              ),
              const SizedBox(height: 20),
              const Text("Hapus Transaksi?",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: primaryBrown)),
              const SizedBox(height: 10),
              Text(
                "Data yang dihapus tidak dapat dikembalikan",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
              const SizedBox(height: 28),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Get.back(),
                      style: OutlinedButton.styleFrom(
                          padding:
                              const EdgeInsets.symmetric(vertical: 16),
                          side: BorderSide(color: Colors.grey[300]!),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14))),
                      child: const Text("Batal",
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 15)),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        controller.deleteBarangMasuk(id);
                        Get.back();
                      },
                      style: ElevatedButton.styleFrom(
                          padding:
                              const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14)),
                          elevation: 3),
                      child: const Text("Ya, Hapus",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
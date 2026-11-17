import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/umkm_controller.dart';
import 'umkm_form_page.dart';

class UmkmView extends StatelessWidget {
  const UmkmView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UmkmController());

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          "Daftar UMKM",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Muat Ulang',
            onPressed: () => controller.fetchUmkm(),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.umkmList.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.storefront_outlined,
                  size: 72,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 12),
                Text(
                  "Belum ada data UMKM",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          );
        }
        return RefreshIndicator(
          onRefresh: controller.fetchUmkm,
          child: ListView.builder(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 80),
            itemCount: controller.umkmList.length,
            itemBuilder: (context, index) {
              final item = controller.umkmList[index];
              final kategoriText =
                  (item.kategori != null && item.kategori!.isNotEmpty)
                      ? item.kategori!
                      : 'Umum';
              final pemilikText =
                  (item.pemilik != null && item.pemilik!.isNotEmpty)
                      ? item.pemilik!
                      : '-';
              final alamatText =
                  (item.alamat != null && item.alamat!.isNotEmpty)
                      ? item.alamat!
                      : '-';
              final kontakText =
                  (item.kontak != null && item.kontak!.isNotEmpty)
                      ? item.kontak!
                      : '-';

              return Card(
                elevation: 2,
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.teal.shade100,
                            foregroundColor: Colors.teal.shade800,
                            child: Text(
                              item.id?.toString() ?? "?",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              item.namaUmkm,
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.teal.shade50,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.teal.shade200,
                              ),
                            ),
                            child: Text(
                              kategoriText,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.teal.shade700,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 20),
                      Row(
                        children: [
                          const Icon(Icons.person_outline,
                              size: 16, color: Colors.grey),
                          const SizedBox(width: 8),
                          Text(
                            "Pemilik: $pemilikText",
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.location_on_outlined,
                              size: 16, color: Colors.grey),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              alamatText,
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(Icons.phone_outlined,
                              size: 16, color: Colors.grey),
                          const SizedBox(width: 8),
                          Text(
                            kontakText,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          controller.responseMessage.value = '';
          Get.to(() => UmkmFormPage());
        },
        icon: const Icon(Icons.add),
        label: const Text("Tambah UMKM"),
      ),
    );
  }
}
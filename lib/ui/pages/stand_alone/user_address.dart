import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_shop/controllers/address_controller.dart';

class AddressListView extends StatelessWidget {
  const AddressListView({super.key});
  @override
  Widget build(BuildContext context) {
    final addressController = Get.put(AddressController());
    return Obx(() {
      if (addressController.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      }

      if (addressController.address.isEmpty) {
        return Center(
          child: Text(
            'No address found.',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        );
      }

      return ListView.builder(
        itemCount: addressController.address.length,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        itemBuilder: (context, index) {
          final item = addressController.address[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            margin: const EdgeInsets.symmetric(vertical: 8),
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.address_line,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal[800],
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${item.district}, ${item.region}, ${item.country}',
                    style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                  ),
                  if (item.postal_code.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      'Postal Code: ${item.postal_code}',
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      );
    });
  }
}

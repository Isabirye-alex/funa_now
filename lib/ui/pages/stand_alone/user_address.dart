import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_shop/controllers/address_controller.dart';
import 'package:go_shop/ui/pages/stand_alone/address.dart';

class AddressListView extends StatelessWidget {
  const AddressListView({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    final addressController = Get.put(AddressController());

    // Fetch addresses when screen builds (if not yet fetched)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (addressController.address.isEmpty) {
        addressController.fetchUserAddresses(context);
      }
    });

    return Scaffold(
      backgroundColor: Colors.white60,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Your Addresses'),
        backgroundColor: Colors.teal,
      ),
      body: Obx(() {
        if (addressController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (addressController.address.isEmpty) {
          return const Center(
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
                      'Town: ${item.district}',
                      style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                    ),
                    Text(
                      'Region: ${item.region}',
                      style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                    ),
                    Text(
                      'Country: ${item.country}',
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
      }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                content: AddAddressPage(),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              );
            },
          );
        },
        label: Text("Add Address"),
        icon: Icon(Icons.add_location_alt),
        backgroundColor: Colors.teal,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_shop/controllers/address_controller.dart';

class AddAddressPage extends StatelessWidget {
  const AddAddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Address'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const Text(
              'Address Info',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildInput(controller.addresslineController, 'Address Line'),
            _buildInput(controller.districtController, 'District'),
            _buildInput(controller.regionController, 'Region'),
            _buildInput(
              controller.postalcodeController,
              'Postal Code',
              TextInputType.number,
            ),
            _buildInput(controller.countryController, 'Country'),

            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: controller.addNewAddress,
              icon: const Icon(Icons.save),
              label: const Text('Save Address'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInput(
    TextEditingController controller,
    String label, [
    TextInputType type = TextInputType.text,
  ]) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        keyboardType: type,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}

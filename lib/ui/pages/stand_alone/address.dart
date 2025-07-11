import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_shop/controllers/address_controller.dart';

class AddAddressPage extends StatelessWidget {
  const AddAddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressController());

    return Scaffold(
      // backgroundColor: Colors.deepPurple,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.deepPurple,
              Color(0xFFe0f7fa),
              Color(0xFFffffff),
              Colors.deepPurple,
              Colors.amber,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Card(
                  color: Colors.white, // explicitly set card background
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  shadowColor: Colors.blueAccent.withAlpha(200),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 32,
                      horizontal: 24,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Column(
                              children: const [
                                Icon(
                                  Icons.home_work_rounded,
                                  size: 40,
                                  color: Colors.blueAccent,
                                ),
                                SizedBox(height: 12),
                                Text(
                                  'Add New Address',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87, // ensure visible
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 30),

                          Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '* required',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                              SizedBox(height: 2),
                              _buildInput(
                                controller.addresslineController,
                                'Village / Town',
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '* required',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                              SizedBox(height: 2),
                              _buildInput(
                                controller.districtController,
                                'District',
                              ),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '* required',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                              SizedBox(height: 2),
                              _buildInput(
                                controller.regionController,
                                'Region',
                              ),
                            ],
                          ),
                          _buildInput(
                            controller.postalcodeController,
                            'Postal Code (optional)',
                            TextInputType.number,
                          ),
                          _buildInput(
                            controller.countryController,
                            'Country (optional)',
                          ),

                          const SizedBox(height: 20),

                          Obx(() {
                            return AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              width: double.infinity,
                              height: 52,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: controller.isLoading.value
                                    ? Colors.grey
                                    : Colors.blueAccent,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.blueAccent.withAlpha(200),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: InkWell(
                                onTap: controller.isLoading.value
                                    ? null
                                    : () => controller.addNewAddress(context),
                                borderRadius: BorderRadius.circular(12),
                                child: Center(
                                  child: controller.isLoading.value
                                      ? const CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 2,
                                        )
                                      : const Text(
                                          'Save Address',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
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
      padding: const EdgeInsets.only(bottom: 8),
      child: TextField(
        controller: controller,
        keyboardType: type,
        style: const TextStyle(color: Colors.black87),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.w500,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 8,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.black26),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.blueAccent, width: 1.5),
          ),
        ),
      ),
    );
  }
}

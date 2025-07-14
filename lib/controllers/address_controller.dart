// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_shop/features/constants/url_constant.dart';
import 'package:go_shop/features/helper_function/db_helper.dart';
import 'package:go_shop/models/address_model.dart';
import 'package:http/http.dart' as http;

class AddressController extends GetxController {
  final authService = AuthStorage();
  RxList<AddressModel> address = <AddressModel>[].obs;
  var userId = RxnInt();
  final addresslineController = TextEditingController();
  final districtController = TextEditingController();
  final regionController = TextEditingController();
  final postalcodeController = TextEditingController();
  final countryController = TextEditingController();
  var isLoading = false.obs;
  var selectedAddess = ''.obs;
  var shippingAddress = ''.obs;
  var village = ''.obs;
  var district = ''.obs;
  var region = ''.obs;
  var country = ''.obs;

  Future<void> addNewAddress(BuildContext context) async {
    final dbquery = await authService.getAuthData();
    if (dbquery != null && dbquery['userId'] != null) {
      debugPrint('🔵 Entered addNewAddress');
      userId.value = dbquery['userId'];
      debugPrint('🟢 User ID found: ${dbquery['userId']}');
      if (addresslineController.text.isEmpty ||
          regionController.text.isEmpty ||
          countryController.text.isEmpty ||
          districtController.text.isEmpty) {
        Flushbar(
          shouldIconPulse: false,
          borderRadius: BorderRadius.circular(8),
          margin: EdgeInsets.all(24),
          flushbarPosition: FlushbarPosition.TOP,
          animationDuration: const Duration(milliseconds: 300),
          backgroundColor: Colors.green,
          messageText: Text(
            'Error',
            style: const TextStyle(color: Colors.white),
          ),
          duration: const Duration(seconds: 4),
          icon: Icon(Icons.check_circle, color: Colors.white),
          titleText: Text(
            'Required fields are missing',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ).show(context);
        return;
      }
      try {
        isLoading.value = true;
        final address = AddressModel(
          user_id: userId.value.toString(),
          address_line: addresslineController.text.trim(),
          district: districtController.text.trim(),
          postal_code: postalcodeController.text.trim(),
          region: regionController.text.trim(),
          country: countryController.text.trim(),
        );
        debugPrint('📦 Sending: ${jsonEncode(address.toMap())}');

        final response = await http.post(
          Uri.parse('${UrlConstant}address/addaddress'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(address.toMap()),
        );
        debugPrint('✅ Response Status: ${response.statusCode}');
        debugPrint('✅ Response Body: ${response.body}');

        isLoading.value = false;
        if (response.statusCode == 201 || response.statusCode == 200) {
          final result = jsonDecode(response.body);
          regionController.clear();
          districtController.clear();
          postalcodeController.clear();
          addresslineController.clear();
          countryController.clear();
          debugPrint('$result');
        }
      } catch (e) {
        debugPrint('🛑 Exception occurred with: $e');
        debugPrint('Could not add address: $e');
      }
    } else {
      userId.value = null;
    }
  }

  Future<void> fetchUserAddresses(BuildContext context) async {
    debugPrint('🔄 Fetching user addresses...');
    final dbquery = await authService.getAuthData();

    if (dbquery != null && dbquery['userId'] != null) {
      userId.value = dbquery['userId'];
      isLoading.value = true;

      try {
        final response = await http.get(
          Uri.parse('${UrlConstant}address/${userId.value}'),
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          final result = jsonDecode(response.body);
          final List<dynamic> jsonList = result['data'];

          final List<AddressModel> userAddress = jsonList
              .map((e) => AddressModel.fromMap(e))
              .toList();

          address.assignAll(userAddress);

          // Auto-select first address
          if (userAddress.isNotEmpty) {
            final first = userAddress[0];
            selectedAddess.value =
                '${first.address_line}, ${first.district}, ${first.region}, ${first.country}';
          }

          debugPrint('✅ Address list updated with ${userAddress.length} items');
        } else {
          debugPrint('❌ Failed to fetch addresses: ${response.body}');
          address.clear();
        }
      } catch (e) {
        debugPrint('🛑 Exception occurred: $e');
        address.clear();
      } finally {
        isLoading.value = false;
      }
    } else {
      debugPrint('⚠️ No userId found, cannot fetch address');
      address.clear();
    }
  }

  Future<void> fetchUserId() async {
    final dbquery = await authService.getAuthData();
    if (dbquery != null && dbquery['userId'] != null) {
      userId.value = dbquery['userId'];
    } else {
      userId.value = null;
    }
  }
}

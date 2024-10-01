import 'package:contacts_app_fl/preference_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'api_service.dart';
import 'contact.dart';


class ContactController extends GetxController {
  RxBool isFingerprintEnabled = false.obs;
  var contacts = <Contact>[].obs;
  // var isLoading = true.obs;
  final ApiService apiService = ApiService();

  @override
  void onInit() {

    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchContacts();
    });
  }

  void fetchContacts() async {
    try {
      // isLoading(true);
      var contactList = await apiService.fetchContacts();
      if (contactList != null) {
        contacts.assignAll(contactList);
      }
    } finally {
      // isLoading(false);
    }
  }

  var validationErrors = {}.obs;

  void addContact(Contact contact) async {
    try {
      await apiService.createContact(contact.name, contact.email, contact.phone);
      validationErrors.clear();
      Get.back();
      fetchContacts();
    } catch (e) {
      if (e is ValidationError) {
        validationErrors.value = e.errors;
      } else {
        print('Failed to create contact: $e');
      }
    }
  }

  void updateContact(id,name,phone,email) async {
    try {
      await apiService.updateContact(id, name,email,phone);

      if (id != -1) {
        // contacts[index] = contact;
        // fetchContacts();
      }
    } catch (e) {
      Get.snackbar('Error', 'Could not update contact');
    }
  }

  void deleteContact(int id) async {
    try {
      await apiService.deleteContact(id);
      contacts.removeWhere((c) => c.id == id);
    } catch (e) {
      print(e);
      Get.snackbar('Error', 'Could not delete contact');
    }
  }
  void toggleFingerprint(bool value) {

      isFingerprintEnabled.value = value;
      PreferenceManager.setFingerPrintEnabled(value);
      print(PreferenceManager.isFingerPrintEnabledValue());
      // storage.write('fingerprintEnabled', isFingerprintEnabled); // Save the toggle state

  }
}
class ValidationError implements Exception {
  final Map<String, dynamic> errors;

  ValidationError(this.errors);
}
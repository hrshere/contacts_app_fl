import 'dart:convert';
import 'package:get/get.dart';
import 'contact.dart';
import 'contact_controller.dart';
import 'network/commom_api_service.dart';

class ApiService {


  Future<List<Contact>> fetchContacts() async {

    final response = await CommonApiService().fetchContacts();

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((dynamic item) => Contact.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load contacts');
    }
  }

  Future<void> createContact(String name, String email, String phone) async {
    Map <String, String> contactReqBody = {
      'name': name,
      'email': email,
      'phone': phone,
    };
    final response = await CommonApiService().createContact(contactReqBody);

    if (response.statusCode == 201) {
      print('Contact created successfully');
    } else if (response.statusCode == 400) {
      var errors = jsonDecode(response.body);
      throw ValidationError(errors);
    } else {
      throw Exception('Failed to create contact');
    }
  }

  Future<void> updateContact(id,name,email,phone) async {
    print(name);
    print(email);
    print(phone);
    Map <String, String> contactReqBody = {
      'name': name,
      'email': email,
      'phone': phone,
    };
    final response = await CommonApiService().updateContact(id,contactReqBody);

    if (response.statusCode != 200) {
      throw Exception('Failed to update contact');
    }
    else{
      Get.back();
      fetchContacts();
    }
  }

  Future<void> deleteContact(int id) async {
    final response = await CommonApiService().deleteContact(id);
    print('object');
    print(response.statusCode);
    print(response.body);
    print(response.request);
    if (response.statusCode == 204) {
      fetchContacts();
    }
  }
}

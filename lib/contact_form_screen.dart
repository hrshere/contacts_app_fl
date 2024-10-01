import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'contact.dart';
import 'contact_controller.dart';

class ContactFormScreen extends StatelessWidget {
  final ContactController contactController = Get.put(ContactController());
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Contact')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Obx(() {
          return Column(
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  errorText: contactController.validationErrors['name'] != null
                      ? contactController.validationErrors['name'][0]
                      : null,
                ),
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  errorText: contactController.validationErrors['email'] != null
                      ? contactController.validationErrors['email'][0]
                      : null,
                ),
              ),
              TextField(
                controller: phoneController,
                decoration: InputDecoration(
                  labelText: 'Phone',
                  errorText: contactController.validationErrors['phone'] != null
                      ? contactController.validationErrors['phone'][0]
                      : null,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final contact = Contact(
                    id: 0,
                    name: nameController.text,
                    email: emailController.text,
                    phone: phoneController.text,
                  );
                  contactController.addContact(contact);
                },
                child: Text('Save'),
              ),
            ],
          );
        }),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'contact_controller.dart';

class UpdateContactDialog extends StatefulWidget {

  @override
  State<UpdateContactDialog> createState() => _UpdateContactDialogState();
}

class _UpdateContactDialogState extends State<UpdateContactDialog> {
  String name = '';
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  int id = 0;

  String email = '';
  String phone = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    id = Get.arguments['id'];
    name = Get.arguments['name'];
    email = Get.arguments['email'];
    phone = Get.arguments['phone'];
    nameController.text = name;
    emailController.text = email;
    phoneController.text = phone;
  }
  final ContactController contactController = Get.put(ContactController());

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
           TextField(
            controller: nameController,
            decoration: InputDecoration(
              labelText: 'Name'
            ),
          ),
           TextField(
             controller: emailController,
             decoration: InputDecoration(

                labelText: 'Email'
            ),
          ),
           TextField(
            controller: phoneController,
            decoration: InputDecoration(
                labelText: 'Phone'
            ),
          ),
          TextButton(onPressed: (){contactController.updateContact(id,nameController.text,phoneController.text,emailController.text);}, child: Text('save'))
        ],
      ),
    );
  }
}

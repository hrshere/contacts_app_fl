
import 'package:contacts_app_fl/page_routes/page_route_constant.dart';
import 'package:contacts_app_fl/preference_manager.dart';
import 'package:contacts_app_fl/update_contact_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'contact_controller.dart';
import 'contact_form_screen.dart';

class ContactListScreen extends StatefulWidget {
  @override
  State<ContactListScreen> createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
  final ContactController contactController = Get.put(ContactController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    contactController.isFingerprintEnabled.value = PreferenceManager.isFingerPrintEnabledValue() ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
        ()=> Scaffold(
        appBar: AppBar(title: Text('Contacts'),

      ),
          drawer: Drawer(
            // Add a ListView to the drawer. This ensures the user can scroll
            // through the options in the drawer if there isn't enough vertical
            // space to fit everything.
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  child: Text('Drawer Header'),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                ),
                ListTile(
                  leading:  Switch(
                    value: contactController.isFingerprintEnabled.value,
                    onChanged: contactController.toggleFingerprint,
                    activeColor: Colors.green,
                  ),
                  title:
                    Text(
                      contactController.isFingerprintEnabled.value ? 'Fingerprint is Enabled' : 'Fingerprint is Disabled',
                      style: TextStyle(fontSize: 16, color: contactController.isFingerprintEnabled.value ? Colors.green : Colors.red),
                    ),

                ),
                ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('Logout',style: TextStyle(color: Colors.redAccent,fontSize: 20),),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    Get.offAllNamed(PageRouteConstant.loginScreen);
                    PreferenceManager.deleteData();
                  },
                ),
              ],
            ),
          ),
        body:Center(
          child: Text('Home Screen',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.blue),),
        )
          // if (contactController.isLoading.value) {
          //   return Center(child: CircularProgressIndicator());
          // }
          // Expanded(
          //   child: ListView.builder(
          //     itemCount: contactController.contacts.length,
          //     itemBuilder: (context, index) {
          //       final contact = contactController.contacts[index];
          //       return ListTile(
          //         title: Text(contact.name),
          //         subtitle: Text(contact.email),
          //         trailing: SizedBox(
          //           width: 100,
          //           child: Row(
          //             children: [
          //               IconButton(onPressed: (){
          //                 Get.dialog(UpdateContactDialog(),arguments: {'id':contact.id,'name':contact.name,'email':contact.email,'phone':contact.phone});
          //               }, icon: Icon(Icons.edit)),
          //               IconButton(
          //                 icon: Icon(Icons.delete),
          //                 onPressed: () {
          //                   contactController.deleteContact(contact.id);
          //                 },
          //               ),
          //             ],
          //           ),
          //         ),
          //       );
          //     },
          //   ),
          // ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     Get.to(ContactFormScreen());
        //   },
        //   child: Icon(Icons.add),
        // ),
      ),
    );
  }
}

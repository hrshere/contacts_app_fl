
import 'package:contacts_app_fl/preference_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../page_routes/page_route_constant.dart';
import 'login_controller.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  final LoginController loginController = Get.put(LoginController());

  @override
  void initState() {
    super.initState();

    // Ensure GetStorage is initialized before reading any values
    GetStorage.init().then((_) {
      // Safely get fingerprint status with fallback to false if it's not yet set
      loginController.isFingerprintEnabled.value = PreferenceManager.isFingerPrintEnabledValue() ?? false;

      Future.delayed(Duration(seconds: 2), () async {
        print('1');
        print(PreferenceManager.getString(PreferenceManager.bearerToken));

        if (PreferenceManager.getString(PreferenceManager.bearerToken) != null &&
            PreferenceManager.getString(PreferenceManager.bearerToken) != 'null') {
          print('2');
          print(loginController.isFingerprintEnabled.value);

          if (loginController.isFingerprintEnabled.value) {
            loginController.authenticateWithBiometrics();
          } else {
            Get.offNamed(PageRouteConstant.contact);
          }
        } else {
          print('3');
          Get.offNamed(PageRouteConstant.loginScreen);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: IconButton(icon: Icon(Icons.login_sharp),onPressed: ()=>Get.offNamed(PageRouteConstant.loginScreen),),),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          // color: ,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
           SizedBox(height: 50,),
              Text('Splash Screen',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),

            ],
          ),
        ),
      ),
    );
  }
}

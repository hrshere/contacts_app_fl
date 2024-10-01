import 'dart:ffi';


import 'package:contacts_app_fl/page_routes/page_route_constant.dart';
import 'package:contacts_app_fl/preference_manager.dart';
import 'package:contacts_app_fl/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:local_auth/local_auth.dart';

import 'network/commom_api_service.dart';

class LoginController extends GetxController {
  RxBool isFingerprintEnabled = false.obs;
  final LocalAuthentication localAuth = LocalAuthentication();
  RxString authorized = 'Not Authorized'.obs;
  RxBool isAuthenticating = false.obs;

  // final FlutterAppAuth appAuth = FlutterAppAuth();
  var result;
  FirebaseAuth auth = FirebaseAuth.instance;

  var isLoading = false.obs;

  Future<void> login(String username, String password) async {
    // isLoading.value = true;
    Map<String,String> loginReqBody =
    {
      "username":username,
      "password":password
    };

    final response = await CommonApiService().login(loginReqBody);
    print(response.statusCode);

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
  saveData(responseData['access']);
      Get.offNamed(PageRouteConstant.contact);
    } else {
      Get.snackbar('Error', 'Invalid username or password');
    }

    // isLoading.value = false;
  }

  // Future<UserCredential?> loginWithMicrosoft() async {
  //   print('011');
  //   OAuthProvider provider = OAuthProvider('microsoft.com');
  //   print('012');
  //   provider.setCustomParameters({
  //     "tenant": "2b55602e-647a-4625-87b8-f2493d349000",
  //   });
  //   print('013');
  //   // provider.addScope('user.read');
  //   // print('014');
  //   // provider.addScope('profile');
  //   // print('015');
  //   try {
  //     print('016');
  //     final result = await auth.signInWithProvider(provider);
  //     print('017');
  //     print(result);
  //     // return userCredential;
  //
  //     if (result != null) {
  //       print(result);
  //       final String? accessToken = result.credential?.accessToken;
  //       print('result');
  //       print(accessToken);
  //       final response = await CommonApiService().microsoftLogin({'access_token': accessToken});
  //       print(response.statusCode);
  //       if (response.statusCode == 200) {
  //         final Map<String, dynamic> responseData = json.decode(response.body);
  //         saveData(responseData['access']);
  //         Get.offNamed(PageRouteConstant.contact);
  //       } else {
  //         Get.snackbar('Error', 'Microsoft login failed');
  //       }
  //     }
  //
  //   } on FirebaseAuthException catch(err) {
  //     print('018');
  //     debugPrint(err.message);
  //     debugPrint(err.email);
  //     debugPrint(err.credential?.accessToken);
  //     debugPrint(err.phoneNumber);
  //     debugPrint(err.tenantId);
  //     // Handle FirebaseAuthExceptions
  //     // ex: firebase_auth/account-exists-with-different-credential
  //   }
  //   catch (e) {
  //     print('019');
  //     debugPrint('Exception: $e');
  //   }
  // }
  //
  // Future<void> signInWithMicrosoft() async {print('test1');
  //   try {
  //     final AuthorizationTokenResponse? result = await appAuth.authorizeAndExchangeCode(
  //       AuthorizationTokenRequest(
  //         'd1aeb0f9-1f21-4399-b8bb-c85e3cefcd02',  // Replace with the Client ID from Azure
  //         'msauth://com.example.contacts_db_utility/Jkr5IblQVPbtRMnnHr3com5oACc%3D',  // Redirect URI set in Azure
  //         discoveryUrl: 'https://login.microsoftonline.com/2b55602e-647a-4625-87b8-f2493d349000/v2.0/.well-known/openid-configuration',
  //         scopes: ['openid', 'profile', 'email', 'offline_access'],
  //       ),
  //
  //     );
  //     print('test2');
  //     if (result != null) {
  //       print(result);
  //       final String? accessToken = result.accessToken;
  //       print('result');
  //       print(accessToken);
  //       final response = await CommonApiService().microsoftLogin({'access_token': accessToken});
  //       print(response.statusCode);
  //       if (response.statusCode == 200) {
  //         final Map<String, dynamic> responseData = json.decode(response.body);
  //         saveData(responseData['access']);
  //         Get.offNamed(PageRouteConstant.contact);
  //       } else {
  //         Get.snackbar('Error', 'Microsoft login failed');
  //       }
  //     }
  //   } catch (e) {
  //     print(e);
  //     Get.snackbar('Error', 'An error occurred');
  //   }
  // }


  //local auth

  Future<void> authenticateWithBiometrics() async {
    // PreferenceManager.deleteData();
    print('c1');
    bool authenticated = false;
    print('c2');
    try {
      print('c3');
        isAuthenticating.value = true;
        authorized.value = 'Authenticating';
      // Show the bottom sheet when biometric authentication starts
      // showModalBottomSheet(
      //   context: Get.context!,  // Assuming you're using GetX
      //   builder: (BuildContext context) {
      //     return Container(
      //       height: 150,
      //       padding: EdgeInsets.all(16),
      //       child: Column(
      //         mainAxisSize: MainAxisSize.min,
      //         children: [
      //           Text('Scan your fingerprint (or face) to authenticate'),
      //           SizedBox(height: 20),
      //           ElevatedButton(
      //             onPressed: () async {
      //               // Call cancelAuthentication when user presses cancel
      //               await cancelAuthentication();
      //               Navigator.pop(context); // Close the bottom sheet
      //             },
      //             child: Text('Cancel'),
      //           ),
      //         ],
      //       ),
      //     );
      //   },
      // );
      authenticated = await localAuth.authenticate(
        localizedReason:
        'Scan your fingerprint (or face or whatever) to authenticate',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
      print('c4');
        isAuthenticating.value = false;
        authorized.value = 'Authenticating';
    } on PlatformException catch (e) {
      print('c5');
      print(e);
        isAuthenticating.value = false;
        authorized.value = 'Error - ${e.message}';
        print(authorized.value);
      return;
    }
    // if (!isClosed) {
    //   print('c6');
    //   return;
    // }
    print('c7');

    final String message = authenticated ? 'Authorized' : 'Not Authorized';
      authorized.value = message;
      print(message);
      if(message=='Authorized'){
        print('c8');
        Get.offNamed(PageRouteConstant.contact);
      }
      print('c9');
  }

  Future<void> cancelAuthentication() async {
    print('c10');
    await localAuth.stopAuthentication();
    isAuthenticating.value = false;
    Get.offNamed(PageRouteConstant.loginScreen);
    PreferenceManager.deleteData();
    print('c11');
  }

}

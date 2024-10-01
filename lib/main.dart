
import 'package:contacts_app_fl/page_routes/store_page_route.dart';
import 'package:contacts_app_fl/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'contact_list_screen.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user == null) {
      print('User is currently signed out!');
    } else {
      print('User is signed in!');
    }
  });
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: StorePageRoute.mainPageRoute,
      title: 'Flutter Django Contacts',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreenPage(),
    );
  }
}

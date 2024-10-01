import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'login_controller.dart';

class LoginScreen extends StatelessWidget {
  final LoginController loginController = Get.put(LoginController());
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: usernameController,
                decoration: InputDecoration(labelText: 'Username'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Obx(() {
                return loginController.isLoading.value
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      loginController.login(
                        usernameController.text,
                        passwordController.text,
                      );
                    }
                  },
                  child: Text('Login'),
                );
              }),
              // Obx(() {
              //   return loginController.isLoading.value
              //       ? CircularProgressIndicator()
              //       : ElevatedButton(
              //     onPressed: () {
              //       if (_formKey.currentState!.validate()) {
              //         loginController.loginWithMicrosoft(
              //           // usernameController.text,
              //           // passwordController.text,
              //         );
              //       }
              //     },
              //     child: Text('Login With Microsoft'),
              //   );
              //
              // }),
              // Obx(() {
              //   return ElevatedButton(
              //     onPressed: loginController.authenticateWithBiometrics,
              //     child: Row(
              //       mainAxisSize: MainAxisSize.min,
              //       children: <Widget>[
              //         Text(loginController.isAuthenticating.value
              //             ? 'Cancel'
              //             : 'Authenticate: biometrics only'),
              //         const Icon(Icons.fingerprint),
              //       ],
              //     ),
              //   );
              // })
            ],
          ),
        ),
      ),
    );
  }
}

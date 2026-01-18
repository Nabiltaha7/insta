import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'auth_controller.dart';
import 'register_view.dart';

class LoginView extends StatelessWidget {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final auth = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'login'.tr,
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30),

            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                labelText: 'username'.tr,
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 15),

            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'password'.tr,
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),

            ElevatedButton(
              onPressed: () async {
                final success = await auth.login(
                  usernameController.text,
                  passwordController.text,
                );

                if (!success) {
                  Get.snackbar(
                    'error'.tr,
                    'invalid_credentials'.tr,
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                }
              },
              child: Text('login'.tr),
            ),

            TextButton(
              onPressed: () {
                Get.to(() => RegisterView());
              },
              child: Text('no_account_register'.tr),
            ),
          ],
        ),
      ),
    );
  }
}

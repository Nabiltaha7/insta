import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta/data/models/auth/auth_controller.dart';
import 'settings_controller.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = Get.find<SettingsController>();
    final auth = Get.find<AuthController>();

    return Scaffold(
      appBar: AppBar(title: Text('settings'.tr)),
      body: Obx(
        () => ListView(
          children: [
            const SizedBox(height: 10),

            // 🌙 الوضع الليلي
            SwitchListTile(
              title: Text('dark_mode'.tr),
              value: settings.isDark.value,
              onChanged: settings.toggleTheme,
              secondary: const Icon(Icons.dark_mode),
            ),

            const Divider(),

            // 🌍 اللغة
            ListTile(
              leading: const Icon(Icons.language),
              title: Text('language'.tr),
              subtitle: Text(
                settings.locale.value.languageCode == 'ar'
                    ? 'العربية'
                    : 'English',
              ),
              onTap: () {
                Get.bottomSheet(
                  Container(
                    color: Theme.of(context).cardColor,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          title: const Text('العربية'),
                          onTap: () {
                            settings.changeLanguage('ar');
                            Get.back();
                          },
                        ),
                        ListTile(
                          title: const Text('English'),
                          onTap: () {
                            settings.changeLanguage('en');
                            Get.back();
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

            const Divider(),

            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: Text('logout'.tr, style: TextStyle(color: Colors.red)),
              onTap: () {
                auth.logout();
              },
            ),
          ],
        ),
      ),
    );
  }
}

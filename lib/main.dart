import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:insta/core/localization/app_translation.dart';
import 'package:insta/data/models/auth/auth_controller.dart';
import 'package:insta/data/models/auth/login_view.dart';
import 'package:insta/models/settings/settings_controller.dart';
import 'data/models/layout/main_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // تهيئة التخزين المحلي
  await GetStorage.init();

  // Controllers الأساسية (دائمة)
  Get.put(AuthController(), permanent: true);
  Get.put(SettingsController(), permanent: true);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = Get.find<SettingsController>();
    final auth = Get.find<AuthController>();

    return Obx(
      () => GetMaterialApp(
        translations: AppTranslations(),
        locale: settings.locale.value,
        fallbackLocale: const Locale('en'),

        builder: (context, child) {
          return Directionality(
            textDirection:
                settings.locale.value.languageCode == 'ar'
                    ? TextDirection.rtl
                    : TextDirection.ltr,
            child: child!,
          );
        },

        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: settings.isDark.value ? ThemeMode.dark : ThemeMode.light,
        home: auth.currentUser.value == null ? LoginView() : MainLayout(),
      ),
    );
  }
}

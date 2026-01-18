import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';

class SettingsController extends GetxController {
  final box = GetStorage();

  var isDark = false.obs;
  var locale = const Locale('en').obs;

  @override
  void onInit() {
    super.onInit();
    isDark.value = box.read('isDark') ?? false;
    locale.value = Locale(box.read('lang') ?? 'en');
  }

  void toggleTheme(bool value) {
    isDark.value = value;
    box.write('isDark', value);
    Get.changeThemeMode(value ? ThemeMode.dark : ThemeMode.light);
  }

  void changeLanguage(String langCode) {
    locale.value = Locale(langCode);
    box.write('lang', langCode);
    Get.updateLocale(locale.value);
  }
}

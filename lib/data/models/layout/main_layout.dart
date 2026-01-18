import 'package:flutter/material.dart';
import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:get/get.dart';

import 'package:insta/models/home/home_view.dart';
import 'package:insta/data/models/layout/video_view.dart';
import 'package:insta/models/settings/settings_view.dart';
import '../profile/profile_view.dart';
import '../auth/auth_controller.dart';
import 'package:insta/shared/widgets/user_avatar.dart';

class MainLayout extends StatefulWidget {
  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int index = 0;
  final auth = Get.find<AuthController>();

  late final pages = [
    HomeView(),
    VideoView(),
    ProfileView(),
    const SettingsView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[index],

      bottomNavigationBar: Obx(
        () => CircleNavBar(
          activeIndex: index,

          activeIcons: [
            const Icon(Icons.home, color: Colors.white),
            const Icon(Icons.video_library, color: Colors.white),
            UserAvatar(imagePath: auth.currentUser.value?['image'], size: 28),
            const Icon(Icons.settings, color: Colors.white),
          ],

          inactiveIcons: [
            const Icon(Icons.home),
            const Icon(Icons.video_library),
            UserAvatar(imagePath: auth.currentUser.value?['image'], size: 28),
            const Icon(Icons.settings),
          ],

          onTap: (v) {
            setState(() => index = v);
          },

          height: 60,
          circleWidth: 55,
          color: Colors.white,
          circleColor: Colors.blue,
        ),
      ),
    );
  }
}

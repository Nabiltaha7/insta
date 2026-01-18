import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta/shared/widgets/user_avatar.dart';
import '../auth/auth_controller.dart';
import 'profile_controller.dart';
import 'edit_profile_view.dart';

class ProfileView extends StatelessWidget {
  final controller = Get.put(ProfileController());
  final auth = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    final user = auth.currentUser.value!;

    return Scaffold(
      appBar: AppBar(
        title: Text('profile'.tr),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () async {
              await Get.to(() => EditProfileView());
              controller.fetchMyPosts();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),

            UserAvatar(imagePath: user['image'], size: 80),

            SizedBox(height: 10),
            Text(
              user['username'],
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(user['email']),

            SizedBox(height: 20),
            Divider(),

            Text(
              'my_posts'.tr,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            Obx(
              () => ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: controller.myPosts.length,
                itemBuilder: (context, index) {
                  final post = controller.myPosts[index];
                  return Card(
                    margin: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Image.file(File(post['image'])),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(post['caption']),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

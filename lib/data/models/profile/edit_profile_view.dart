import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta/core/db/app_database.dart';
import '../auth/auth_controller.dart';

class EditProfileView extends StatefulWidget {
  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final auth = Get.find<AuthController>();
  File? imageFile;

  late TextEditingController usernameController;
  late TextEditingController emailController;

  @override
  void initState() {
    super.initState();
    final user = auth.currentUser.value!;
    usernameController = TextEditingController(text: user['username']);
    emailController = TextEditingController(text: user['email']);
    if (user['image'] != null && user['image'] != '') {
      imageFile = File(user['image']);
    }
  }

  Future pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => imageFile = File(picked.path));
    }
  }

  Future saveProfile() async {
    final db = await AppDatabase.db;
    final currentUser = auth.currentUser.value!;
    final currentId = currentUser['id'];

    final newUsername = usernameController.text.trim();
    final newEmail = emailController.text.trim();

    final oldUsername = currentUser['username'];
    final oldEmail = currentUser['email'];

    // تحقق فقط إذا تغيّرت القيم
    if (newUsername != oldUsername || newEmail != oldEmail) {
      final exist = await db.query(
        'users',
        where: '(username = ? OR email = ?) AND id != ?',
        whereArgs: [newUsername, newEmail, currentId],
      );

      if (exist.isNotEmpty) {
        Get.snackbar(
          'error'.tr,
          'username_email_taken'.tr,
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }
    }

    await db.update(
      'users',
      {
        'username': newUsername,
        'email': newEmail,
        'image': imageFile?.path ?? '',
      },
      where: 'id = ?',
      whereArgs: [currentId],
    );

    // تحديث الجلسة
    auth.currentUser.value = {
      ...currentUser,
      'username': newUsername,
      'email': newEmail,
      'image': imageFile?.path ?? '',
    };

    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('edit_profile'.tr)),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            GestureDetector(
              onTap: pickImage,
              child: CircleAvatar(
                radius: 45,
                backgroundImage:
                    imageFile != null ? FileImage(imageFile!) : null,
                child: imageFile == null ? Icon(Icons.camera_alt) : null,
              ),
            ),
            SizedBox(height: 20),
            TextField(controller: usernameController),
            TextField(controller: emailController),
            SizedBox(height: 20),
            ElevatedButton(onPressed: saveProfile, child: Text('save'.tr)),
          ],
        ),
      ),
    );
  }
}

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'post_controller.dart';

class PostView extends StatelessWidget {
  final controller = Get.put(PostController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('new_post'.tr)),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Obx(
              () =>
                  controller.imagePath.isEmpty
                      ? IconButton(
                        icon: Icon(Icons.add_a_photo, size: 40),
                        onPressed: controller.pickImage,
                      )
                      : Image.file(
                        File(controller.imagePath.value),
                        height: 200,
                      ),
            ),

            TextField(
              onChanged: (v) => controller.caption.value = v,
              decoration: InputDecoration(hintText: 'write_caption'.tr),
            ),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: controller.savePost,
              child: Text('publish'.tr),
            ),
          ],
        ),
      ),
    );
  }
}

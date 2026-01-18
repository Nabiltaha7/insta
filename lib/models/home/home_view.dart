import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta/data/models/auth/auth_controller.dart';

import '../post/post_view.dart';
import '../comments/comment_view.dart';
import 'home_controller.dart';

class HomeView extends StatelessWidget {
  final controller = Get.put(HomeController());
  final auth = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [IconButton(icon: Icon(Icons.logout), onPressed: auth.logout)],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          final result = await Get.to(() => PostView());
          if (result == true) controller.fetchPosts();
        },
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: controller.posts.length,
          itemBuilder: (context, index) {
            final post = controller.posts[index];

            return Card(
              margin: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.file(File(post['image'])),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(post['caption']),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.comment),
                        onPressed: () {
                          Get.to(() => CommentView(postId: post['id']));
                        },
                      ),
                      if (post['userId'] == auth.currentUser.value!['id'])
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            // صفحة تعديل لاحقًا
                          },
                        ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

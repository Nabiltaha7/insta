import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta/data/models/auth/auth_controller.dart';
import '../../shared/widgets/user_avatar.dart';
import 'comment_controller.dart';

class CommentView extends StatelessWidget {
  final int postId;

  const CommentView({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CommentController(postId));
    final auth = Get.find<AuthController>();

    return Scaffold(
      appBar: AppBar(title: Text('comments'.tr)),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: controller.comments.length,
                itemBuilder: (context, index) {
                  final comment = controller.comments[index];

                  final isMe =
                      comment['userId'] == auth.currentUser.value!['id'];

                  return Row(
                    mainAxisAlignment:
                        isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // صورة الآخرين (يسار)
                      if (!isMe)
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: UserAvatar(
                            imagePath: comment['user_image'],
                            size: 36,
                          ),
                        ),

                      // فقاعة التعليق
                      Flexible(
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: isMe ? Colors.blue[400] : Colors.grey[300],
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                              bottomLeft:
                                  isMe
                                      ? Radius.circular(12)
                                      : Radius.circular(0),
                              bottomRight:
                                  isMe
                                      ? Radius.circular(0)
                                      : Radius.circular(12),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment:
                                isMe
                                    ? CrossAxisAlignment.end
                                    : CrossAxisAlignment.start,
                            children: [
                              Text(
                                comment['username'] ?? 'User',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: isMe ? Colors.white70 : Colors.black54,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                comment['text'],
                                style: TextStyle(
                                  color: isMe ? Colors.white : Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // صورة المستخدم (يمين)
                      if (isMe)
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: UserAvatar(
                            imagePath: auth.currentUser.value!['image'],
                            size: 36,
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
          ),

          // إدخال تعليق
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (v) => controller.commentText.value = v,
                    decoration: InputDecoration(
                      hintText: 'add_comment'.tr,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: controller.addComment,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

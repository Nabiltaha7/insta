import 'package:get/get.dart';
import 'package:insta/data/models/auth/auth_controller.dart';
import '../../core/db/app_database.dart';

class CommentController extends GetxController {
  final int postId;
  final auth = Get.find<AuthController>();

  CommentController(this.postId);

  var comments = <Map<String, dynamic>>[].obs;
  var commentText = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchComments();
  }

  Future fetchComments() async {
    final db = await AppDatabase.db;

    final result = await db.rawQuery(
      '''
      SELECT comments.id,
             comments.text,
             comments.userId,
             users.username,
             users.image AS user_image
      FROM comments
      JOIN users ON users.id = comments.userId
      WHERE comments.postId = ?
      ORDER BY comments.id ASC
    ''',
      [postId],
    );

    comments.value = result;
  }

  Future addComment() async {
    if (commentText.value.trim().isEmpty) return;

    final db = await AppDatabase.db;

    await db.insert('comments', {
      'postId': postId,
      'userId': auth.currentUser.value!['id'],
      'text': commentText.value.trim(),
    });

    commentText.value = '';
    await fetchComments();
  }
}

import 'package:get/get.dart';
import 'package:insta/core/db/app_database.dart';
import '../auth/auth_controller.dart';

class ProfileController extends GetxController {
  final auth = Get.find<AuthController>();

  var myPosts = [].obs;

  fetchMyPosts() async {
    final db = await AppDatabase.db;
    myPosts.value = await db.query(
      'posts',
      where: 'userId = ?',
      whereArgs: [auth.currentUser.value!['id']],
      orderBy: 'id DESC',
    );
  }

  @override
  void onInit() {
    fetchMyPosts();
    super.onInit();
  }
}

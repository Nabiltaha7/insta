import 'package:get/get.dart';
import '../../core/db/app_database.dart';

class HomeController extends GetxController {
  var posts = [].obs;

  fetchPosts() async {
    final db = await AppDatabase.db;
    posts.value = await db.query('posts', orderBy: 'id DESC');
  }

  @override
  void onInit() {
    fetchPosts();
    super.onInit();
  }
}

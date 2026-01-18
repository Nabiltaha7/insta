import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta/data/models/auth/auth_controller.dart';
import '../../core/db/app_database.dart';

class PostController extends GetxController {
  final AuthController auth = Get.find();

  var imagePath = ''.obs;
  var caption = ''.obs;

  pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      imagePath.value = image.path;
    }
  }

  savePost() async {
    final db = await AppDatabase.db;

    await db.insert('posts', {
      'userId': auth.currentUser.value!['id'],
      'image': imagePath.value,
      'caption': caption.value,
    });

    Get.back(result: true);
  }
}

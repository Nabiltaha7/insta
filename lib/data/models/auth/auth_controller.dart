import 'package:get/get.dart';
import 'package:insta/core/db/app_database.dart';

class AuthController extends GetxController {
  var currentUser = Rxn<Map<String, dynamic>>();

  /// إنشاء حساب
  Future<bool> register(String username, String email, String password) async {
    final db = await AppDatabase.db;

    username = username.trim();
    email = email.trim();
    password = password.trim();

    final exist = await db.query(
      'users',
      where: 'email = ? OR username = ?',
      whereArgs: [email, username],
    );

    if (exist.isNotEmpty) return false;

    await db.insert('users', {
      'username': username,
      'email': email,
      'password': password,
      'image': '',
    });

    return true;
  }

  /// تسجيل دخول (اسم مستخدم + كلمة سر)
  Future<bool> login(String username, String password) async {
    final db = await AppDatabase.db;

    username = username.trim();
    password = password.trim();

    final user = await db.query(
      'users',
      where: 'username = ? AND password = ?',
      whereArgs: [username, password],
    );

    if (user.isNotEmpty) {
      currentUser.value = user.first;
      return true;
    }
    return false;
  }

  logout() {
    currentUser.value = null;
  }
}

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AppDatabase {
  static Database? _db;

  static Future<Database> get db async {
    _db ??= await initDB();
    return _db!;
  }

  static Future<Database> initDB() async {
    final path = join(await getDatabasesPath(), 'social.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, v) async {
        await db.execute('''
        CREATE TABLE users(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          username TEXT,
          email TEXT,
          password TEXT,
          image TEXT
        )
        ''');

        await db.execute('''
        CREATE TABLE posts(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          userId INTEGER,
          image TEXT,
          caption TEXT
        )
        ''');

        await db.execute('''
        CREATE TABLE comments(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          postId INTEGER,
          userId INTEGER,
          text TEXT
        )
        ''');
      },
    );
  }
}

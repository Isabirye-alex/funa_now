import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AuthStorage {
  static Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  Future<Database> _initDB() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = join(dir.path, 'auth.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE auth (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        token TEXT,
        userId INTEGER
      )
    ''');
  }

  Future<void> saveAuthData(String token, int userId) async {
    final db = await database;
    await db.insert('auth', {
      'token': token,
      'userId': userId,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<Map<String, dynamic>?> getAuthData() async {
    final db = await database;
    final result = await db.query('auth', orderBy: 'id DESC', limit: 1);
    if (result.isNotEmpty) {
      return result.first;
    }
    return null;
  }

  Future<void> clearAuthData() async {
    final db = await database;
    await db.delete('auth');
  }
}

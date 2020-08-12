import 'package:MySeedBank/models/db_item.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class DB {
  static Future<Database> connect() async {
    final dbDir = await getDatabasesPath();
    final dbPath = path.join(dbDir, 'seeds.db');

    // reset current database
    // await deleteDatabase(dbPath);

    return openDatabase(dbPath, onCreate: (db, version) {
      db.execute(
          "CREATE TABLE IF NOT EXISTS seeds (id INTEGER PRIMARY KEY AUTOINCREMENT, plantId INTEGER, title TEXT, quantity INTEGER, units INTEGER, datePacked TEXT)");
      db.execute(
          "CREATE TABLE IF NOT EXISTS user (id INTEGER PRIMARY KEY AUTOINCREMENT, storage TEXT, hemisphere TEXT, climate TEXT)");
    }, version: 1);
  }

  static Future<T> insert<T extends DBItem>(String table, T data) async {
    var db = await DB.connect();
    data.id = await db.insert(table, data.toMap());
    return data;
  }

  static Future<void> update<T extends DBItem>(
      int id, String table, T data) async {
    var db = await DB.connect();
    await db.update(table, data.toMap(), where: "id == $id");
  }

  static Future<List<Map<String, dynamic>>> getRecords<T>(String table) async {
    var db = await DB.connect();
    return db.query(table);
  }

  static Future<Map<String, dynamic>> getRecordById<T>(
      String table, int id) async {
    var db = await DB.connect();
    var data = await db.query(table, where: "id = $id");
    return data.length > 0 ? data[0] : null;
  }

  static Future<void> deleteRecord(int id, String table) async {
    var db = await DB.connect();
    await db.delete(table, where: "id = $id");
  }
}

import 'dart:io';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class StaticDB {
  static Future<Database> connect() async {
    final dbDir = await getDatabasesPath();
    final dbPath = path.join(dbDir, 'seeds-static.db');

    var exists = await databaseExists(dbPath);
    if (!exists) {
      try {
        await Directory(path.dirname(dbPath)).create(recursive: true);
      } catch (_) {}

      ByteData data = await rootBundle.load(path.join("assets", "seedbank.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(dbPath).writeAsBytes(bytes, flush: true);
    }

    return openDatabase(dbPath, version: 1);
  }

  static Future<List<Map<String, dynamic>>> getRecords<T>(String table) async {
    var db = await StaticDB.connect();
    return db.query(table);
  }

  static Future<Map<String, dynamic>> getRecordById<T>(
      String table, int id) async {
    var db = await StaticDB.connect();
    var data = await db.query(table, where: "id = $id");
    return data.length > 0 ? data[0] : null;
  }
}

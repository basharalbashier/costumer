import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    // if _database is null we instantiate it
    _database = await initDB();
    return _database!;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "1.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE info (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, phone TEXT, email TEXT)');});
 
  }


   Future getMe() async {
    final db = await database;
    var result = await db.rawQuery("SELECT * FROM info  ");
    // WHERE job = '%${search}%' OR joba = '${search}' OR jobb = '${search}' OR jobc = '${search}' ORDER BY distance;
    // print(result[0]);
    if (result.isEmpty) return 0;

    return result;
  }

  addMe( newPro) async {
    final db = await database;
    db.rawDelete("Delete from info");
    var raw = await db.rawInsert(
        "INSERT Into info (id,name,phone,email)"
        " VALUES (?,?,?,?)",
        [
          1,
          newPro[0],
          newPro[1],
          newPro[2],
        ]);

    return raw;
  }

  }
  

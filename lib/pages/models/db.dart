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
          'CREATE TABLE info (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, phone TEXT, email TEXT, account TEXT, token TEXT)');

      await db.execute(
          'CREATE TABLE stores (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, comments TEXT, address TEXT, late TEXT, longe TEXT)');

      await db.execute(
          'CREATE TABLE locations (id INTEGER PRIMARY KEY AUTOINCREMENT, address TEXT, late TEXT, longe TEXT)');
    });
  }

  Future getMe() async {
    final db = await database;
    var result = await db.rawQuery("SELECT * FROM info  ");
    // WHERE job = '%${search}%' OR joba = '${search}' OR jobb = '${search}' OR jobc = '${search}' ORDER BY distance;
    // print(result[0]);
    if (result.isEmpty) return 0;

    return result;
  }
  Future getPoints() async {
    final db = await database;
    var result = await db.rawQuery("SELECT * FROM locations  ");
    // WHERE job = '%${search}%' OR joba = '${search}' OR jobb = '${search}' OR jobc = '${search}' ORDER BY distance;
    // print(result[0]);
    if (result.isEmpty) return 0;

    return result;
  }
  addMe(Map newPro) async {
    final db = await database;
    db.rawDelete("Delete from info");
    var raw = await db.rawInsert(
        "INSERT Into info (id,name,phone,email,account,token)"
        " VALUES (?,?,?,?,?,?)",
        [
           newPro['id'],
          newPro['name'],
          newPro['phone'],
          newPro['email'],
          newPro['account'],
          newPro['token'],
        ]);

    return raw;
  }

 addPoint(List<String> newPoint) async {
    final db = await database;

      var result = await db.rawQuery(
        "SELECT * FROM locations WHERE late LIKE '%${newPoint[1]}%' AND longe LIKE '%${  newPoint[2]}%'  ");
   if(result.isEmpty){

     await db.rawInsert(
        "INSERT Into locations (address,late,longe)"
        " VALUES (?,?,?)",
        [
          
          newPoint[0],
          newPoint[1],
          newPoint[2],
        
        ]);

   }else{
    print(result);
   }
   
    

    // return raw;
  }


}

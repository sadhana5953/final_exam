import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DataBaseHelper
{
  DataBaseHelper._();
  static DataBaseHelper dbHelper=DataBaseHelper._();

  Database? _database;

  Future<Database?> get database async =>_database??await initDatabase();

  Future<Database> initDatabase()
  async {
    var path = await getDatabasesPath();
    String dbPath = join(path, 'fitness.db');
   return _database = await openDatabase(dbPath, version: 1,
        onCreate: (Database db, int version) async {
          await db.execute(
              '''CREATE TABLE fitness(id INTEGER PRIMARY KEY, email TEXT, name TEXT,time TEXT,date TEXT,type TEXT, docId TEXT)''');
        });
  }

  Future<void> insertData(String email,String name,String time,String date,String type,String docId)
  async {
    final db=await database;
    String sql='''
    INSERT INTO fitness(email, name, time, date, type, docId) VALUES(?, ?, ?, ?, ?, ?);
    ''';
    List args=[email,name,time,date,type,docId];
    await db!.rawInsert(sql,args);
  }

  Future<List<Map<String, Object?>>> redaData(String email)
  async {
    final db=await database;
    String sql='''
    SELECT * FROM fitness WHERE email=?;
    ''';
    List args=[email];
    return await db!.rawQuery(sql,args);
  }

  Future<void> updateData(String name,String time,String date,String type,int id,String email)
  async {
    final db=await database;
    String sql='''
    UPDATE fitness SET name = ?, time=?, date=?, type = ? WHERE id = ? AND email=?;
    ''';
    List args=[name,time,date,type,id,email];
    await db!.rawUpdate(sql,args);
  }

  Future<void> removeData(int id,String email)
  async {
    final db=await database;
    String sql='''
    DELETE FROM fitness WHERE id = ? AND email=?;
    ''';
    List args=[id,email];
    await db!.rawDelete(sql,args);
  }

  Future<List<Map<String, Object?>>> selectData(String email,String type)
  async {
    final db=await database;
    String sql='''
    SELECT * FROM fitness WHERE email=? AND type=?;
    ''';
    List args=[email,type];
    return await db!.rawQuery(sql,args);
  }
}
//Workout Name, Duration (minutes), Date, and Type (e.g., Cardio, Strength).
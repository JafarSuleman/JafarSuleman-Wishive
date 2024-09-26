
import 'package:socialv/whv/constants/whv_local_storage_tables.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class WhvDBHelper {
  static Database? _db;

  Future<Database?> get database async {
    if (_db != null) {
      return _db;
    } else {
      _db = await _initDatabase();
      return _db;
    }
  }

  Future<Database> _initDatabase() async {
    final appDocsDirectory = await getApplicationDocumentsDirectory();
    var path = join(appDocsDirectory.path, 'whv_shop.db');
    var db = await openDatabase(
      path,
      onCreate: _onCreate,
      version: 1,
    );
    return db;
  }

  static _onCreate(Database db, int newVersion) async {
    Batch batch = db.batch();

    batch.execute(
      'CREATE TABLE ${WhvLocalStorageTables.tabs}(id TEXT PRIMARY KEY, title TEXT, url TEXT, preview BLOB)',
    );
    batch.execute(
      'CREATE TABLE ${WhvLocalStorageTables.bookmarks}(id TEXT PRIMARY KEY, title TEXT, url TEXT, date INTEGER)',
    );
    batch.execute(
      'CREATE TABLE ${WhvLocalStorageTables.history}(id TEXT PRIMARY KEY, title TEXT, url TEXT, date INTEGER)',
    );
    List<dynamic> res = await batch.commit();
  }

  Future<int> insert({
    required String? table,
    required Map<String, dynamic>? data,
  }) async {
    final db = await database;
    int id = await db!.insert(
      table!,
      data!,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return id;
  }

  Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await database;
    return db!.query(table);
  }

  Future<int> delete({
    String? table,
    int? id,
  }) async {
    final db = await database;
    var response = await db?.delete(
      table!,
      where: 'id = ?',
      whereArgs: [id],
    );
    return response ?? -1;
  }

  Future<int> updateData({
    int? id,
    String? table,
    required Map<String, dynamic>? data,
  }) async {
    final db = await database;
    var response = await db?.update(
      table!,
      data!,
      where: 'id = ?',
      whereArgs: [id],
    );
    return response ?? -1;
  }

  Future deleteTable(String tableName) async {
    final db = await database;

    return db?.rawQuery('DELETE FROM $tableName');
  }
}

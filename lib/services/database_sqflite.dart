import 'package:path/path.dart';
import 'package:shortly/models/short_link/short_link.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseSqfLite {
  static const _databaseName = "shortLink.db";
  static const _databaseVersion = 1;
  static const table = 'short_link';
  static const columnId = 'id';

  /// For Singleton
  DatabaseSqfLite._privateConstructor();

  static final DatabaseSqfLite instance = DatabaseSqfLite._privateConstructor();
  static Database? _database;

  /// For Get or Initialize DB
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  /// For Initialize DB
  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  /// For Create DB
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            code TEXT,
            short_link TEXT,
            full_short_link TEXT,
            short_link2 TEXT,
            full_short_link2 TEXT,
            short_link3 TEXT,
            full_short_link3 TEXT,
            share_link TEXT,
            full_share_link TEXT,
            original_link TEXT
          )
          ''');
  }

  /// For Add ShortLink To DB
  Future<int> insert(ShortLink link) async {
    Database db = await instance.database;
    return await db.insert(table, link.toJson());
  }

  /// For Fetch ShortLink From DB
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(table);
  }

  /// For Delete ShortLink From DB
  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }
}
import 'package:dictionary_app/database/memori/memori_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'dart:io';
import 'package:path/path.dart';


class MemoriDatabase {
  final String DB_NAME = "my_memori.db";
  final String TABLE = "my_memori";
  final String ID = "id";
  final String WORD = "word";
  final String SPELL = "spell";
  final String MEAN = "mean";

  static final MemoriDatabase _instance = MemoriDatabase._();
  static Database _database;

  MemoriDatabase._();

  factory MemoriDatabase() {
    return _instance;
  }

  Future<Database> get db async {
    if (_database != null) {
      return _database;
    }
    _database = await init();
    return _database;
  }
  // Database isn't available
  Future<Database> init() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, DB_NAME);

    var database = openDatabase(path, version: 1, onCreate: _onCreate, onUpgrade: _onUpgrade);
    return database;
  }

  // Database from Asset
  /*
  Future<Database> init() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, DB_NAME);
// Check if the database exists
    var exists = await databaseExists(path);
    if (!exists) {
      // Should happen only the first time you launch your application
      print("Creating new copy from asset");
      // Make sure the parent directory exists
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}
      // Copy from asset
      ByteData data = await rootBundle.load(join("assets/databases", DB_NAME));
      List<int> bytes =
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      // Write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);
    } else {
      print("Opening existing database");
    }
// open the database
    var db = await openDatabase(path, readOnly: true);
    return db;
  }
  */


  void _onCreate(Database db, int version) {
    db.execute('''
      CREATE TABLE $TABLE(
        $ID INTEGER PRIMARY KEY AUTOINCREMENT,
        $WORD TEXT,
        $SPELL TEXT,
        $MEAN TEXT)       
    ''');
    print("Mark Database was created!");
  }

  void _onUpgrade(Database db, int oldVersion, int newVersion) {
    // Run migration according database versions
  }

  // Add Row
  Future<int> addMark(MemoriModel mark) async {
    var client = await db;
    print("Adding...");
    return client.insert(
        TABLE, mark.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<MemoriModel> fetchMark(int id) async {
    var client = await db;
    final Future<List<Map<String, dynamic>>> futureMaps =
    client.query(TABLE, where: '$ID = ?', whereArgs: [id]);

    var maps = await futureMaps;
    if (maps.length != 0) {
      return MemoriModel.fromJson(maps.first);
    }
    return null;
  }

  Future<MemoriModel> fetchMarkByWord(String word) async {
    var client = await db;
    final Future<List<Map<String, dynamic>>> futureMaps =
    client.query(TABLE, where: '$WORD = ?', whereArgs: [word]);

    var maps = await futureMaps;
    if (maps.length != 0) {
      return MemoriModel.fromJson(maps.first);
    }
    return null;
  }

  Future<List<MemoriModel>> fetchAll() async {
    var client = await db;
    var res = await client.query(TABLE);

    if (res.isNotEmpty) {
      var marks = res.map((markMap) => MemoriModel.fromJson(markMap)).toList();
      return marks;
    }
    return [];
  }

  deleteAll() async {
    List<MemoriModel> list = await fetchAll();
    for (int i = 0; i < list.length; i++) {
      await removeMark(list[i].id);
    }
  }

  Future<void> removeMark(int id) async {
    var client = await db;
    client.delete(TABLE, where: '$ID = ?', whereArgs: [id]);
  }

  Future closeDb() async {
    var client = await db;
    client.close();
  }
}

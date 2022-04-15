// ignore_for_file: unused_local_variable
import 'package:flashorder/helpers/table_creator.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Helper {
  static final Helper instance = Helper._init();

  static Database? _database;

  Helper._init();

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await _initDB('theflashorder.db');
    return _database;
  }

  Future<Database> _initDB(String filepath) async {
    final dbpath = await getDatabasesPath();
    final path = join(dbpath, filepath);

    return await openDatabase(path,
        version: 1, onCreate: _createDB, onUpgrade: _upgradeDB);
  }

  Future<void> _upgradeDB(Database db, int version, int newversion) async {}

  Future _createDB(Database db, int version) async {
    await TableCreator.createFavoriteTable(db);
  }

  Future close() async {
    final db = await instance.database;
    db!.close();
  }
}

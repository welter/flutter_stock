import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class sqfDatabaseProvider {
  static Database _database;

  static Future<Database> getDatabase(String db_name) async {
    if (_database != null) return _database;

    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      // 初始化 FFI
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    }

    // 获取路径
    String path;
    if (Platform.isAndroid || Platform.isIOS) {
      final dir = await getApplicationDocumentsDirectory();
      path = join(dir.path, db_name);
    } else {
      path = join(Directory.current.path, db_name);
    }

    _database = await openDatabase(path, version: 4,
        onCreate: (Database db, int version) async {
          print('db created version is $version');
        }, onOpen: (Database db) async {
          await db.execute('''  
                CREATE TABLE 'stock_list' (
                  id INTEGER PRIMARY KEY, 
                  code TEXT, 
                  name TEXT, 
                  jc TEXT);             
                ''');
        }
        );

    return _database;
  }
}

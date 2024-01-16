import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseInitializer {
  static Future<Database> initDatabase() async {
    final String path = join(await getDatabasesPath(), 'organizagro.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE cash_transactions(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            amount TEXT,
            date INTEGER,
            multiplier INTEGER
          )
        ''');
        await db.execute('''
          CREATE TABLE item_categories(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            icon TEXT,
            unit_of_measure TEXT,
            name TEXT
          )
        ''');
        await db.execute('''
          CREATE TABLE inventory_items(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            category_id INTEGER,
            name TEXT,
            quantity INTEGER,
            date INTEGER,
            multiplier INTEGER,
            FOREIGN KEY (category_id) REFERENCES item_categories(id) ON DELETE CASCADE
          )
        ''');
        await db.rawInsert('''
          INSERT INTO item_categories (icon, unit_of_measure, name)
          VALUES ('inventário', 'Sacos', 'Silagem')
        ''');
        await db.rawInsert('''
          INSERT INTO item_categories (icon, unit_of_measure, name)
          VALUES ('engrenagem', 'Metros', 'Arame')
        ''');
        await db.rawInsert('''
          INSERT INTO item_categories (icon, unit_of_measure, name)
          VALUES ('estoque', 'Quilos', 'Milho')
        ''');
      },
    );
  }
}

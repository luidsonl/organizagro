import 'package:sqflite/sqflite.dart';
import '../models/iten_category.dart';
import 'database_initializer_dao.dart';

class ItemCategoryDAO {
  static const String tableName = 'item_categories';

  Future<Database> get database async =>
      await DatabaseInitializer.initDatabase();

  Future<void> insertItemCategory(ItemCategory itemCategory) async {
    final Database db = await database;

    await db.insert(
      tableName,
      itemCategory.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<ItemCategory>> getAllItemCategories() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(tableName);

    return List.generate(
      maps.length,
      (index) {
        return ItemCategory.fromMap(maps[index], db);
      },
    );
  }

  Future<ItemCategory> getItemCategory(int id) async {
    final Database db = await database;

    List<Map<String, dynamic>> maps = await db.query(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );

    return ItemCategory.fromMap(maps.first, db);
  }

  Future<void> updateItemCategory(ItemCategory itemCategory) async {
    final Database db = await database;

    await db.update(
      tableName,
      itemCategory.toMap(),
      where: 'id = ?',
      whereArgs: [itemCategory.id],
    );
  }

  Future<void> deleteItemCategory(int id) async {
    final Database db = await database;

    await db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    await db.delete(
      'inventory_items',
      where: 'category_id = ?',
      whereArgs: [id],
    );
  }
}

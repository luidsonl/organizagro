import 'package:sqflite/sqflite.dart';
import '../models/inventory_item.dart';
import 'database_initializer_dao.dart';

class InventoryItemDAO {
  static const String tableName = 'inventory_items';

  Future<Database> get database async =>
      await DatabaseInitializer.initDatabase();

  Future<void> insertInventoryItem(InventoryItem inventoryItem) async {
    final Database db = await database;

    await db.insert(
      tableName,
      inventoryItem.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<InventoryItem>> getAllInventoryItems() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(tableName);

    return List.generate(
      maps.length,
      (index) {
        return InventoryItem.fromMap(maps[index], db);
      },
    );
  }

  Future<List<InventoryItem>> getInventoryItemsByCategory(
      int categoryId) async {
    final Database db = await database;

    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      where: 'category_id = ?',
      whereArgs: [categoryId],
    );

    return List.generate(
      maps.length,
      (index) {
        return InventoryItem.fromMap(maps[index], db);
      },
    );
  }

  Future<void> updateInventoryItem(InventoryItem inventoryItem) async {
    final Database db = await database;

    await db.update(
      tableName,
      inventoryItem.toMap(),
      where: 'id = ?',
      whereArgs: [inventoryItem.id],
    );
  }

  Future<void> deleteInventoryItem(int id) async {
    final Database db = await database;

    await db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id.toString()],
    );
  }
}

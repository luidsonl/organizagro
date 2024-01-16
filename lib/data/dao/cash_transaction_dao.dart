import 'package:organizagro/data/dao/database_initializer_dao.dart';
import 'package:sqflite/sqflite.dart';

import '../models/cash_transaction.dart';

class CashTransactionDAO {
  static const String tableName = 'cash_transactions';

  Future<Database> get database async =>
      await DatabaseInitializer.initDatabase();

  Future<void> insertCashTransaction(CashTransaction cashTransaction) async {
    final Database db = await database;

    await db.insert(
      tableName,
      cashTransaction.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<CashTransaction>> getAllCashTransactions() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(tableName);

    return List.generate(
      maps.length,
      (index) {
        return CashTransaction.fromMap(maps[index]);
      },
    );
  }

  Future<void> updateCashTransaction(CashTransaction cashTransaction) async {
    final Database db = await database;

    await db.update(
      tableName,
      cashTransaction.toMap(),
      where: 'id = ?',
      whereArgs: [cashTransaction.id],
    );
  }

  Future<void> deleteCashTransaction(int id) async {
    final Database db = await database;

    await db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

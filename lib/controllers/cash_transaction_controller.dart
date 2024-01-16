import 'package:organizagro/data/dao/cash_transaction_dao.dart';
import 'package:organizagro/data/models/cash_transaction.dart';

class CashTransactionController {
  Future<List<CashTransaction>> fetchAllTransactions() async {
    return await CashTransactionDAO().getAllCashTransactions();
  }

  Future<void> createTransaction(CashTransaction transaction) async {
    await CashTransactionDAO().insertCashTransaction(transaction);
  }

  Future<void> deleteTransaction(int id) async {
    await CashTransactionDAO().deleteCashTransaction(id);
  }
}

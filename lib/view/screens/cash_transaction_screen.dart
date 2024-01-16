import 'package:flutter/material.dart';
import 'package:organizagro/controllers/cash_transaction_controller.dart';
import 'package:organizagro/data/models/cash_transaction.dart';
import 'package:organizagro/view/widgets/cash_transaction_screen/final_balance_card.dart';
import 'package:organizagro/view/widgets/cash_transaction_screen/transaction_form.dart';
import 'package:organizagro/view/widgets/cash_transaction_screen/transaction_list.dart';
import 'package:organizagro/view/widgets/organizagro_drawer.dart';

class CashTransactionScreen extends StatefulWidget {
  const CashTransactionScreen({super.key});
  static const name = '/cash_transaction_screen';
  @override
  State<CashTransactionScreen> createState() => _CashTransactionScreenState();
}

class _CashTransactionScreenState extends State<CashTransactionScreen> {
  List<CashTransaction> transactionList = [];
  double totalAmount = 0;

  Future<void> updateTransactionList() async {
    final data = await CashTransactionController().fetchAllTransactions();
    setState(() {
      transactionList = data;
    });
  }

  void updateState() {
    updateTransactionList();
  }

  @override
  void initState() {
    super.initState();
    updateTransactionList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Financeiro'),
      ),
      drawer: const OrganizagroDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Center(
              child: FinalBalanceCard(transactionList: transactionList),
            ),
            Expanded(
              child: TransactionList(
                updateState: updateState,
                transactionList: transactionList,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await showModalBottomSheet(
            context: context,
            builder: (_) => const TransactionForm(),
            isScrollControlled: true,
          );
          updateState();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

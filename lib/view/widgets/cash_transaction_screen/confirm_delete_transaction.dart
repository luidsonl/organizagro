import 'package:flutter/material.dart';
import 'package:organizagro/controllers/cash_transaction_controller.dart';
import 'package:organizagro/data/models/cash_transaction.dart';

class ConfirmDeleteTransaction extends StatelessWidget {
  final CashTransaction transaction;
  const ConfirmDeleteTransaction({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Deletar "${transaction.name}" ?'),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('Não deletar')),
          ElevatedButton(
              onPressed: () async {
                await CashTransactionController()
                    .deleteTransaction(transaction.id);
                // ignore: use_build_context_synchronously
                Navigator.pop(context);
              },
              child: const Text('Deletar'))
        ],
      ),
    );
  }
}

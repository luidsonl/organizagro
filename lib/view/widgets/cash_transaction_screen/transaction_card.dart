import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:organizagro/data/models/cash_transaction.dart';
import 'package:organizagro/view/widgets/cash_transaction_screen/confirm_delete_transaction.dart';

class TransactionCard extends StatelessWidget {
  final CashTransaction cashTransaction;
  final VoidCallback? updateState;

  const TransactionCard(
      {super.key, required this.cashTransaction, this.updateState});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(cashTransaction.id),
      confirmDismiss: (_) async {
        await showDialog(
            context: context,
            builder: (_) => ConfirmDeleteTransaction(
                  transaction: cashTransaction,
                ));
        if (updateState != null) {
          updateState!();
        }
        return null;
      },
      child: ListTile(
        contentPadding: const EdgeInsets.all(20),
        title: Text(
          cashTransaction.name,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const Text(
                  'Data:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  DateFormat('dd/MM/yyyy').format(cashTransaction.date),
                ),
              ],
            ),
          ],
        ),
        trailing: Text(
            '${(cashTransaction.amount * cashTransaction.multiplier).toStringAsFixed(2)} R\$'),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:organizagro/data/models/cash_transaction.dart';

import 'transaction_card.dart';

class TransactionList extends StatelessWidget {
  final List<CashTransaction> transactionList;
  final VoidCallback? updateState;

  const TransactionList(
      {super.key, required this.transactionList, this.updateState});

  @override
  Widget build(BuildContext context) {
    transactionList.sort((a, b) => b.date.compareTo(a.date));
    if (transactionList.isEmpty) {
      return const Center(child: Text('Sem registro de operações'));
    } else {
      return ListView.builder(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        itemBuilder: (_, i) => TransactionCard(
          cashTransaction: transactionList[i],
          updateState: updateState,
        ),
        itemCount: transactionList.length,
      );
    }
  }
}

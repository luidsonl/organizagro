import 'package:flutter/material.dart';
import 'package:organizagro/data/models/cash_transaction.dart';

class FinalBalanceCard extends StatelessWidget {
  final List<CashTransaction> transactionList;
  const FinalBalanceCard({super.key, required this.transactionList});

  @override
  Widget build(BuildContext context) {
    double totalSum = 0;

    for (var transaction in transactionList) {
      totalSum += transaction.amount * transaction.multiplier;
    }

    return Center(
      child: Container(
        width: 300,
        decoration: BoxDecoration(
          border: Border.all(width: 1),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Saldo: ${totalSum.toStringAsFixed(2)} R\$',
                style: const TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

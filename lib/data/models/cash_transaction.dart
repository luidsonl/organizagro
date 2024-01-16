class CashTransaction {
  int id;
  String name;
  double amount;
  DateTime date;
  int multiplier; // 1 para entrada, -1 para saída

  CashTransaction({
    required this.name,
    required this.id,
    required this.amount,
    required this.multiplier,
    required this.date,
  });

  factory CashTransaction.fromMap(Map<String, dynamic> map) {
    return CashTransaction(
      name: map['name'],
      id: map['id'],
      amount: double.parse(map['amount']),
      multiplier: map['multiplier'],
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'amount': amount.toString(),
      'multiplier': multiplier,
      'date': date.millisecondsSinceEpoch,
    };
  }
}

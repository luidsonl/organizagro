import 'package:sqflite/sqflite.dart';

class InventoryItem {
  int id;
  int categoryId;
  String name;
  int quantity;
  DateTime date;
  int multiplier;

  InventoryItem({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.quantity,
    required this.date,
    required this.multiplier,
  });

  factory InventoryItem.fromMap(Map<String, dynamic> map, Database db) {
    return InventoryItem(
      id: map['id'],
      categoryId: map['category_id'],
      name: map['name'],
      quantity: map['quantity'],
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      multiplier: map['multiplier'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'category_id': categoryId,
      'name': name,
      'quantity': quantity,
      'date': date.millisecondsSinceEpoch,
      'multiplier': multiplier,
    };
  }
}

import 'package:sqflite/sqflite.dart';

class ItemCategory {
  int id;
  String icon;
  String unitOfMeasure;
  String name;

  ItemCategory({
    required this.id,
    required this.icon,
    required this.unitOfMeasure,
    required this.name,
  });

  factory ItemCategory.fromMap(Map<String, dynamic> map, Database db) {
    return ItemCategory(
        id: map['id'],
        icon: map['icon'],
        unitOfMeasure: map['unit_of_measure'],
        name: map['name']);
  }

  Map<String, dynamic> toMap() {
    return {
      'icon': icon,
      'unit_of_measure': unitOfMeasure,
      'name': name,
    };
  }
}

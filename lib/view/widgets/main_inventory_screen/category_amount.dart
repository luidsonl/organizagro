import 'package:flutter/material.dart';
import 'package:organizagro/controllers/inventory_item_controller.dart';
import '../../../data/models/iten_category.dart';

class CategoryAmount extends StatelessWidget {
  const CategoryAmount({
    super.key,
    required this.itemCategory,
  });

  final ItemCategory itemCategory;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
      future: InventoryItemController().getTotalCategoryAmount(itemCategory.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data == 0) {
          return const Text('Sem estoque disponível');
        } else {
          int amount = snapshot.data!;
          return Text('${amount.toString()} ${itemCategory.unitOfMeasure}');
        }
      },
    );
  }
}

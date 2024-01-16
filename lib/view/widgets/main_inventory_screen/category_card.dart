import 'package:flutter/material.dart';
import 'package:organizagro/constants/icons.dart';
import 'package:organizagro/view/screens/inventory_category_screen.dart';
import '../../../data/models/iten_category.dart';
import 'category_amount.dart';

class CategoryCard extends StatelessWidget {
  final ItemCategory itemCategory;
  final VoidCallback? updateState;

  const CategoryCard({Key? key, required this.itemCategory, this.updateState})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () async {
          await Navigator.of(context)
              .pushNamed(InventoryCategoryScreen.name, arguments: itemCategory);
          if (updateState != null) {
            updateState!();
          }
        },
        title: Text(itemCategory.name),
        trailing: CategoryAmount(itemCategory: itemCategory),
        leading: Icon(categoryIcons[itemCategory.icon]),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:organizagro/data/models/inventory_item.dart';
import 'package:organizagro/data/models/iten_category.dart';
import 'package:organizagro/view/widgets/inventory_category_screen/item_card.dart';

class ItemList extends StatelessWidget {
  final List<InventoryItem> itemList;
  final ItemCategory category;
  final VoidCallback? updateState;

  const ItemList({
    super.key,
    required this.itemList,
    required this.category,
    this.updateState,
  });

  @override
  Widget build(BuildContext context) {
    if (itemList.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Sem movimentações'),
        ),
      );
    } else {
      itemList.sort((a, b) => b.date.compareTo(a.date));
      return ListView.builder(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        itemBuilder: (_, i) => ItemCard(
          updateState: updateState,
          item: itemList[i],
          category: category,
        ),
        itemCount: itemList.length,
      );
    }
  }
}

import 'package:flutter/material.dart';
import 'package:organizagro/controllers/inventory_item_controller.dart';
import 'package:organizagro/data/models/inventory_item.dart';
import 'package:organizagro/data/models/iten_category.dart';

class ConfirmDeleteItem extends StatelessWidget {
  const ConfirmDeleteItem(
      {super.key,
      required this.item,
      required this.category,
      this.updateState});

  final VoidCallback? updateState;
  final InventoryItem item;
  final ItemCategory category;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Deletar "${item.name}" ?'),
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
                await InventoryItemController().deleteItem(item.id);
                if (updateState != null) {
                  updateState!();
                }
                Navigator.of(context).pop();
              },
              child: const Text('Deletar'))
        ],
      ),
    );
  }
}

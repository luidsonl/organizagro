import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:organizagro/data/models/inventory_item.dart';
import 'package:organizagro/data/models/iten_category.dart';
import 'package:organizagro/view/widgets/inventory_category_screen/confirm_delete_item.dart';

class ItemCard extends StatelessWidget {
  final ItemCategory category;
  final InventoryItem item;
  final VoidCallback? updateState;

  const ItemCard(
      {super.key,
      required this.item,
      required this.category,
      this.updateState});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(item.id),
      confirmDismiss: (_) async {
        await showDialog(
            context: context,
            builder: (_) => ConfirmDeleteItem(
                  item: item,
                  category: category,
                ));
        if (updateState != null) {
          updateState!();
        }
        return null;
      },
      child: ListTile(
        contentPadding: const EdgeInsets.all(20),
        title: Text(
          item.name,
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
                  DateFormat('dd/MM/yyyy').format(item.date),
                ),
              ],
            ),
          ],
        ),
        trailing: Text(
            '${(item.quantity * item.multiplier).toString()} ${category.unitOfMeasure}'),
      ),
    );
  }
}

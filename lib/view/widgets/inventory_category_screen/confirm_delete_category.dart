import 'package:flutter/material.dart';
import 'package:organizagro/controllers/item_category_controller.dart';
import 'package:organizagro/data/models/iten_category.dart';

class ConfirmDeleteCategory extends StatelessWidget {
  const ConfirmDeleteCategory({
    super.key,
    required this.category,
  });

  final ItemCategory category;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Deletar "${category.name}" ?'),
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
                await ItemCategoryController().deleteCategory(category.id);

                // ignore: use_build_context_synchronously
                Navigator.pop(context);
                // ignore: use_build_context_synchronously
                Navigator.pop(context);
              },
              child: const Text('Deletar'))
        ],
      ),
    );
  }
}

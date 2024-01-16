import 'package:flutter/material.dart';
import 'package:organizagro/constants/icons.dart';
import 'package:organizagro/controllers/inventory_item_controller.dart';
import 'package:organizagro/data/models/inventory_item.dart';
import 'package:organizagro/data/models/iten_category.dart';
import 'package:organizagro/view/widgets/inventory_category_screen/category_info.dart';
import 'package:organizagro/view/widgets/inventory_category_screen/confirm_delete_category.dart';
import 'package:organizagro/view/widgets/inventory_category_screen/item_form.dart';
import 'package:organizagro/view/widgets/inventory_category_screen/item_list.dart';

class InventoryCategoryScreen extends StatefulWidget {
  const InventoryCategoryScreen({super.key});

  static const name = '/inventory_category_screen';

  @override
  State<InventoryCategoryScreen> createState() =>
      _InventoryCategoryScreenState();
}

class _InventoryCategoryScreenState extends State<InventoryCategoryScreen> {
  late ItemCategory category;
  List<InventoryItem> itemList = [];
  int totalAmount = 0;

  Future<void> updateItemCategoryAmount() async {
    final data =
        await InventoryItemController().getTotalCategoryAmount(category.id);
    setState(() {
      totalAmount = data;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    category = ModalRoute.of(context)!.settings.arguments as ItemCategory;
    updateItemList();
    super.didChangeDependencies();
  }

  void updateState() {
    updateItemList();
    updateItemCategoryAmount();
  }

  Future<void> updateItemList() async {
    final data =
        await InventoryItemController().fetchItemsPerCategory(category.id);
    setState(() {
      itemList = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Icon(categoryIcons[category.icon]),
        actions: [
          PopupMenuButton<String>(
            onSelected: (String result) {
              if (result == 'delete') {
                showDialog(
                    context: context,
                    builder: (_) => ConfirmDeleteCategory(
                          category: category,
                        ));
                return;
              }
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem<String>(
                value: 'delete',
                child: Text('Deletar Categoria'),
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            CategoryInfo(
              category: category,
              totalAmount: totalAmount,
            ),
            Expanded(
              child: ItemList(
                updateState: updateState,
                itemList: itemList,
                category: category,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await showModalBottomSheet(
            context: context,
            builder: (_) => ItemForm(
              category: category,
            ),
            isScrollControlled: true,
          );
          updateState();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

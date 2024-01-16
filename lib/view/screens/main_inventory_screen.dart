import 'package:flutter/material.dart';
import 'package:organizagro/controllers/item_category_controller.dart';
import 'package:organizagro/data/models/iten_category.dart';
import 'package:organizagro/view/widgets/main_inventory_screen/category_form.dart';
import 'package:organizagro/view/widgets/main_inventory_screen/category_list.dart';
import 'package:organizagro/view/widgets/organizagro_drawer.dart';

class MainInventoryScreen extends StatefulWidget {
  const MainInventoryScreen({super.key});

  static const name = '/main_inventory_screen';

  @override
  State<MainInventoryScreen> createState() => MainInventoryScreenState();
}

class MainInventoryScreenState extends State<MainInventoryScreen> {
  List<ItemCategory> itemCategoryList = [];

  Future<void> updateCategoryList() async {
    final data = await ItemCategoryController().fetchCategories();

    setState(() {
      itemCategoryList = data;
    });
  }

  void updateState() {
    updateCategoryList();
  }

  void sayHello() {
    print('hello');
  }

  @override
  void initState() {
    super.initState();
    updateState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Estoque'),
      ),
      drawer: const OrganizagroDrawer(),
      body: CategoryList(
        categoryList: itemCategoryList,
        updateState: updateState,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          await showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (_) => const CategoryForm(),
          );
          updateState();
        },
      ),
    );
  }
}

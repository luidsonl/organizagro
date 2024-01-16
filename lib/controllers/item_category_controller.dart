import 'package:organizagro/data/models/iten_category.dart';

import '../data/dao/item_category_dao.dart';

class ItemCategoryController {
  Future<List<ItemCategory>> fetchCategories() async {
    return await ItemCategoryDAO().getAllItemCategories();
  }

  Future<ItemCategory> fetchCategory(int id) async {
    return await ItemCategoryDAO().getItemCategory(id);
  }

  Future<void> createCategory(ItemCategory newCategory) async {
    await ItemCategoryDAO().insertItemCategory(newCategory);
  }

  Future<void> deleteCategory(int id) async {
    await ItemCategoryDAO().deleteItemCategory(id);
  }
}

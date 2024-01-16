import 'package:organizagro/data/dao/inventory_item_dao.dart';
import 'package:organizagro/data/models/inventory_item.dart';

class InventoryItemController {
  Future<List<InventoryItem>> fetchAllItems() async {
    return await InventoryItemDAO().getAllInventoryItems();
  }

  Future<List<InventoryItem>> fetchItemsPerCategory(int id) async {
    return await InventoryItemDAO().getInventoryItemsByCategory(id);
  }

  Future<int> getTotalCategoryAmount(int id) async {
    List<InventoryItem> list = await fetchItemsPerCategory(id);
    int counter = 0;

    for (var item in list) {
      counter += item.quantity * item.multiplier;
    }

    return counter;
  }

  Future<void> createItem(InventoryItem inventoryItem) async {
    await InventoryItemDAO().insertInventoryItem(inventoryItem);
  }

  Future<void> deleteItem(int id) async {
    await InventoryItemDAO().deleteInventoryItem(id);
  }
}

import '../models/item_model.dart';

abstract class ItemDataSource {
  Future<List<ItemModel>> fetchItems();

  Future<void> saveItem(ItemModel item);

  Future<void> updateItem(ItemModel item);

  Future<void> deleteItem(String id);
}

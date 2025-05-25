import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../domain/entities/item.dart';
import '../../domain/repositories/item_repository.dart';
// import '../../infrastructure/data_sources/interfaces/item_data_source.dart'; // 新しいデータソースインターフェース
import '../../infrastructure/data_sources/mock/mock_item_data_source.dart'; // モックデータソースの実装
import '../../infrastructure/data_sources/models/item_model.dart';
import '../../infrastructure/data_sources/models/item_model_extensions.dart';
import '../data_sources/interfaces/item_data_source.dart'; // 拡張メソッドをインポート

class ItemRepositoryImpl implements ItemRepository {
  final ItemDataSource _dataSource; // データソースへの依存

  ItemRepositoryImpl(this._dataSource); // コンストラクタでデータソースを受け取る

  @override
  Future<List<Item>> getItems() async {
    final itemModels = await _dataSource.fetchItems();
    return itemModels.map((model) => model.toEntity()).toList();
  }

  @override
  Future<void> addItem(Item item) async {
    final itemModel = ItemModel.fromEntity(item);
    await _dataSource.saveItem(itemModel);
  }

  @override
  Future<void> updateItem(Item item) async {
    final itemModel = ItemModel.fromEntity(item);
    await _dataSource.updateItem(itemModel);
  }

  @override
  Future<void> deleteItem(String id) async {
    await _dataSource.deleteItem(id);
  }
}

// Provider for ItemRepositoryImpl
final itemRepositoryProvider = Provider<ItemRepository>((ref) {
  // ここでMockItemDataSourceを注入
  final dataSource = MockItemDataSource();
  return ItemRepositoryImpl(dataSource);
});

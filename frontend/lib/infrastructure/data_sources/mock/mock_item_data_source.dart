import '../interfaces/item_data_source.dart';
import '../models/item_model.dart';

// モックデータ用のIDカウンター
int _nextMockId = 0;

class MockItemDataSource implements ItemDataSource {
  // モックデータ
  static final List<ItemModel> _mockItems = [
    ItemModel(
      id: (_nextMockId++).toString(),
      name: 'いさぎ',
      quantity: 5,
      imageUrl: 'assets/images/isagi.jpg',
      isFavorite: true,
      price: 1200,
      description: 'お気に入りの小説',
      acquisitionDate: DateTime(2023, 1, 15),
    ),
    ItemModel(
      id: (_nextMockId++).toString(),
      name: 'カイザー',
      quantity: 10,
      imageUrl: 'assets/images/kaiza.jpg',
      isFavorite: false,
      price: 100,
      description: '書きやすいボールペン',
      acquisitionDate: DateTime(2023, 2, 20),
    ),
    ItemModel(
      id: (_nextMockId++).toString(),
      name: 'ばちら',
      quantity: 3,
      imageUrl: 'assets/images/batira.jpg',
      isFavorite: true,
      price: 500,
      description: 'シンプルなノート',
      acquisitionDate: DateTime(2023, 3, 10),
    ),
    ItemModel(
      id: (_nextMockId++).toString(),
      name: 'なぎ',
      quantity: 3,
      imageUrl: 'assets/images/nagi.jpg',
      isFavorite: true,
      price: 500,
      description: 'シンプルなノート',
      acquisitionDate: DateTime(2023, 3, 10),
    ),
    ItemModel(
      id: (_nextMockId++).toString(),
      name: 'れお',
      quantity: 3,
      imageUrl: 'assets/images/reo.jpg',
      isFavorite: true,
      price: 500,
      description: 'シンプルなノート',
      acquisitionDate: DateTime(2023, 3, 10),
    ),
    ItemModel(
      id: (_nextMockId++).toString(),
      name: 'ががまる',
      quantity: 3,
      imageUrl: 'assets/images/gagamaru.jpg',
      isFavorite: true,
      price: 500,
      description: 'シンプルなノート',
      acquisitionDate: DateTime(2023, 3, 10),
    ),
    ItemModel(
      id: (_nextMockId++).toString(),
      name: 'いとしりん',
      quantity: 3,
      imageUrl: 'assets/images/itoshi.jpg',
      isFavorite: true,
      price: 500,
      description: 'シンプルなノート',
      acquisitionDate: DateTime(2023, 3, 10),
    )
  ];

  @override
  Future<List<ItemModel>> fetchItems() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List.from(
        _mockItems); // Return a copy to prevent external modification
  }

  @override
  Future<void> saveItem(ItemModel item) async {
    await Future.delayed(const Duration(milliseconds: 100));
    // Assign a new ID if it's a new item (id is not set or empty)
    final itemToSave =
        item.id.isEmpty ? item.copyWith(id: (_nextMockId++).toString()) : item;
    _mockItems.add(itemToSave);
  }

  @override
  Future<void> updateItem(ItemModel item) async {
    await Future.delayed(const Duration(milliseconds: 100));
    final index = _mockItems.indexWhere((element) => element.id == item.id);
    if (index != -1) {
      _mockItems[index] = item;
    }
  }

  @override
  Future<void> deleteItem(String id) async {
    await Future.delayed(const Duration(milliseconds: 100));
    _mockItems.removeWhere((element) => element.id == id);
  }
}

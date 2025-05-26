import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../domain/entities/item.dart';
import '../../domain/repositories/item_repository.dart';
import '../../infrastructure/repositories/item_repository_impl.dart'; // 実装をインポート

// グッズを追加するユースケース
class AddItemUseCase {
  final ItemRepository _repository;

  AddItemUseCase(this._repository);

  Future<void> call(Item item) async {
    await _repository.addItem(item);
  }
}

// Provider for AddItemUseCase
final addItemUseCaseProvider = Provider<AddItemUseCase>((ref) {
  final repository = ref.watch(itemRepositoryProvider);
  return AddItemUseCase(repository);
});

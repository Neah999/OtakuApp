import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../domain/repositories/item_repository.dart';
import '../../infrastructure/repositories/item_repository_impl.dart'; // 実装をインポート

// グッズを削除するユースケース
class DeleteItemUseCase {
  final ItemRepository _repository;

  DeleteItemUseCase(this._repository);

  Future<void> call(String id) async {
    await _repository.deleteItem(id);
  }
}

// Provider for DeleteItemUseCase
final deleteItemUseCaseProvider = Provider<DeleteItemUseCase>((ref) {
  final repository = ref.watch(itemRepositoryProvider);
  return DeleteItemUseCase(repository);
});

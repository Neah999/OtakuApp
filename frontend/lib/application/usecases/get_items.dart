import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../domain/entities/item.dart';
import '../../domain/repositories/item_repository.dart';
import '../../infrastructure/repositories/item_repository_impl.dart'; // 実装をインポート

// アイテムリストを取得するユースケース
class GetItemsUseCase {
  final ItemRepository _repository;

  GetItemsUseCase(this._repository);

  Future<List<Item>> call() async {
    return await _repository.getItems();
  }
}

// Provider for GetItemsUseCase
final getItemsUseCaseProvider = Provider<GetItemsUseCase>((ref) {
  final repository = ref.watch(itemRepositoryProvider);
  return GetItemsUseCase(repository);
});

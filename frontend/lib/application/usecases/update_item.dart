import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../domain/entities/item.dart';
import '../../domain/repositories/item_repository.dart';
import '../../infrastructure/repositories/item_repository_impl.dart'; // 実装をインポート

// アイテムを更新するユースケース
class UpdateItemUseCase {
  final ItemRepository _repository;

  UpdateItemUseCase(this._repository);

  Future<void> call(Item item) async {
    await _repository.updateItem(item);
  }
}

// Provider for UpdateItemUseCase
final updateItemUseCaseProvider = Provider<UpdateItemUseCase>((ref) {
  final repository = ref.watch(itemRepositoryProvider);
  return UpdateItemUseCase(repository);
});

import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/item.dart';
import '../../application/usecases/get_items.dart';
import '../../application/usecases/add_item.dart';
import '../../application/usecases/update_item.dart';
import '../../application/usecases/delete_item.dart';

part 'item_notifiers.g.dart';

// アイテムリストの状態を管理するAsyncNotifierProvider
@riverpod
class ItemsNotifier extends _$ItemsNotifier {
  @override
  FutureOr<List<Item>> build() async {
    // 初期データをロード
    return ref.watch(getItemsUseCaseProvider).call();
  }

  Future<void> addItem(Item item) async {
    state = const AsyncValue.loading(); // ローディング状態に設定
    state = await AsyncValue.guard(() async {
      await ref.read(addItemUseCaseProvider).call(item);
      return ref.read(getItemsUseCaseProvider).call(); // 最新のリストを再取得
    });
  }

  Future<void> updateItem(Item item) async {
    state = const AsyncValue.loading(); // ローディング状態に設定
    state = await AsyncValue.guard(() async {
      await ref.read(updateItemUseCaseProvider).call(item);
      return ref.read(getItemsUseCaseProvider).call(); // 最新のリストを再取得
    });
  }

  Future<void> deleteItem(String id) async {
    state = const AsyncValue.loading(); // ローディング状態に設定
    state = await AsyncValue.guard(() async {
      await ref.read(deleteItemUseCaseProvider).call(id);
      return ref.read(getItemsUseCaseProvider).call(); // 最新のリストを再取得
    });
  }

  // リストをリフレッシュするメソッド
  Future<void> refreshItems() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return ref.read(getItemsUseCaseProvider).call();
    });
  }
}

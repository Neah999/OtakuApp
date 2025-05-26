import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:frontend/presentation/theme/fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../domain/entities/item.dart';
import '../../presentation/notifiers/item_notifiers.dart';

class ItemEditPage extends HookConsumerWidget {
  final String? itemId; // 編集対象のアイテムID

  const ItemEditPage({super.key, required this.itemId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemsAsyncValue = ref.watch(itemsNotifierProvider);

    // 編集対象のアイテムをロード
    final Item? initialItem = useMemoized(() {
      if (itemsAsyncValue.hasValue && itemId != null) {
        return itemsAsyncValue.value!.firstWhereOrNull((item) => item.id == itemId);
      }
      return null;
    }, [itemId, itemsAsyncValue.value]);

    // アイテムが見つからない場合の処理
    if (itemId == null || (itemsAsyncValue.hasValue && initialItem == null)) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('指定されたアイテムが見つかりませんでした。')),
        );
        context.go('/'); // リストページに戻る
      });
      return Scaffold(
        appBar: AppBar(title: const Text('エラー')),
        body: const Center(child: Text('アイテムの読み込みに失敗しました。')),
      );
    }

    // ローディング中の表示
    if (itemsAsyncValue.isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('アイテム編集'),
          centerTitle: true,
          backgroundColor: Colors.blue.shade700,
          foregroundColor: Colors.white,
          elevation: 4,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(16),
            ),
          ),
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    // フォームのコントローラーと状態 (initialItemがnullでないことを保証)
    final nameController = useTextEditingController(text: initialItem!.name);
    final quantityController = useTextEditingController(text: initialItem.quantity.toString());
    final imageUrlController = useTextEditingController(text: initialItem.imageUrl);
    final priceController = useTextEditingController(text: initialItem.price.toString());
    final descriptionController = useTextEditingController(text: initialItem.description);
    final isFavorite = useState<bool>(initialItem.isFavorite);
    final acquisitionDate = useState<DateTime>(initialItem.acquisitionDate);

    final formKey = useMemoized(() => GlobalKey<FormState>(), []);

    return Scaffold(
      appBar: AppBar(
        title: Text('アイテム編集'),
        centerTitle: true,
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        elevation: 4,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(16),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField(
                controller: nameController,
                labelText: 'アイテム名',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'アイテム名を入力してください';
                  }
                  return null;
                },
              ),
              _buildTextField(
                controller: quantityController,
                labelText: '所持数',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '所持数を入力してください';
                  }
                  if (int.tryParse(value) == null) {
                    return '有効な数値を入力してください';
                  }
                  return null;
                },
              ),
              _buildTextField(
                controller: imageUrlController,
                labelText: '画像URL',
                keyboardType: TextInputType.url,
              ),
              _buildTextField(
                controller: priceController,
                labelText: '価格',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '価格を入力してください';
                  }
                  if (int.tryParse(value) == null) {
                    return '有効な数値を入力してください';
                  }
                  return null;
                },
              ),
              _buildTextField(
                controller: descriptionController,
                labelText: '説明',
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              _buildDateField(context, acquisitionDate),
              const SizedBox(height: 16),
              _buildFavoriteSwitch(isFavorite),
              const SizedBox(height: 32),
              Center(
                child: ElevatedButton.icon(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      final updatedItem = Item(
                        id: initialItem.id, // 編集時は既存IDを使用
                        name: nameController.text,
                        quantity: int.parse(quantityController.text),
                        imageUrl: imageUrlController.text.isEmpty ? null : imageUrlController.text,
                        isFavorite: isFavorite.value,
                        price: int.parse(priceController.text),
                        description: descriptionController.text.isEmpty ? null : descriptionController.text,
                        acquisitionDate: acquisitionDate.value,
                      );

                      await ref.read(itemsNotifierProvider.notifier).updateItem(updatedItem);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${updatedItem.name}を更新しました。')),
                      );
                      context.go('/grid'); // 一覧画面に戻る
                    }
                  },
                  icon: const Icon(Icons.save),
                  label: const Text('変更を保存'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade600,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    textStyle: const TextStyle(fontSize: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 8,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.blue.shade700, width: 2),
          ),
          filled: true,
          fillColor: Colors.blue.shade50.withOpacity(0.5),
        ),
        keyboardType: keyboardType,
        maxLines: maxLines,
        validator: validator,
      ),
    );
  }

  Widget _buildDateField(BuildContext context, ValueNotifier<DateTime> dateNotifier) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '取得日時:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blueGrey.shade700),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: () async {
            final pickedDate = await showDatePicker(
              context: context,
              initialDate: dateNotifier.value,
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
              builder: (context, child) {
                return Theme(
                  data: ThemeData.light().copyWith(
                    colorScheme: ColorScheme.light(
                      primary: Colors.blue.shade700, // ヘッダーの色
                      onPrimary: Colors.white, // ヘッダーのテキスト色
                      onSurface: Colors.black, // カレンダーのテキスト色
                    ),
                    textButtonTheme: TextButtonThemeData(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.blue.shade700, // ボタンのテキスト色
                      ),
                    ),
                  ),
                  child: child!,
                );
              },
            );
            if (pickedDate != null && pickedDate != dateNotifier.value) {
              dateNotifier.value = pickedDate;
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(12),
              color: Colors.blue.shade50.withOpacity(0.5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${dateNotifier.value.year}/${dateNotifier.value.month}/${dateNotifier.value.day}',
                  style: const TextStyle(fontSize: 16),
                ),
                Icon(Icons.calendar_today, color: Colors.blue.shade700),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFavoriteSwitch(ValueNotifier<bool> isFavoriteNotifier) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'お気に入り:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blueGrey.shade700),
        ),
        Switch(
          value: isFavoriteNotifier.value,
          onChanged: (value) {
            isFavoriteNotifier.value = value;
          },
          activeColor: Colors.redAccent,
          inactiveThumbColor: Colors.grey,
          inactiveTrackColor: Colors.grey.shade300,
        ),
      ],
    );
  }
}

// Extension to find an item in a list
extension IterableExtension<T> on Iterable<T> {
  T? firstWhereOrNull(bool Function(T element) test) {
    for (final element in this) {
      if (test(element)) {
        return element;
      }
    }
    return null;
  }
}
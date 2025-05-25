import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../domain/entities/item.dart';
import '../../presentation/notifiers/item_notifiers.dart';
import 'package:uuid/uuid.dart'; // ユニークID生成用

class ItemAddPage extends HookConsumerWidget {
  const ItemAddPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // フォームのコントローラーと状態
    final nameController = useTextEditingController();
    final quantityController = useTextEditingController();
    final imageUrlController = useTextEditingController();
    final priceController = useTextEditingController();
    final descriptionController = useTextEditingController();
    final isFavorite = useState<bool>(false);
    final acquisitionDate = useState<DateTime>(DateTime.now());

    final formKey = useMemoized(() => GlobalKey<FormState>(), []);

    return Scaffold(
      appBar: AppBar(
        title: const Text('アイテム追加'),
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
                      final newItem = Item(
                        id: const Uuid().v4(), // 新規追加時は新しいID
                        name: nameController.text,
                        quantity: int.parse(quantityController.text),
                        imageUrl: imageUrlController.text.isEmpty ? null : imageUrlController.text,
                        isFavorite: isFavorite.value,
                        price: int.parse(priceController.text),
                        description: descriptionController.text.isEmpty ? null : descriptionController.text,
                        acquisitionDate: acquisitionDate.value,
                      );

                      await ref.read(itemsNotifierProvider.notifier).addItem(newItem);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${newItem.name}を追加しました。')),
                      );
                      context.go('/'); // 一覧画面に戻る
                    }
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('アイテムを追加'),
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
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'item.freezed.dart';
part 'item.g.dart';

@freezed
class Item with _$Item {
  const factory Item({
    required String id, // ユニークなID
    required String name, // アイテム名
    required int quantity, // 個数
    String? imageUrl, // 画像URL
    @Default(false) bool isFavorite, // お気に入り状態
    required int price, // 価格
    String? description, // 説明
    required DateTime acquisitionDate, // 獲得日時
  }) = _Item;

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
}

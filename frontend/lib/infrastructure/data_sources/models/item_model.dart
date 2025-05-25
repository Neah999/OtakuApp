// lib/infrastructure/data_sources/models/item_model.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import '../../../domain/entities/item.dart'; // Entityをインポート

part 'item_model.freezed.dart';
part 'item_model.g.dart';

@freezed
class ItemModel with _$ItemModel {
  const factory ItemModel({
    required String id,
    required String name,
    required int quantity,
    String? imageUrl,
    @Default(false) bool isFavorite,
    required int price,
    String? description,
    required DateTime acquisitionDate,
  }) = _ItemModel;

  factory ItemModel.fromJson(Map<String, dynamic> json) => _$ItemModelFromJson(json);

  factory ItemModel.fromEntity(Item item) {
    return ItemModel(
      id: item.id,
      name: item.name,
      quantity: item.quantity,
      imageUrl: item.imageUrl,
      isFavorite: item.isFavorite,
      price: item.price,
      description: item.description,
      acquisitionDate: item.acquisitionDate,
    );
  }
}

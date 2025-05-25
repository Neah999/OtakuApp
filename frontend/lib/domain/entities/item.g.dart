// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ItemImpl _$$ItemImplFromJson(Map<String, dynamic> json) => _$ItemImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      quantity: (json['quantity'] as num).toInt(),
      imageUrl: json['imageUrl'] as String?,
      isFavorite: json['isFavorite'] as bool? ?? false,
      price: (json['price'] as num).toInt(),
      description: json['description'] as String?,
      acquisitionDate: DateTime.parse(json['acquisitionDate'] as String),
    );

Map<String, dynamic> _$$ItemImplToJson(_$ItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'quantity': instance.quantity,
      'imageUrl': instance.imageUrl,
      'isFavorite': instance.isFavorite,
      'price': instance.price,
      'description': instance.description,
      'acquisitionDate': instance.acquisitionDate.toIso8601String(),
    };

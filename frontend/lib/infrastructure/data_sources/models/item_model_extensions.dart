import '../../../domain/entities/item.dart';
import '../../../infrastructure/data_sources/models/item_model.dart';

extension ItemModelExtension on ItemModel {
  Item toEntity() {
    return Item(
      id: id,
      name: name,
      quantity: quantity,
      imageUrl: imageUrl,
      isFavorite: isFavorite,
      price: price,
      description: description,
      acquisitionDate: acquisitionDate,
    );
  }
}
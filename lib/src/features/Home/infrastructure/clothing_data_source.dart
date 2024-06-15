import 'package:obsessed_app/src/features/Home/domain/entities/clothing_item.dart';

// Clase que permitirá cambiar fácilmente la fuente de datos sin tener que cambiar el resto de la aplicación
class ClothingDataSource {
  Future<List<ClothingItem>> getAllItems() {
    return Future.delayed(const Duration(seconds: 1), () {
      return listOfClothingItems();
    });
  }
}
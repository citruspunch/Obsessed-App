import 'package:obsessed_app/src/features/Home/domain/entities/shirt.dart';

// Clase que permitirá cambiar fácilmente la fuente de datos sin tener que cambiar el resto de la aplicación
class ShirtDataSource {
  Future<List<Shirt>> getAllShirts() {
    return Future.delayed(const Duration(seconds: 1), () {
      return listOfShirts();
    });
  }
}
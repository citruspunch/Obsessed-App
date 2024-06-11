import 'package:obsessed_app/src/features/Home/domain/entities/shirt.dart';
import 'package:obsessed_app/src/features/Home/infrastructure/shirt_data_source.dart';

/* Esta clase es la encargada de comunicarse con la fuente de datos
intermediario entre casos de uso y la fuente de datos */
class ShirtRepository {
  final ShirtDataSource shirtDataSource;

  ShirtRepository(this.shirtDataSource);

  Future<List<Shirt>> getAllShirts() {
    return shirtDataSource.getAllShirts();
  }
}
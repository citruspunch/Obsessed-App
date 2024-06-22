import 'package:obsessed_app/src/core/entities/clothing_item.dart';
import 'package:obsessed_app/src/features/home/domain/repositories/clothing_repository_contract.dart';
import 'package:obsessed_app/src/features/home/infrastructure/clothing_data_source.dart';

/* Esta clase es la encargada de comunicarse con la fuente de datos
intermediario entre casos de uso y la fuente de datos */
class ClothingRepository implements ClothingRepositoryContract {
  final ClothingDataSource clothingDataSource;

  ClothingRepository(this.clothingDataSource);

  @override
  Future<List<ClothingItem>> getAllItems() {
    return clothingDataSource.getAllItems();
  }
}
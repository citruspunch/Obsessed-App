import 'package:obsessed_app/src/features/Home/domain/entities/clothing_item.dart';
import '../../infrastructure/repositories/clothing_repository.dart';

class GetAllItems {
  final ClothingRepository clothingRepository;

  GetAllItems(this.clothingRepository);

  Future<List<ClothingItem>> call() {
    return clothingRepository.getAllItems();
  }
}
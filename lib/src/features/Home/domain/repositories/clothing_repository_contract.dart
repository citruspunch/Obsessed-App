import 'package:obsessed_app/src/features/Home/domain/entities/clothing_item.dart';

abstract class ClothingRepositoryContract {
  Future<List<ClothingItem>> getAllItems();
}
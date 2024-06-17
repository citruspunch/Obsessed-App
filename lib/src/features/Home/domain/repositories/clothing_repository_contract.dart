import 'package:obsessed_app/src/core/entities/clothing_item.dart';

abstract class ClothingRepositoryContract {
  Future<List<ClothingItem>> getAllItems();
}
import 'package:flutter/material.dart';
import 'package:obsessed_app/src/core/entities/clothing_item.dart';
import 'package:obsessed_app/src/features/home/domain/use_cases/get_all_items.dart';

class ClothingProvider extends ChangeNotifier {
  final GetAllItems getAllItems;
  List<ClothingItem> items = [];

  ClothingProvider({required this.getAllItems});

  Future<void> loadItems() async {
    items = await getAllItems.call();
    notifyListeners();
  }
}
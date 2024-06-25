import 'package:flutter/material.dart';
import 'package:obsessed_app/src/core/entities/clothing_item.dart';

class FavoritesProvider with ChangeNotifier {
  final List<ClothingItem> _items = [];

  void add(ClothingItem item) {
    _items.add(item);
    notifyListeners();
  }

  void remove(ClothingItem item) {
    _items.remove(item);
    notifyListeners();
  }

  List<ClothingItem> get items => _items;
  
}
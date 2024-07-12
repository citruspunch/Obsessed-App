import 'package:flutter/material.dart';
import 'package:obsessed_app/main.dart';
import 'package:obsessed_app/src/core/entities/clothing_item.dart';

class FavoritesProvider with ChangeNotifier {
  final List<ClothingItem> _items = [];

  void add(ClothingItem item) async {
    _items.add(item);
    notifyListeners();
    await saveFavoritesToDatabase();
  }

  void remove(ClothingItem item) async {
    _items.remove(item);
    notifyListeners();
    await saveFavoritesToDatabase();
  }

  Future<void> saveFavoritesToDatabase() async {
    try {
      var favoriteData = _items.map((item) => item.toJson()).toList();
      final userId = supabase.auth.currentSession!.user.id;

      await supabase
          .from('profiles')
          .update({'favorites': favoriteData}).eq('id', userId);
    } catch (e) {
      return;
    }
  }

  Future<void> loadFavoritesFromDatabase() async {
    try {
      final userId = supabase.auth.currentSession!.user.id;
      final data =
          await supabase.from('profiles').select().eq('id', userId).single();
      List<dynamic> favoriteData = (data['favorites'] ?? []) as List<dynamic>;
      _items.clear();
      for (var itemData in favoriteData) {
        _items.add(ClothingItem.fromJson(itemData));
      }
      notifyListeners();
    } catch (e) {
      return;
    }
  }

  List<ClothingItem> get items => _items;
}

import 'package:flutter/material.dart';
import 'package:obsessed_app/src/core/entities/clothing_item.dart';
import 'package:obsessed_app/src/features/home/domain/use_cases/get_all_items.dart';

class ClothingProvider extends ChangeNotifier {
  final GetAllItems getAllItems;
  List<ClothingItem> items = [];
  List<ClothingItem> filteredItems = []; // Lista para almacenar todos los ítems

  ClothingProvider({required this.getAllItems});

  Future<void> loadItems() async {
    items = await getAllItems.call();
    filteredItems = List.from(items); // Guarda una copia de todos los ítems
    notifyListeners();
  }

  void filterProducts(String query) {
    if (query.isEmpty) {
      filteredItems = List.from(items); // Restablece a todos los ítems si la consulta está vacía
    } else {
      filteredItems = items
          .where((item) => item.title.toLowerCase().contains(query.toLowerCase()))
          .toList(); // Filtra los ítems basados en la consulta
    }
    notifyListeners(); // Notifica a los oyentes sobre el cambio
  }
}
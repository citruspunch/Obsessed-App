import 'package:obsessed_app/src/core/entities/clothing_item.dart';
import 'package:obsessed_app/src/core/constants/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Clase que permitirá cambiar fácilmente la fuente de datos sin tener que cambiar el resto de la aplicación
class ClothingDataSource {
  Future<List<ClothingItem>> getAllItems() async {
    var url = Uri.parse(productsUrl);
    try {
      final response = await http.get(url); 
    
      if (response.statusCode == 200) {
        final List<dynamic> itemJson = jsonDecode(response.body);
        // Ignorar artículos que no son ropa
        for (int i=firstNonUsableItem; i<lastNonUsableItem; i++) {
          itemJson.removeAt(firstNonUsableItem);
        }
        return itemJson.map((json) => ClothingItem.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load clothing items');
      }
    } catch (e){
      print(e.toString());
      return [];
    }
  }
}
import 'package:flutter/material.dart';
import 'package:obsessed_app/src/core/entities/clothing_item.dart';
import 'package:obsessed_app/src/features/cart/domain/entities/cart_item.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  void addItem(CartItem item) {
    final index = _items.indexWhere((element) => element.id == item.id && element.size == item.size && element.color == item.color);
    if (index != -1) {
      // El ítem ya existe en el carrito, verifica las existencias antes de aumentar la cantidad
      if (_items[index].stock >= item.quantity) {
        _items[index].quantity += item.quantity;
        _items[index].stock -= item.quantity; // Disminuye las existencias disponibles
      }
    } else {
      // El ítem no existe en el carrito, verifica las existencias antes de agregar
      if (item.stock >= item.quantity) {
        _items.add(item);
        item.stock -= item.quantity; // Disminuye las existencias disponibles
      }
    }
    notifyListeners();
  }

  void removeItem(CartItem item) {
    final index = _items.indexWhere((element) => element.id == item.id && element.size == item.size && element.color == item.color);
    if (index != -1) {
      _items[index].stock += item.quantity;
      _items.removeAt(index);
      notifyListeners();
    }
  }

  void increaseItemQuantity(CartItem item) {
    final index = _items.indexWhere((element) => element.id == item.id && element.size == item.size && element.color == item.color);
    if (index != -1) {
      if (_items[index].stock > 0) {
        _items[index].quantity++;
        _items[index].stock--;
        notifyListeners();
      }
    }
  }

  void decreaseItemQuantity(CartItem item) {
    final index = _items.indexWhere((element) => element.id == item.id && element.size == item.size && element.color == item.color);
    if (index != -1) {
      if (_items[index].quantity > 1) {
        _items[index].quantity--;
        _items[index].stock++;
        notifyListeners();
      } 
    }
  }

  bool containsClothingItem(ClothingItem item, Color color, String size) {
    return _items.any((element) => element.item == item && element.color == color && element.size == size);
  }

  int getIndex(ClothingItem item) {
    return _items.indexWhere((element) => element.item == item);
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }

  double get totalPrice => _items.fold(0, (total, current) => total + current.price);

  int get totalQuantity => _items.fold(0, (total, current) => total + current.quantity);
}
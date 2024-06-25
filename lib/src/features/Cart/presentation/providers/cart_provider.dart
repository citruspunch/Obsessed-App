import 'package:flutter/material.dart';
import 'package:obsessed_app/src/features/cart/domain/entities/cart_item.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  void addItem(CartItem item) {
    final index = _items.indexWhere((element) => element.id == item.id && element.size == item.size && element.color == item.color);
    if (index != -1) {
      // El ítem ya existe en el carrito, aumenta la cantidad
      _items[index].quantity += item.quantity;
    } else {
      // El ítem no existe en el carrito, lo agrega
      _items.add(item);
    }
    notifyListeners();
  }

  void removeItem(CartItem item) {
    final index = _items.indexWhere((element) => element.id == item.id && element.size == item.size && element.color == item.color);
    if (index != -1) {
      _items.removeAt(index);
      notifyListeners();
    }
  }

  void increaseItemQuantity(CartItem item) {
    final index = _items.indexWhere((element) => element.id == item.id && element.size == item.size && element.color == item.color);
    if (index != -1) {
      _items[index].quantity++;
      notifyListeners();
    }
  }

  void decreaseItemQuantity(CartItem item) {
    final index = _items.indexWhere((element) => element.id == item.id && element.size == item.size && element.color == item.color);
    if (index != -1) {
      if (_items[index].quantity > 1) {
        _items[index].quantity--;
        notifyListeners();
      } 
    }
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }

  double get totalPrice => _items.fold(0, (total, current) => total + current.price);

  int get totalQuantity => _items.fold(0, (total, current) => total + current.quantity);
}
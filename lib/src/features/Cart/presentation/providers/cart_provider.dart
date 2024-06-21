import 'package:flutter/material.dart';
import 'package:obsessed_app/src/features/Cart/presentation/UI/widgets/cart_item.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  void addItem(CartItem item) {
    _items.add(item);
    notifyListeners();
  }

  void removeItem(CartItem item) {
    _items.remove(item);
    notifyListeners();
  }

  double get totalPrice => _items.fold(0, (total, current) => total + current.price);

  int get totalQuantity => _items.fold(0, (total, current) => total + current.quantity);
}
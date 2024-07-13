import 'dart:async';

import 'package:flutter/material.dart';
import 'package:obsessed_app/main.dart';
import 'package:obsessed_app/src/core/entities/clothing_item.dart';
import 'package:obsessed_app/src/features/cart/domain/entities/cart_item.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  void addItem(CartItem item) async {
    final index = _items.indexWhere((element) =>
        element.id == item.id &&
        element.size == item.size &&
        element.color == item.color);
    if (index != -1) {
      // El ítem ya existe en el carrito, verifica las existencias antes de aumentar la cantidad
      if (_items[index].stock >= item.quantity) {
        _items[index].quantity += item.quantity;
        _items[index].stock -= item.quantity;
      }
    } else {
      // El ítem no existe en el carrito, verifica las existencias antes de agregar
      if (item.stock >= item.quantity) {
        _items.add(item);
        item.stock -= item.quantity; // Disminuye las existencias disponibles
      }
    }
    await saveCartToDatabase();
    notifyListeners();
  }

  void removeItem(CartItem item) async {
    final index = _items.indexWhere((element) =>
        element.id == item.id &&
        element.size == item.size &&
        element.color == item.color);
    if (index != -1) {
      _items[index].stock += item.quantity;
      _items.removeAt(index);
      notifyListeners();
      await saveCartToDatabase();
    }
  }

  void increaseItemQuantity(CartItem item) async {
    final index = _items.indexWhere((element) =>
        element.id == item.id &&
        element.size == item.size &&
        element.color == item.color);
    if (index != -1) {
      if (_items[index].stock > 0) {
        _items[index].quantity++;
        _items[index].stock--;
        notifyListeners();
        await saveCartToDatabase();
      }
    }
  }

  void decreaseItemQuantity(CartItem item) async {
    final index = _items.indexWhere((element) =>
        element.id == item.id &&
        element.size == item.size &&
        element.color == item.color);
    if (index != -1) {
      if (_items[index].quantity > 1) {
        _items[index].quantity--;
        _items[index].stock++;
        notifyListeners();
        await saveCartToDatabase();
      }
    }
  }

  bool containsClothingItem(ClothingItem item, Color color, String size) {
    return _items.any((element) =>
        element.item == item && element.color == color && element.size == size);
  }

  int getIndex(ClothingItem item) {
    return _items.indexWhere((element) => element.item == item);
  }

  Future<void> saveCartToDatabase() async {
    try {
      var cartData = _items.map((item) => item.toJson()).toList();
      final userId = supabase.auth.currentSession!.user.id;
      await supabase
          .from('profiles')
          .update({'cart_items': cartData}).eq('id', userId);
    } catch (e) {
      return;
    }
  }

  Future<void> loadCartFromDatabase() async {
    try {
      final userId = supabase.auth.currentSession!.user.id;
      final data =
          await supabase.from('profiles').select().eq('id', userId).single();
      List<dynamic> cartData = (data['cart_items'] ?? []) as List<dynamic>;
      // Convertir cartData de nuevo a una lista de CartItem y actualizar _items
      _items.clear();
      for (var itemData in cartData) {
        _items.add(CartItem.fromJson(itemData));
      }
      notifyListeners();
    } catch (e) {
      return;
    }
  }

  void clear() async {
    _items.clear();
    await saveCartToDatabase();
    notifyListeners();
  }

  double get totalPrice =>
      _items.fold(0, (total, current) => total + current.price);

  int get totalQuantity =>
      _items.fold(0, (total, current) => total + current.quantity);
}

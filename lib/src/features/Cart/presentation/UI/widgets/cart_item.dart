import 'package:flutter/material.dart';
import 'package:obsessed_app/src/core/entities/clothing_item.dart';

class CartItem {
  final ClothingItem item;
  final String name;
  final String description;
  final String image;
  int quantity;
  final String? size;
  final Color? color;

  CartItem({
    required this.item,
    required this.quantity,
    required this.name,
    required this.description,
    required this.image,
    this.size,
    this.color,
  });

  double get price => item.price * quantity;
}
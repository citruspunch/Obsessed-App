import 'package:flutter/material.dart';
import 'package:obsessed_app/src/core/entities/clothing_item.dart';

class CartItem {
  final int id;
  final ClothingItem item;
  final String name;
  final String description;
  final String category;
  final String image;
  final int count;
  int quantity;
  final String? size;
  final Color? color;

  CartItem({
    required this.id,
    required this.item,
    required this.quantity,
    required this.name,
    required this.description,
    required this.category,
    required this.image,
    required this.count,
    this.size,
    this.color,
  });

  double get price => item.price * quantity;
}
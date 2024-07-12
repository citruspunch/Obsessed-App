import 'package:flutter/material.dart';
import 'package:obsessed_app/src/core/constants/constants.dart';
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
  int stock;

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
    this.stock = initialStock,
  });

  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'item': item.toJson(),
      'name': name,
      'description': description,
      'category': category,
      'image': image,
      'count': count,
      'quantity': quantity,
      'size': size,
      'color': serializeColor(color),
      'stock': stock,
    };
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      item: ClothingItem.fromJson(json['item']),
      name: json['name'],
      description: json['description'],
      category: json['category'],
      image: json['image'],
      count: json['count'],
      quantity: json['quantity'],
      size: json['size'],
      color: deserializeColor(json['color']),
      stock: json['stock'],
    );
  }

  static String serializeColor(Color? color) {
    return getColorName(color);
  }
  
  static Color? deserializeColor(String colorName) {
    Map<String, Color> nameToColor = {
      "Black": Colors.black,
      "Blue": Colors.blue,
      "Red": Colors.red,
      "Teal": Colors.teal,
    };
    return nameToColor[colorName];
  }

  static String getColorName(Color? color) {
    Map<Color, String> colorNames = {
      Colors.black: "Black",
      Colors.blue: "Blue",
      Colors.red: "Red",
      Colors.teal: "Teal",
    };
    return colorNames[color] ?? "Unknown Color";
  }

  double get price => item.price * quantity;
}
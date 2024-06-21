import 'package:flutter/material.dart';
import 'package:obsessed_app/src/core/entities/clothing_item.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

class StarRatingWidget extends StatelessWidget {
  final ClothingItem item;
  const StarRatingWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return SmoothStarRating(
      allowHalfRating: false,
      starCount: 5,
      rating: item.rating['rate'].toDouble(), // rating API
      size: 30.0,
      color: Colors.amber,
      borderColor: Colors.amber,
      spacing: 2.0,
    );
  }
}
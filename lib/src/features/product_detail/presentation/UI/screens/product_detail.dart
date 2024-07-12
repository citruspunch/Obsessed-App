import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:obsessed_app/src/core/entities/clothing_item.dart';
import 'package:obsessed_app/src/features/product_detail/presentation/UI/widgets/add_to_cart_bar.dart';
import 'package:obsessed_app/src/features/product_detail/presentation/UI/widgets/add_to_favorites_button.dart';
import 'package:obsessed_app/src/features/product_detail/presentation/UI/widgets/product_label.dart';
import 'package:obsessed_app/src/features/product_detail/presentation/UI/widgets/return_to_home_button.dart';
import 'package:obsessed_app/src/features/product_detail/presentation/UI/widgets/star_rating.dart';

class ProductDetail extends StatelessWidget {
  final ClothingItem item;

  const ProductDetail({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F1F1),
      body: SafeArea(
        child: Stack(
          children: [
            ListView(
              children: [
                Container(
                  alignment: Alignment.topCenter,
                  height: MediaQuery.of(context).size.height / 1.8,
                  color: Colors.white,
                  child: Stack(
                    children: [
                      Center(
                        child: Transform.scale(
                          scale: 0.80,
                          child: Hero(
                            tag: 'hero-${item.id}',
                            child: Image(
                              image: NetworkImage(item.imagePath),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(
                                bottom: 17.0,
                                right: 13.0,
                                left: 10.0,
                                top: 15.0),
                            child: ReturnToHomeButton(),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 9.0),
                            child: AddToFavoritesButton(item: item),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(top: 8, left: 15, right: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProductLabel(item: item),
                      const SizedBox(height: 6),
                      Text(
                        capitalizeFirstLetter(item.name),
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      const SizedBox(height: 5),
                      // RATING BAR
                      StarRatingWidget(item: item),
                      const SizedBox(height: 5),
                      Text(
                        item.description,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.black54,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: AddToCartBar(item: item),
    );
  }

  String capitalizeFirstLetter(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }
}

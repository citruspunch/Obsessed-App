import 'package:flutter/material.dart';
import 'package:obsessed_app/src/features/Cart/presentation/UI/widgets/cart_title.dart';
import 'package:obsessed_app/src/features/Cart/presentation/UI/widgets/more_options_button.dart';
import 'package:obsessed_app/src/features/ProductDetail/presentation/UI/widgets/return_to_home_button.dart';

class CartHeader extends StatelessWidget {
  const CartHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ReturnToHomeButton(),
          CartTitle(),
          MoreOptionsButton(),
        ],
      ),
    );
  }
}
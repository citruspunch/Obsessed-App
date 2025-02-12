import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:obsessed_app/src/features/cart/domain/entities/cart_item.dart';
import 'package:obsessed_app/src/features/cart/presentation/UI/screens/cart_screen.dart';
import 'package:obsessed_app/src/features/cart/presentation/providers/cart_provider.dart';
import 'package:obsessed_app/src/features/favorites/presentation/UI/screens/favorites.dart';
import 'package:obsessed_app/src/features/home/presentation/UI/screens/home.dart';
import 'package:obsessed_app/src/features/search/presentation/UI/screens/search_screen.dart';
import 'package:provider/provider.dart';

class NavigationBarHome extends StatefulWidget {
  final VoidCallback? scrollToTop;

  const NavigationBarHome({super.key, this.scrollToTop});

  @override
  State<NavigationBarHome> createState() => _NavigationBarHomeState();
}

class _NavigationBarHomeState extends State<NavigationBarHome> {
  @override
  Widget build(BuildContext context) {
    List<CartItem> cartItems = Provider.of<CartProvider>(context).items;
    double totalPrice = Provider.of<CartProvider>(context).totalPrice;
    int totalProducts = Provider.of<CartProvider>(context).items.length;
    return Container(
      height: 55,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(69),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        IconButton(
            onPressed: widget.scrollToTop ??
                () {
                  Navigator.of(context).pushAndRemoveUntil(
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const Home(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        return FadeTransition(
                          opacity: animation,
                          child: child,
                        );
                      },
                      transitionDuration: const Duration(milliseconds: 400),
                    ),
                    (Route<dynamic> route) => false,
                  );
                },
            icon: const Icon(
              FeatherIcons.home,
              size: 27,
              color: Colors.black,
            )),
        IconButton(
          onPressed: () {
            animateTransition(context, const SearchScreen());
          },
          icon: const Icon(
            FeatherIcons.search,
            size: 27,
            color: Colors.black,
          ),
        ),
        IconButton(
            onPressed: () {
              animateTransition(context, const Favorites());
            },
            icon: const Icon(
              FeatherIcons.heart,
              size: 27,
              color: Colors.black,
            )),
        Stack(
          children: [
            IconButton(
                onPressed: () {
                  animateTransition(context,
                      CartScreen(cartItems: cartItems, totalPrice: totalPrice));
                },
                icon: Icon(
                  totalProducts > 0
                      ? FeatherIcons.shoppingCart
                      : FeatherIcons.shoppingBag,
                  size: 27,
                  color: Colors.black,
                )),
            if (totalProducts > 0 && totalProducts < 100)
              Positioned(
                right: 1,
                top: 3.5,
                child: CircleAvatar(
                  backgroundColor: Colors.grey[900],
                  radius: 10,
                  child: Text(
                    totalProducts.toString(),
                    style: GoogleFonts.poppins(
                      fontSize: (totalProducts > 9) ? 11.5 : 13.5,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
          ],
        )
      ]),
    );
  }

  void animateTransition(BuildContext context, Widget page) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 400),
      ),
    );
  }
}

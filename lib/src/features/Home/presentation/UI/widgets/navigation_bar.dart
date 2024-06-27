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
    int totalQuantity = Provider.of<CartProvider>(context).totalQuantity;
    return Container(
      height: 65,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(69)),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        IconButton(
            onPressed: widget.scrollToTop ?? () {
              Navigator.of(context).pushAndRemoveUntil(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => const Home(),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                  transitionDuration: const Duration(milliseconds: 300),
                ),
                (Route<dynamic> route) => false,
              );
            },
            icon: const Icon(
              FeatherIcons.home,
              size: 30,
            )),
        IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SearchScreen(),
                ),
              );
            },
            icon: const Icon(
              FeatherIcons.search,
              size: 30,
            )),
        IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Favorites(),
                ),
              );
            },
            icon: const Icon(
              FeatherIcons.heart,
              size: 30,
            )),
        Stack(
          children: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CartScreen(cartItems: cartItems, totalPrice: totalPrice),
                    ),
                  );
                },
                icon: Icon(
                  totalQuantity > 0 ? FeatherIcons.shoppingCart : FeatherIcons.shoppingBag,
                  size: 30,
                )),
            if ( totalQuantity > 0 && totalQuantity < 100)
              Positioned(
                right: 1,
                top: 1,
                child: CircleAvatar(
                  backgroundColor: Colors.grey[800],
                  radius: 10,
                  child: Text(
                    totalQuantity.toString(),
                    style: GoogleFonts.poppins(
                      fontSize: 13,
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
}
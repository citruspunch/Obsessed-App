import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:obsessed_app/src/core/entities/clothing_item.dart';
import 'package:obsessed_app/src/features/Cart/presentation/UI/screens/cart_screen.dart';
import 'package:obsessed_app/src/features/Cart/presentation/UI/widgets/cart_item.dart';
import 'package:obsessed_app/src/features/Cart/presentation/providers/cart_provider.dart';
import 'package:obsessed_app/src/features/ProductDetail/presentation/UI/widgets/color_option.dart';
import 'package:obsessed_app/src/features/ProductDetail/presentation/UI/widgets/size_option.dart';
import 'package:provider/provider.dart';

class ProductSelectionModal extends StatefulWidget {
  final ClothingItem item;
  const ProductSelectionModal({super.key, required this.item});

  @override
  State<ProductSelectionModal> createState() => _ProductSelectionModalState();
}

class _ProductSelectionModalState extends State<ProductSelectionModal> {
  final List<String> sizes = ['S', 'M', 'L', 'XL'];
  int quantity = 1;
  Color? selectedColor;
  String? selectedSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20), //only(top: 20, left: 20, right: 0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.only(bottom: 15),
              width: 60,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
          Text(
            'Select a size',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: sizes
                .map(
                  (size) => SizeOption(
                    size: size,
                    backgroundColor: Colors.grey[200] ?? Colors.grey,
                    isSelected: selectedSize == size,
                    onSelect: () => setState(() => selectedSize = size),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 24),
          Text(
            'Select a color',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              ColorOption(
                color: Colors.black,
                isSelected: selectedColor == Colors.black,
                onSelect: () => setState(() => selectedColor = Colors.black),
              ),
              ColorOption(
                color: Colors.blue,
                isSelected: selectedColor == Colors.blue,
                onSelect: () => setState(() => selectedColor = Colors.blue),
              ),
              ColorOption(
                color: Colors.red,
                isSelected: selectedColor == Colors.red,
                onSelect: () => setState(() => selectedColor = Colors.red),
              ),
              ColorOption(
                color: Colors.teal,
                isSelected: selectedColor == Colors.grey,
                onSelect: () => setState(() => selectedColor = Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            'Select a quantity',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              SizedBox(
                height: 40,
                width: 40,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      if (quantity > 1 &&
                          quantity <= widget.item.rating['count']) {
                        setState(() {
                          quantity--;
                        });
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                quantity.toString(),
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                height: 40,
                width: 40,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      if (quantity > 0 &&
                          quantity < widget.item.rating['count']) {
                        setState(() {
                          quantity++;
                        });
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Divider(
            color: Colors.black,
            height: 20,
            thickness: 1,
            indent: 0,
            endIndent: 0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: GoogleFonts.poppins(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                '\$${(widget.item.price * quantity).toStringAsFixed(2)}',
                style: GoogleFonts.poppins(
                  fontSize: 23,
                  color: const Color.fromARGB(255, 255, 0, 0).withOpacity(0.7),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const Divider(
            color: Colors.black,
            height: 20,
            thickness: 1,
            indent: 0,
            endIndent: 0,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            onPressed: () {
              var cartProvider =
                Provider.of<CartProvider>(context, listen: false);
              cartProvider.addItem(
                CartItem(
                  item: widget.item,
                  quantity: quantity,
                  size: selectedSize,
                  color: selectedColor,
                  name: widget.item.title,
                  description: widget.item.description,
                  image: widget.item.imagePath,
                ),
              );
              // Obtener los items del carrito y el precio total
              List<CartItem> cartItems = cartProvider.items;
              double totalPrice = cartProvider.totalPrice;
              // Abrir la pantalla del carrito
              Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CartScreen(
                  cartItems: cartItems,
                  totalPrice: totalPrice,
                ),
              ),
            );
            },
            child: Text(
              'Checkout',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

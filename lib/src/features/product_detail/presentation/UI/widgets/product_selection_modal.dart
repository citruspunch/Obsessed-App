import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:obsessed_app/src/core/constants/constants.dart';
import 'package:obsessed_app/src/core/entities/clothing_item.dart';
import 'package:obsessed_app/src/features/cart/domain/entities/cart_item.dart';
import 'package:obsessed_app/src/features/cart/presentation/providers/cart_provider.dart';
import 'package:obsessed_app/src/features/product_detail/presentation/UI/widgets/personalized_dialog.dart';
import 'package:obsessed_app/src/features/product_detail/presentation/UI/widgets/color_option.dart';
import 'package:obsessed_app/src/features/product_detail/presentation/UI/widgets/size_option.dart';
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
    var cartProvider = Provider.of<CartProvider>(context, listen: false);
    int maxQuantity;
    if (selectedColor != null && selectedSize != null) {
      maxQuantity = cartProvider.containsClothingItem(
              widget.item, selectedColor!, selectedSize!)
          ? cartProvider.items[cartProvider.getIndex(widget.item)].stock
          : initialStock;
    } else {
      maxQuantity = initialStock;
    }
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: SingleChildScrollView(
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
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
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
            const SizedBox(height: 15),
            Text(
              'Select a color',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
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
                  isSelected: selectedColor == Colors.teal,
                  onSelect: () => setState(() => selectedColor = Colors.teal),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Text(
              'Select a quantity',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            if (maxQuantity > 0)
              Row(
                children: [
                  SizedBox(
                    height: 35,
                    width: 35,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: InkWell(
                        onTap: () {
                          if (selectedColor == null || selectedSize == null) {
                            // Mostrar diálogo si el color o tamaño no están seleccionados
                            showPersonalizedDialog(
                                context: context,
                                text: 'Please select a size\nand a color',
                                icon: FeatherIcons.alertCircle,
                                iconColor: Colors.indigoAccent);
                          } else {
                            if (quantity > 1 && quantity <= maxQuantity) {
                              setState(() {
                                quantity--;
                              });
                            }
                          }
                        },
                        child: const Icon(Icons.remove),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    quantity.toString(),
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    height: 35,
                    width: 35,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: InkWell(
                        onTap: () {
                          if (selectedColor == null || selectedSize == null) {
                            showPersonalizedDialog(
                                context: context,
                                text: 'Please select a size\nand a color',
                                icon: FeatherIcons.alertCircle,
                                iconColor: Colors.indigoAccent);
                          } else {
                            if (quantity > 0 && quantity < maxQuantity) {
                              setState(() {
                                quantity++;
                              });
                            }
                          }
                        },
                        child: const Icon(Icons.add),
                      ),
                    ),
                  ),
                ],
              ),
            if (maxQuantity == 0)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.error_outline,
                    color: Colors.redAccent,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Out of stock',
                    style: GoogleFonts.poppins(
                      color: Colors.redAccent,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 10),
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
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '\$${(widget.item.price * quantity).toStringAsFixed(2)}',
                  style: GoogleFonts.poppins(
                    fontSize: 23,
                    color: Colors.redAccent,
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
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(30),
              ),
              child: InkWell(
                onTap: () {
                  if (maxQuantity == 0) {
                    Navigator.pop(context);
                    showPersonalizedDialog(
                        context: context,
                        text: 'NO STOCK AVAILABLE',
                        icon: FeatherIcons.slash,
                        iconColor: Colors.red);
                    return;
                  }
                  if (selectedColor == null || selectedSize == null) {
                    showPersonalizedDialog(
                        context: context,
                        text: 'Please select a size\nand a color',
                        icon: FeatherIcons.alertCircle,
                        iconColor: Colors.indigoAccent);

                    return;
                  }
                  cartProvider.addItem(
                    CartItem(
                      id: widget.item.id,
                      item: widget.item,
                      quantity: quantity,
                      size: selectedSize,
                      color: selectedColor,
                      name: widget.item.title,
                      description: widget.item.description,
                      category: widget.item.name,
                      image: widget.item.imagePath,
                      count: widget.item.count,
                    ),
                  );
                  Navigator.pop(context);
                  showPersonalizedDialog(
                      context: context,
                      icon: FeatherIcons.checkCircle,
                      text: 'Item successfully\nadded to cart.',
                      iconColor: Colors.green);
                },
                child: Center(
                  child: Text(
                    'Add to cart',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:obsessed_app/src/features/home/presentation/UI/widgets/clothing_item_widget.dart';
import 'package:obsessed_app/src/features/home/presentation/providers/clothing_provider.dart';
import 'package:obsessed_app/src/features/search/presentation/UI/widgets/no_items_found_widget.dart';
import 'package:provider/provider.dart';

class FilteredProductsWidget extends StatelessWidget {
  const FilteredProductsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Acceder a los productos filtrados a través del Provider
    final filteredProducts = Provider.of<ClothingProvider>(context).filteredItems;

    // Verificar si hay productos filtrados
    if (filteredProducts.isEmpty) {
      return const Center(child: NoItemsFoundWidget());
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: filteredProducts.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisExtent: 230,
            mainAxisSpacing: 24,
            crossAxisSpacing: 18,
            crossAxisCount: 2,
          ),
          itemBuilder: (context, index) {
            final item = filteredProducts[index];
            return ClothingItemWidget(item: item);
          },
        ),
      );
    }
  }
}
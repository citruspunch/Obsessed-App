import 'package:flutter/material.dart';
import 'package:obsessed_app/src/features/home/presentation/UI/widgets/clothing_item_widget.dart';
import 'package:obsessed_app/src/features/home/presentation/providers/clothing_provider.dart';
import 'package:obsessed_app/src/features/search/presentation/UI/widgets/no_items_found_widget.dart';
import 'package:provider/provider.dart';

class FilteredProductsWidget extends StatelessWidget {
  const FilteredProductsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final filteredProducts = Provider.of<ClothingProvider>(context).filteredItems;

    // Verificar si hay productos filtrados
    if (filteredProducts.isEmpty) {
      return const Center(child: NoItemsFoundWidget());
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: filteredProducts.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisExtent: 200,
            mainAxisSpacing: 14,
            crossAxisSpacing: 12,
            crossAxisCount: 2,
          ),
          itemBuilder: (context, index) {
            final item = filteredProducts[index];
            return ClothingItemWidget(item: item, heroActivated: false);
          },
        ),
      );
    }
  }
}
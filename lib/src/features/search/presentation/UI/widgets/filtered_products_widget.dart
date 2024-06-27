import 'package:flutter/material.dart';
import 'package:obsessed_app/src/features/home/presentation/UI/widgets/clothing_item_widget.dart';
import 'package:obsessed_app/src/features/home/presentation/providers/clothing_provider.dart';
import 'package:provider/provider.dart';

class FilteredProductsWidget extends StatelessWidget {
  const FilteredProductsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Acceder a los productos filtrados a través del Provider
    final filteredProducts = Provider.of<ClothingProvider>(context).filteredItems;

    return Padding(
      padding: const EdgeInsets.symmetric( horizontal: 20.0),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(), // Evita el desplazamiento propio del GridView
        shrinkWrap: true, // Permite que este widget se use dentro de un SingleChildScrollView
        itemCount: filteredProducts.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisExtent: 230, // Altura de cada elemento
          mainAxisSpacing: 24, // Espacio vertical entre elementos
          crossAxisSpacing: 18, // Espacio horizontal entre elementos
          crossAxisCount: 2, // Número de columnas
        ),
        itemBuilder: (context, index) {
          final item = filteredProducts[index];
          return ClothingItemWidget(item: item); // Widget para mostrar cada producto
        },
      ),
    );
  }
}
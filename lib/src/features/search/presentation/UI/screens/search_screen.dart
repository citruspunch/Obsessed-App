import 'package:flutter/material.dart';
import 'package:obsessed_app/src/features/home/presentation/UI/widgets/navigation_bar.dart';
import 'package:obsessed_app/src/features/search/presentation/UI/widgets/filtered_products_widget.dart';
import 'package:obsessed_app/src/features/search/presentation/UI/widgets/search_bar.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SearchBarWidget(),
            FilteredProductsWidget(),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBarHome(),
    );
  }
}


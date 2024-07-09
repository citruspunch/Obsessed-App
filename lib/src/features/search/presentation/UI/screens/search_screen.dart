import 'package:flutter/material.dart';
import 'package:obsessed_app/src/features/home/presentation/UI/widgets/navigation_bar.dart';
import 'package:obsessed_app/src/features/search/presentation/UI/widgets/filtered_products_widget.dart';
import 'package:obsessed_app/src/features/search/presentation/UI/widgets/search_bar.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: const SearchBarWidget(),
        forceMaterialTransparency: true,
        automaticallyImplyLeading: false,
        toolbarHeight: 67.0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(10.0),
          child: Container(),
        ),
      ),
      backgroundColor: const Color(0xFFF1F1F1),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.minHeight),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  FilteredProductsWidget(),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: const NavigationBarHome(),
    );
  }
}


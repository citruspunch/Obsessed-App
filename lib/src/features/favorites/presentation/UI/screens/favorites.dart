import 'package:flutter/material.dart';
import 'package:obsessed_app/src/features/favorites/presentation/UI/widgets/empty_favorites_widget.dart';
import 'package:obsessed_app/src/features/favorites/presentation/UI/widgets/favorites_body.dart';
import 'package:obsessed_app/src/features/favorites/presentation/UI/widgets/favorites_header.dart';
import 'package:obsessed_app/src/features/favorites/presentation/providers/favorites_provider.dart';
import 'package:obsessed_app/src/features/home/presentation/UI/widgets/navigation_bar.dart';
import 'package:provider/provider.dart';

class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  @override
  Widget build(BuildContext context) {
    final favorites = Provider.of<FavoritesProvider>(context);
    bool hasFavorites = favorites.items.isNotEmpty;

    return Scaffold(
      backgroundColor: const Color(0xFFF1F1F1),
      body: hasFavorites ? buildFavoritesList(favorites) : buildEmptyFavorites(),
      bottomNavigationBar: const NavigationBarHome(),
    );
  }

  Widget buildFavoritesList(FavoritesProvider favorites) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: [
            const FavoritesHeader(),
            FavoritesBody(favoriteItems: favorites.items),
            SizedBox(height: MediaQuery.of(context).size.height * 0.7),
          ],
        ),
      ),
    );
  }

  Widget buildEmptyFavorites() {
    return const SafeArea(
      child: Column(
        children: [
          FavoritesHeader(),
          Expanded(
            child: Center(
              child: EmptyFavoritesWidget(),
            ),
          ),
          SizedBox(height: 100),
        ],
      ),
    );
  }
}
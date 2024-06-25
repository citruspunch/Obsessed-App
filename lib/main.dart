import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:obsessed_app/src/features/cart/presentation/providers/cart_provider.dart';
import 'package:obsessed_app/src/features/favorites/presentation/providers/favorites_provider.dart';
import 'package:obsessed_app/src/features/home/infrastructure/repositories/clothing_repository.dart';
import 'package:obsessed_app/src/features/home/domain/use_cases/get_all_items.dart';
import 'package:obsessed_app/src/features/home/infrastructure/clothing_data_source.dart';
import 'package:obsessed_app/src/features/home/presentation/UI/screens/home.dart';
import 'package:obsessed_app/src/features/home/presentation/providers/clothing_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Asegurar la inicialización de los widgets
  await dotenv.load(fileName: ".env"); // Cargar las variables de entorno

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ClothingProvider(
            getAllItems: GetAllItems(
              ClothingRepository(
                ClothingDataSource(),
              ),
            ),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => FavoritesProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Obsessed App',
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:obsessed_app/src/features/Cart/presentation/providers/cart_provider.dart';
import 'package:obsessed_app/src/features/Home/infrastructure/repositories/clothing_repository.dart';
import 'package:obsessed_app/src/features/Home/domain/use_cases/get_all_items.dart';
import 'package:obsessed_app/src/features/Home/infrastructure/clothing_data_source.dart';
import 'package:obsessed_app/src/features/Home/presentation/UI/screens/home.dart';
import 'package:obsessed_app/src/features/Home/presentation/providers/clothing_provider.dart';
import 'package:provider/provider.dart';

void main() {
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
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Obsessed App',
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:obsessed_app/src/features/cart/presentation/providers/cart_provider.dart';
import 'package:obsessed_app/src/features/favorites/presentation/providers/favorites_provider.dart';
import 'package:obsessed_app/src/features/home/infrastructure/repositories/clothing_repository.dart';
import 'package:obsessed_app/src/features/home/domain/use_cases/get_all_items.dart';
import 'package:obsessed_app/src/features/home/infrastructure/clothing_data_source.dart';
import 'package:obsessed_app/src/features/home/presentation/UI/screens/home.dart';
import 'package:obsessed_app/src/features/home/presentation/providers/clothing_provider.dart';
import 'package:obsessed_app/src/features/user_account/presentation/UI/screens/welcome.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Asegurar la inicialización de los widgets
  await dotenv.load(fileName: ".env"); // Cargar las variables de entorno
  await Supabase.initialize(
    url: 'https://xotoaqcjdpsgkzfeafge.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhvdG9hcWNqZHBzZ2t6ZmVhZmdlIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjAzMDY4MTgsImV4cCI6MjAzNTg4MjgxOH0.s1WsN1FbErB9p4ATv3V0n0CLrURt2B-sRDnZY0hxu_Y',
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CartProvider()..loadCartFromDatabase(),
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
          create: (context) => FavoritesProvider()..loadFavoritesFromDatabase(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Obsessed App',
      debugShowCheckedModeBanner: false,
      home: supabase.auth.currentSession == null
          ? const WelcomeScreen()
          : const Home(),
    );
  }
}

extension ContextExtension on BuildContext {
  void showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError
            ? Theme.of(this).colorScheme.error
            : Theme.of(this).snackBarTheme.backgroundColor,
      ),
    );
  }
}

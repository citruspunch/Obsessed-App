import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:obsessed_app/main.dart';
import 'package:obsessed_app/src/features/home/presentation/UI/widgets/carousel.dart';
import 'package:obsessed_app/src/features/home/presentation/UI/widgets/navigation_bar.dart';
import 'package:obsessed_app/src/features/home/presentation/UI/widgets/clothing_item_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:obsessed_app/src/features/home/presentation/providers/clothing_provider.dart';
import 'package:obsessed_app/src/features/user_account/presentation/UI/screens/login_screen.dart';
import 'package:obsessed_app/src/features/user_account/presentation/UI/screens/profile_page.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ScrollController _scrollController = ScrollController();
  final controller = CarouselController();
  String? _avatarUrl;

  @override
  void initState() {
    super.initState();
    if (supabase.auth.currentSession != null) {
      _initializeProfile();
    }
  }

  Future<void> _initializeProfile() async {
    await _getPicture();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  final List<String> backgroundImages = [
    "assets/images/background1.png",
    "assets/images/background2.png",
    "assets/images/background3.png",
    "assets/images/background4.png",
  ];
  Future<void> _getPicture() async {
    try {
      final userId = supabase.auth.currentSession!.user.id;
      final data =
          await supabase.from('profiles').select().eq('id', userId).single();
      setState(() {
        _avatarUrl = (data['avatar_url'] ?? '') as String;
      });
    } on PostgrestException catch (error) {
      if (mounted) context.showSnackBar(error.message, isError: true);
    } catch (error) {
      if (mounted) {
        context.showSnackBar('Unexpected error occurred', isError: true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: const Color(0xFFF1F1F1),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFFF1F1F1),
        forceMaterialTransparency: true,
        toolbarHeight: 65,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: Text("OBSESSED",
              style: GoogleFonts.playfairDisplay(
                  color: Colors.black,
                  fontSize: 26,
                  fontWeight: FontWeight.bold)),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 15),
            width: 41,
            height: 41,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              shape: BoxShape.circle,
            ),
            child: InkWell(
              onTap: () {
                // Verifica si el usuario está autenticado
                if (supabase.auth.currentSession == null) {
                  // Si no hay sesión, navega a LoginPage
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const LoginScreen(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        return FadeTransition(
                          opacity: animation,
                          child: child,
                        );
                      },
                      transitionDuration: const Duration(milliseconds: 600),
                    ),
                  );
                } else {
                  // Si hay sesión, navega a AccountPage
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const ProfilePage(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        return FadeTransition(
                          opacity: animation,
                          child: child,
                        );
                      },
                      transitionDuration: const Duration(milliseconds: 500),
                    ),
                  );
                }
              },
              child: (_avatarUrl != null && _avatarUrl!.isNotEmpty)
                  ? ClipOval(
                      child: Image.network(
                        _avatarUrl!,
                        fit: BoxFit.cover,
                      ),
                    )
                  : const Icon(
                      FeatherIcons.user,
                      color: Colors.black,
                    ),
            ),
          )
        ],
      ),
      body: FutureBuilder(
        future:
            Provider.of<ClothingProvider>(context, listen: false).loadItems(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Text('An error occurred (future): ${snapshot.error}'));
          } else {
            return Consumer<ClothingProvider>(
              builder: (context, clothingProvider, child) {
                return SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    children: [
                      Carousel(
                        controller: controller,
                        backgroundImages: backgroundImages,
                        onPreviousPage: previousPage,
                        onNextPage: nextPage,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 23),
                        child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: clothingProvider.items.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisExtent: 200,
                                  mainAxisSpacing: 15,
                                  crossAxisSpacing: 13,
                                  crossAxisCount: 2),
                          itemBuilder: (context, index) {
                            return ClothingItemWidget(
                                item: clothingProvider.items[index]);
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
      bottomNavigationBar: NavigationBarHome(
        scrollToTop: () {
          _scrollController.animateTo(
            0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        },
      ),
    );
  }

  void previousPage() {
    controller.previousPage(duration: const Duration(milliseconds: 400));
  }

  void nextPage() {
    controller.nextPage(duration: const Duration(milliseconds: 400));
  }
}

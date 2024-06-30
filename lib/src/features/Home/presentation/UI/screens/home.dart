import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:obsessed_app/src/features/home/presentation/UI/widgets/carousel.dart';
import 'package:obsessed_app/src/features/home/presentation/UI/widgets/navigation_bar.dart';
import 'package:obsessed_app/src/features/home/presentation/UI/widgets/clothing_item_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:obsessed_app/src/features/home/presentation/providers/clothing_provider.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {

  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ScrollController _scrollController = ScrollController();
  final controller = CarouselController();

  final List<String> backgroundImages = [
    "assets/images/background1.png",
    "assets/images/background2.png",
    "assets/images/background3.png",
    "assets/images/background4.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: const Color(0xFFF1F1F1),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF1F1F1),
        forceMaterialTransparency: true,
        toolbarHeight: 90,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: Text("OBSESSED",
              style: GoogleFonts.playfairDisplay(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold)),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 15),
            width: 43,
            height: 43,
            decoration: BoxDecoration(
                color: Colors.grey[300], shape: BoxShape.circle),
            child: const Icon(
              FeatherIcons.user,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<ClothingProvider>(context, listen: false).loadItems(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('An error occurred (future): ${snapshot.error}'));
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
                                  mainAxisExtent: 230,
                                  mainAxisSpacing: 24,
                                  crossAxisSpacing: 13,
                                  crossAxisCount: 2),
                          itemBuilder: (context, index) {
                            return ClothingItemWidget(item: clothingProvider.items[index]);
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
import 'package:flutter/material.dart';
import 'package:obsessed_app/src/features/Home/presentation/UI/widgets/carousel.dart';
import 'package:obsessed_app/src/features/Home/presentation/UI/widgets/navigation_bar.dart';
import 'package:obsessed_app/src/features/Home/presentation/UI/widgets/clothing_item.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:obsessed_app/src/features/Home/presentation/providers/clothing_provider.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final controller = CarouselController();
  final List<String> backgroundImages = [
    "assets/images/background1.png",
    "assets/images/background2.png",
    "assets/images/background3.png",
    "assets/images/background4.png",
  ];

  Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 90,
        elevation: 0,
        title: Text("OBSESSED",
            style: GoogleFonts.playfairDisplay(
                color: Colors.black,
                fontSize: 27,
                fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        leading: IconButton(
            iconSize: 40,
            onPressed: (
              //Implementar el boton de menu
            ) {},
            icon: SvgPicture.asset(
              "assets/icons/menu_icon.svg",
              fit: BoxFit.contain,
            )),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 12),
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
                color: Colors.black, shape: BoxShape.circle),
            child: Image.asset(
              "assets/images/avatar2.png",
              fit: BoxFit.contain,
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
                            horizontal: 12, vertical: 30),
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
      bottomNavigationBar: const NavigationBarHome(),
    );
  }

  void previousPage() {
    controller.previousPage(duration: const Duration(milliseconds: 400));
  }

  void nextPage() {
    controller.nextPage(duration: const Duration(milliseconds: 400));
  }
}
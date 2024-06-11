import 'package:flutter/material.dart';
import 'package:obsessed_app/src/features/Home/UI/widgets/carousel.dart';
import 'package:obsessed_app/src/features/Home/UI/widgets/navigation_bar.dart';
import 'package:obsessed_app/src/features/Home/UI/widgets/shirt_item.dart';
import 'package:obsessed_app/src/features/Home/domain/entities/shirt.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final controller = CarouselController();

  List<Shirt> shirts = listOfShirts();
  List<String> backgroundImages = [
    "assets/images/background1.png",
    "assets/images/background2.png",
    "assets/images/background3.png",
    "assets/images/background4.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 90,
        elevation: 0,
        title: Text("Obsessed",
            style: GoogleFonts.playfairDisplay(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        leading: IconButton(
            iconSize: 40,
            onPressed: () {},
            icon: SvgPicture.asset("assets/icons/menu_icon.svg")),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 12),
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
                color: Colors.black, shape: BoxShape.circle),
            child:
                Image.asset("assets/images/avatar.png", fit: BoxFit.contain),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Carousel(
              controller: controller,
              backgroundImages: backgroundImages,
              onPreviousPage: previousPage,
              onNextPage: nextPage,
            ),
            Padding(
              padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 30),
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: shirts.length, 
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisExtent: 230,
                  mainAxisSpacing: 24,
                  crossAxisSpacing: 13,
                  crossAxisCount: 2),
                itemBuilder: (context, index) {
                  return ShirtItem(shirt: shirts[index]);
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const NavigationBarHome());
  }
  void previousPage() {
    controller.previousPage(duration: const Duration(milliseconds: 400));
  }

  void nextPage() {
    controller.nextPage(duration: const Duration(milliseconds: 400));
  }
}
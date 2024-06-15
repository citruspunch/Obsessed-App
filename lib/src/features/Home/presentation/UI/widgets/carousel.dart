import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Carousel extends StatelessWidget {
  final CarouselController controller;
  final List<String> backgroundImages;
  final VoidCallback onPreviousPage;
  final VoidCallback onNextPage;
  
  const Carousel({
    super.key, 
    required this.controller, 
    required this.backgroundImages, 
    required this.onPreviousPage, 
    required this.onNextPage
    });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider.builder(
            carouselController: controller,
            itemCount: backgroundImages.length,
            options: CarouselOptions(
                viewportFraction: 1, height: 230, enableInfiniteScroll: true),
            itemBuilder: (context, index, realIndex) {
              return Container(
                width: double.infinity,
                margin: const EdgeInsets.only(left: 12, right: 12, bottom: 10),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(backgroundImages[index]),
                        fit: BoxFit.cover)),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: Text(
                          " NEW \n MONTH, \n NEW \n DROP",
                          style: GoogleFonts.playfairDisplay(
                              backgroundColor: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ]),
              );
            }),
        Positioned(
          bottom: 1,
          right: 22,
          child: Row(
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      minimumSize: const Size(50, 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0))),
                  onPressed: onPreviousPage,
                  child: const Icon(
                    Icons.arrow_back,
                    size: 30,
                  )),
              const SizedBox(width: 3),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      minimumSize: const Size(50, 50),
                      shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(0) )),
                  onPressed: onNextPage,
                  child: const Icon(
                    Icons.arrow_forward,
                    size: 30,
                  ))
            ],
          ),
        )
      ],
    );
  }
}
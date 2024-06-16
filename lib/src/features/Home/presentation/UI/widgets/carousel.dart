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
                viewportFraction: 1, 
                height: 230, 
                enableInfiniteScroll: true,
                autoPlay: true, // Habilitar el cambio automático de imágenes
                autoPlayInterval: const Duration(seconds: 6), // Duración entre cada cambio de imagen
            ),
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
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: Text(
                          " NEW DROP ",
                          style: GoogleFonts.playfairDisplay(
                              color: Colors.white,
                              fontSize: 30,
                              decorationStyle: TextDecorationStyle.solid,
                              decorationThickness: 2,
                              shadows: [
                                const Shadow(
                                  blurRadius: 5.0,
                                  color: Colors.black54, // Aumenta la opacidad
                                  offset: Offset(3.0, .0),
                                ),
                              ],
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ]),
              );
            }),
        Positioned(
          left: 14,
          bottom: 1,
          top: 1,
          child: ButtonTheme(
            minWidth: 40,
            height: 30,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0)
                ),
                elevation: 0, // Eliminar la sombra del botón
              ),
              onPressed: onPreviousPage,
              child: const Icon(
                Icons.arrow_back_ios_rounded,
                size: 40,
                color: Colors.white,
              ),
            ),
          ),
        ),
        Positioned(
          right: 14,
          bottom: 1,
          top: 1,
          child: SizedBox(
            width: 40,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0)
                ),
                elevation: 0, // Eliminar la sombra del botón
              ),
              onPressed: onNextPage,
              child: const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 40,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
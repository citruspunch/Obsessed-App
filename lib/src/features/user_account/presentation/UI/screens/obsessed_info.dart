import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:obsessed_app/src/features/product_detail/presentation/UI/widgets/return_to_home_button.dart';
import 'package:obsessed_app/src/features/user_account/presentation/UI/widgets/info_card.dart';

class ObsessedInfoScreen extends StatelessWidget {
  const ObsessedInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: true,
        leading: const ReturnToHomeButton(),
        title: Text('About us', style: GoogleFonts.poppins(
          fontSize: 25,
          fontWeight: FontWeight.w600,
        )),
        forceMaterialTransparency: true,
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            InfoCard(
              title: 'About Obsessed',
              englishText: 'We are a Guatemalan gym wear brand committed to providing unique designs with the highest quality standards. Our focus is on creating garments that blend style, functionality, and comfort, empowering our customers to feel confident and motivated on their journey towards an active, healthy lifestyle. With an emphasis on excellence and creativity, we aim to be the preferred choice for fitness enthusiasts in Guatemala.',
              spanishText: 'Somos una marca guatemalteca de ropa deportiva comprometida con brindar diseños únicos con los más altos estándares de calidad. Nos enfocamos en crear prendas que combinan estilo, funcionalidad y comodidad, permitiendo a nuestros clientes sentirse seguros y motivados en su camino hacia un estilo de vida activo y saludable. Con un enfoque en la excelencia y la creatividad, nos esforzamos por ser la opción preferida de los entusiastas del fitness en Guatemala.',
              icon: Icons.info,
            ),
            InfoCard(
              title: 'Our Mission',
              englishText: 'At Obsessed, our mission is to provide innovative and high-quality gym wear in Guatemala and around the world, empowering our customers to reach their fitness goals with style and comfort.',
              spanishText: 'En Obsessed, nuestra misión es ofrecer ropa de gimnasio innovadora y de alta calidad en Guatemala y alrededor del mundo, empoderando a nuestros clientes a alcanzar sus metas fitness con estilo y comodidad.',
              icon: FeatherIcons.compass,
            ),
          ],
        ),
      ),
    );
  }
}



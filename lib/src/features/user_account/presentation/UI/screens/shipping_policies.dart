import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:obsessed_app/src/features/product_detail/presentation/UI/widgets/return_to_home_button.dart';
import 'package:obsessed_app/src/features/user_account/presentation/UI/widgets/info_card.dart';

class ShippingPolicies extends StatelessWidget {
  const ShippingPolicies({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: true,
        leading: const ReturnToHomeButton(),
        title: Text('Policies', style: GoogleFonts.poppins(
          fontSize: 25,
          fontWeight: FontWeight.w600,
        )),
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 5),
            InfoCard(
              title: 'Shipping Guidelines',
              englishText: 'Our shipping policies are meticulously designed to ensure that your orders are delivered with utmost precision and speed. We partner with leading logistics providers to offer a wide range of delivery options, catering to your specific needs. From standard to express delivery, we prioritize efficiency and reliability. Our policies include detailed information on shipping rates, estimated delivery times, and tracking capabilities, ensuring a transparent and seamless delivery process. For international shipments, we navigate customs regulations to minimize delays, providing a hassle-free shopping experience from checkout to delivery.',
              spanishText: 'Nuestras políticas de envío están meticulosamente diseñadas para garantizar que sus pedidos se entreguen con la máxima precisión y rapidez. Nos asociamos con los principales proveedores de logística para ofrecer una amplia gama de opciones de entrega, adaptadas a sus necesidades específicas. Desde la entrega estándar hasta la exprés, priorizamos la eficiencia y la confiabilidad. Nuestras políticas incluyen información detallada sobre las tarifas de envío, los tiempos de entrega estimados y las capacidades de seguimiento, garantizando un proceso de entrega transparente y sin problemas. Para los envíos internacionales, navegamos por las regulaciones aduaneras para minimizar los retrasos, proporcionando una experiencia de compra sin complicaciones desde el pago hasta la entrega.',
              icon: FeatherIcons.alertCircle,
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
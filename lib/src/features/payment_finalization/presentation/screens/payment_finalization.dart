import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:obsessed_app/src/features/payment_finalization/presentation/widgets/order_details_form.dart';
import 'package:obsessed_app/src/features/product_detail/presentation/UI/widgets/return_to_home_button.dart';

class PaymentFinalization extends StatelessWidget {
  final double totalPrice;
  final double deliveryFee = 20.00;

  const PaymentFinalization({super.key, required this.totalPrice});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: true,
        leading: const Padding(
          padding: EdgeInsets.only(left: 11.0, bottom: 2.0),
          child: ReturnToHomeButton(),
        ),
        title: Text('Payment',
            style: GoogleFonts.poppins(
              fontSize: 25,
              fontWeight: FontWeight.w600,
            )),
        forceMaterialTransparency: true,
      ),
      body: const SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
            child: OrderDetailsForm(),
          ),
        ),
      ),
    );
  }
}

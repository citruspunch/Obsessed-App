import 'package:flutter/material.dart';
import 'package:obsessed_app/src/features/payment_finalization/presentation/widgets/order_details_form.dart';
import 'package:obsessed_app/src/features/payment_finalization/presentation/widgets/payment_title.dart';
import 'package:obsessed_app/src/features/product_detail/presentation/UI/widgets/return_to_home_button.dart';

class PaymentFinalization extends StatelessWidget {
  final double totalPrice;
  final double deliveryFee = 20.00;

  const PaymentFinalization({super.key, required this.totalPrice});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const ReturnToHomeButton(),
                          const PaymentTitle(),
                          Container(width: 30),
                        ],
                      ),
                      const OrderDetailsForm(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
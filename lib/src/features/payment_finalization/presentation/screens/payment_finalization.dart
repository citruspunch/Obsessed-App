import 'package:flutter/material.dart';
import 'package:obsessed_app/src/features/cart/presentation/UI/widgets/more_options_button.dart';
import 'package:obsessed_app/src/features/payment_finalization/presentation/widgets/order_details_form.dart';
import 'package:obsessed_app/src/features/payment_finalization/presentation/widgets/payment_title.dart';
import 'package:obsessed_app/src/features/product_detail/presentation/UI/widgets/return_to_home_button.dart';

class PaymentFinalization extends StatelessWidget {
  final double totalPrice;
  final double deliveryFee = 20.00;

  const PaymentFinalization({super.key, required this.totalPrice});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(25.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ReturnToHomeButton(),
                          PaymentTitle(),
                          MoreOptionsButton(),
                        ],
                      ),
                      OrderDetailsForm(),
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
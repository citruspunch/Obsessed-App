import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:obsessed_app/src/features/cart/domain/entities/cart_item.dart';
import 'package:obsessed_app/src/features/cart/presentation/providers/cart_provider.dart';
import 'package:obsessed_app/src/features/payment_finalization/domain/repositories/email_repository.dart';
import 'package:obsessed_app/src/features/payment_finalization/domain/use_cases/send_email_use_case.dart';
import 'package:obsessed_app/src/features/payment_finalization/infrastructure/email_service.dart';
import 'package:obsessed_app/src/features/payment_finalization/presentation/widgets/succesful_payment.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class OrderDetailsForm extends StatefulWidget {
  const OrderDetailsForm({super.key});

  @override
  State<OrderDetailsForm> createState() => _OrderDetailsFormState();
}

class _OrderDetailsFormState extends State<OrderDetailsForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _countryController = TextEditingController();
  final _cityController = TextEditingController();
  final _emailController = TextEditingController();
  final EmailRepository _emailRepository = EmailService();
  late final SendEmailUseCase _sendEmailUseCase;

  @override
  void initState() {
    super.initState();
    // Crear la instancia de SendEmailUseCase con EmailRepository
    _sendEmailUseCase = SendEmailUseCase(_emailRepository);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _lastNameController.dispose();
    _countryController.dispose();
    _cityController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  icon: const Icon(Icons.person),
                  labelText: 'Name: ',
                  labelStyle: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: GoogleFonts.poppins(
                  fontSize: 15,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 45),
              TextFormField(
                controller: _lastNameController,
                decoration: InputDecoration(
                  icon: const Icon(Icons.person_outline),
                  labelText: 'Last Name:',
                  labelStyle: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: GoogleFonts.poppins(
                  fontSize: 15,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your last name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 45),
              TextFormField(
                controller: _countryController,
                decoration: InputDecoration(
                  icon: const Icon(Icons.flag),
                  labelText: 'Country:',
                  labelStyle: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: GoogleFonts.poppins(
                  fontSize: 15,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your country';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 45),
              TextFormField(
                controller: _cityController,
                decoration: InputDecoration(
                  icon: const Icon(Icons.location_city),
                  labelText: 'City:',
                  labelStyle: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: GoogleFonts.poppins(
                  fontSize: 15,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your city';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 45),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  icon: const Icon(Icons.email),
                  labelText: 'Email:',
                  labelStyle: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: GoogleFonts.poppins(
                  fontSize: 15,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  } else if (!value.contains('@')) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 45),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          final cart = Provider.of<CartProvider>(context, listen: false);
                          final List<CartItem> cartItems = cart.items;
                          final double totalAmount = cart.totalPrice;
                          final List<String> products = cartItems.map((item) => '${item.quantity}x ${item.name}').toList();
                          var uuid = const Uuid();
                          final String uniqueId = uuid.v4(); // Generar un UUID
                          final String email = _emailController.text;
                          const String subject = 'Order Details';
                          final String body = _generateEmailBody(
                            orderId: uniqueId,
                            name: _nameController.text,
                            lastName: _lastNameController.text,
                            country: _countryController.text,
                            city: _cityController.text,
                            totalAmount: totalAmount,
                            products: products,
                          );
                          // Llamada a la función de envío de correo electrónico
                          await _sendEmailUseCase.sendEmail(email, subject, body);
                          print('Sending email...\n$subject\n$body');
                          showDialog(
                            // ignore: use_build_context_synchronously
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const SuccesfulPayment(),
                              );
                            },
                          );
                        } catch (e) {
                          print('Error al enviar el correo: $e');
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.grey[800],
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      'Submit',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _generateEmailBody({
  required String orderId,
  required String name,
  required String lastName,
  required String country,
  required String city,
  required double totalAmount,
  required List<String> products,
}) {
  final productsString = products.map((product) => '• $product').join('<br>');
    return '''
  <html>
  <head>
    <style>
      body {
        font-family: 'Arial', sans-serif; /* Cambia 'Arial' por el tipo de letra que prefieras */
      }
      .bold {
        font-weight: bold;
      }
    </style>
  </head>
  <body>
    <p>Thank you for shopping with <span class="bold">Obsessed</span>!</p>

    <p>Here are your order details:</p>

    <p><span class="bold">Order ID:</span> $orderId</p>

    <p><span class="bold">Name:</span> $name $lastName<br>
    <span class="bold">Country:</span> $country<br>
    <span class="bold">City:</span> $city<br>

    <p><span class="bold">Products:</span><br>
    $productsString</p>

    <p><span class="bold">Total Amount:</span> \$${totalAmount.toStringAsFixed(2)}</p>

    <p>We hope you enjoy your purchase. If you have any questions or need further assistance, please do not hesitate to contact us.</p>

    <p>Best regards,<br>
    The <span class="bold">Obsessed</span> Team</p>
  </body>
  </html>
  ''';
  }
}
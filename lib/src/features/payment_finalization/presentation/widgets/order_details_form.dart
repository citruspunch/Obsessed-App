import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:obsessed_app/src/features/cart/domain/entities/cart_item.dart';
import 'package:obsessed_app/src/features/cart/presentation/providers/cart_provider.dart';
import 'package:obsessed_app/src/features/payment_finalization/domain/entities/city.dart';
import 'package:obsessed_app/src/features/payment_finalization/domain/entities/country.dart';
import 'package:obsessed_app/src/features/payment_finalization/domain/repositories/email_repository.dart';
import 'package:obsessed_app/src/features/payment_finalization/domain/use_cases/send_email_use_case.dart';
import 'package:obsessed_app/src/features/payment_finalization/infrastructure/city_service.dart';
import 'package:obsessed_app/src/features/payment_finalization/infrastructure/countries_service.dart';
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
  final _emailController = TextEditingController();
  final EmailRepository _emailRepository = EmailService();
  late final SendEmailUseCase _sendEmailUseCase;

  List<Country> _countries = [];
  String? _selectedCountry;
  List<City> _cities = [];
  String? _selectedCity;

  @override
  void initState() {
    super.initState();
    // Crear la instancia de SendEmailUseCase con EmailRepository
    _sendEmailUseCase = SendEmailUseCase(_emailRepository);
    _loadCountries();
  }

  void _loadCountries() async {
    try {
      CountriesService service = CountriesService();
      List<Country> countries = await service.getCountries(); // Obtiene los países
      // Actualiza el estado con los nuevos países y selecciona el primer país por defecto
      if (countries.isNotEmpty) {
        setState(() {
          _countries = countries;
          _selectedCountry = countries.first.name;
        });
      }
    } catch (e) {
      throw Exception('Error loading countries: $e');
    }
  }

  void _loadCities(String countryName) async {
    try {
      CityService service = CityService();
      List<City> cities = await service.getCities(countryName);
      setState(() {
        _cities = cities;
        _selectedCity = cities.isNotEmpty ? cities.first.name : null;
      });
    } catch (e) {
      setState(() {
        _cities = [];
        _selectedCity = 'No cities Available';
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.only(left: 3, right: 3, top: 80),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                autofocus: true,
                controller: _nameController,
                decoration: createDecoration('Name:', icon: Icons.person),
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
              const SizedBox(height: 65),
              TextFormField(
                controller: _lastNameController,
                decoration: createDecoration('Last Name:', icon: Icons.person_outline),
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
              const SizedBox(height: 65),
              DropdownButtonFormField<String>(
                value: _selectedCountry,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  icon: const Icon(Icons.flag, color: Colors.deepPurple),
                  labelText: 'Country:',
                  labelStyle: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                  border: OutlineInputBorder( 
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  enabledBorder: OutlineInputBorder( 
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder( 
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Colors.deepPurple, width: 2),
                  ),
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCountry = newValue;
                    _loadCities(_selectedCountry!);
                  });
                },
                items: _countries.map<DropdownMenuItem<String>>((Country country) {
                  return DropdownMenuItem<String>(
                    value: country.name,
                    child: Text(
                      country.name.length > 40 ? '${country.name.substring(0, country.name.length - 7)}...' : country.name,
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 65),
              DropdownButtonFormField<String>(
                value: _selectedCity,
                decoration: InputDecoration(
                  fillColor: Colors.white, 
                  filled: true,
                  icon: const Icon(Icons.location_city, color: Colors.deepPurple),
                  labelText: 'City:',
                  labelStyle: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                  border: OutlineInputBorder( 
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Colors.deepPurple, width: 2),
                  ),
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCity = newValue;
                  });
                },
                items: _cities.map<DropdownMenuItem<String>>((City city) {
                  return DropdownMenuItem<String>(
                    value: city.name,
                    child: Text(
                      city.name.length > 40 ? '${city.name.substring(0, city.name.length - 10)}...' : city.name,
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 65),
              TextFormField(
                controller: _emailController,
                decoration: createDecoration('Email:', icon: Icons.email),
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
              const SizedBox(height: 65),
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
                            country: _selectedCountry!,
                            city: _selectedCity!,
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
                      fixedSize: const Size(230, 80),
                      foregroundColor: Colors.deepPurple[500],
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      shadowColor: Colors.grey,
                      elevation: 6,
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

  InputDecoration createDecoration(String label, {IconData? icon}) {
    return InputDecoration(
                fillColor: Colors.white,
                filled: true,
                icon: Icon(icon, color: Colors.deepPurple), 
                labelText: label,
                labelStyle: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
                border: OutlineInputBorder( 
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                enabledBorder: OutlineInputBorder( 
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder( 
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(color: Colors.deepPurple, width: 2),
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
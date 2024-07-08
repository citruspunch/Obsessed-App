import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:obsessed_app/main.dart';
import 'package:obsessed_app/src/features/payment_finalization/domain/entities/city.dart';
import 'package:obsessed_app/src/features/payment_finalization/domain/entities/country.dart';
import 'package:obsessed_app/src/features/payment_finalization/infrastructure/location_service.dart';
import 'package:obsessed_app/src/features/product_detail/presentation/UI/widgets/return_to_home_button.dart';
import 'package:obsessed_app/src/features/user_account/presentation/UI/screens/login_screen.dart';
import 'package:obsessed_app/src/features/user_account/presentation/UI/widgets/avatar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final _usernameController = TextEditingController();
  final _genderController = TextEditingController();
  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final LocationService _locationService = LocationService();

  List<Country> _countries = [];
  String? _selectedCountry;
  List<City> _cities = [];
  String? _selectedCity;

  String? _avatarUrl;
  var _loading = true;

  Future<void> _getProfile() async {
    setState(() {
      _loading = true;
    });

    try {
      final userId = supabase.auth.currentSession!.user.id;
      final data =
          await supabase.from('profiles').select().eq('id', userId).single();
      _usernameController.text = (data['username'] ?? '') as String;
      _nameController.text = (data['name'] ?? '') as String;
      _lastNameController.text = (data['last_name'] ?? '') as String;
      _selectedCountry = (data['country'] ?? '') as String;
      _selectedCity = (data['city'] ?? '') as String;
      _genderController.text = (data['gender'] ?? '') as String;
      _avatarUrl = (data['avatar_url'] ?? '') as String;
    } on PostgrestException catch (error) {
      if (mounted) context.showSnackBar(error.message, isError: true);
    } catch (error) {
      if (mounted) {
        context.showSnackBar('Unexpected error occurred', isError: true);
      }
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  Future<void> _updateProfile() async {
    setState(() {
      _loading = true;
    });
    final userName = _usernameController.text.trim();
    final name = _nameController.text.trim();
    final lastName = _lastNameController.text.trim();
    final gender = _genderController.text.trim();
    final user = supabase.auth.currentUser;
    final updates = {
      'id': user!.id,
      'username': userName,
      'name': name,
      'last_name': lastName,
      'country': _selectedCountry,
      'city': _selectedCity,
      'gender' : gender,
      'avatar_url': _avatarUrl,
      'updated_at': DateTime.now().toIso8601String(),
    };
    try {
      await supabase.from('profiles').upsert(updates);
      if (mounted) {
        context.showSnackBar('Successfully updated profile!');
        Navigator.of(context).pop();
      }
    } on PostgrestException catch (error) {
      if (mounted) context.showSnackBar(error.message, isError: true);
    } catch (error) {
      if (mounted) {
        context.showSnackBar('Unexpected error occurred', isError: true);
      }
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  Future<void> _signOut() async {
    try {
      await supabase.auth.signOut();
    } on AuthException catch (error) {
      if (mounted) context.showSnackBar(error.message, isError: true);
    } catch (error) {
      if (mounted) {
        context.showSnackBar('Unexpected error occurred', isError: true);
      }
    } finally {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      }
    }
  }

  void _loadCountries([String? selectedCountryFromDb]) async {
    try {
      List<Country> countries = await _locationService.getCountries();
      if (countries.isNotEmpty) {
        setState(() {
          _countries = countries;
          // Verifica si el país obtenido de la base de datos está en la lista de países cargados
          _selectedCountry = selectedCountryFromDb != null && countries.any((country) => country.name == selectedCountryFromDb)
              ? selectedCountryFromDb
              : countries.first.name;
        });
      }
    } catch (e) {
      throw Exception('Error loading countries: $e');
    }
  }

  void _loadCities(String countryName, [String? selectedCityFromDb]) async {
    try {
      List<City> cities = await _locationService.getCities(countryName);
      setState(() {
        _cities = cities;
        // Verifica si la ciudad obtenida de la base de datos está en la lista de ciudades cargadas
        _selectedCity = selectedCityFromDb != null && cities.any((city) => city.name == selectedCityFromDb)
            ? selectedCityFromDb
            : cities.isNotEmpty ? cities.first.name : null;
      });
    } catch (e) {
      setState(() {
        _cities = [];
        _selectedCity = 'No cities Available';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _initializeProfileAndCountries();
  }

  Future<void> _initializeProfileAndCountries() async {
    await _getProfile();
    _loadCountries(_selectedCountry);
    _loadCities(_selectedCountry!, _selectedCity);
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _genderController.dispose();
    _nameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: true,
        leading: const ReturnToHomeButton(),
        title: Text('Profile', style: GoogleFonts.poppins(
          fontSize: 25,
          fontWeight: FontWeight.w600,
        )),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
        children: [
          Avatar( imageUrl: _avatarUrl, onUpload: (imageUrl){
            setState(() {
              _avatarUrl = imageUrl;
            });
          }),
          TextFormField(
            controller: _usernameController,
            decoration: createDecoration('User Name:'),
            style: GoogleFonts.poppins(
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 30),
          TextFormField(
            controller: _nameController,
            decoration: createDecoration('Name:'),
            style: GoogleFonts.poppins(
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 30),
          TextFormField(
            controller: _lastNameController,
            decoration: createDecoration('Last Name:'),
            style: GoogleFonts.poppins(
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 30),
          DropdownButtonFormField<String>(
            value: _selectedCountry,
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
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
          const SizedBox(height: 30),
          DropdownButtonFormField<String>(
            value: _selectedCity,
            decoration: InputDecoration(
              fillColor: Colors.white, 
              filled: true,
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
          const SizedBox(height: 30),
          DropdownButtonFormField<String>(
            value: _genderController.text.isEmpty ? null : _genderController.text,
            decoration: InputDecoration(
              fillColor: Colors.white, 
              filled: true,
              labelText: 'Gender:',
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
            items: [
              DropdownMenuItem<String>(
                value: 'Male',
                child: Text(
                  'Male', 
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                  )),
              ),
              DropdownMenuItem<String>(
                value: 'Female',
                child: Text('Female', style: GoogleFonts.poppins(
                    fontSize: 15,
                  )),
              ),
            ],
            onChanged: (value) {
              if (value != null) {
                _genderController.text = value;
              }
            },
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: _loading ? null : _updateProfile,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            ),
            child: Text(
              _loading ? 'Saving...' : 'Update', 
              style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)
            ),
          ),
          const SizedBox(height: 18),
          TextButton(onPressed: _signOut, child: const Text('Sign Out', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600))),
        ],
      ),
    );
  }
  InputDecoration createDecoration(String label, {IconData? icon}) {
    return InputDecoration(
                fillColor: Colors.white,
                filled: true,
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
}
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:obsessed_app/main.dart';
import 'package:obsessed_app/src/features/product_detail/presentation/UI/widgets/return_to_home_button.dart';
import 'package:obsessed_app/src/features/user_account/presentation/UI/widgets/info_card.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  String? _username;
  String? _name;
  String? _lastName;
  String? _city;
  String? _country;
  String? _gender;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    setState(() {
      _loading = true;
    });

    try {
      final userId = supabase.auth.currentSession!.user.id;
      final data =
          await supabase.from('profiles').select().eq('id', userId).single();
      _username = (data['username'] ?? '') as String;
      _country = (data['country'] ?? '') as String;
      _gender = (data['gender'] ?? '') as String;
      _name = (data['name'] ?? '') as String;
      _lastName = (data['last_name'] ?? '') as String;
      _city = (data['city'] ?? '') as String;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: true,
        leading: const ReturnToHomeButton(),
        title: Text('User', style: GoogleFonts.poppins(
          fontSize: 25,
          fontWeight: FontWeight.w600,
        )),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            InfoCard(
              title: 'Username',
              englishText: _username,
              icon: FeatherIcons.globe,
              titleSize: 23,
              iconSize: 25,
            ),
            const SizedBox(height: 8),
            InfoCard(
              title: 'Name',
              englishText: _name,
              icon: FeatherIcons.user,
              titleSize: 23,
              iconSize: 25,
            ),
            const SizedBox(height: 8),
            InfoCard(
              title: 'Last Name',
              englishText: _lastName,
              icon: Icons.person,
              titleSize: 23,
              iconSize: 25,
            ),
            const SizedBox(height: 8),
            InfoCard(
              title: 'Country',
              englishText: _country,
              icon: FeatherIcons.flag,
              titleSize: 23,
              iconSize: 25,
            ),
            const SizedBox(height: 8),
            InfoCard(
              title: 'City',
              englishText: _city,
              icon: FeatherIcons.mapPin,
              titleSize: 23,
              iconSize: 25,
            ),
            const SizedBox(height: 8),
            InfoCard(
              title: 'Gender',
              englishText: _gender,
              icon: FeatherIcons.feather,
              titleSize: 23,
              iconSize: 25,
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}



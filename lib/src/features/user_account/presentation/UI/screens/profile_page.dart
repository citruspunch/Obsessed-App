import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:obsessed_app/main.dart';
import 'package:obsessed_app/src/features/product_detail/presentation/UI/widgets/return_to_home_button.dart';
import 'package:obsessed_app/src/features/user_account/presentation/UI/screens/edit_account_page.dart';
import 'package:obsessed_app/src/features/user_account/presentation/UI/screens/login_screen.dart';
import 'package:obsessed_app/src/features/user_account/presentation/UI/screens/obsessed_info.dart';
import 'package:obsessed_app/src/features/user_account/presentation/UI/screens/purchase_history.dart';
import 'package:obsessed_app/src/features/user_account/presentation/UI/screens/shipping_policies.dart';
import 'package:obsessed_app/src/features/user_account/presentation/UI/screens/user.dart';
import 'package:obsessed_app/src/features/user_account/presentation/UI/widgets/profile_menu.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? _username;
  String? _avatarUrl;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        toolbarHeight: 80,
        centerTitle: true,
        leading: const Padding(
          padding: EdgeInsets.only(left: 11.0, bottom: 2.0),
          child: ReturnToHomeButton(),
        ),
        title: Text('Profile',
            style: GoogleFonts.poppins(
              fontSize: 25,
              fontWeight: FontWeight.w600,
            )),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 25),
                  Center(
                    child: ClipOval(
                      child: _avatarUrl == null || _avatarUrl!.isEmpty
                          ? Container(
                              width: 170,
                              height: 170,
                              color: Colors.grey,
                              child: const Icon(Icons.person,
                                  size: 80, color: Colors.white),
                            )
                          : Image.network(
                              _avatarUrl!,
                              width: 170,
                              height: 170,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(_username!,
                      style: GoogleFonts.poppins(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                      )),
                  Text(
                      Supabase.instance.client.auth.currentSession!.user.email!,
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      )),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context)
                            .push(_createRoute())
                            .then((_) => _loadProfile());
                      },
                      child: Text('Edit Profile',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          )),
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Divider(thickness: 0.7),
                  const SizedBox(height: 20),
                  ProfileMenuWidget(
                    title: 'User',
                    icon: FeatherIcons.user,
                    textColor: Colors.black,
                    onTap: () {
                      animate(context, const UserScreen());
                    },
                  ),
                  ProfileMenuWidget(
                    title: 'Purchase History',
                    icon: Icons.wallet_rounded,
                    textColor: Colors.black,
                    onTap: () {
                      animate(context, const PurchaseHistory());
                    },
                  ),
                  ProfileMenuWidget(
                    title: 'Shipping Policies',
                    icon: Icons.local_shipping,
                    textColor: Colors.black,
                    onTap: () {
                      animate(context, const ShippingPolicies());
                    },
                  ),
                  const SizedBox(height: 20),
                  const Divider(thickness: 0.7),
                  const SizedBox(height: 20),
                  ProfileMenuWidget(
                    title: 'About Obsessed',
                    icon: Icons.info_outline,
                    textColor: Colors.black,
                    isBold: true,
                    onTap: () {
                      animate(context, const ObsessedInfoScreen());
                    },
                  ),
                  ProfileMenuWidget(
                    title: 'Logout',
                    icon: FeatherIcons.logOut,
                    onTap: _signOut,
                    textColor: Colors.red,
                    endIcon: false,
                    isBold: true,
                    isLogout: true,
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
    );
  }

  void animateTransition(BuildContext context, Widget page) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 400),
      ),
    );
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const AccountPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  // Método para navegar con animación
  void animate(BuildContext context, Widget page) {
    Navigator.of(context).push(PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);
        return SlideTransition(
          position: offsetAnimation,
          child: page,
        );
      },
      transitionDuration: const Duration(milliseconds: 500),
    ));
  }
}

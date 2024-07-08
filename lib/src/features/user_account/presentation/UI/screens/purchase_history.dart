import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:obsessed_app/main.dart';
import 'package:obsessed_app/src/features/cart/presentation/UI/widgets/no_products_widget.dart';
import 'package:obsessed_app/src/features/product_detail/presentation/UI/widgets/return_to_home_button.dart';
import 'package:obsessed_app/src/features/user_account/presentation/UI/widgets/info_card.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PurchaseHistory extends StatefulWidget {
  const PurchaseHistory({super.key});

  @override
  State<PurchaseHistory> createState() => _PurchaseHistoryState();
}

class _PurchaseHistoryState extends State<PurchaseHistory> {
  late Future<List<dynamic>> _purchases;

  @override
  void initState() {
    super.initState();
    _purchases = _fetchPurchases();
  }

  Future<List<dynamic>> _fetchPurchases() async {
    try {
      final userId = supabase.auth.currentSession!.user.id;
      final data = await supabase.from('profiles').select().eq('id', userId).single();
      if (data['purchases'] is List) {
        return data['purchases'] as List<dynamic>;
      }
    } on PostgrestException catch (error) {
      if (mounted) context.showSnackBar(error.message, isError: true);
    } catch (error) {
      if (mounted) context.showSnackBar('Unexpected error occurred', isError: true);
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: true,
        leading: const ReturnToHomeButton(),
        title: Text('Purchases', style: GoogleFonts.poppins(
          fontSize: 25,
          fontWeight: FontWeight.w600,
        )),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _purchases,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final purchases = snapshot.data!;
            if (purchases.isEmpty) {
              return const NoProductsWidget(backToHome: false, text: 'No purchases found.');
            }
            return SingleChildScrollView(
              child: Column(
                children: purchases.map<Widget>((purchase) {
                  DateTime date = DateTime.parse(purchase['date']);
                  String formattedDate = DateFormat('yyyy-MM-dd – HH:mm').format(date);
                  return InfoCard(
                    title: 'Transaction at: $formattedDate',
                    isPurchaseHistory: true,
                    orderId: purchase['orderId'],
                    products: purchase['products'],
                    total: purchase['totalAmount'],
                    icon: FeatherIcons.calendar,
                  );
                }).toList(),
              ),
            );
          } else {
            return const NoProductsWidget(backToHome: false, text: 'No purchases found.');
          }
        },
      ),
    );
  }
}
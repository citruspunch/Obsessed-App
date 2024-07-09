import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    super.key, 
    required this.title, 
    required this.icon, 
    required this.onTap, 
    this.endIcon = true, 
    this.isBold = false,
    this.textColor,
    this.isLogout = false,
  });

  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final bool endIcon;
  final Color? textColor;
  final bool isBold;
  final bool isLogout;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: isLogout ? Colors.redAccent.withOpacity(0.2) : Colors.deepPurple.withOpacity(0.2),
            borderRadius: BorderRadius.circular(100),
          ),
          child: Icon(icon, color: isLogout ? Colors.red : Colors.deepPurple[800], size: 27.0),
        ),
        title: Text(title, style: GoogleFonts.poppins(
          fontSize: 19,
          fontWeight: isBold ? FontWeight.w600 : FontWeight.w500,
          color: textColor,
        )),
        trailing: endIcon ? Container(
          width: 45,
          height: 45,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(100),
          ),
          child: const Icon(Icons.arrow_forward_ios_outlined, size: 21.0, color: Colors.grey),
        ) : null,
      ),
    );
  }
}
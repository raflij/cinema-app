import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Notification',
            style: GoogleFonts.aBeeZee(fontSize: 20, color: Colors.black),
          ),
          backgroundColor: Colors.white),
      body: Center(
          child: Text(
        "Tidak ada notifikasi",
        style: GoogleFonts.aBeeZee(fontSize: 18, fontWeight: FontWeight.w500),
      )),
    );
  }
}

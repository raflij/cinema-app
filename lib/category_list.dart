

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryList extends StatelessWidget {
  final List<String> buttonNames = ['horror', 'romance', 'comedy', 'action'];
  final Color buttonColor = const Color(0xFF7C3AED);

  CategoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: buttonNames.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(12),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24)
                ),
                backgroundColor: index == 0 ? buttonColor : const Color(0xFF404040),
                padding: const EdgeInsets.all(16.0),
              ),
              child: Text(
                buttonNames[index],
                style: 
                  GoogleFonts.aBeeZee(fontSize: 20, color: Colors.white),
                
              ),
            ),
          );
        },
      ),
    );
  }
}

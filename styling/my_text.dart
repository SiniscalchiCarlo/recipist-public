import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyText extends StatelessWidget {
  final String text;
  final double size;
  const MyText({super.key, required this.text, required this.size});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: GoogleFonts.dmSerifText(
          fontSize: size,
          color: Theme.of(context).colorScheme.inversePrimary,
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyText extends StatelessWidget {
  final String text;
  final double? size;
  final Color? color;
  final bool? bold;
  const MyText(
      {super.key, required this.text, this.size, this.color, this.bold});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: GoogleFonts.outfit(
            fontSize: size ?? 16,
            color: color != null ? color : Colors.black,
            fontWeight: bold == true ? FontWeight.bold : FontWeight.normal));
  }
}

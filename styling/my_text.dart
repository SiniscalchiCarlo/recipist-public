import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyText extends StatelessWidget {
  final String text;
  final double? size;
  final Color? color;
  const MyText({super.key, required this.text, this.size, this.color});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: GoogleFonts.outfit(
          fontSize: size ?? 16,
          color: color != null
              ? color
              : Theme.of(context).colorScheme.inversePrimary,
        ));
  }
}

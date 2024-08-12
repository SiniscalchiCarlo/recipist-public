import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void printWarning(String text) {
  print('\x1B[33m$text\x1B[0m');
}

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final int maxLength;
  final double? size;
  final Function(String)? onChanged;
  const MyTextField(
      {super.key,
      required this.controller,
      required this.maxLength,
      this.size,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: maxLength * (size ?? 18) * 0.6, // Set the maximum width here
      ),
      child: TextField(
        onChanged: onChanged,
        maxLength: maxLength,
        controller: controller,
        style: GoogleFonts.dmSerifText(
          fontSize: size ?? 20,
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
        decoration: InputDecoration(counterText: ""),
      ),
    );
  }
}
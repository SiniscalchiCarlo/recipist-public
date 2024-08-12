import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyNumberField extends StatelessWidget {
  final TextEditingController controller;
  final int maxLength;
  final double? size;
  final Function(String)? onChanged;
  const MyNumberField(
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
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        controller: controller,
        style: GoogleFonts.dmSerifText(
          fontSize: size ?? 18,
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
        decoration: InputDecoration(counterText: ""),
      ),
    );
  }
}

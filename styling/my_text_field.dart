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
  final double? maxWidth;
  final String? hintText;
  const MyTextField(
      {super.key,
      required this.controller,
      required this.maxLength,
      this.size,
      this.onChanged,
      this.maxWidth,
      this.hintText});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 4),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade500),
          borderRadius: BorderRadius.circular(10)),
      constraints: BoxConstraints(
        maxWidth: maxWidth ??
            (maxLength * (size ?? 18) * 0.6), // Set the maximum width here
      ),
      child: Container(
        height: 30,
        child: TextField(
          onChanged: onChanged,
          maxLength: maxLength,
          controller: controller,
          style: GoogleFonts.outfit(
            fontSize: size ?? 16,
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
          decoration: InputDecoration(
              counterText: "",
              border: InputBorder.none,
              hintText: hintText,
              contentPadding: EdgeInsets.only(bottom: 10),
              hintStyle: TextStyle(color: Colors.grey.shade400)),
        ),
      ),
    );
  }
}

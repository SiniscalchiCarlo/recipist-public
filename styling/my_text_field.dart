import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final int maxLength;
  final double size;
  const MyTextField(
      {super.key,
      required this.controller,
      required this.maxLength,
      required this.size});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      margin: EdgeInsets.only(top: 20, left: 0, right: 25, bottom: 0),
      child: TextField(
        maxLength: maxLength,
        controller: controller,
        style: GoogleFonts.dmSerifText(
          fontSize: size,
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
        decoration: InputDecoration(counterText: ""),
      ),
    ));
  }
}

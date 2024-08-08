import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class MyNumberInput extends StatelessWidget {
  final TextEditingController controller;

  const MyNumberInput({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      height: 30,
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'^[0-9]*[.,]?[0-9]*')),
        ],
        style: GoogleFonts.dmSerifText(
          fontSize: 20,
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(5),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}

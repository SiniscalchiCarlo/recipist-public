import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void printWarning(String text) {
  print('\x1B[33m$text\x1B[0m');
}

class MyNumberField extends StatelessWidget {
  final TextEditingController controller;
  final int maxLength;
  final double? size;
  final Function(String)? onChanged;
  final double? maxWidth;
  final String? hintText;
  final bool? onlyLine;
  const MyNumberField(
      {super.key,
      required this.controller,
      required this.maxLength,
      this.size,
      this.onChanged,
      this.maxWidth,
      this.hintText,
      this.onlyLine});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 4),
      decoration: onlyLine != true
          ? BoxDecoration(
              border: Border.all(color: Colors.grey.shade500),
              borderRadius: BorderRadius.circular(10))
          : null,
      constraints: BoxConstraints(
        maxWidth: maxWidth ??
            (maxLength * (size ?? 18) * 0.8), // Set the maximum width here
      ),
      child: Container(
        height: 30,
        child: Theme(
          data: ThemeData(
              textSelectionTheme: TextSelectionThemeData(
                  cursorColor: Colors.black,
                  selectionColor: Colors.orange.shade100,
                  selectionHandleColor: Colors.orange.shade400)),
          child: TextField(
            onChanged: onChanged,
            maxLength: maxLength,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            controller: controller,
            style: GoogleFonts.outfit(
              fontSize: size ?? 16,
              color: Colors.black,
            ),
            decoration: InputDecoration(
                counterText: "",
                border: onlyLine != true
                    ? InputBorder.none
                    : UnderlineInputBorder(),
                hintText: hintText,
                contentPadding: EdgeInsets.only(bottom: 15),
                hintStyle: TextStyle(color: Colors.grey.shade400)),
          ),
        ),
      ),
    );
  }
}

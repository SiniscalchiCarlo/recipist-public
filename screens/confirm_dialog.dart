import 'package:flutter/material.dart';
import 'package:smart_shopping_list/styling/my_text.dart';

class ConfirmDialog extends StatelessWidget {
  final VoidCallback callBack;
  final String warning;
  final String buttonText;
  final Color buttonColor;

  const ConfirmDialog(
      {Key? key,
      required this.callBack,
      required this.warning,
      required this.buttonText,
      required this.buttonColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: MyText(text: warning),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child:
              MyText(text: 'Cancel', color: Colors.grey.shade500, bold: false),
        ),
        TextButton(
          onPressed: () {
            callBack();
          },
          child: MyText(text: buttonText, color: buttonColor, bold: true),
        ),
      ],
    );
  }
}

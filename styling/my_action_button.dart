import 'package:flutter/material.dart';

class MyActionButton extends StatelessWidget {
  final Function()? onPressed;
  final String text;
  final Color? color;
  const MyActionButton(
      {super.key, required this.onPressed, required this.text, this.color});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: color != null ? color : Colors.orange,
      onPressed: onPressed,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(100))),
      child: Text(
        text,
        style: TextStyle(color: Colors.grey.shade200, fontSize: 25),
      ),
    );
  }
}

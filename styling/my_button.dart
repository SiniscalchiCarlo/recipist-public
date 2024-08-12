import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Widget child;
  final double? size;
  final Function onPressed;
  const MyButton(
      {super.key, required this.child, this.size, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed(),
      child: child,
    );
  }
}

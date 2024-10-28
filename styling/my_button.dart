import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Widget child;
  final double? size;
  final Function onPressed;
  final Color? color;
  const MyButton({
    super.key,
    required this.child,
    this.size,
    required this.onPressed,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed(),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        decoration: BoxDecoration(
            color: color != null ? color : Colors.orange,
            borderRadius: BorderRadius.circular(10)),
        child: child,
      ),
    );
  }
}

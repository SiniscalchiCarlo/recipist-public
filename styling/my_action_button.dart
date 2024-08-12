import 'package:flutter/material.dart';

class MyActionButton extends StatelessWidget {
  final Function()? onPressed;
  final String text;
  const MyActionButton(
      {super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Theme.of(context).colorScheme.primary,
      onPressed: onPressed,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(100))),
      child: Text(
        text,
        style: TextStyle(
            color: Theme.of(context).colorScheme.inversePrimary, fontSize: 25),
      ),
    );
  }
}

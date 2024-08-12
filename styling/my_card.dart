import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class MyCard extends StatelessWidget {
  final Widget child;
  final Function() onTap;
  const MyCard({super.key, required this.child, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
            child: ListTile(title: child),
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(8)),
            margin: EdgeInsets.only(top: 10, left: 25, right: 25)));
  }
}

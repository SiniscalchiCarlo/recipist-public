import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShoppingList extends StatefulWidget {
  const ShoppingList({super.key});

  @override
  State<ShoppingList> createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Shopping List',
                style: GoogleFonts.dmSerifText(
                  fontSize: 48,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ))),
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Text('body'));
  }
}

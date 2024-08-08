import 'package:flutter/material.dart';
import 'package:smart_shopping_list/styling/my_text.dart';

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
            title: MyText(
          text: "List",
          size: 48,
        )),
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Text('body'));
  }
}

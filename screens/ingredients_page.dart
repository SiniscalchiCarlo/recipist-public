import 'package:flutter/material.dart';
import 'package:smart_shopping_list/styling/my_text.dart';

class IngredientsPage extends StatefulWidget {
  const IngredientsPage({super.key});

  @override
  State<IngredientsPage> createState() => _IngredientsPageState();
}

class _IngredientsPageState extends State<IngredientsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: MyText(text: "Ingredients", size: 48)),
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Text('body'));
  }
}

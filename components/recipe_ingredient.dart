import 'package:flutter/material.dart';
import 'package:smart_shopping_list/models/Ingredient.dart';
import 'package:smart_shopping_list/styling/my_number_input.dart';
import 'package:smart_shopping_list/styling/my_text_field.dart';

class RecipeIngredient extends StatefulWidget {
  final Ingredient ingredient;
  const RecipeIngredient({super.key, required this.ingredient});

  @override
  State<RecipeIngredient> createState() => _RecipeIngredientState();
}

class _RecipeIngredientState extends State<RecipeIngredient> {
  String bullet = "\u2022 ";

  late TextEditingController _nameController;
  late TextEditingController _numberController;
  late TextEditingController _unitController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.ingredient.name);
    _numberController =
        TextEditingController(text: widget.ingredient.quantity.toString());
    _unitController = TextEditingController(text: widget.ingredient.unit);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.radio_button_unchecked,
          size: 10,
        ),
        SizedBox(
            width: 200,
            child: MyTextField(
                controller: _nameController, maxLength: 15, size: 20)),
        MyNumberInput(controller: _numberController),
        SizedBox(width: 10),
        SizedBox(
            width: 50,
            child: MyTextField(
                controller: _unitController, maxLength: 3, size: 20))
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:smart_shopping_list/models/Ingredient.dart';
import 'package:smart_shopping_list/models/Recipe.dart';
import 'package:smart_shopping_list/styling/my_check_bok.dart';
import 'package:smart_shopping_list/styling/my_drop_down.dart';
import 'package:smart_shopping_list/styling/my_number_input.dart';
import 'package:smart_shopping_list/styling/my_text_field.dart';

class Recipeingredient extends StatefulWidget {
  final Function onChange;
  final Ingredient ingredient;
  final bool check;
  const Recipeingredient(
      {super.key,
      required this.onChange,
      required this.ingredient,
      required this.check});

  @override
  State<Recipeingredient> createState() => _RecipeingredientState();
}

class _RecipeingredientState extends State<Recipeingredient> {
  late TextEditingController _nameController;
  late TextEditingController _unitController;
  late TextEditingController _quantityController;
  late String selectedUnit;
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.ingredient.name);
    _unitController = TextEditingController(text: widget.ingredient.unit);
    _quantityController =
        TextEditingController(text: widget.ingredient.quantity.toString());
    selectedUnit = widget.ingredient.unit;
  }

  @override
  void didUpdateWidget(covariant Recipeingredient oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Check if the new widget's data is different from the old one
    _nameController = TextEditingController(text: widget.ingredient.name);
    _unitController = TextEditingController(text: widget.ingredient.unit);
    _quantityController =
        TextEditingController(text: widget.ingredient.quantity.toString());
    selectedUnit = widget.ingredient.unit;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _quantityController.dispose();
    _unitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 0, left: 5, right: 0, bottom: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          widget.check
              ? MyCheckBok()
              : Icon(
                  Icons.circle,
                  size: 12,
                ),
          SizedBox(width: 5),
          //INGREDIENT NAME
          MyTextField(
              controller: _nameController,
              maxLength: 20,
              maxWidth: 130,
              hintText: "Ingredient",
              onChanged: (value) => widget.onChange(
                  widget.ingredient,
                  _nameController.text,
                  _quantityController.text,
                  _unitController.text)),
          SizedBox(width: 15),
          //INGREDIENT QUANTIY
          MyNumberField(
            controller: _quantityController,
            maxLength: 4,
            onChanged: (value) => widget.onChange(
                widget.ingredient,
                _nameController.text,
                _quantityController.text,
                _unitController.text),
          ),
          SizedBox(width: 10),
          //INGREDIENT UNIT
          MyDropDown(
            items: ['unit', 'g', 'kg', 'ml', 'l'],
            selectedValue: selectedUnit,
            onChanged: (newValue) {
              setState(() {
                selectedUnit = newValue;
              });
              widget.onChange(widget.ingredient, _nameController.text,
                  _quantityController.text, selectedUnit);
            },
          ),
          // MyTextField(
          //   controller: _unitController,
          //   maxLength: 3,
          //   size: 18,
          //   onChanged: (value) => widget.onChange(
          //       widget.ingredient,
          //       _nameController.text,
          //       _quantityController.text,
          //       _unitController.text),
          // )
        ],
      ),
    );
  }
}

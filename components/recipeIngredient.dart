import 'package:flutter/material.dart';
import 'package:smart_shopping_list/models/Ingredient.dart';
import 'package:smart_shopping_list/models/Recipe.dart';
import 'package:smart_shopping_list/styling/my_button.dart';
import 'package:smart_shopping_list/styling/my_check_bok.dart';
import 'package:smart_shopping_list/styling/my_drop_down.dart';
import 'package:smart_shopping_list/styling/my_number_input.dart';
import 'package:smart_shopping_list/styling/my_text_field.dart';

class Recipeingredient extends StatefulWidget {
  final Function onChange;
  final Function deleteIngredient;
  final Ingredient ingredient;
  final bool check;
  final int index;
  const Recipeingredient({
    super.key,
    required this.onChange,
    required this.ingredient,
    required this.check,
    required this.deleteIngredient,
    required this.index,
  });

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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          widget.check
              ? MyCheckBok(
                  initialValue: widget.ingredient.checked,
                  onChanged: (bool? newValue) {
                    setState(() {
                      widget.ingredient.checked =
                          newValue ?? false; // Update ingredient.checked
                    });
                  },
                )
              : SizedBox.shrink(),
          //INGREDIENT NAME
          MyTextField(
              controller: _nameController,
              maxLength: 20,
              maxWidth: 120,
              hintText: "Ingredient",
              onChanged: (value) => widget.onChange(
                  widget.ingredient,
                  _nameController.text,
                  _quantityController.text,
                  _unitController.text)),
          SizedBox(width: 5),
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
          SizedBox(width: 5),
          //INGREDIENT UNIT
          MyDropDown(
            items: ['unit', 'g', 'kg', 'ml', 'l', 'tbsp', 'tsp', 'need'],
            selectedValue: selectedUnit,
            onChanged: (newValue) {
              setState(() {
                selectedUnit = newValue;
              });
              widget.onChange(widget.ingredient, _nameController.text,
                  _quantityController.text, selectedUnit);
            },
          ),
          SizedBox(width: 3),
          //DELETE BUTTON
          GestureDetector(
            onTap: () => widget.deleteIngredient(widget.index),
            child: Container(
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.only(right: 7),
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10)),
                child: Icon(
                  Icons.delete,
                  color: Colors.grey.shade400,
                )),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:smart_shopping_list/models/Ingredient.dart';
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
  late TextEditingController nameController;
  late TextEditingController unitController;
  late TextEditingController quantityController;
  late String selectedUnit;
  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(text: widget.ingredient.name);
    unitController = TextEditingController(text: widget.ingredient.unit);
    quantityController =
        TextEditingController(text: widget.ingredient.quantity.toString());
    selectedUnit = widget.ingredient.unit;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5, left: 0, right: 0, bottom: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          widget.check
              ? MyCheckBok()
              : Icon(
                  Icons.circle,
                  size: 12,
                ),
          SizedBox(width: 5),
          //INGREDIENT NAM
          MyTextField(
              controller: nameController,
              maxLength: 20,
              onChanged: (value) => widget.onChange(
                  widget.ingredient,
                  nameController.text,
                  quantityController.text,
                  unitController.text)),
          SizedBox(width: 15),
          //INGREDIENT QUANTIY
          MyNumberField(
            controller: quantityController,
            maxLength: 4,
            onChanged: (value) => widget.onChange(
                widget.ingredient,
                nameController.text,
                quantityController.text,
                unitController.text),
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
              widget.onChange(widget.ingredient, nameController.text,
                  quantityController.text, selectedUnit);
            },
          ),
          // MyTextField(
          //   controller: unitController,
          //   maxLength: 3,
          //   size: 18,
          //   onChanged: (value) => widget.onChange(
          //       widget.ingredient,
          //       nameController.text,
          //       quantityController.text,
          //       unitController.text),
          // )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:smart_shopping_list/components/recipeIngredient.dart';
import 'package:smart_shopping_list/models/Ingredient.dart';
import 'package:smart_shopping_list/styling/my_action_button.dart';
import 'package:smart_shopping_list/styling/my_button.dart';
import 'package:smart_shopping_list/styling/my_text.dart';
import 'package:smart_shopping_list/styling/my_text_field.dart';
import 'package:smart_shopping_list/models/Recipe.dart';
import 'package:flutter/services.dart';

void printWarning(String text) {
  print('\x1B[33m$text\x1B[0m');
}

class EditRecipe extends StatefulWidget {
  final Recipe? recipe;
  const EditRecipe({super.key, required this.recipe});

  @override
  State<EditRecipe> createState() => _EditRecipeState();
}

class _EditRecipeState extends State<EditRecipe> {
  late TextEditingController _nameController;
  late TextEditingController _notesController;
  late Recipe newRecipe;

  @override
  void initState() {
    super.initState();

    newRecipe = widget.recipe ??
        Recipe(
            name: "",
            notes: "",
            ingredients: [Ingredient(name: "", quantity: "0", unit: "unit")],
            nperson: 1);
    _nameController = TextEditingController(text: newRecipe.name);
    _notesController = TextEditingController(text: newRecipe.notes);
  }

  void onChange(ingredient, name, quantity, unit) {
    ingredient.name = name;
    ingredient.quantity = quantity;
    ingredient.unit = unit;
  }

  void saveRecipe() {
    final result = Recipe(
        name: _nameController.text,
        notes: _notesController.text,
        nperson: 2,
        ingredients: newRecipe.ingredients);
    Navigator.pop(context, result);
  }

  void deleteRecipe() {
    final result = null;
    Navigator.pop(context, result);
  }

  void addIngredient() {
    setState(() {
      newRecipe.ingredients
          .add(Ingredient(name: "", quantity: "0", unit: "unit"));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Column(children: [
          //RECIPE TITLE AND IMAGE
          Row(
            children: [
              Icon(Icons.image),
              MyTextField(controller: _nameController, maxLength: 15, size: 30),
              SizedBox(
                width: 20,
              ),
              MyButton(
                  child: Icon(
                    Icons.check,
                    color: Colors.green,
                    size: 30,
                  ),
                  onPressed: saveRecipe),
              SizedBox(
                width: 10,
              ),
              MyButton(
                  child: Icon(
                    Icons.delete_forever,
                    color: Colors.red,
                    size: 30,
                  ),
                  onPressed: deleteRecipe),
            ],
          ),

          SizedBox(
            height: 30,
          ),
          MyText(text: "Ingredients", size: 25),
          // RECIPE INGREDIENT NAMES
          Expanded(
              child: ListView.builder(
                  itemCount: newRecipe.ingredients.length,
                  itemBuilder: (context, index) {
                    return Recipeingredient(
                      ingredient: newRecipe.ingredients[index],
                      onChange: onChange,
                    );
                  })),

          SizedBox(
            height: 30,
          ),
          MyActionButton(onPressed: addIngredient, text: "+"),
          SizedBox(
            height: 40,
          ),
          MyText(text: "Notes", size: 25),
          Container(
            margin: EdgeInsets.all(10),
            child: TextField(
                controller: _notesController,
                maxLines: 15, //or null
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(10.0),
                    hintText: "Enter your notes here",
                    border: OutlineInputBorder())),
          )
        ]));
  }
}

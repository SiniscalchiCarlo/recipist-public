import 'package:flutter/material.dart';
import 'package:smart_shopping_list/components/recipe_ingredient.dart';
import 'package:smart_shopping_list/models/Ingredient.dart';
import 'package:smart_shopping_list/styling/my_action_button.dart';
import 'package:smart_shopping_list/styling/my_text_field.dart';
import 'package:smart_shopping_list/models/Recipe.dart';

class EditRecipe extends StatefulWidget {
  final Recipe? recipe;
  const EditRecipe({super.key, required this.recipe});

  @override
  State<EditRecipe> createState() => _EditRecipeState();
}

class _EditRecipeState extends State<EditRecipe> {
  late TextEditingController _nameController;
  late Recipe newRecipe;
  @override
  void initState() {
    super.initState();
    newRecipe = widget.recipe ?? Recipe(name: "", ingredients: [], nperson: 1);
    _nameController = TextEditingController(text: newRecipe.name);
  }

  void addIngredient() {
    print("ADD");
    setState(() {
      newRecipe.ingredients
          .add(Ingredient(name: "dsfaasdf", quantity: 1, unit: "g"));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Column(
          children: [
            //RECIPE TITLE AND IMAGE
            Row(
              children: [
                Icon(Icons.image),
                MyTextField(
                    controller: _nameController, maxLength: 15, size: 48)
              ],
            ),

            // RECIPE INGREDIENT NAMES
            Expanded(
              child: ListView(
                children: newRecipe.ingredients
                    .map((ingredient) =>
                        RecipeIngredient(ingredient: ingredient))
                    .toList(),
              ),
            ),
            MyActionButton(onPressed: addIngredient),
          ],
        ));
  }
}

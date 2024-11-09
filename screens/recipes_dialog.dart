import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:smart_shopping_list/models/ListRecipe.dart';
import 'package:smart_shopping_list/models/Recipe.dart';
import 'package:smart_shopping_list/screens/edit_recipe.dart';
import 'package:smart_shopping_list/styling/my_check_bok.dart';
import 'package:smart_shopping_list/styling/my_text.dart';

class RecipesDialog extends StatefulWidget {
  final List<ListRecipe> selectedRecipes;
  const RecipesDialog({super.key, required this.selectedRecipes});

  @override
  State<RecipesDialog> createState() => _RecipesDialogState();
}

class _RecipesDialogState extends State<RecipesDialog> {
  List<int> selectedIndexes = [];
  List<Recipe> recipes =
      Hive.box<Recipe>("recipes").values.cast<Recipe>().toList();
  late List<bool> _isChecked;

  @override
  void initState() {
    super.initState();
    _isChecked = List<bool>.filled(recipes.length, false);
  }

  void saveRecipes() {
    Navigator.pop(context, widget.selectedRecipes);
  }

  void checkRecipe(value, index) {
    print("INDEX $index");

    ListRecipe lr = ListRecipe(recipe: recipes[index], nperson: 1);
    _isChecked[index] = value ?? false;
    if (_isChecked[index]) {
      // Add only if it does not already exist
      if (!widget.selectedRecipes
          .any((element) => element.recipe.name == lr.recipe.name)) {
        widget.selectedRecipes.add(lr);
      }
    } else {
      // Remove based on content
      widget.selectedRecipes
          .removeWhere((element) => element.recipe.name == lr.recipe.name);
    }

    for (var lr in widget.selectedRecipes) {
      printWarning(lr.recipe.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    //i get a list of the names of recipes (selected by the user before opening the dialog
    List<String> names =
        widget.selectedRecipes.map((value) => value.recipe.name).toList();

    return AlertDialog(
      content: Container(
        height: 500,
        width: 200,
        child: ListView.builder(
            itemCount: recipes.length,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  MyCheckBok(
                      initialValue:
                          names.contains(recipes[index].name) ? true : false,
                      onChanged: (value) => checkRecipe(value, index)),
                  MyText(text: recipes[index].name)
                ],
              );
            }),
      ),
      actions: [
        TextButton(
          child: MyText(text: 'Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: MyText(text: 'Save'),
          onPressed: () {
            saveRecipes();
          },
        ),
      ],
    );
  }
}

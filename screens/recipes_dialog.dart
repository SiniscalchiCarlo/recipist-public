import 'package:flutter/material.dart';
import 'package:smart_shopping_list/data.dart';
import 'package:smart_shopping_list/models/ShopList.dart';
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
  late List<ListRecipe> selectedRecipes;

  @override
  void initState() {
    super.initState();
    selectedRecipes = widget.selectedRecipes;
  }

  void saveRecipes() {
    Navigator.pop(context, selectedRecipes);
  }

  void checkRecipe(index) {
    ListRecipe lr = ListRecipe(recipe: recipes[index], nperson: 1);
    if (selectedRecipes.contains(lr)) {
      setState(() {
        selectedRecipes.remove(lr);
      });
    } else {
      setState(() {
        selectedRecipes.add(lr);
      });
    }

    for (var lr in selectedRecipes) {
      printWarning(lr.recipe.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    //i get a list of the names of recipes (selected by the user before opening the dialog
    List<String> names =
        selectedRecipes.map((value) => value.recipe.name).toList();

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
                      onChanged: () => checkRecipe(index)),
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

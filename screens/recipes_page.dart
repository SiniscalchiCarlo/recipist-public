import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:smart_shopping_list/components/user_app_bar.dart';
import 'package:smart_shopping_list/models/Ingredient.dart';
import 'package:smart_shopping_list/models/Recipe.dart';
import 'package:smart_shopping_list/styling/my_action_button.dart';
import 'package:smart_shopping_list/styling/my_card.dart';
import 'package:smart_shopping_list/styling/my_text.dart';
import 'package:smart_shopping_list/screens/edit_recipe.dart';
import 'package:uuid/uuid.dart';

class RecipesPage extends StatefulWidget {
  const RecipesPage({super.key});

  @override
  State<RecipesPage> createState() => _RecipesPageState();
}

class _RecipesPageState extends State<RecipesPage> {
  late Box<Recipe> recipesBox;
  late List<Recipe> recipes;

  @override
  void initState() {
    super.initState();
    recipesBox = Hive.box<Recipe>('recipes');
    recipes = recipesBox.values.cast<Recipe>().toList();
  }

  int getHighestId() {
    var keys = recipesBox.keys.cast<int>();
    var highestId = keys.isNotEmpty ? keys.reduce(max) : 0;
    return highestId;
  }

  void addRecipe() async {
    String newId = Uuid().v4().substring(0, 8);
    ;
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditRecipe(
            recipe: Recipe(
                name: "",
                notes: "",
                ingredients: [
                  Ingredient(name: "", quantity: "0", unit: "unit")
                ],
                nperson: 1,
                id: newId)),
      ),
    );
    if (result != null && result != "delete") {
      result.id = newId;
      recipesBox.put(newId, result);
      setState(() {
        recipes.add(result);
      });
    }
  }

  void modifyRecipe(index) async {
    printWarning("${recipes[index].name}");
    printWarning("${recipes[index].id}");
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditRecipe(recipe: recipes[index]),
      ),
    );
    if (result != null && result != "delete") {
      printWarning("${recipes[index].id}");
      recipesBox.put(recipes[index].id, result);
      setState(() {
        recipes[index] = result;
      });
    }

    if (result == "delete") {
      recipesBox.delete(recipes[index].id);
      setState(() {
        recipes.removeAt(index);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: UserAppBar()),
      backgroundColor: Theme.of(context).colorScheme.surface,
      floatingActionButton: MyActionButton(
        onPressed: addRecipe,
        text: "+",
      ),
      body: Column(
        children: [
          MyText(
            text: "My recipes:",
            size: 25,
          ),
          Expanded(
            child: ListView.builder(
                itemCount: recipes.length,
                itemBuilder: (BuildContext context, int index) {
                  return MyCard(
                    onTap: () => modifyRecipe(index),
                    child: Row(
                      children: [
                        recipes[index].photo != null
                            ? ClipOval(
                                child: SizedBox.fromSize(
                                  size: Size.fromRadius(15), // Image radius
                                  child: Image.file(
                                    recipes[index].photo!,
                                    fit: BoxFit
                                        .cover, // Ensures the image fills the circle
                                  ),
                                ),
                              )
                            : Icon(Icons.menu_book),
                        SizedBox(width: 10),
                        MyText(text: recipes[index].name, size: 20)
                      ],
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}

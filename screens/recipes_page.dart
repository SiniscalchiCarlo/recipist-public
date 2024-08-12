import 'package:flutter/material.dart';
import 'package:smart_shopping_list/styling/my_action_button.dart';
import 'package:smart_shopping_list/styling/my_card.dart';
import 'package:smart_shopping_list/styling/my_text.dart';
import 'package:smart_shopping_list/data.dart';
import 'package:smart_shopping_list/screens/edit_recipe.dart';

class RecipesPage extends StatefulWidget {
  const RecipesPage({super.key});

  @override
  State<RecipesPage> createState() => _RecipesPageState();
}

class _RecipesPageState extends State<RecipesPage> {
  void addRecipe() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditRecipe(recipe: null),
      ),
    );
    if (result != null) {
      setState(() {
        recipes.add(result);
      });
    }
  }

  void modifyRecipe(index) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditRecipe(recipe: recipes[index]),
      ),
    );
    if (result != null) {
      setState(() {
        recipes[index] = result;
      });
    } else {
      setState(() {
        print(recipes);
        recipes.removeAt(index);
        print(recipes);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: MyText(
        text: "Recipes",
        size: 48,
      )),
      backgroundColor: Theme.of(context).colorScheme.surface,
      floatingActionButton: MyActionButton(
        onPressed: addRecipe,
        text: "+",
      ),
      body: ListView.builder(
          itemCount: recipes.length,
          itemBuilder: (BuildContext context, int index) {
            return MyCard(
              onTap: () => modifyRecipe(index),
              child: Row(
                children: [
                  Icon(Icons.image),
                  SizedBox(width: 10),
                  MyText(text: recipes[index].name, size: 20)
                ],
              ),
            );
          }),
    );
  }
}

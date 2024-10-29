import 'package:flutter/material.dart';
import 'package:smart_shopping_list/models/ShopList.dart';
import 'package:smart_shopping_list/screens/recipes_dialog.dart';
import 'package:smart_shopping_list/screens/shop%20list/other_ingredients.dart';
import 'package:smart_shopping_list/styling/my_button.dart';
import 'package:smart_shopping_list/styling/my_counter.dart';
import 'package:smart_shopping_list/styling/my_text.dart';

class RecipesScreen extends StatefulWidget {
  final String name;
  final String newId;
  const RecipesScreen({super.key, required this.name, required this.newId});

  @override
  State<RecipesScreen> createState() => _RecipesScreenState();
}

class _RecipesScreenState extends State<RecipesScreen> {
  late ShopList newList;
  final ScrollController _recipescroll = ScrollController();
  @override
  void initState() {
    super.initState();
    newList = ShopList(
        name: widget.name,
        recipes: [],
        recipesIngredients: [],
        otherIngredients: [],
        id: widget.newId,
        shared: false,
        members: []);
  }

  void deleteRecipe(int index) {
    setState(() {
      newList.recipes.removeAt(index);
    });
  }

  void addRecipe() async {
    final result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return RecipesDialog(
          selectedRecipes: newList.recipes,
        ); // Utilizza la nuova schermata del dialog
      },
    );
    if (result != null) {
      if (result != null) {
        setState(() {
          newList.recipes = result;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: SizedBox.shrink()),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MyText(
            text: "What do you want to cook?",
            size: 25,
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 100,
            margin: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade500),
                borderRadius: BorderRadius.circular(10)),
            child: Scrollbar(
              thumbVisibility: true,
              controller: _recipescroll,
              child: ListView.builder(
                  controller: _recipescroll,
                  itemCount: newList.recipes.length,
                  itemBuilder: (context, index) {
                    return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(width: 5),
                          MyText(text: newList.recipes[index].recipe.name),
                          SizedBox(width: 20),
                          MyCounter(
                            size: 20,
                            onPressed: (value) {
                              setState(() {
                                newList.recipes[index].nperson = value;
                              });
                            },
                            startValue: newList.recipes[index].nperson,
                          ),
                          SizedBox(width: 20),
                          IconButton(
                            onPressed: () => deleteRecipe(index),
                            icon: Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: Colors.orange.shade100,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.orange,
                                )),
                          )
                        ]);
                  }),
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: MyButton(
                child: MyText(
                  text: "+ Add Recipe",
                  color: Theme.of(context).colorScheme.primary,
                ),
                onPressed: addRecipe),
          ),
          SizedBox(height: 20),
          MyButton(
            child: MyText(
              text: "Next",
              color: Theme.of(context).colorScheme.primary,
            ),
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OtherIngredients(newList: newList),
                ),
              );
              Navigator.pop(context, result);
            },
          ),
        ],
      ),
    );
  }
}

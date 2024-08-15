import 'package:flutter/material.dart';
import 'package:smart_shopping_list/components/recipeIngredient.dart';
import 'package:smart_shopping_list/models/Ingredient.dart';
import 'package:smart_shopping_list/models/ShopList.dart';
import 'package:smart_shopping_list/screens/recipes_dialog.dart';
import 'package:smart_shopping_list/styling/my_button.dart';
import 'package:smart_shopping_list/styling/my_counter.dart';
import 'package:smart_shopping_list/styling/my_text.dart';
import 'package:smart_shopping_list/styling/my_text_field.dart';

class EditShopList extends StatefulWidget {
  final ShopList? shopList;
  const EditShopList({super.key, required this.shopList});

  @override
  State<EditShopList> createState() => _EditShopListState();
}

class _EditShopListState extends State<EditShopList> {
  late ShopList newList;
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    newList = widget.shopList ??
        ShopList(
          name: "",
          recipes: [],
          recipesIngredients: [],
          otherIngredients: [],
          id: -1, //temporary id will be changed when the lis tis saved
        );
    _nameController = TextEditingController(text: newList.name);
  }

  void saveList() {
    newList.name = _nameController.text;
    final result = newList;
    Navigator.pop(context, result);
  }

  void deleteList() {
    final result = null;
    Navigator.pop(context, result);
  }

  void deleteRecipe(int index) {
    setState(() {
      newList.recipes.removeAt(index);
    });
    getListIngredients();
  }

  int? findIngredient(ingredients, myIngredient) {
    int index = -1;
    for (var ingredient in ingredients) {
      index += 1;
      if (ingredient.name == myIngredient.name &&
          ingredient.unit == myIngredient.unit) {
        return index;
      }
    }
    return null;
  }

  void getListIngredients() {
    List<Ingredient> ingredients = [];
    for (var lrecipe in newList.recipes) {
      int nPersons =
          lrecipe.nperson; //number of person the recipe will be cooked for
      for (var ingredient in lrecipe.recipe.ingredients) {
        //check if already exists the same ingredient with the same unit
        int? index = findIngredient(ingredients,
            ingredient); //null: no ingredient found, index: index of the ingredient

        //calculate the proportion of the ingredients
        double qt = double.parse(ingredient.quantity);
        int nPersons_ = lrecipe.recipe
            .nperson; //nPersons_ is the number of persons the recipe quantities are calculated for
        qt = (qt / nPersons_) * nPersons;
        if (index != null) {
          //sum the quantities if the already existing ingredent
          qt = double.parse(ingredients[index].quantity) + qt;
          ingredients[index].quantity = qt.toString();
        } else {
          //add a new ingredient
          ingredients.add(Ingredient(
              name: ingredient.name,
              quantity: qt.toString(),
              unit: ingredient.unit));
        }
      }
    }
    setState(() {
      newList.recipesIngredients = ingredients;
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
      for (var lr in result) {
        printWarning(lr.recipe.name);
      }
      if (result != null) {
        setState(() {
          newList.recipes = result;
        });
        getListIngredients();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    getListIngredients();
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  Icon(Icons.image),
                  MyTextField(
                      controller: _nameController, maxLength: 15, size: 30)
                ]),

                //DELETE AND SAVE LIST
                Row(
                  children: [
                    MyButton(
                        child: Icon(
                          Icons.check,
                          color: Colors.green,
                          size: 30,
                        ),
                        onPressed: saveList),
                    SizedBox(
                      width: 10,
                    ),
                    MyButton(
                        child: Icon(
                          Icons.delete_forever,
                          color: Colors.red,
                          size: 30,
                        ),
                        onPressed: deleteList),
                  ],
                )
              ],
            ),
            SizedBox(height: 30),
            MyText(text: "What do you want to cook?", size: 30),

            //RECIPES LIST
            Expanded(
              child: ListView.builder(
                  itemCount: newList.recipes.length + 1,
                  itemBuilder: (context, index) {
                    if (index != newList.recipes.length) {
                      return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.circle,
                              size: 12,
                            ),
                            SizedBox(width: 5),
                            MyText(text: newList.recipes[index].recipe.name),
                            SizedBox(width: 20),
                            MyCounter(
                                size: 20,
                                onPressed: (value) {
                                  setState(() {
                                    newList.recipes[index].nperson = value;
                                  });
                                  getListIngredients();
                                },
                                startValue: newList.recipes[index].nperson,
                                child: Icon(Icons.person, size: 30)),
                            SizedBox(width: 20),
                            IconButton(
                              onPressed: () => deleteRecipe(index),
                              icon: Icon(
                                Icons.delete_forever_outlined,
                                size: 30,
                                color: Colors.red.shade700,
                              ),
                            )
                          ]);
                    } else {
                      return Center(
                        child: MyButton(
                            child: Icon(
                              Icons.add,
                              color:
                                  Theme.of(context).colorScheme.inversePrimary,
                            ),
                            onPressed: addRecipe),
                      );
                    }
                  }),
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: newList.recipesIngredients.length,
                    itemBuilder: (context, index) {
                      return Recipeingredient(
                        check: true,
                        ingredient: newList.recipesIngredients[index],
                        onChange: () {},
                      );
                    })),
          ],
        ));
  }
}

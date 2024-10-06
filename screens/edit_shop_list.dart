import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:share_plus/share_plus.dart';
import 'package:smart_shopping_list/components/recipeIngredient.dart';
import 'package:smart_shopping_list/models/Ingredient.dart';
import 'package:smart_shopping_list/models/Recipe.dart';
import 'package:smart_shopping_list/models/ShopList.dart';
import 'package:smart_shopping_list/screens/recipes_dialog.dart';
import 'package:smart_shopping_list/services/firestore.dart';
import 'package:smart_shopping_list/styling/my_button.dart';
import 'package:smart_shopping_list/styling/my_counter.dart';
import 'package:smart_shopping_list/styling/my_text.dart';
import 'package:smart_shopping_list/styling/my_text_field.dart';

class EditShopList extends StatefulWidget {
  final ShopList shopList;
  const EditShopList({super.key, required this.shopList});

  @override
  State<EditShopList> createState() => _EditShopListState();
}

class _EditShopListState extends State<EditShopList> {
  late ShopList newList;
  late TextEditingController _nameController;
  final CollectionReference listsDb =
      FirebaseFirestore.instance.collection('shopping_lists');
  List<Recipe> myRecipes =
      Hive.box<Recipe>("recipes").values.cast<Recipe>().toList();
  @override
  void initState() {
    super.initState();
    newList = widget.shopList;

    _nameController = TextEditingController(text: newList.name);

    if (newList.recipes.length > 0) {
      refreshRecipes();
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void refreshRecipes() {
    for (var i = 0; i < newList.recipes.length; i++) {
      int recipeIndex =
          myRecipes.indexWhere((obj) => obj.id == newList.recipes[i].recipe.id);
      if (recipeIndex != -1) {
        newList.recipes[i].recipe = myRecipes[recipeIndex];
      }
    }
  }

  void saveList() async {
    newList.name = _nameController.text;
    final result = newList;
    if (newList.shared) {
      await FirestoreService().saveListToDb(newList.id, newList);
    }
    Navigator.pop(context, result);
  }

  void deleteList() async {
    final result = "delete";

    if (newList.shared) {
      await FirestoreService().deleteListFromDb(newList.id);
    }

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

  void deleteIngredient(index) {
    setState(() {
      newList.recipesIngredients.removeAt(index);
    });
  }

  void shareList() async {
    //check if the user is logged in
    // if (user == null) {
    //   showDialog(
    //       context: context,
    //       builder: (context) {
    //         return AlertDialog(
    //           content:
    //               Text('You need to be logged in to share a shopping list'),
    //           actions: [
    //             TextButton(
    //               onPressed: () {
    //                 Navigator.pop(context);
    //               },
    //               child: Text('Ok'),
    //             ),
    //           ],
    //         );
    //       });
    // }
    newList.name = _nameController.text;
    newList.shared = true;
    await FirestoreService().saveListToDb(newList.id, newList);

    String domain = "https://deeplink-on-server.vercel.app/list";
    Share.share("${domain}?listId=${newList.id}");
  }

  @override
  Widget build(BuildContext context) {
    getListIngredients();
    return Scaffold(
        appBar: AppBar(
            title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            //ADD PERSON BUTTON
            Row(
              children: [
                IconButton(
                    onPressed: () => {shareList()},
                    icon: Icon(
                      Icons.person_add,
                      size: 40,
                      color: Colors.grey.shade700,
                    ))
              ],
            )
          ],
        )),
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Column(
          children: [
            //SHOPPING LIST NAME
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(
                Icons.receipt_long,
                size: 35,
              ),
              SizedBox(
                width: 5,
              ),
              MyTextField(
                controller: _nameController,
                maxLength: 15,
                size: 20,
                maxWidth: 150,
              )
            ]),
            SizedBox(height: 30),
            MyText(text: "What do you want to cook?", size: 25),

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
                    } else {
                      return Center(
                        child: MyButton(
                            child: MyText(
                              text: "+ Add Recipe",
                              color: Theme.of(context).colorScheme.primary,
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
                        deleteIngredient: deleteIngredient,
                        index: index,
                      );
                    })),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyButton(
                    child: MyText(
                      text: "Delete",
                      color: Colors.red,
                    ),
                    onPressed: saveList),
                SizedBox(
                  width: 5,
                ),
                MyButton(
                    child: MyText(
                      text: "Save",
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    onPressed: saveList),
              ],
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ));
  }
}

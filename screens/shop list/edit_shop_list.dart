import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:share_plus/share_plus.dart';
import 'package:smart_shopping_list/components/recipeIngredient.dart';
import 'package:smart_shopping_list/models/Ingredient.dart';
import 'package:smart_shopping_list/models/Recipe.dart';
import 'package:smart_shopping_list/models/ShopList.dart';
import 'package:smart_shopping_list/screens/confirm_delete_dialog.dart';
import 'package:smart_shopping_list/screens/list_page.dart';
import 'package:smart_shopping_list/screens/recipes_dialog.dart';
import 'package:smart_shopping_list/services/firestore.dart';
import 'package:smart_shopping_list/styling/my_button.dart';
import 'package:smart_shopping_list/styling/my_counter.dart';
import 'package:smart_shopping_list/styling/my_text.dart';
import 'package:smart_shopping_list/styling/my_text_field.dart';
import 'package:android_id/android_id.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io' show Platform;

import 'package:smart_shopping_list/styling/my_title.dart';

Future<String?> _getId() async {
  var deviceInfo = DeviceInfoPlugin();
  if (Platform.isIOS) {
    // import 'dart:io'
    var iosDeviceInfo = await deviceInfo.iosInfo;
    return iosDeviceInfo.identifierForVendor; // unique ID on iOS
  } else if (Platform.isAndroid) {
    var androidDeviceInfo = await deviceInfo.androidInfo;
    return AndroidId().getId(); // unique ID on Android
  }
}

class EditShopList extends StatefulWidget {
  final ShopList shopList;
  final bool? isNew;
  const EditShopList({super.key, required this.shopList, this.isNew});

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
  String? deviceId;

  @override
  void initState() {
    super.initState();
    newList = widget.shopList;

    _nameController = TextEditingController(text: newList.name);
    if (widget.isNew == true) {
      getListIngredients();
    }
    _initializeAsyncData();
  }

  Future<void> _initializeAsyncData() async {
    if (newList.shared) {
      deviceId = await _getId();
      if (!newList.members.contains(deviceId)) {
        newList.members.add(deviceId ?? "");
      }
    }
    if (newList.recipes.isNotEmpty) {
      refreshRecipes();
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  //reassigns the recipes to the shopping list, this way if the recipes are modified will be modifiend in the shopping list too (if you press the restore proportions button)
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
      if (newList.members.length == 1 && newList.members.contains(deviceId)) {
        await FirestoreService().deleteListFromDb(newList.id);
      }
    }
    print("DELETE LIST");
    Navigator.pop(context, result);
  }

  void showConfirmDeleteDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ConfirmDeleteDialog(onDelete: deleteList);
      },
    );
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
    print("get list ingredients");
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
      print("SETTING INGREDIENTS");
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

  void onChange(ingredient, name, quantity, unit) {
    ingredient.name = name;
    ingredient.quantity = quantity;
    ingredient.unit = unit;
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
    newList.members = [deviceId ?? ""];
    await FirestoreService().saveListToDb(newList.id, newList);

    String domain = "https://deeplink-on-server.vercel.app/list";
    Share.share("${domain}?listId=${newList.id}");
  }

  void addOtherIngredient() {
    setState(() {
      newList.otherIngredients
          .add(Ingredient(name: "", quantity: "0", unit: "unit"));
    });
  }

  void deleteOtherIngredient(index) {
    setState(() {
      newList.otherIngredients.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController _otherIngredietsScroll = ScrollController();
    final ScrollController _recipesIngredietsScroll = ScrollController();
    final ScrollController _recipescroll = ScrollController();
    //getListIngredients();
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: widget.isNew == true ? false : true,
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
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              //SHOPPING LIST NAME
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.receipt_long,
                  size: 35,
                ),
                SizedBox(
                  width: 5,
                ),
                MyTitle(
                  controller: _nameController,
                  maxLength: 15,
                  size: 20,
                  maxWidth: 150,
                )
              ]),

              //TITLE
              SizedBox(height: 30),
              MyText(text: "What do you want to cook?", size: 25),

              //RECIPES LIST
              Container(
                width: double.infinity,
                height: 100,
                margin: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade500),
                    borderRadius: BorderRadius.circular(10)),
                child: newList.recipes.length == 0
                    ? Container(
                        margin: EdgeInsets.all(5),
                        child: MyText(
                          text: "Add the recipes you'd like to cook...",
                          color: Colors.grey.shade400,
                        ),
                      )
                    : Scrollbar(
                        thumbVisibility: true,
                        controller: _recipescroll,
                        child: ListView.builder(
                            controller: _recipescroll,
                            itemCount: newList.recipes.length,
                            itemBuilder: (context, index) {
                              return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(width: 5),
                                    MyText(
                                        text:
                                            newList.recipes[index].recipe.name),
                                    SizedBox(width: 20),
                                    MyCounter(
                                      size: 20,
                                      onPressed: (value) {
                                        setState(() {
                                          newList.recipes[index].nperson =
                                              value;
                                        });
                                        getListIngredients();
                                      },
                                      startValue:
                                          newList.recipes[index].nperson,
                                    ),
                                    SizedBox(width: 20),
                                    IconButton(
                                      onPressed: () => deleteRecipe(index),
                                      icon: Container(
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                              color: Colors.orange.shade100,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Icon(
                                            Icons.delete,
                                            color: Colors.orange,
                                          )),
                                    )
                                  ]);
                            }),
                      ),
              ),

              //AD RECEIPT BUTTON
              Center(
                child: MyButton(
                    child: MyText(
                      text: "+ Add Recipe",
                      color: Colors.grey.shade200,
                    ),
                    onPressed: addRecipe),
              ),
              SizedBox(height: 20),

              //INGREDIENTS
              Container(
                height: 140,
                margin: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade500),
                    borderRadius: BorderRadius.circular(10)),
                child: newList.recipesIngredients.length == 0
                    ? Container(
                        margin: EdgeInsets.all(5),
                        child: MyText(
                          text:
                              "Ingredients for your recipes will appear here automatically...",
                          color: Colors.grey.shade400,
                        ),
                      )
                    : Scrollbar(
                        thumbVisibility: true,
                        controller: _recipesIngredietsScroll,
                        child: ListView.builder(
                            controller: _recipesIngredietsScroll,
                            itemCount: newList.recipesIngredients.length,
                            itemBuilder: (context, index) {
                              //RECIPE INGREDIENTS

                              return Column(
                                children: [
                                  //REFRESH BUTTON
                                  index == 0
                                      ? Row(
                                          children: [
                                            SizedBox(
                                              width: 15,
                                            ),
                                            // MyText(
                                            //   text: "Name of ingredient",
                                            //   color: Colors.grey,
                                            // ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            // MyText(
                                            //   text: "Quantity",
                                            //   color: Colors.grey,
                                            // ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            GestureDetector(
                                              onTap: () => getListIngredients(),
                                              child: Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Container(
                                                    margin: EdgeInsets.all(5),
                                                    padding: EdgeInsets.all(5),
                                                    decoration: BoxDecoration(
                                                        color: Colors
                                                            .orange.shade100,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    child: Icon(
                                                      Icons.refresh,
                                                      color: Colors.orange,
                                                    )),
                                              ),
                                            ),
                                          ],
                                        )
                                      : SizedBox.shrink(),
                                  Recipeingredient(
                                    check: true,
                                    ingredient:
                                        newList.recipesIngredients[index],
                                    onChange: onChange,
                                    deleteIngredient: deleteIngredient,
                                    index: index,
                                  ),
                                ],
                              );
                            }),
                      ),
              ),

              SizedBox(
                height: 15,
              ),

              //OTHER INGREDIENTS
              Container(
                height: 140,
                margin: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade500),
                    borderRadius: BorderRadius.circular(10)),
                child: newList.recipesIngredients.length == 0
                    ? Container(
                        margin: EdgeInsets.all(5),
                        padding: const EdgeInsets.all(8.0),
                        child: MyText(
                          text: "Add other items you need...",
                          color: Colors.grey.shade400,
                        ),
                      )
                    : Scrollbar(
                        thumbVisibility: true,
                        controller: _otherIngredietsScroll,
                        child: ListView.builder(
                            controller: _otherIngredietsScroll,
                            shrinkWrap:
                                true, // This ensures the inner ListView takes only the space it needs
                            //physics: NeverScrollableScrollPhysics(),
                            itemCount: newList.otherIngredients.length + 1,
                            itemBuilder: (context, index) {
                              //OTHER INGREDIENTS
                              if (index < newList.otherIngredients.length) {
                                return Recipeingredient(
                                  check: true,
                                  ingredient: newList.otherIngredients[index],
                                  onChange: onChange,
                                  deleteIngredient: deleteOtherIngredient,
                                  index: index,
                                );
                              }
                            }),
                      ),
              ),

              //ADD OTHER OBJECTS
              MyButton(
                  child: MyText(
                    text: "+ Add Item",
                    color: Colors.grey.shade200,
                  ),
                  onPressed: addOtherIngredient),

              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyButton(
                      color: Colors.red,
                      child: MyText(
                        text: "Delete",
                        color: Colors.grey.shade200,
                      ),
                      onPressed: showConfirmDeleteDialog),
                  SizedBox(
                    width: 5,
                  ),
                  MyButton(
                      child: MyText(
                        text: "Save",
                        color: Colors.grey.shade200,
                      ),
                      onPressed: saveList),
                ],
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ));
  }
}

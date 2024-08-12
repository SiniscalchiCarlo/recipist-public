import 'package:flutter/material.dart';
import 'package:smart_shopping_list/components/recipeIngredient.dart';
import 'package:smart_shopping_list/models/ShopList.dart';
import 'package:smart_shopping_list/styling/my_action_button.dart';
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
        );
    _nameController = TextEditingController(text: newList.name);
  }

  @override
  Widget build(BuildContext context) {
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
                        onPressed: () {}),
                    SizedBox(
                      width: 10,
                    ),
                    MyButton(
                        child: Icon(
                          Icons.delete_forever,
                          color: Colors.red,
                          size: 30,
                        ),
                        onPressed: () {}),
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
                                onPressed: (value) => setState(() {
                                      newList.recipes[index].nperson = value;
                                    }),
                                startValue: newList.recipes[index].nperson),
                            SizedBox(width: 20),
                            Icon(
                              Icons.delete_forever_outlined,
                              size: 30,
                              color: Colors.red.shade700,
                            ),
                          ]);
                    } else {
                      return Center(
                        child: MyButton(
                            child: Icon(
                              Icons.add,
                              color:
                                  Theme.of(context).colorScheme.inversePrimary,
                            ),
                            onPressed: () {}),
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

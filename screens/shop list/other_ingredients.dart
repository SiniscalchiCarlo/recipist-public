import 'package:flutter/material.dart';
import 'package:smart_shopping_list/components/recipeIngredient.dart';
import 'package:smart_shopping_list/models/Ingredient.dart';
import 'package:smart_shopping_list/models/ShopList.dart';
import 'package:smart_shopping_list/screens/shop%20list/edit_shop_list.dart';
import 'package:smart_shopping_list/styling/my_button.dart';
import 'package:smart_shopping_list/styling/my_counter.dart';
import 'package:smart_shopping_list/styling/my_text.dart';

class OtherIngredients extends StatefulWidget {
  final ShopList newList;
  const OtherIngredients({super.key, required this.newList});

  @override
  State<OtherIngredients> createState() => _OtherIngredientsState();
}

class _OtherIngredientsState extends State<OtherIngredients> {
  void onChange(ingredient, name, quantity, unit) {
    ingredient.name = name;
    ingredient.quantity = quantity;
    ingredient.unit = unit;
  }

  void addOtherIngredient() {
    setState(() {
      widget.newList.otherIngredients
          .add(Ingredient(name: "", quantity: "0", unit: "unit"));
    });
  }

  void deleteOtherIngredient(index) {
    setState(() {
      widget.newList.otherIngredients.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController _otherIngredietsScroll = ScrollController();
    return Scaffold(
      appBar: AppBar(title: SizedBox.shrink()),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MyText(
            text: "Need anythings else?",
            size: 25,
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 140,
            margin: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade500),
                borderRadius: BorderRadius.circular(10)),
            child: Scrollbar(
              thumbVisibility: true,
              controller: _otherIngredietsScroll,
              child: ListView.builder(
                  controller: _otherIngredietsScroll,
                  shrinkWrap:
                      true, // This ensures the inner ListView takes only the space it needs
                  //physics: NeverScrollableScrollPhysics(),
                  itemCount: widget.newList.otherIngredients.length + 1,
                  itemBuilder: (context, index) {
                    //OTHER INGREDIENTS
                    if (index < widget.newList.otherIngredients.length) {
                      return Recipeingredient(
                        check: true,
                        ingredient: widget.newList.otherIngredients[index],
                        onChange: onChange,
                        deleteIngredient: deleteOtherIngredient,
                        index: index,
                      );
                    }
                  }),
            ),
          ),
          SizedBox(height: 20),
          MyButton(
              child: MyText(
                text: "+ Add Item",
                color: Theme.of(context).colorScheme.primary,
              ),
              onPressed: addOtherIngredient),
          SizedBox(
            height: 20,
          ),
          MyButton(
            child: MyText(
              text: "Next",
              color: Theme.of(context).colorScheme.primary,
            ),
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      EditShopList(shopList: widget.newList, isNew: true),
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

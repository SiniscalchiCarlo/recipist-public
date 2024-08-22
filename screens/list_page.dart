import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:smart_shopping_list/components/user_app_bar.dart';
import 'package:smart_shopping_list/models/ShopList.dart';
import 'package:smart_shopping_list/screens/edit_shop_list.dart';
import 'package:smart_shopping_list/styling/my_action_button.dart';
import 'package:smart_shopping_list/styling/my_card.dart';
import 'package:smart_shopping_list/styling/my_text.dart';
import 'package:uuid/uuid.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  late Box<ShopList> shopListBox;
  late List<ShopList> shopLists;

  @override
  void initState() {
    super.initState();
    shopListBox = Hive.box<ShopList>('shopLists');
    shopLists = shopListBox.values.cast<ShopList>().toList();
  }

  int getHighestId() {
    var keys = shopListBox.keys.cast<int>();
    var highestId = keys.isNotEmpty ? keys.reduce(max) : 0;
    return highestId;
  }

  void addShopList() async {
    String newId = Uuid().v4().substring(0, 8);
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditShopList(
            shopList: ShopList(
                name: "",
                recipes: [],
                recipesIngredients: [],
                otherIngredients: [],
                id: newId,
                shared: false)),
      ),
    );
    if (result != null && result != "delete") {
      result.id = newId;
      shopListBox.put(newId, result);
      setState(() {
        shopLists.add(result);
      });
    }
  }

  void modifyShopList(index) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditShopList(shopList: shopLists[index]),
      ),
    );
    if (result != null && result != "delete") {
      shopListBox.put(shopLists[index].id, result);
      setState(() {
        shopLists[index] = result;
      });
    }

    if (result == "delete") {
      shopListBox.delete(shopLists[index].id);
      setState(() {
        shopLists.removeAt(index);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: UserAppBar()),
      backgroundColor: Theme.of(context).colorScheme.surface,
      floatingActionButton: MyActionButton(
        onPressed: addShopList,
        text: "+",
      ),
      body: Column(
        children: [
          MyText(
            text: "My shopping lists:",
            size: 25,
          ),
          Expanded(
            child: ListView.builder(
                itemCount: shopLists.length,
                itemBuilder: (BuildContext context, int index) {
                  return MyCard(
                    onTap: () => modifyShopList(index),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: 10),
                        MyText(text: shopLists[index].name, size: 20)
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

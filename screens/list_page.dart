import 'package:flutter/material.dart';
import 'package:smart_shopping_list/screens/edit_shop_list.dart';
import 'package:smart_shopping_list/styling/my_action_button.dart';
import 'package:smart_shopping_list/styling/my_card.dart';
import 'package:smart_shopping_list/styling/my_text.dart';
import 'package:smart_shopping_list/data.dart';
import 'package:smart_shopping_list/screens/edit_recipe.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  void addShopList() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditShopList(shopList: null),
      ),
    );
    if (result != null) {
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
    if (result != null) {
      setState(() {
        shopLists[index] = result;
      });
    } else {
      setState(() {
        print(shopLists);
        shopLists.removeAt(index);
        print(shopLists);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: MyText(
        text: "Shop lists",
        size: 48,
      )),
      backgroundColor: Theme.of(context).colorScheme.surface,
      floatingActionButton: MyActionButton(
        onPressed: addShopList,
        text: "+",
      ),
      body: ListView.builder(
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
    );
  }
}

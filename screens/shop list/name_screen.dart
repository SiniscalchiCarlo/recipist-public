import 'package:flutter/material.dart';
import 'package:smart_shopping_list/models/ShopList.dart';
import 'package:smart_shopping_list/screens/shop%20list/recipes_screen.dart';
import 'package:smart_shopping_list/styling/my_button.dart';
import 'package:smart_shopping_list/styling/my_text.dart';
import 'package:smart_shopping_list/styling/my_title.dart';

class NameScreen extends StatelessWidget {
  final String newId;
  final TextEditingController _nameController = TextEditingController();
  NameScreen({required this.newId});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: SizedBox.shrink()),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyText(
              text: "List Name:",
              size: 40,
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyTitle(
                  controller: _nameController,
                  maxLength: 15,
                  size: 30,
                  maxWidth: 150,
                ),
              ],
            ),
            SizedBox(height: 20),
            MyButton(
              child: MyText(
                text: "Next",
                color: Theme.of(context).colorScheme.primary,
              ),
              onPressed: () async {
                String name = _nameController.text.trim();
                if (name.isNotEmpty) {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          RecipesScreen(name: name, newId: newId),
                    ),
                  );
                  Navigator.pop(context, result);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

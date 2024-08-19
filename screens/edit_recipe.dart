import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:smart_shopping_list/styling/my_counter.dart';
import 'package:smart_shopping_list/components/recipeIngredient.dart';
import 'package:smart_shopping_list/models/Ingredient.dart';
import 'package:smart_shopping_list/styling/my_action_button.dart';
import 'package:smart_shopping_list/styling/my_button.dart';
import 'package:smart_shopping_list/styling/my_text.dart';
import 'package:smart_shopping_list/styling/my_text_field.dart';
import 'package:smart_shopping_list/models/Recipe.dart';
import 'package:flutter/services.dart';

void printWarning(String text) {
  print('\x1B[33m$text\x1B[0m');
}

class EditRecipe extends StatefulWidget {
  final Recipe recipe;
  const EditRecipe({super.key, required this.recipe});

  @override
  State<EditRecipe> createState() => _EditRecipeState();
}

class _EditRecipeState extends State<EditRecipe> {
  late TextEditingController _nameController;
  late TextEditingController _notesController;
  late Recipe newRecipe;
  late File? selectedImage;

  @override
  void initState() {
    super.initState();

    newRecipe = widget.recipe;
    _nameController = TextEditingController(text: newRecipe.name);
    _notesController = TextEditingController(text: newRecipe.notes);

    selectedImage = newRecipe.photo;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void setPersons(value) {
    setState(() {
      newRecipe.nperson = value;
    });
  }

  void onChange(ingredient, name, quantity, unit) {
    ingredient.name = name;
    ingredient.quantity = quantity;
    ingredient.unit = unit;
  }

  void saveRecipe() {
    final result = Recipe(
        name: _nameController.text,
        notes: _notesController.text,
        nperson: newRecipe.nperson,
        ingredients: newRecipe.ingredients,
        imagePath: selectedImage?.path,
        id: newRecipe.id); //temporary id will be changed after navigator pop.
    Navigator.pop(context, result);
  }

  void deleteRecipe() {
    final result = "delete";
    Navigator.pop(context, result);
  }

  void addIngredient() {
    setState(() {
      newRecipe.ingredients
          .add(Ingredient(name: "", quantity: "0", unit: "unit"));
    });
  }

  @override
  Widget build(BuildContext context) {
    Future PickImageFromCamera() async {
      final returnedImage =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (returnedImage == null) return;
      setState(() {
        selectedImage = File(returnedImage.path);
      });
    }

    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Column(children: [
          //RECIPE TITLE AND IMAGE
          Container(
            margin: EdgeInsets.only(top: 40, left: 5, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  //RECIPE PHOTO
                  OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: CircleBorder(),
                        padding: selectedImage != null
                            ? EdgeInsets.all(0)
                            : EdgeInsets.all(15),
                        backgroundColor: Colors
                            .white, // <-- Button color // <-- Splash color
                      ),
                      onPressed: () {
                        PickImageFromCamera();
                      },
                      child: selectedImage != null
                          ? ClipOval(
                              child: SizedBox.fromSize(
                                size: Size.fromRadius(30), // Image radius
                                child: Image.file(
                                  selectedImage!,
                                  fit: BoxFit
                                      .cover, // Ensures the image fills the circle
                                ),
                              ),
                            )
                          : Icon(
                              Icons.add_a_photo_rounded,
                              color: Colors.grey,
                              size: 30.0,
                            )),
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

                //DELETE AND SAVE RECIPE
                Column(
                  children: [
                    MyButton(
                        child: Icon(
                          Icons.check,
                          color: Colors.green,
                          size: 20,
                        ),
                        onPressed: saveRecipe),
                    MyButton(
                        child: Icon(
                          Icons.delete_forever,
                          color: Colors.red,
                          size: 20,
                        ),
                        onPressed: deleteRecipe),
                  ],
                )
              ],
            ),
          ),

          //NUMBER OF PERSONS
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyText(text: "Ingredients for:", size: 20),
              SizedBox(
                width: 20,
              ),
              MyCounter(
                size: 20,
                onPressed: (value) => setState(() {
                  newRecipe.nperson = value;
                }),
                startValue: newRecipe.nperson,
                child: Icon(Icons.person, size: 30),
              )
            ],
          ),
          // RECIPE INGREDIENTS
          Expanded(
              child: ListView.builder(
                  itemCount: newRecipe.ingredients.length + 1,
                  itemBuilder: (context, index) {
                    if (index < newRecipe.ingredients.length) {
                      return Recipeingredient(
                        ingredient: newRecipe.ingredients[index],
                        onChange: onChange,
                        check: false,
                      );
                    } else {
                      return Column(
                        children: [
                          //ADD NEW INGREDIENT BUTTON
                          SizedBox(
                            height: 10,
                          ),
                          MyActionButton(onPressed: addIngredient, text: "+"),
                          SizedBox(
                            height: 10,
                          ),
                          MyText(text: "Notes", size: 25),
                          Container(
                            margin: EdgeInsets.all(10),
                            child: TextField(
                                controller: _notesController,
                                maxLines: 15, //or null
                                keyboardType: TextInputType.multiline,
                                decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.all(10.0),
                                    hintText: "Enter your notes here",
                                    border: OutlineInputBorder())),
                          )
                        ],
                      );
                    }
                  })),
        ]));
  }
}

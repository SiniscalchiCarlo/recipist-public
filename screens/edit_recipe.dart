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

  void deleteIngredient(index) {
    setState(() {
      newRecipe.ingredients.removeAt(index);
    });
  }

  void addIngredient() {
    setState(() {
      newRecipe.ingredients
          .add(Ingredient(name: "", quantity: "0", unit: "unit"));
    });
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController _ingredietsScrollController = ScrollController();
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
          Center(
            child: Column(children: [
              SizedBox(
                height: 50,
              ),
              //RECIPE PHOTO
              OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    shape: CircleBorder(),
                    padding: selectedImage != null
                        ? EdgeInsets.all(0)
                        : EdgeInsets.all(30),
                    backgroundColor: Colors.white,

                    side: BorderSide(
                      color: Colors.amber, // Border color
                      width: 1, // Border width
                    ),
                    elevation: 7, // Shadow effect
                    shadowColor: Colors.orange.withOpacity(0.5),
                  ),
                  onPressed: () {
                    PickImageFromCamera();
                  },
                  child: selectedImage != null
                      ? ClipOval(
                          child: SizedBox.fromSize(
                            size: Size.fromRadius(50),
                            child: Image.file(
                              selectedImage!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      : Icon(
                          Icons.add_a_photo_rounded,
                          color: Colors.grey,
                          size: 30.0,
                        )),
              SizedBox(
                height: 10,
              ),

              //RECIPE TITLE
              MyTextField(
                controller: _nameController,
                maxLength: 25,
                maxWidth: 200,
                hintText: "Recipe Name...",
              )
            ]),
          ),
          SizedBox(height: 20),
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
              )
            ],
          ),
          // RECIPE INGREDIENTS
          Container(
              height: 140,
              margin: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade500),
                  borderRadius: BorderRadius.circular(10)),
              child: Scrollbar(
                thumbVisibility: true,
                controller: _ingredietsScrollController,
                child: ListView.builder(
                    controller: _ingredietsScrollController,
                    padding: EdgeInsets.zero,
                    itemCount: newRecipe.ingredients.length,
                    itemBuilder: (context, index) {
                      return Column(children: [
                        index == 0
                            ? Row(
                                children: [
                                  SizedBox(
                                    width: 15,
                                  ),
                                  MyText(
                                    text: "Name of ingredient",
                                    color: Colors.grey,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  MyText(
                                    text: "Quantity",
                                    color: Colors.grey,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                ],
                              )
                            : SizedBox.shrink(),
                        Recipeingredient(
                            ingredient: newRecipe.ingredients[index],
                            index: index,
                            onChange: onChange,
                            check: false,
                            deleteIngredient: deleteIngredient)
                      ]);
                    }),
              )),
          Column(
            children: [
              //ADD NEW INGREDIENT BUTTON
              SizedBox(
                height: 5,
              ),
              MyButton(
                  child: MyText(
                    text: "+ Add Ingredient",
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  onPressed: addIngredient),
              SizedBox(
                height: 20,
              ),
              MyText(text: "Notes", size: 25),
              Container(
                height: 150,
                margin:
                    EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 15),
                child: TextField(
                    controller: _notesController,
                    maxLines: 15, //or null
                    keyboardType: TextInputType.multiline,
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(10.0),
                        hintText: "Recipe Steps...",
                        border: OutlineInputBorder())),
              ),

              //SAVE DELETE BUTTON
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyButton(
                      child: MyText(
                        text: "Delete",
                        color: Colors.red,
                      ),
                      onPressed: deleteRecipe),
                  SizedBox(
                    width: 5,
                  ),
                  MyButton(
                      child: MyText(
                        text: "Save",
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      onPressed: saveRecipe),
                ],
              )
            ],
          )
        ]));
  }
}

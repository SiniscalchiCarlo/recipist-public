import 'package:smart_shopping_list/models/Ingredient.dart';

class Recipe {
  String name;
  String notes;
  int nperson;
  List<Ingredient> ingredients;

  Recipe(
      {required this.name,
      required this.notes,
      required this.nperson,
      required this.ingredients});
}

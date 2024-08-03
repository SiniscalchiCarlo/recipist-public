import 'package:smart_shopping_list/models/Ingredient.dart';

class Recipe {
  String name;
  int nperson;
  List<Ingredient> ingredients;

  Recipe(
      {required this.name, required this.nperson, required this.ingredients});
}

import 'package:smart_shopping_list/models/Ingredient.dart';
import 'package:smart_shopping_list/models/Recipe.dart';

class Slis {
  String name;
  List<Recipe> recipes;
  List<Ingredient> recipesIngredients;
  List<Ingredient> otherIngredients;
  Slis(
      {required this.name,
      required this.recipes,
      required this.recipesIngredients,
      required this.otherIngredients});
}

import 'package:smart_shopping_list/models/Ingredient.dart';
import 'package:smart_shopping_list/models/Recipe.dart';

class ListRecipe {
  Recipe recipe;
  int nperson;
  ListRecipe({required this.recipe, required this.nperson});
}

class ShopList {
  String name;
  List<ListRecipe> recipes;
  List<Ingredient> recipesIngredients;
  List<Ingredient> otherIngredients;
  ShopList(
      {required this.name,
      required this.recipes,
      required this.recipesIngredients,
      required this.otherIngredients});
}

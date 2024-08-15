import 'package:hive_flutter/adapters.dart';
import 'package:smart_shopping_list/models/Ingredient.dart';
import 'package:smart_shopping_list/models/ListRecipe.dart';
import 'package:smart_shopping_list/models/Recipe.dart';
part 'ShopList.g.dart';

@HiveType(typeId: 3)
class ShopList {
  @HiveField(0)
  String name;
  @HiveField(1)
  List<ListRecipe> recipes;
  @HiveField(2)
  List<Ingredient> recipesIngredients;
  @HiveField(3)
  List<Ingredient> otherIngredients;
  @HiveField(4)
  int id;

  ShopList(
      {required this.name,
      required this.recipes,
      required this.recipesIngredients,
      required this.otherIngredients,
      required this.id});
}

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
  String id;
  @HiveField(5)
  bool shared;

  ShopList(
      {required this.name,
      required this.recipes,
      required this.recipesIngredients,
      required this.otherIngredients,
      required this.id,
      required this.shared});

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "recipes": recipes.map((recipe) => recipe.toMap()).toList(),
      "recipesIngredients": recipesIngredients.map((e) => e.toMap()).toList(),
      "otherIngredients": otherIngredients.map((e) => e.toMap()).toList(),
      "id": id,
      "shared": shared
    };
  }

  factory ShopList.fromMap(Map<String, dynamic> map) {
    return ShopList(
        name: map["name"],
        recipes: map["recipes"].map((recipe) => recipe.fromMap()).toList(),
        recipesIngredients:
            map["recipesIngredients"].map((e) => e.fromMap()).toList(),
        otherIngredients:
            map["otherIngredients"].map((e) => e.fromMap()).toList(),
        id: map["id"],
        shared: map["shared"]);
  }
}

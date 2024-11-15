import 'package:hive_flutter/adapters.dart';
import 'package:smart_shopping_list/models/Recipe.dart';
part 'ListRecipe.g.dart';

@HiveType(typeId: 2)
class ListRecipe {
  @HiveField(0)
  Recipe recipe;
  @HiveField(1)
  int nperson;
  ListRecipe({required this.recipe, required this.nperson});

  Map<String, dynamic> toMap() {
    return {
      "recipe": recipe.toMap(),
      "nperson": nperson,
    };
  }

  factory ListRecipe.fromMap(Map<String, dynamic> map) {
    return ListRecipe(
        recipe: Recipe.fromMap(map["recipe"]), nperson: map["nperson"]);
  }
}

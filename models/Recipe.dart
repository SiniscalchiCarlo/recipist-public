import 'dart:io';
import 'package:hive_flutter/adapters.dart';
import 'package:smart_shopping_list/models/Ingredient.dart';
part 'Recipe.g.dart';

@HiveType(typeId: 1)
class Recipe {
  @HiveField(0)
  String name;
  @HiveField(1)
  String notes;
  @HiveField(2)
  int nperson;
  @HiveField(3)
  String? imagePath;
  @HiveField(4)
  List<Ingredient> ingredients;
  @HiveField(5)
  String id;

  Recipe(
      {required this.name,
      required this.notes,
      required this.nperson,
      required this.ingredients,
      required this.id,
      this.imagePath});

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "notes": notes,
      "nperson": nperson,
      "ingredients":
          ingredients.map((ingredient) => ingredient.toMap()).toList(),
      "id": id,
      "imagePath": imagePath
    };
  }

  factory Recipe.fromMap(Map<String, dynamic> map) {
    return Recipe(
      name: map["name"],
      notes: map["notes"],
      nperson: map["nperson"],
      ingredients:
          map["ingredients"].map((ingredient) => ingredient.fromMap()).toList(),
      id: map["id"],
    );
  }

  File? get photo => imagePath != null ? File(imagePath!) : null;
}

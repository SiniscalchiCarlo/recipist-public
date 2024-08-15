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
  int id;

  Recipe(
      {required this.name,
      required this.notes,
      required this.nperson,
      required this.ingredients,
      required this.id,
      this.imagePath});

  File? get photo => imagePath != null ? File(imagePath!) : null;
}

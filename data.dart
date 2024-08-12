import 'package:smart_shopping_list/models/Ingredient.dart';
import 'package:smart_shopping_list/models/Recipe.dart';

List<Ingredient> ingredients1 = [
  Ingredient(name: "egg", quantity: "4.0", unit: "unit"),
  Ingredient(name: "rice", quantity: "300.0", unit: "grams"),
  Ingredient(name: "milk", quantity: "0.5", unit: "unit"),
];

List<Ingredient> ingredients2 = [
  Ingredient(name: "carrots", quantity: "0.5", unit: "unit"),
  Ingredient(
      name: "something very very very long", quantity: "0.5", unit: "grams"),
  Ingredient(name: "milk", quantity: "0.5", unit: "unit"),
];

List<Ingredient> ingredients3 = [
  Ingredient(name: "carrots", quantity: "0.5", unit: "unit"),
  Ingredient(
      name: "something very very very long", quantity: "0.5", unit: "grams"),
  Ingredient(name: "milk", quantity: "0.5", unit: "unit"),
];

List<Recipe> recipes = [
  Recipe(name: "Recipe1", nperson: 3, ingredients: ingredients1, notes: ""),
  Recipe(name: "Recipe2", nperson: 2, ingredients: ingredients2, notes: ""),
  Recipe(name: "Recipe3", nperson: 5, ingredients: ingredients3, notes: ""),
];

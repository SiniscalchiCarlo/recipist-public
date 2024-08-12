import 'package:smart_shopping_list/models/Ingredient.dart';
import 'package:smart_shopping_list/models/Recipe.dart';
import 'package:smart_shopping_list/models/ShopList.dart';

List<Ingredient> ingredients1 = [
  Ingredient(name: "egg", quantity: "4.0", unit: "unit"),
  Ingredient(name: "rice", quantity: "300.0", unit: "g"),
  Ingredient(name: "milk", quantity: "0.5", unit: "unit"),
];

List<Ingredient> ingredients2 = [
  Ingredient(name: "carrots", quantity: "0.5", unit: "unit"),
  Ingredient(name: "something very very very long", quantity: "0.5", unit: "g"),
  Ingredient(name: "milk", quantity: "0.5", unit: "unit"),
];

List<Ingredient> ingredients3 = [
  Ingredient(name: "carrots", quantity: "0.5", unit: "unit"),
  Ingredient(name: "something very very very long", quantity: "0.5", unit: "g"),
  Ingredient(name: "milk", quantity: "0.5", unit: "unit"),
];

Recipe r1 =
    Recipe(name: "Recipe1", nperson: 3, ingredients: ingredients1, notes: "");
Recipe r2 =
    Recipe(name: "Recipe1", nperson: 2, ingredients: ingredients2, notes: "");
Recipe r3 =
    Recipe(name: "Recipe1", nperson: 5, ingredients: ingredients3, notes: "");

List<Recipe> recipes = [r1, r2, r3];

List<ShopList> shopLists = [
  ShopList(
      name: "Lista1",
      recipes: [
        ListRecipe(recipe: r1, nperson: 6),
        ListRecipe(recipe: r2, nperson: 3)
      ],
      recipesIngredients: ingredients1,
      otherIngredients: [])
];

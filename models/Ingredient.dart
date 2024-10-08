import 'dart:core';
import 'package:hive_flutter/adapters.dart';
part 'Ingredient.g.dart';

@HiveType(typeId: 0)
class Ingredient {
  @HiveField(0)
  String name;
  @HiveField(1)
  String quantity;
  @HiveField(2)
  String unit;
  @HiveField(3)
  bool? checked;
  Ingredient(
      {required this.name,
      required this.quantity,
      required this.unit,
      this.checked});

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "quantity": quantity,
      "unit": unit,
    };
  }

  factory Ingredient.fromMap(Map<String, dynamic> map) {
    return Ingredient(
        name: map["name"], quantity: map["quantity"], unit: map["unit"]);
  }
}

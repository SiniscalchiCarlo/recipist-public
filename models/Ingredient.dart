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
  Ingredient({required this.name, required this.quantity, required this.unit});
}

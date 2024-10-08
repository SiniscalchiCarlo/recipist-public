// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ShopList.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ShopListAdapter extends TypeAdapter<ShopList> {
  @override
  final int typeId = 3;

  @override
  ShopList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ShopList(
      name: fields[0] as String,
      recipes: (fields[1] as List).cast<ListRecipe>(),
      recipesIngredients: (fields[2] as List).cast<Ingredient>(),
      otherIngredients: (fields[3] as List).cast<Ingredient>(),
      id: fields[4] as String,
      shared: fields[5] as bool,
      members: (fields[6] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, ShopList obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.recipes)
      ..writeByte(2)
      ..write(obj.recipesIngredients)
      ..writeByte(3)
      ..write(obj.otherIngredients)
      ..writeByte(4)
      ..write(obj.id)
      ..writeByte(5)
      ..write(obj.shared)
      ..writeByte(6)
      ..write(obj.members);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShopListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

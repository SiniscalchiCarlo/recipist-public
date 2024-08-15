// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ListRecipe.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ListRecipeAdapter extends TypeAdapter<ListRecipe> {
  @override
  final int typeId = 2;

  @override
  ListRecipe read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ListRecipe(
      recipe: fields[0] as Recipe,
      nperson: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, ListRecipe obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.recipe)
      ..writeByte(1)
      ..write(obj.nperson);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ListRecipeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

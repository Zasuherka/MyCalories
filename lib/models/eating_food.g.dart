// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'eating_food.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EatingFoodAdapter extends TypeAdapter<EatingFood> {
  @override
  final int typeId = 2;

  @override
  EatingFood read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EatingFood(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
      fields[3] as double,
      fields[4] as double,
      fields[5] as double,
      fields[6] as double,
      fields[9] as int,
    )
      ..isThisFoodOnTheMyFoodList = fields[7] as bool
      ..isUserFood = fields[8] as bool;
  }

  @override
  void write(BinaryWriter writer, EatingFood obj) {
    writer
      ..writeByte(10)
      ..writeByte(9)
      ..write(obj.weight)
      ..writeByte(0)
      ..write(obj.idFood)
      ..writeByte(1)
      ..write(obj.authorEmail)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.protein)
      ..writeByte(4)
      ..write(obj.fats)
      ..writeByte(5)
      ..write(obj.carbohydrates)
      ..writeByte(6)
      ..write(obj.calories)
      ..writeByte(7)
      ..write(obj.isThisFoodOnTheMyFoodList)
      ..writeByte(8)
      ..write(obj.isUserFood);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EatingFoodAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

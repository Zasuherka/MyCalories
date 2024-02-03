// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AppUserAdapter extends TypeAdapter<AppUser> {
  @override
  final int typeId = 0;

  @override
  AppUser read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AppUser(
      userId: fields[0] as String,
      name: fields[1] as String,
      email: fields[2] as String,
      weightNow: fields[3] as double?,
      weightGoal: fields[4] as double?,
      height: fields[5] as int?,
      birthday: fields[6] as DateTime?,
      urlAvatar: fields[8] as String?,
      caloriesGoal: fields[9] as int?,
      fatsGoal: fields[10] as int?,
      proteinGoal: fields[12] as int?,
      carbohydratesGoal: fields[11] as int?,
    )
      ..age = fields[7] as int?
      ..sex = fields[13] as Sex?;
  }

  @override
  void write(BinaryWriter writer, AppUser obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.weightNow)
      ..writeByte(4)
      ..write(obj.weightGoal)
      ..writeByte(5)
      ..write(obj.height)
      ..writeByte(6)
      ..write(obj.birthday)
      ..writeByte(7)
      ..write(obj.age)
      ..writeByte(8)
      ..write(obj.urlAvatar)
      ..writeByte(9)
      ..write(obj.caloriesGoal)
      ..writeByte(10)
      ..write(obj.fatsGoal)
      ..writeByte(11)
      ..write(obj.carbohydratesGoal)
      ..writeByte(12)
      ..write(obj.proteinGoal)
      ..writeByte(13)
      ..write(obj.sex);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppUserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

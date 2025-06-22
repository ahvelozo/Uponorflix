// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VideoEntityAdapter extends TypeAdapter<VideoEntity> {
  @override
  final int typeId = 2;

  @override
  VideoEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VideoEntity(
      id: fields[0] as String,
      title: fields[1] as String,
      year: fields[2] as int,
      thumbnailUrl: fields[3] as String,
      type: fields[4] as CatalogTypeHive,
      createdAt: fields[5] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, VideoEntity obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.year)
      ..writeByte(3)
      ..write(obj.thumbnailUrl)
      ..writeByte(4)
      ..write(obj.type)
      ..writeByte(5)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VideoEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CatalogTypeHiveAdapter extends TypeAdapter<CatalogTypeHive> {
  @override
  final int typeId = 1;

  @override
  CatalogTypeHive read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return CatalogTypeHive.movie;
      case 1:
        return CatalogTypeHive.series;
      case 2:
        return CatalogTypeHive.clip;
      case 3:
        return CatalogTypeHive.other;
      default:
        return CatalogTypeHive.movie;
    }
  }

  @override
  void write(BinaryWriter writer, CatalogTypeHive obj) {
    switch (obj) {
      case CatalogTypeHive.movie:
        writer.writeByte(0);
        break;
      case CatalogTypeHive.series:
        writer.writeByte(1);
        break;
      case CatalogTypeHive.clip:
        writer.writeByte(2);
        break;
      case CatalogTypeHive.other:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CatalogTypeHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

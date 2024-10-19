import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'levels_group_entity.g.dart';

@HiveType(typeId: 4)
class LevelAndCollectionEntity extends Equatable {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String imgPath;
  @HiveField(3)
  final int skipPoints;
  @HiveField(4)
  final int userPoints;
  @HiveField(5)
  final String description;
  @HiveField(6)
  final String itemColor;

  const LevelAndCollectionEntity({
    required this.description,
    required this.itemColor,
    required this.id,
    required this.skipPoints,
    required this.userPoints,
    required this.name,
    required this.imgPath,
  });
  LevelAndCollectionEntity copyWith({
    int? id,
    String? name,
    String? imgPath,
    int? skipPoints,
    int? userPoints,
    String? description,
    String? itemColor,
  }) {
    return LevelAndCollectionEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      imgPath: imgPath ?? this.imgPath,
      skipPoints: skipPoints ?? this.skipPoints,
      userPoints: userPoints ?? this.userPoints,
      description: description ?? this.description,
      itemColor: itemColor ?? this.itemColor,
    );
  }

  @override
  List<Object?> get props =>
      [
        id,
        name,
        imgPath,
        skipPoints,
        userPoints,
        description,
        itemColor,
      ];
}

import '../../../shared/entity/levels_group_entity.dart';

class CollectionModel extends LevelAndCollectionEntity {
  const CollectionModel({
    required super.id,
    required super.skipPoints,
    required super.userPoints,
    required super.name,
    required super.imgPath,
    required super.description,
    required super.itemColor,
  });

  factory CollectionModel.fromMap(Map<String, dynamic> json) {
    return CollectionModel(
      id: json['id'] as int,
      name: json['name'] as String,
      skipPoints: json['skip_point'] as int,
      userPoints: json['child_answers_point'] ?? 0,
      imgPath: json['img'] ?? '',
      description: json['description'] ?? '',
      itemColor: json['color'] ?? '',
    );
  }
}

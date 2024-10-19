import 'package:my_portfolio/features/child_flow/questions/shared/entity/levels_group_entity.dart';

class LevelModel extends LevelAndCollectionEntity {
  const LevelModel({
    required super.id,
    required super.skipPoints,
    required super.userPoints,
    required super.name,
    required super.imgPath,
    required super.description,
    required super.itemColor,
  });

  factory LevelModel.fromMap(Map<String, dynamic> json) {
    return LevelModel(
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

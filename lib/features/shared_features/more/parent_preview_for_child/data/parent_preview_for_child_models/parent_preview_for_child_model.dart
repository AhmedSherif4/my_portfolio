
import '../../domain/parent_preview_for_child_entities/parent_preview_for_child_entity.dart';

class ParentPreviewForChildModel extends ParentPreviewForChildEntity {
  const ParentPreviewForChildModel({
    required super.parentId,
    required super.name,
    required super.phone,
    required super.email,
    required super.type,
    required super.gender,
    required super.imgPath,
    required super.username,
  });

  factory ParentPreviewForChildModel.fromJson(Map<String, dynamic> json) {
    return ParentPreviewForChildModel(
      parentId: json['id'] as int,
      name: json['name'] as String,
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
      type: json['type'] as String,
      gender: json['gendar'] as String,
      imgPath: json['img'] ?? '',
      username: json['username'] as String,
    );
  }
}

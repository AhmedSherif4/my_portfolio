import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'parent_preview_for_child_entity.g.dart';

@HiveType(typeId: 20)
class ParentPreviewForChildEntity extends Equatable {
  @HiveField(0)
  final int parentId;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String phone;
  @HiveField(3)
  final String email;
  @HiveField(4)
  final String type;
  @HiveField(5)
  final String gender;
  @HiveField(6)
  final String imgPath;
  @HiveField(7)
  final String username;

  const ParentPreviewForChildEntity(
      {required this.parentId,
      required this.name,
      required this.phone,
      required this.email,
      required this.type,
      required this.gender,
      required this.imgPath,
      required this.username});

  @override
  List<Object> get props => [
        parentId,
        name,
        phone,
        email,
        type,
        gender,
        imgPath,
        username,
      ];
}

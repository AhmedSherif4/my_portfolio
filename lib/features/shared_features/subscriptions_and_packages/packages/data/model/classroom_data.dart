import 'package:equatable/equatable.dart';

class ClassroomData  extends Equatable {
  final int classroomId;
  final int price;
  final bool havePaths;
  final List<PathsInClassroomModel>? pathsData;

  const ClassroomData({required this.classroomId, required this.price, required this.havePaths, this.pathsData});

  @override
  List<Object?> get props => [classroomId, price, havePaths, pathsData];
}

class PathsInClassroomModel extends Equatable {
  final int pathId;
  final String pathName;

  const PathsInClassroomModel({required this.pathId, required this.pathName});

  @override
  List<Object> get props => [pathId, pathName];

}
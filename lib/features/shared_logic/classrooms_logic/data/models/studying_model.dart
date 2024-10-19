import 'package:equatable/equatable.dart';

import '../../../../shared_features/subscriptions_and_packages/packages/data/model/classroom_data.dart';


class StudyingModel extends Equatable {
  final int id;
  final String name;
  final int? price;
  final bool? isPath;
  final List<PathsInClassroomModel>? paths;

  const StudyingModel({
    required this.id,
    required this.name,
    this.price,
    this.paths,
    this.isPath,
  });

  factory StudyingModel.fromJson(Map<String, dynamic> json) {
    return StudyingModel(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      isPath: json['paths_count'] != null ? json['paths_count'] > 0
          ? true
          : false : false,
    );
  }

  @override
  List<Object> get props => [
        id,
        name,
        paths ?? [],
        price ?? 0,
        isPath ?? false,
      ];
}

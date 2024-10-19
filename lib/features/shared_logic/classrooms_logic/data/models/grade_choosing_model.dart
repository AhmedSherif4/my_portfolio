import 'package:equatable/equatable.dart';

class GradeChoosingModel extends Equatable {
  final String message;
  final bool status;

  const GradeChoosingModel({
    required this.message,
    required this.status,
  });

  factory GradeChoosingModel.fromJson(Map<String, dynamic> json) {
    return GradeChoosingModel(
      message: json['message'],
      status: json['status'],
    );
  }

  @override
  List<Object> get props => [
        message,
        status,
      ];
}

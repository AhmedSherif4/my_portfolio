import 'package:equatable/equatable.dart';

class AnswerModel extends Equatable {
  final int point;
  final String message;

  const AnswerModel({required this.point, required this.message});

  factory AnswerModel.fromJson(Map<String, dynamic> json) {
    return AnswerModel(
      message: json['message'] ?? '',
      point: json['data']['total_point'] ?? 0,
    );
  }

  @override
  List<Object> get props => [point, message];
}

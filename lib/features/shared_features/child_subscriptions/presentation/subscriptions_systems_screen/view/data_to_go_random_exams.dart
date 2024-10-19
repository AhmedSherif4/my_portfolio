
import 'package:equatable/equatable.dart';
import 'package:my_portfolio/core/shared_models/user/user_entity/user_entity.dart';
import 'package:my_portfolio/features/child_flow/exams/exams/data_to_go_exams.dart';


class DataToGoRandomExams extends Equatable {
  final DataToGoExams? dataToGoExams;
  final UserEntity user;
  final bool isPrimary;
  final bool? fromSubscription;
  final bool isRandomExam;

  const DataToGoRandomExams({
    required this.user,
    required this.isPrimary,
    this.dataToGoExams,
    this.fromSubscription,
    required this.isRandomExam,
  });

  DataToGoRandomExams copyWith({
    DataToGoExams? dataToGoExams,
    UserEntity? user,
    bool? isPrimary,
    bool? fromSubscription,
    bool? isRandomExam,
  }) {
    return DataToGoRandomExams(
      dataToGoExams: dataToGoExams ?? this.dataToGoExams,
      user: user ?? this.user,
      isPrimary: isPrimary ?? this.isPrimary,
      fromSubscription: fromSubscription ?? this.fromSubscription,
      isRandomExam: isRandomExam ?? this.isRandomExam,
    );
  }

  @override
  List<Object?> get props => [
    user,
    isPrimary,
    fromSubscription,
    isRandomExam,
    dataToGoExams
  ];
}

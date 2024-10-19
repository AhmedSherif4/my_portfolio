import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'child_common_questions_entity.g.dart';

@HiveType(typeId: 19)
class CommonQuestionEntity extends Equatable {
  @HiveField(0)
  final String question;
  @HiveField(1)
  final String answer;

  const CommonQuestionEntity({required this.question, required this.answer});

  @override
  List<Object> get props => [question, answer];
}

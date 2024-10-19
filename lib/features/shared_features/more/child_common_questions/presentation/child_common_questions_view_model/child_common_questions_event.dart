part of '../../child_common_questions.dart';

abstract class ChildCommonQuestionsEvent extends Equatable {
  const ChildCommonQuestionsEvent();

  @override
  List<Object> get props => [];
}

class GetAllChildCommonQuestionsEvent extends ChildCommonQuestionsEvent {}

part of '../../exams.dart';

abstract class ExamsEvent extends Equatable {
  const ExamsEvent();

}

class GetExamsOfThatSubject extends ExamsEvent {
  final int systemId;
  final int subjectId;
  final int stageId;
  final int termId;
  final int classroomId;
  final int? pathId;
  final int selectedIndex;
  const GetExamsOfThatSubject({
    required this.systemId,
    required this.subjectId,
    required this.stageId,
    required this.termId,
    required this.pathId,
    required this.classroomId,
    required this.selectedIndex,
  });
  @override
  List<Object?> get props => [
        systemId,
        pathId,
        subjectId,
        stageId,
        termId,
        classroomId,
        selectedIndex,
      ];
}

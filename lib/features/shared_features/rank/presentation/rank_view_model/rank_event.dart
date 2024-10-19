part of '../../rank.dart';

abstract class RankEvent extends Equatable {
  const RankEvent();
}

class GotUserRankClassroom extends RankEvent {
  final int systemID;
  final int stageID;
  final int classroomID;
  final int pageNumber;

  const GotUserRankClassroom({
    required this.systemID,
    required this.stageID,
    required this.classroomID,
    required this.pageNumber,
  });

  @override
  List<Object> get props => [
    systemID,
        stageID,
        classroomID,
        pageNumber,
      ];
}

class GotUserRankTerm extends RankEvent {
  final int systemID;
  final int stageID;
  final int classroomID;
  final int termID;
  final int? pathID;
  final int pageNumber;

  const GotUserRankTerm({
    required this.systemID,
    required this.stageID,
    required this.classroomID,
    required this.termID,
     this.pathID,
    required this.pageNumber,
  });

  @override
  List<Object?> get props => [
    systemID,
        stageID,
        classroomID,
        termID,
    pathID,
        pageNumber,
      ];
}

class GotUserRankSubject extends RankEvent {
  final int systemID;
  final int stageID;
  final int classroomID;
  final int termID;
  final int pathID;
  final int subjectID;
  final int pageNumber;

  const GotUserRankSubject({
    required this.systemID,
    required this.stageID,
    required this.classroomID,
    required this.termID,
    required this.pathID,
    required this.subjectID,
    required this.pageNumber,
  });

  @override
  List<Object> get props => [
    systemID,
        stageID,
        classroomID,
        termID,
    pathID,
        subjectID,
        pageNumber,
      ];
}


class GotSubjectsForRank extends RankEvent {
  final ParameterGoToQuestions subjectParameters;

  const GotSubjectsForRank({required this.subjectParameters});

  @override
  List<Object> get props => [subjectParameters];
}

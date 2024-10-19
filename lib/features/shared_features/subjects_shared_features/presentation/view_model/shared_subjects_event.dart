part of '../../subjects_shared_features.dart';


abstract class SharedSubjectsEvent extends Equatable {
  const SharedSubjectsEvent();
}

class GetSharedSubjectsEvent extends SharedSubjectsEvent {
  final ParameterGoToQuestions parameter;

  const GetSharedSubjectsEvent({required this.parameter});

  @override
  List<Object> get props => [parameter];
}

class GetIdOfThatSubject extends SharedSubjectsEvent {
  final int subjectId;
  final int selectedIndex;
  const GetIdOfThatSubject({
    required this.subjectId,
    required this.selectedIndex,
  });
  @override
  List<Object?> get props => [subjectId,
    selectedIndex,
  ];
}

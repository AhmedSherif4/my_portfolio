part of '../../statics.dart';

class StaticsState extends Equatable {
  final RequestStates getTimeInAppStates;
  final String geTimeInAppMessage;
  final TimeInAppModel? timeInAppdata;

  final RequestStates subjectsStates;
  final String subjectsErrorMessage;
  final List<SubjectsEntity> subjects;

  final RequestStates lessonsStaticsStates;
  final String lessonsStaticsErrorMessage;
  final LessonsStaticsModel? lessonsStatics;

  final RequestStates bestSubjectsStates;
  final String bestSubjectsErrorMessage;
  final List<BestSubjectsModel> bestSubjects;

  const StaticsState({
    this.getTimeInAppStates = RequestStates.initial,
    this.geTimeInAppMessage = '',
    this.timeInAppdata,
    this.subjectsStates = RequestStates.initial,
    this.subjectsErrorMessage = '',
    this.subjects = const <SubjectsEntity>[],
    this.lessonsStaticsStates = RequestStates.initial,
    this.lessonsStaticsErrorMessage = '',
    this.lessonsStatics,
    this.bestSubjectsStates = RequestStates.initial,
    this.bestSubjectsErrorMessage = '',
    this.bestSubjects = const <BestSubjectsModel>[],
  });

  StaticsState copyWith({
    RequestStates? getTimeInAppStates,
    String? geTimeInAppMessage,
    TimeInAppModel? timeInAppdata,
    RequestStates? subjectsStates,
    String? subjectsErrorMessage,
    List<SubjectsEntity>? subjects,
    RequestStates? lessonsStaticsStates,
    String? lessonsStaticsErrorMessage,
    LessonsStaticsModel? lessonsStatics,
    RequestStates? bestSubjectsStates,
    String? bestSubjectsErrorMessage,
    List<BestSubjectsModel>? bestSubjects,
  }) {
    return StaticsState(
      geTimeInAppMessage: geTimeInAppMessage ?? this.geTimeInAppMessage,
      getTimeInAppStates: getTimeInAppStates ?? this.getTimeInAppStates,
      timeInAppdata: timeInAppdata ?? this.timeInAppdata,
      subjectsStates: subjectsStates ?? this.subjectsStates,
      subjectsErrorMessage: subjectsErrorMessage ?? this.subjectsErrorMessage,
      subjects: subjects ?? this.subjects,
      lessonsStaticsStates: lessonsStaticsStates ?? this.lessonsStaticsStates,
      lessonsStaticsErrorMessage:
          lessonsStaticsErrorMessage ?? this.lessonsStaticsErrorMessage,
      lessonsStatics: lessonsStatics ?? this.lessonsStatics,
      bestSubjectsStates: bestSubjectsStates ?? this.bestSubjectsStates,
      bestSubjectsErrorMessage:
          bestSubjectsErrorMessage ?? this.bestSubjectsErrorMessage,
      bestSubjects: bestSubjects ?? this.bestSubjects,
    );
  }

  @override
  List<Object?> get props => [
        getTimeInAppStates,
        geTimeInAppMessage,
        timeInAppdata,
        subjectsStates,
        subjectsErrorMessage,
        subjects,
        lessonsStaticsStates,
        lessonsStaticsErrorMessage,
        lessonsStatics,
        bestSubjectsStates,
        bestSubjectsErrorMessage,
        bestSubjects,
      ];
}

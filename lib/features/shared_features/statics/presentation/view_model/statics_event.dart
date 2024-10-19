part of '../../statics.dart';


abstract class StaticsEvent extends Equatable {
  const StaticsEvent();
}

class GetTimeInAppEvent extends StaticsEvent {
  final TimeInAppInputs? timeInAppInputs;

  const GetTimeInAppEvent({this.timeInAppInputs});

  @override
  List<Object?> get props => [timeInAppInputs];
}

class GetSubjectsForStaticsEvent extends StaticsEvent {
  final GetStaticsParam staticsParam;

  const GetSubjectsForStaticsEvent({required this.staticsParam});

  @override
  List<Object?> get props => [staticsParam];
}

class GetLessonsStaticsEvent extends StaticsEvent {
  final GetStaticsParam lessonsStaticsParam;

  const GetLessonsStaticsEvent({required this.lessonsStaticsParam});

  @override
  List<Object?> get props => [lessonsStaticsParam];
}

class GetBestSubjectsEvent extends StaticsEvent {
  final GetStaticsParam bestSubjectsParm;

  const GetBestSubjectsEvent({required this.bestSubjectsParm});

  @override
  List<Object?> get props => [bestSubjectsParm];
}

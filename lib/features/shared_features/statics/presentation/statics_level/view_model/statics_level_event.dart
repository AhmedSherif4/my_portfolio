part of '../../../statics.dart';

abstract class StaticsLevelEvent extends Equatable {
  const StaticsLevelEvent();
}

class GetLevelStaticsEvent extends StaticsLevelEvent {
  final GetStaticsParam levelStaticsParam;

  const GetLevelStaticsEvent({required this.levelStaticsParam});

  @override
  List<Object?> get props => [levelStaticsParam];
}

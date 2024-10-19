part of '../../../statics.dart';

class StaticsLevelState extends Equatable {
  final RequestStates levelStaticsStates;
  final String levelStaticsErrorMessage;
  final LevelStaticsModel? levelStatics;

  const StaticsLevelState({
    this.levelStaticsStates = RequestStates.initial,
    this.levelStaticsErrorMessage = '',
    this.levelStatics,
  });

  StaticsLevelState copyWith({
    RequestStates? levelStaticsStates,
    String? levelStaticsErrorMessage,
    LevelStaticsModel? levelStatics,
  }) {
    return StaticsLevelState(
      levelStaticsStates: levelStaticsStates ?? this.levelStaticsStates,
      levelStaticsErrorMessage:
          levelStaticsErrorMessage ?? this.levelStaticsErrorMessage,
      levelStatics: levelStatics ?? this.levelStatics,
    );
  }

  @override
  List<Object?> get props => [
        levelStaticsStates,
        levelStaticsErrorMessage,
        levelStatics,
      ];
}

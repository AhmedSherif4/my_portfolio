part of '../../levels.dart';

class LevelsState extends Equatable {
  final RequestStates levelsStates;
  final String levelsErrorMessage;
  final List<LevelAndCollectionEntity> levels;
  final LevelAndCollectionEntity? currentLevel;

  const LevelsState({
    this.levelsStates = RequestStates.initial,
    this.levelsErrorMessage = '',
    this.levels = const <LevelAndCollectionEntity>[],
    this.currentLevel,
  });

  LevelsState copyWith({
    RequestStates? levelsStates,
    String? levelsErrorMessage,
    List<LevelAndCollectionEntity>? levels,
    LevelAndCollectionEntity? currentLevel,
  }) {
    return LevelsState(
      levelsStates: levelsStates ?? this.levelsStates,
      levelsErrorMessage: levelsErrorMessage ?? this.levelsErrorMessage,
      levels: levels ?? this.levels,
      currentLevel: currentLevel ?? this.currentLevel,
    );
  }

  @override
  List<Object?> get props => [
        levelsStates,
        levelsErrorMessage,
        levels,
        currentLevel,
      ];
}

part of '../../home.dart';

class HomeState extends Equatable {
  final RequestStates getPuzzleAndAdviceState;
  final String puzzleAnswer;
  final String puzzleAndAdviceMessage;
  final PuzzleAndAdviceEntity puzzleAndAdviceEntity;

  const HomeState({
    this.getPuzzleAndAdviceState = RequestStates.initial,
    this.puzzleAnswer = "",
    this.puzzleAndAdviceMessage = '',
    this.puzzleAndAdviceEntity =
        const PuzzleAndAdviceEntity(advice: '', content: '', correctSelect: "", select1: "", select2: "", select3: "", select4: ""),
  });

  HomeState copyWith({
    RequestStates? getPuzzleAndAdviceState,
    String? puzzleAnswer,
    String? puzzleAndAdviceMessage,
    PuzzleAndAdviceEntity? puzzleAndAdviceEntity,
    RequestStates? subjectsStates,
    String? subjectsErrorMessage,
    List<SubjectsEntity>? subjects,

  }) {
    return HomeState(
      getPuzzleAndAdviceState:
          getPuzzleAndAdviceState ?? this.getPuzzleAndAdviceState,
      puzzleAndAdviceMessage:
          puzzleAndAdviceMessage ?? this.puzzleAndAdviceMessage,
      puzzleAndAdviceEntity:
          puzzleAndAdviceEntity ?? this.puzzleAndAdviceEntity,
      puzzleAnswer: puzzleAnswer ?? this.puzzleAnswer,
    );
  }

  @override
  List<Object?> get props => [
        getPuzzleAndAdviceState,
        puzzleAndAdviceMessage,
        puzzleAndAdviceEntity,
        puzzleAnswer
      ];
}

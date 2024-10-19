part of '../../levels.dart';

@Injectable()
class LevelsBloc extends Bloc<LevelsEvent, LevelsState> {
  final LevelsUseCase levelsUseCase;

  LevelsBloc(this.levelsUseCase) : super(const LevelsState()) {
    on<GetAllLevels>((event, emit) async {
      {
        emit(
          state.copyWith(
            levelsStates: RequestStates.loading,
          ),
        );
        final result = await levelsUseCase(event.parameters);
        result.fold(
          (failure) => emit(state.copyWith(
            levelsStates: RequestStates.error,
            levelsErrorMessage: failure.message,
          )),
          (levels) {
            List<LevelAndCollectionEntity> level = [];
            if (levels.isNotEmpty) {
              for (var element in levels) {
                levels.first == element ? level.add(element) : null;
                element.skipPoints <= element.userPoints
                    ? level.contains(element)
                        ? null
                        : level.add(element)
                    : null;
              }
              emit(
                state.copyWith(
                  levelsStates: RequestStates.loaded,
                  levels: levels,
                  currentLevel: level.last,
                ),
              );
            } else {
              emit(
                state.copyWith(
                  levelsStates: RequestStates.loaded,
                  levels: levels,
                ),
              );
            }
          },
        );
      }
    });
  }
}

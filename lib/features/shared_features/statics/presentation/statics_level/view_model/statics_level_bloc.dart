part of '../../../statics.dart';


@Injectable()
class StaticsLevelBloc extends Bloc<StaticsLevelEvent, StaticsLevelState> {
  final GetLevelStaticsUseCase levelStaticsUseCase;

  StaticsLevelBloc(this.levelStaticsUseCase)
      : super(const StaticsLevelState()) {
    on<GetLevelStaticsEvent>(_getLessonsStatics);
  }

  List<DataForCharts> pointForCharts = [];
  List<DataForCharts> timeForCharts = [];
  List<DataForCharts> attemptsForCharts = [];

  FutureOr<void> _getLessonsStatics(
      GetLevelStaticsEvent event, Emitter<StaticsLevelState> emit) async {
    pointForCharts.clear();
    timeForCharts.clear();
    attemptsForCharts.clear();
    emit(
      state.copyWith(
        levelStaticsStates: RequestStates.loading,
      ),
    );
    final result = await levelStaticsUseCase(event.levelStaticsParam);

    result.fold((failure) {
      emit(
        state.copyWith(
          levelStaticsStates: RequestStates.error,
          levelStaticsErrorMessage: failure.message,
        ),
      );
    }, (levelStatics) {
      if (levelStatics.groupData.isNotEmpty) {
        for (int i = 0; i <= levelStatics.groupData.length - 1; i++) {
          pointForCharts.add(DataForCharts(
              index: i + 1, data: levelStatics.groupData[i].point));
          timeForCharts.add(DataForCharts(
              index: i + 1, data: levelStatics.groupData[i].answerTime));
          attemptsForCharts.add(DataForCharts(
              index: i + 1, data: levelStatics.groupData[i].attempts));
        }
      }
      emit(state.copyWith(
        levelStaticsStates: RequestStates.loaded,
        levelStatics: levelStatics,
      ));
    });
  }
}

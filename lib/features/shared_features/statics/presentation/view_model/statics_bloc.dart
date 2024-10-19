part of '../../statics.dart';


@Injectable()
class StaticsBloc extends Bloc<StaticsEvent, StaticsState> {
  final GetTimeInAppUseCase timeInAppUseCase;
  final GetSubjectsForStaticsUseCase subjectsForStaticsUseCase;
  final GetLessonsStaticsUseCase lessonsForStaticsUseCase;
  final GetBestSubjectsUseCase bestSubjectsUseCase;

  StaticsBloc(this.timeInAppUseCase, this.subjectsForStaticsUseCase,
      this.lessonsForStaticsUseCase, this.bestSubjectsUseCase)
      : super(const StaticsState()) {
    on<GetTimeInAppEvent>(_getStatics);
    on<GetSubjectsForStaticsEvent>(_getSubjectsForStatics);
    on<GetLessonsStaticsEvent>(_getLessonsStatics);
    on<GetBestSubjectsEvent>(_getBestSubjects);
  }

  void _getStatics(GetTimeInAppEvent event, Emitter<StaticsState> emit) async {
    emit(state.copyWith(
      getTimeInAppStates: RequestStates.loading,
    ));
    final result = await timeInAppUseCase(event.timeInAppInputs!);
    result.fold(
      (failure) => emit(state.copyWith(
        getTimeInAppStates: RequestStates.error,
        geTimeInAppMessage: failure.message,
      )),
      (success) => emit(state.copyWith(
        getTimeInAppStates: RequestStates.loaded,
        timeInAppdata: success,
      )),
    );
  }

  FutureOr<void> _getSubjectsForStatics(
      GetSubjectsForStaticsEvent event, Emitter<StaticsState> emit) async {
    emit(
      state.copyWith(
        subjectsStates: RequestStates.loading,
      ),
    );
    final result = await subjectsForStaticsUseCase(event.staticsParam);

    result.fold((failure) {
      emit(
        state.copyWith(
          subjectsStates: RequestStates.error,
          subjectsErrorMessage: failure.message,
        ),
      );
    }, (subjects) {
      emit(state.copyWith(
        subjectsStates: RequestStates.loaded,
        subjects: subjects,
      ));
    });
  }

  List<DataForCharts> pointForCharts = [];
  List<DataForCharts> timeForCharts = [];
  List<DataForCharts> attemptsForCharts = [];

  FutureOr<void> _getLessonsStatics(
      GetLessonsStaticsEvent event, Emitter<StaticsState> emit) async {
    pointForCharts.clear();
    timeForCharts.clear();
    attemptsForCharts.clear();
    emit(
      state.copyWith(
        lessonsStaticsStates: RequestStates.loading,
      ),
    );
    final result = await lessonsForStaticsUseCase(event.lessonsStaticsParam);

    result.fold((failure) {
      emit(
        state.copyWith(
          lessonsStaticsStates: RequestStates.error,
          lessonsStaticsErrorMessage: failure.message,
        ),
      );
    }, (lessons) {
      if (lessons.lessonsData.isNotEmpty) {
        for (int i = 0; i <= lessons.lessonsData.length - 1; i++) {
          pointForCharts.add(
              DataForCharts(index: i + 1, data: lessons.lessonsData[i].point));
          timeForCharts.add(DataForCharts(
              index: i + 1, data: (lessons.lessonsData[i].answerTime ~/ 60) ));
          attemptsForCharts.add(DataForCharts(
              index: i + 1, data: lessons.lessonsData[i].attempts));
        }
      }
      emit(state.copyWith(
        lessonsStaticsStates: RequestStates.loaded,
        lessonsStatics: lessons,
      ));
    });
  }

  FutureOr<void> _getBestSubjects(
      GetBestSubjectsEvent event, Emitter<StaticsState> emit) async {
    emit(
      state.copyWith(
        bestSubjectsStates: RequestStates.loading,
      ),
    );
    final result = await bestSubjectsUseCase(event.bestSubjectsParm);

    result.fold((failure) {
      emit(
        state.copyWith(
          bestSubjectsStates: RequestStates.error,
          bestSubjectsErrorMessage: failure.message,
        ),
      );
    }, (bestSubjects) {
      emit(state.copyWith(
        bestSubjectsStates: RequestStates.loaded,
        bestSubjects: bestSubjects,
      ));
    });
  }
}

class DataForCharts extends Equatable {
  final int index;
  final int data;

  const DataForCharts({required this.index, required this.data});

  @override
  List<Object> get props => [index, data];
}

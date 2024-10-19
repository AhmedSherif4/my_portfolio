part of '../../lessons.dart';

@Injectable()
class LessonsBloc extends Bloc<LessonsEvent, LessonsState> {
  final GetLessonsUseCase getLessonsUseCase;
  final GetLessonsByUnitUseCase getLessonsWithUnitsUseCase;
  // final LessonsLocalDataSource lessonsLocalDataSource;

  LessonsBloc(
      this.getLessonsUseCase,
      this.getLessonsWithUnitsUseCase,
      // this.lessonsLocalDataSource
      )
      : super(const LessonsState()) {

    on<GetAllLessonsEvent>((event, emit) async {
      emit(state.copyWith(getAllLessonsState: RequestStates.loading));
      final data = await getLessonsUseCase(event.lessonParameters);
      data.fold(
        (l) => emit(
          state.copyWith(
            getAllLessonsState: RequestStates.error,
          ),
        ),
        (r) => emit(
          state.copyWith(
            getAllLessonsState: RequestStates.loaded,
            allLessons: r,
          ),
        ),
      );
    });
    on<GetAllLessonsByUnitsEvent>((event, emit) async {
      emit(state.copyWith(getAllLessonsState: RequestStates.loading));
      final data = await getLessonsWithUnitsUseCase(event.lessonParameters);
      data.fold(
        (l) => emit(
          state.copyWith(
            getAllLessonsState: RequestStates.error,
          ),
        ),
        (r) => emit(
          state.copyWith(
            getAllLessonsState: RequestStates.loaded,
            allLessonsByUnits: r,
          ),
        ),
      );
    });



    // on<UpdatePointAfterAnswerQuestionsEvent>((event, emit) async {
    //   final listOfLessons = await lessonsLocalDataSource.getLessonsInLocalData(subjectId: event.lessonParameters.subjectId,);
    //   final LessonEntity updatedLesson =
    //   listOfLessons![event.lessonParameters.index].copyWith(
    //     lessonUserPoints: listOfLessons[event.lessonParameters.index]
    //           .lessonUserPoints);
    //   await lessonsLocalDataSource.updateLesson(
    //       index:event.lessonParameters.index,
    //       subjectId: event.lessonParameters.subjectId,
    //       updatedUserPoint: updatedLesson.lessonUserPoints);
    //   emit(state.copyWith(
    //     updatePointAfterAnswerQuestionsState: RequestStates.loaded,
    //   ));
    // });

    // on<UpdatePointAfterAnswerQuestionsEventWithUnit>((event, emit) async {
    //   final listOfLessons = await lessonsLocalDataSource.getLessonsWithUnitsInLocalData(subjectId:
    //      event.lessonParameters.subjectId);
    //
    //   final LessonEntity updatedLesson =
    //   listOfLessons![event.lessonParameters.unitIndex!].unitLessons[event.lessonParameters.index].copyWith(
    //       lessonUserPoints: listOfLessons[event.lessonParameters.index].unitLessons[event.lessonParameters.index]
    //           .lessonUserPoints);
    //   await lessonsLocalDataSource.updateLessonsWithUnits(
    //       index: event.lessonParameters.index,
    //       subjectId: event.lessonParameters.subjectId,
    //       updatedUserPoint: updatedLesson.lessonUserPoints);
    //   emit(state.copyWith(
    //     updatePointAfterAnswerQuestionsState: RequestStates.loaded,
    //   ));
    // });


  }
}

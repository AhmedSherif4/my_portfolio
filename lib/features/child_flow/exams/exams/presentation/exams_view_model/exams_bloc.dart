part of '../../exams.dart';

@Injectable()
class ExamsBloc extends Bloc<ExamsEvent, ExamsState> {
  final ExamsUseCase examsUseCase;
  ExamsBloc(
    this.examsUseCase,
  ) : super(const ExamsState()) {
    on<GetExamsOfThatSubject>(_getExamsOfThatSubject);
  }

  FutureOr<void> _getExamsOfThatSubject(
      GetExamsOfThatSubject event, Emitter<ExamsState> emit) async {
    emit(state.copyWith(
      getExamsRequestState: RequestStates.loading,
      selectedSubject: event.selectedIndex,
    ));
    final result = await examsUseCase(ExamsParameter(
      systemId: event.systemId,
      subjectId: event.subjectId,
      stageId: event.stageId,
      termId: event.termId,
      classroomId: event.classroomId,
      pathId: event.pathId,
    ));
    result.fold(
      (l) => emit(
        state.copyWith(
          getExamsRequestState: RequestStates.error,
          getExamsErrorMessage: l.message,
        ),
      ),
      (exams) => emit(
        state.copyWith(
          getExamsRequestState: RequestStates.loaded,
          exams: exams,
        ),
      ),
    );
  }
}

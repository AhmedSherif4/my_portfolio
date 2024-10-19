part of '../../subjects_shared_features.dart';

@injectable
class SharedSubjectsBloc
    extends Bloc<SharedSubjectsEvent, SharedSubjectsState> {
  final GetSharedSubjectsUseCase getSharedSubjectsUseCase;

  SharedSubjectsBloc(this.getSharedSubjectsUseCase)
      : super(const SharedSubjectsState()) {
    on<GetSharedSubjectsEvent>((event, emit) async {
      emit(
        state.copyWith(
          getSubjectsState: RequestStates.loading,
        ),
      );
      final result = await getSharedSubjectsUseCase(event.parameter);

      result.fold((failure) {
        emit(
          state.copyWith(
            getSubjectsState: RequestStates.error,
            getSubjectsStateMessage: failure.message,
          ),
        );
      }, (subjects) {
        emit(state.copyWith(
          getSubjectsState: RequestStates.loaded,
          subjects: subjects,
        ));
      });
    });
    on<GetIdOfThatSubject>((event, emit) async {
      emit(state.copyWith(
        getSubjectIdState: RequestStates.loaded,
        selectedSubject: event.selectedIndex,
        selectedSubjectId: event.subjectId,
      ));
    });
  }
}

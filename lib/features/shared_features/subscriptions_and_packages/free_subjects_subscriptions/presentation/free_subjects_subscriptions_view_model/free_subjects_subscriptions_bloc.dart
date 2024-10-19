part of '../../free_subjects_subscriptions.dart';

@Injectable()
class FreeSubjectsSubscriptionsBloc extends Bloc<FreeSubjectsSubscriptionsEvent,
    FreeSubjectsSubscriptionsState> {
  final GetSystemTypesUseCase getSystemUseCase;
  final GetStagesUseCase getStagesUseCase;
  final GetClassRoomUseCase getClassRoomUseCase;
  final GetTermsUseCase getTermsUseCase;
  final GetPathsUseCase getPathsUseCase;
  final GetSubjectsFreeSubjectsSubscriptionsUseCase getSubjectsUseCase;
  FreeSubjectsSubscriptionsBloc(
    this.getSystemUseCase,
    this.getStagesUseCase,
    this.getClassRoomUseCase,
    this.getTermsUseCase,
    this.getPathsUseCase,
    this.getSubjectsUseCase,
  ) : super(const FreeSubjectsSubscriptionsState()) {
    on<GetSystemFreeSubjectsEvent>(_getSystemFreeSubjectsEvent);
    on<GetStagesFreeSubjectsEvent>(_getStagesFreeSubjectsEvent);
    on<GetClassRoomFreeSubjectsEvent>(_getClassRoomsFreeSubjectsEvent);
    on<GetTermsFreeSubjectsEvent>(_getTermsFreeSubjectsEvent);
    on<GetPathsFreeSubjectsEvent>(_getPathsFreeSubjectsEvent);
    // on<GetSubjectsFreeSubjectsEvent>(_getSubjectsFreeSubjectsEvent);

    on<ChangeSystemFreeSubjectsEvent>(_changeSystemFreeSubjectsEvent);
    on<ChangeStageFreeSubjectsEvent>(_changeStageFreeSubjectsEvent);
    on<ChangeClassRoomFreeSubjectsEvent>(_changeClassRoomFreeSubjectsEvent);
    on<ChangeTermFreeSubjectsEvent>(_changeTermFreeSubjectsEvent);
    on<ChangePathFreeSubjectsEvent>(_changePathFreeSubjectsEvent);
  }

  FutureOr<void> _getSystemFreeSubjectsEvent(GetSystemFreeSubjectsEvent event,
      Emitter<FreeSubjectsSubscriptionsState> emit) async {
    emit(state.copyWith(
      getSystemState: RequestStates.loading,
    ));
    final result = await getSystemUseCase(const NoParameter());
    result.fold((failure) {
      emit(state.copyWith(
        getSystemState: RequestStates.error,
      ));
    }, (success) {
      emit(state.copyWith(
        getSystemState: RequestStates.loaded,
        systems: success.isNotEmpty
            ? success
            : [const StudyingModel(id: -1, name: 'No Terms Now')],
        currentSystem: success.isNotEmpty
            ? success[0]
            : const StudyingModel(id: -1, name: 'No Terms Now'),
      ));
      add(GetStagesFreeSubjectsEvent(
        state.currentSystem.id,
      ));
    });
  }

  FutureOr<void> _getStagesFreeSubjectsEvent(GetStagesFreeSubjectsEvent event,
      Emitter<FreeSubjectsSubscriptionsState> emit) async {
    emit(
      state.copyWith(
        getStagesState: RequestStates.loading,
      ),
    );
    final result = await getStagesUseCase(event.systemId);
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            getStagesState: RequestStates.error,
          ),
        );
      },
      (success) {
        emit(
          state.copyWith(
            getStagesState: RequestStates.loaded,
            stages: success.isNotEmpty
                ? success
                : [const StudyingModel(id: -1, name: 'No Terms Now')],
            currentStage: success.isNotEmpty
                ? success[0]
                : const StudyingModel(id: -1, name: 'No Terms Now'),
          ),
        );
        add(GetClassRoomFreeSubjectsEvent(GetClassRoomParameter(
            stageId: state.currentStage.id)));
      },
    );
  }

  FutureOr<void> _getClassRoomsFreeSubjectsEvent(
      GetClassRoomFreeSubjectsEvent event,
      Emitter<FreeSubjectsSubscriptionsState> emit) async {
    emit(
      state.copyWith(
        getClassRoomsState: RequestStates.loading,
      ),
    );
    final result = await getClassRoomUseCase(event.getClassRoomParameter);
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            getClassRoomsState: RequestStates.error,
          ),
        );
      },
      (success) {
        emit(
          state.copyWith(
            getClassRoomsState: RequestStates.loaded,
            classRooms: success.isNotEmpty
                ? success
                : [const StudyingModel(id: -1, name: 'No Class Room Now')],
            currentClassRoom: success.isNotEmpty
                ? success[0]
                : const StudyingModel(id: -1, name: 'No Class Room Now'),
          ),
        );
        add(GetTermsFreeSubjectsEvent(GetTermsParameters(
            systemId: state.currentSystem.id,
            stageId: state.currentStage.id,
            classRoomId: state.currentClassRoom.id)));
      },
    );
  }

  FutureOr<void> _getTermsFreeSubjectsEvent(GetTermsFreeSubjectsEvent event,
      Emitter<FreeSubjectsSubscriptionsState> emit) async {
    emit(
      state.copyWith(
        getTermsState: RequestStates.loading,
      ),
    );
    final result = await getTermsUseCase(event.getTermsParameters);
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            getTermsState: RequestStates.error,
          ),
        );
      },
      (success) {
        emit(
          state.copyWith(
            getTermsState: RequestStates.loaded,
            terms: success.isNotEmpty
                ? success
                : [const StudyingModel(id: -1, name: 'No Terms Now')],
            currentTerm: success.isNotEmpty
                ? success[0]
                : const StudyingModel(id: -1, name: 'No Terms Now'),
          ),
        );
      },
    );
    if (state.terms.isNotEmpty && (state.terms[0].isPath ?? false)) {
      add(GetPathsFreeSubjectsEvent(GetPathParameters(
          systemId: state.currentSystem.id,
          stageId: state.currentStage.id,
          classRoomId: state.currentClassRoom.id,
          termId: state.currentTerm.id)));
    }
    // else {
    //   add(GetSubjectsFreeSubjectsEvent(FreeSubjectsSubscriptionsParameter(
    //     systemId: state.currentSystem.id,
    //     stageId: state.currentStage.id,
    //     classRoomId: state.currentClassRoom.id,
    //     termId: state.currentTerm.id,
    //   )));
    // }
  }

  FutureOr<void> _getPathsFreeSubjectsEvent(GetPathsFreeSubjectsEvent event,
      Emitter<FreeSubjectsSubscriptionsState> emit) async {
    emit(state.copyWith(
      getPathsState: RequestStates.loading,
    ));
    final result = await getPathsUseCase(event.getPathsParameters);
    result.fold(
      (failure) {
        emit(state.copyWith(
          getPathsState: RequestStates.error,
        ));
      },
      (success) {
        emit(state.copyWith(
          getPathsState: RequestStates.loaded,
          paths: success.isNotEmpty
              ? success
              : [const StudyingModel(id: -1, name: 'No Paths Now')],
          currentPath: success.isNotEmpty
              ? success[0]
              : const StudyingModel(id: -1, name: 'No Paths Now'),
        ));
        // add(GetSubjectsFreeSubjectsEvent(FreeSubjectsSubscriptionsParameter(
        //   systemId: state.currentSystem.id,
        //   stageId: state.currentStage.id,
        //   classRoomId: state.currentClassRoom.id,
        //   termId: state.currentTerm.id,
        //   pathId: state.currentPath.id,
        // )));
      },
    );
  }

  // FutureOr<void> _getSubjectsFreeSubjectsEvent(
  //     GetSubjectsFreeSubjectsEvent event,
  //     Emitter<FreeSubjectsSubscriptionsState> emit) async {
  //   emit(state.copyWith(
  //     getSubjectsState: RequestStates.loading,
  //   ));
  //   final result = await getSubjectsUseCase(
  //     FreeSubjectsSubscriptionsParameter(
  //       systemId: event.freeSubjectsSubscriptionsParameter.systemId,
  //       stageId: event.freeSubjectsSubscriptionsParameter.stageId,
  //       classRoomId: event.freeSubjectsSubscriptionsParameter.classRoomId,
  //       termId: event.freeSubjectsSubscriptionsParameter.termId,
  //       pathId: event.freeSubjectsSubscriptionsParameter.pathId,
  //     ),
  //   );
  //   result.fold(
  //     (failure) {
  //       emit(state.copyWith(
  //         getSubjectsState: RequestStates.error,
  //       ));
  //     },
  //     (success) {
  //       emit(state.copyWith(
  //         getSubjectsState: RequestStates.loaded,
  //         subjects: success,
  //       ));
  //     },
  //   );
  // }

  FutureOr<void> _changeSystemFreeSubjectsEvent(
      ChangeSystemFreeSubjectsEvent event,
      Emitter<FreeSubjectsSubscriptionsState> emit) {
    emit(state.copyWith(
      currentSystem: event.currentSystem,
      getStagesState: RequestStates.initial,
      getClassRoomsState: RequestStates.initial,
      getTermsState: RequestStates.initial,
      getPathsState: RequestStates.initial,
      getSubjectsState: RequestStates.initial,
      stages: [],
      classRooms: [],
      terms: [],
      paths: [],
    ));
    add(GetStagesFreeSubjectsEvent(state.currentSystem.id));
  }

  FutureOr<void> _changeStageFreeSubjectsEvent(
      ChangeStageFreeSubjectsEvent event,
      Emitter<FreeSubjectsSubscriptionsState> emit) {
    emit(state.copyWith(
      currentStage: event.currentStage,
      getClassRoomsState: RequestStates.initial,
      getTermsState: RequestStates.initial,
      getPathsState: RequestStates.initial,
      getSubjectsState: RequestStates.initial,
      classRooms: [],
      terms: [],
      paths: [],
    ));
    add(GetClassRoomFreeSubjectsEvent(GetClassRoomParameter(stageId: state.currentStage.id)));
  }

  FutureOr<void> _changeClassRoomFreeSubjectsEvent(
      ChangeClassRoomFreeSubjectsEvent event,
      Emitter<FreeSubjectsSubscriptionsState> emit) {
    emit(state.copyWith(
      currentClassRoom: event.currentClassRoom,
      getTermsState: RequestStates.initial,
      getPathsState: RequestStates.initial,
      getSubjectsState: RequestStates.initial,
      terms: [],
      paths: [],
    ));
    add(GetTermsFreeSubjectsEvent(GetTermsParameters(
        systemId: state.currentSystem.id,
        stageId: state.currentStage.id,
        classRoomId: state.currentClassRoom.id)));
  }

  FutureOr<void> _changeTermFreeSubjectsEvent(ChangeTermFreeSubjectsEvent event,
      Emitter<FreeSubjectsSubscriptionsState> emit) {
    emit(state.copyWith(
      currentTerm: event.currentTerm,
      getPathsState: RequestStates.initial,
      getSubjectsState: RequestStates.initial,
      paths: [],
    ));
    if (state.terms[0].isPath ?? false) {
      add(GetPathsFreeSubjectsEvent(GetPathParameters(
        systemId: state.currentSystem.id,
        stageId: state.currentStage.id,
        classRoomId: state.currentClassRoom.id,
        termId: state.currentTerm.id,
      )));
    }
    // else {
    //   add(
    //     GetSubjectsFreeSubjectsEvent(
    //       FreeSubjectsSubscriptionsParameter(
    //           systemId: state.currentSystem.id,
    //           stageId: state.currentStage.id,
    //           classRoomId: state.currentClassRoom.id,
    //           termId: state.currentTerm.id),
    //     ),
    //   );
    // }
  }

  FutureOr<void> _changePathFreeSubjectsEvent(ChangePathFreeSubjectsEvent event,
      Emitter<FreeSubjectsSubscriptionsState> emit) {
    emit(state.copyWith(
      currentPath: event.currentPath,
      getSubjectsState: RequestStates.initial,
    ));
    // add(GetSubjectsFreeSubjectsEvent(FreeSubjectsSubscriptionsParameter(
    //   systemId: state.currentSystem.id,
    //   stageId: state.currentStage.id,
    //   classRoomId: state.currentClassRoom.id,
    //   termId: state.currentTerm.id,
    //   pathId: state.currentPath.id,
    // )));
  }
}

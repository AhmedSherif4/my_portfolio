part of '../free_term_subscriptions.dart';

@Injectable()
class FreeTermSubscriptionsBloc
    extends Bloc<FreeTermSubscriptionsEvent, FreeTermSubscriptionsState> {
  final GetSystemTypesUseCase getSystemUseCase;
  final GetStagesUseCase getStagesUseCase;
  final GetClassRoomUseCase getClassRoomUseCase;
  final GetTermsUseCase getTermsUseCase;
  final GetPathsUseCase getPathsUseCase;

  FreeTermSubscriptionsBloc(
    this.getSystemUseCase,
    this.getStagesUseCase,
    this.getClassRoomUseCase,
    this.getTermsUseCase,
    this.getPathsUseCase,
  ) : super(const FreeTermSubscriptionsState()) {
    on<GetSystemFreeTermSubscriptionsEvent>(_getSystem);
    on<GetStagesFreeTermEvent>(_getStages);
    on<GetClassRoomFreeTermEvent>(_getClassRooms);
    on<GetTermsFreeTermEvent>(_getTerms);
    on<GetPathsFreeTermEvent>(_getPaths);

    on<ChangeSystemFreeTermEvent>(_changeSystem);
    on<ChangeStageFreeTermEvent>(_changeStage);
    on<ChangeClassRoomFreeTermEvent>(_changeClassRoom);
    on<ChangeTermFreeTermEvent>(_changeTerm);
  }

  FutureOr<void> _getSystem(GetSystemFreeTermSubscriptionsEvent event,
      Emitter<FreeTermSubscriptionsState> emit) async {
    emit(
      state.copyWith(
        getSystemState: RequestStates.loading,
      ),
    );
    final result = await getSystemUseCase(const NoParameter());
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            getSystemState: RequestStates.error,
          ),
        );
      },
      (success) {
        emit(
          state.copyWith(
            getSystemState: RequestStates.loaded,
            systems: success.isNotEmpty
                ? success
                : [const StudyingModel(id: -1, name: 'No Terms Now')],
            currentSystem: success.isNotEmpty
                ? success[0]
                : const StudyingModel(id: -1, name: 'No Terms Now'),
          ),
        );
        add(GetStagesFreeTermEvent(state.currentSystem.id));
      },
    );
  }

  FutureOr<void> _getStages(GetStagesFreeTermEvent event,
      Emitter<FreeTermSubscriptionsState> emit) async {
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
        add(GetClassRoomFreeTermEvent(GetClassRoomParameter(stageId: state.currentStage.id)));
      },
    );
  }

  FutureOr<void> _getClassRooms(GetClassRoomFreeTermEvent event,
      Emitter<FreeTermSubscriptionsState> emit) async {
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
        add(GetTermsFreeTermEvent(GetTermsParameters(
            systemId: state.currentSystem.id,
            stageId: state.currentStage.id,
            classRoomId: state.currentClassRoom.id)));
      },
    );
  }

  FutureOr<void> _getTerms(GetTermsFreeTermEvent event,
      Emitter<FreeTermSubscriptionsState> emit) async {
    emit(
      state.copyWith(getTermsState: RequestStates.loading),
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

        if (success.isNotEmpty && (success[0].isPath ?? false)) {
          add(GetPathsFreeTermEvent(GetPathParameters(
              systemId: state.currentSystem.id,
              stageId: state.currentStage.id,
              classRoomId: state.currentClassRoom.id,
              termId: state.currentTerm.id)));
        }
      },
    );
  }

  FutureOr<void> _getPaths(GetPathsFreeTermEvent event,
      Emitter<FreeTermSubscriptionsState> emit) async {
    emit(
      state.copyWith(getPathsState: RequestStates.loading),
    );
    final result = await getPathsUseCase(event.getPathsParameters);
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            getPathsState: RequestStates.error,
          ),
        );
      },
      (success) {
        emit(
          state.copyWith(
            getPathsState: RequestStates.loaded,
            paths: success.isNotEmpty
                ? success
                : [const StudyingModel(id: -1, name: 'No Paths Now')],
          ),
        );
      },
    );
  }

  FutureOr<void> _changeSystem(ChangeSystemFreeTermEvent event,
      Emitter<FreeTermSubscriptionsState> emit) {
    emit(state.copyWith(
      currentSystem: event.currentSystem,
      getStagesState: RequestStates.initial,
      getClassRoomsState: RequestStates.initial,
      getTermsState: RequestStates.initial,
      getPathsState: RequestStates.initial,
      stages: [],
      classRooms: [],
      terms: [],
      paths: [],
    ));
    add(GetStagesFreeTermEvent(state.currentSystem.id));
  }

  FutureOr<void> _changeStage(ChangeStageFreeTermEvent event,
      Emitter<FreeTermSubscriptionsState> emit) {
    emit(state.copyWith(
      currentStage: event.currentStage,
      getClassRoomsState: RequestStates.initial,
      getTermsState: RequestStates.initial,
      getPathsState: RequestStates.initial,
      classRooms: [],
      terms: [],
      paths: [],
    ));
    add(GetClassRoomFreeTermEvent(GetClassRoomParameter( stageId: state.currentStage.id)));
  }

  FutureOr<void> _changeClassRoom(ChangeClassRoomFreeTermEvent event,
      Emitter<FreeTermSubscriptionsState> emit) {
    emit(state.copyWith(
      currentClassRoom: event.currentClassRoom,
      getTermsState: RequestStates.initial,
      getPathsState: RequestStates.initial,
      terms: [],
      paths: [],
    ));
    add(
      GetTermsFreeTermEvent(
        GetTermsParameters(
          systemId: state.currentSystem.id,
          stageId: state.currentStage.id,
          classRoomId: state.currentClassRoom.id,
        ),
      ),
    );
  }

  FutureOr<void> _changeTerm(
      ChangeTermFreeTermEvent event, Emitter<FreeTermSubscriptionsState> emit) {
    emit(state.copyWith(
      currentTerm: event.currentTerm,
      getPathsState: RequestStates.initial,
      paths: [],
    ));
    if (state.terms[0].isPath ?? false) {
      add(GetPathsFreeTermEvent(GetPathParameters(
          systemId: state.currentSystem.id,
          stageId: state.currentStage.id,
          classRoomId: state.currentClassRoom.id,
          termId: state.currentTerm.id)));
    }
  }
}

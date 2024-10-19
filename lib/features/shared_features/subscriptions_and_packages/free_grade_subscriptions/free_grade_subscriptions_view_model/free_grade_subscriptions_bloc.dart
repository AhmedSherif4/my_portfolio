part of '../free_grade_subscriptions.dart';

@Injectable()
class FreeGradeSubscriptionsBloc
    extends Bloc<FreeGradeSubscriptionsEvent, FreeGradeSubscriptionsState> {
  final GetSystemTypesUseCase getSystemsUseCase;
  final GetStagesUseCase getStagesUseCase;
  final GetClassRoomUseCase getClassRoomUseCase;
  FreeGradeSubscriptionsBloc(
    this.getSystemsUseCase,
    this.getStagesUseCase,
    this.getClassRoomUseCase,
  ) : super(const FreeGradeSubscriptionsState()) {
    on<GetSystemsFreeGrade>(_getSystemsFreeGrade);
    on<GetStagesFreeGrade>(_getStagesFreeGrade);
    on<GetClassroomsFreeGrade>(_getClassesFreeGrade);
    on<ChangeStagesFreeGrade>(_changeStagesFreeGrade);
    on<ChangeSystemFreeGrade>(_changeSystemFreeGrade);
  }



  FutureOr<void> _getSystemsFreeGrade(GetSystemsFreeGrade event,
      Emitter<FreeGradeSubscriptionsState> emit) async {
    emit(
      state.copyWith(
        getSystemState: RequestStates.loading,
        // getStagesState: RequestStates.initial,
        // getClassroomsState: RequestStates.initial,
      ),
    );
    final result = await getSystemsUseCase(const NoParameter());
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
        add(GetStagesFreeGrade(systemId: state.currentSystem.id));
      },
    );
  }




  FutureOr<void> _getStagesFreeGrade(GetStagesFreeGrade event,
      Emitter<FreeGradeSubscriptionsState> emit) async {
    emit(
      state.copyWith(
        getStagesState: RequestStates.loading,
        // getClassroomsState: RequestStates.initial,
        // getSystemState: RequestStates.initial,
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
                : [const StudyingModel(id: -1, name: 'No stages Now')],
            currentStage: success.isNotEmpty
                ? success[0]
                : const StudyingModel(id: -1, name: 'No stages Now'),
          ),
        );
        add(GetClassroomsFreeGrade(getClassRoomParameters: GetClassRoomParameter(stageId: state.currentStage.id)));
      },
    );
  }

  FutureOr<void> _getClassesFreeGrade(GetClassroomsFreeGrade event,
      Emitter<FreeGradeSubscriptionsState> emit) async {
    emit(
      state.copyWith(
        // getSystemState: RequestStates.initial,
        // getStagesState: RequestStates.initial,
        getClassroomsState: RequestStates.loading,
      ),
    );
    final result = await getClassRoomUseCase(event.getClassRoomParameters);
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            getClassroomsState: RequestStates.error,
          ),
        );
      },
      (success) {
        emit(
          state.copyWith(
            getClassroomsState: RequestStates.loaded,
            classRooms: success.isNotEmpty
                ? success
                : [const StudyingModel(id: -1, name: 'No Class Room Now')],
          ),
        );
      },
    );
  }


  FutureOr<void> _changeSystemFreeGrade(
      ChangeSystemFreeGrade event, Emitter<FreeGradeSubscriptionsState> emit) {
    emit(
      state.copyWith(
        currentSystem: event.currentSystem,
        classRooms: [],
        getClassroomsState: RequestStates.initial,
      ),
    );
    add(GetStagesFreeGrade(systemId: state.currentSystem.id));
  }

  FutureOr<void> _changeStagesFreeGrade(
      ChangeStagesFreeGrade event, Emitter<FreeGradeSubscriptionsState> emit) {
    emit(
      state.copyWith(
        currentStage: event.currentStage,
      ),
    );
    add(GetClassroomsFreeGrade(getClassRoomParameters: GetClassRoomParameter(stageId: state.currentStage.id)));
  }
}

part of '../../classrooms_logic.dart';

@Injectable()
class GradeChoosingBloc extends Bloc<GradeChoosingEvent, GradeChoosingState> {
  final GradeChoosingUseCase gradeChoosingUseCase;
  final GetStagesUseCase getStagesUseCase;
  final GetClassRoomUseCase getClassRoomUseCase;
  final GetTermsUseCase getTermsUseCase;
  final GetSystemTypesUseCase getSystemUseCase;
  final GetPathsUseCase getPathUseCase;
  bool fromSubscription = false;
// Getter for fromSubscription
//   bool get fromSubscription => _fromSubscription;

  // Method to update fromSubscription
  // void setFromSubscription(bool value) {
  //   _fromSubscription = value;
  // }
  GradeChoosingBloc(
      this.gradeChoosingUseCase,
      this.getStagesUseCase,
      this.getClassRoomUseCase,
      this.getTermsUseCase,
      this.getSystemUseCase,
      this.getPathUseCase)
      : super(const GradeChoosingState()) {
    on<GradeChoosingSubmittedEvent>(
      (event, emit) async {
        emit(
          state.copyWith(
            gradeChoosingSubmittedStates: RequestStates.loading,
          ),
        );
        final result = await gradeChoosingUseCase(event.parameters);
        result.fold(
          (failure) {
            emit(state.copyWith(
                gradeChoosingSubmittedStates: RequestStates.error,
                gradeChoosingMessage: failure.message));
          },
          (success) async {
            final userDate = getIt<UserLocalDataSource>().getUserData();
            if (userDate != null) {
              final newUser =
                  getIt<UserLocalDataSource>().getUserData()!.copyWith(
                        stageId: state.currentStage.id,
                        classroomId: state.currentClassRoom.id,
                        termId: state.currentTerm.id,
                        systemId: state.currentSystem.id,
                        pathId: state.currentPath.id,
                      );

              getIt<UserLocalDataSource>().saveUserData(
                userModel: newUser,
              );
            }
            emit(
              state.copyWith(
                gradeChoosingSubmittedStates: RequestStates.loaded,
                gradeChoosingMessage: success.message,
              ),
            );
            if (success.status) {
              UserEntity? data = getIt<UserLocalDataSource>().getUserData();
              UserEntity newData = data!.copyWith(
                stageId: state.currentStage.id,
                classroomId: state.currentClassRoom.id,
                termId: state.currentTerm.id,
                stageName: state.currentStage.name,
                classroomName: state.currentClassRoom.name,
                termName: state.currentTerm.name,
              );
              await getIt<UserLocalDataSource>()
                  .saveUserData(userModel: newData);
            }
          },
        );
      },
    );
    on<GetSystemEvent>((event, emit) async {
      emit(
        state.copyWith(
          gradeChoosingSubmittedStates: RequestStates.initial,
          getSystemState: RequestStates.loading,
          currentPath: const StudyingModel(id: 0, name: 'Loading'),
        ),
      );
      final result = await getSystemUseCase(const NoParameter());
      result.fold(
        (failure) {
          emit(state.copyWith(
            getSystemState: RequestStates.error,
          ));
        },
        (success) async {
          final StudyingModel userSystem = success.singleWhere(
                  (element) => element.id == getIt<UserLocalDataSource>().getUserData()!.systemId,
              orElse: () => success.first);
          emit(
            state.copyWith(
              getSystemState: RequestStates.loaded,
              systems: success.isNotEmpty
                  ? success
                  : [const StudyingModel(id: -1, name: AppStrings.noTermNow)],
              currentSystem: success.isNotEmpty
                  ? userSystem
                  : const StudyingModel(id: -1, name: AppStrings.noTermNow),
            ),
          );
          add(GetStagesEvent(systemId: state.currentSystem.id));
        },
      );
    });

    on<GetStagesEvent>((event, emit) async {
      emit(
        state.copyWith(
          gradeChoosingSubmittedStates: RequestStates.initial,
          getStagesState: RequestStates.loading,
          currentPath: const StudyingModel(id: 0, name: 'Loading'),
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
          final StudyingModel userStage = success.singleWhere(
                  (element) => element.id == getIt<UserLocalDataSource>().getUserData()!.stageId,
              orElse: () => success.first);
          emit(
            state.copyWith(
              getStagesState: RequestStates.loaded,
              stages: success.isNotEmpty
                  ? success
                  : [const StudyingModel(id: -1, name: AppStrings.noTermNow)],
              currentStage: success.isNotEmpty
                  ? userStage
                  : const StudyingModel(id: -1, name: AppStrings.noTermNow),
              haveSystem: success.isNotEmpty?userStage.id!=7:false,
            ),
          );
          add(
            GetClassRoomGradeEvent(
              getClassRoomParameter: GetClassRoomParameter(
                stageId: state.currentStage.id,
              ),
            ),
          );
        },
      );
    });

    on<GetClassRoomGradeEvent>((event, emit) async {
      emit(
        state.copyWith(
          gradeChoosingSubmittedStates: RequestStates.initial,
          getClassRoomsState: RequestStates.loading,
        ),
      );
      final result = await getClassRoomUseCase(
        GetClassRoomParameter(
          stageId: event.getClassRoomParameter.stageId,
        ),
      );
      result.fold(
        (failure) {
          emit(
            state.copyWith(
              getClassRoomsState: RequestStates.error,
            ),
          );
        },
        (success) {
          final StudyingModel userClassroom = success.singleWhere(
                  (element) => element.id == getIt<UserLocalDataSource>().getUserData()!.classroomId,
              orElse: () => success.first);
          emit(
            state.copyWith(
                getClassRoomsState: RequestStates.loaded,
                classRooms: success.isNotEmpty
                    ? success
                    : [
                        const StudyingModel(
                            id: -1, name: AppStrings.noClassroomFound)
                      ],
                currentClassRoom: success.isNotEmpty
                    ? userClassroom
                    : const StudyingModel(
                        id: -1, name: AppStrings.noClassroomFound),
                classroomPaths:
                    success.first.paths!.isNotEmpty ? success.first.paths : [],
                currentClassroomPath: success.first.paths!.isNotEmpty
                    ? success.first.paths![0]
                    : null),
          );
          if(fromSubscription){
             if(state.currentClassRoom.paths!.isNotEmpty){
              add(
                GetPathEvent(
                  GetPathParameters(
                    systemId: state.currentSystem.id,
                    stageId: state.currentStage.id,
                    classRoomId: state.currentClassRoom.id,
                    termId: state.currentTerm.id,
                  ),
                ),
              );}

          }else {
            add(
              GetTermsEvent(
                GetTermsParameters(
                  stageId: state.currentStage.id,
                  classRoomId: state.currentClassRoom.id,
                  systemId: state.currentSystem.id,
                ),
              ),
            );
          }
        },
      );
    });

    on<GetTermsEvent>((event, emit) async {
      emit(
        state.copyWith(
          gradeChoosingSubmittedStates: RequestStates.initial,
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
          final StudyingModel userTerm = success.singleWhere(
                  (element) => element.id == getIt<UserLocalDataSource>().getUserData()!.termId,
              orElse: () => success.first);
          emit(
            state.copyWith(
              getTermsState: RequestStates.loaded,
              terms: success.isNotEmpty
                  ? success
                  : [const StudyingModel(id: -1, name: AppStrings.noTermNow)],
              currentTerm: success.isNotEmpty
                  ? userTerm
                  : const StudyingModel(id: -1, name: AppStrings.noTermNow),
            ),
          );
          if (state.currentTerm.isPath ?? false) {
            add(
              GetPathEvent(
                GetPathParameters(
                    systemId: state.currentSystem.id,
                    stageId: state.currentStage.id,
                    classRoomId: state.currentClassRoom.id,
                    termId: state.currentTerm.id,
                ),
              ),
            );
          }
        },
      );
    });

    on<GetPathEvent>((event, emit) async {
      emit(
        state.copyWith(
          gradeChoosingSubmittedStates: RequestStates.initial,
          getPathsState: RequestStates.loading,
        ),
      );
      final result = await getPathUseCase(event.getPathParameters);
      result.fold(
        (failure) {
          emit(
            state.copyWith(
              getPathsState: RequestStates.error,
            ),
          );
        },
        (success) {
          final StudyingModel userPath = success.singleWhere(
                  (element) => element.id == getIt<UserLocalDataSource>().getUserData()!.pathId,
              orElse: () => success.first);
          emit(
            state.copyWith(
              getPathsState: RequestStates.loaded,
              paths: success.isNotEmpty
                  ? success
                  : [const StudyingModel(id: -1, name: AppStrings.noTermNow)],
              currentPath: success.isNotEmpty
                  ? userPath
                  : const StudyingModel(id: -1, name: AppStrings.noTermNow),
            ),
          );
        },
      );
    });

    on<ChangeSystemEvent>((event, emit) {
      emit(state.copyWith(
          changeStageState: GradeStates.changeStageState,
          getTermsState: RequestStates.initial,
          getStagesState: RequestStates.initial,
          getClassRoomsState: RequestStates.initial,
          terms: [],
          paths: [],
          currentPath: const StudyingModel(id: 0, name: 'Loading'),

          currentSystem: event.currentSystem));
      add(GetStagesEvent(systemId: state.currentSystem.id));
    });

    on<ChangeStageEvent>((event, emit) {
      emit(state.copyWith(
          changeStageState: GradeStates.changeStageState,
          getTermsState: RequestStates.initial,
          getClassRoomsState: RequestStates.initial,
          terms: [],
          paths: [],
          currentPath: const StudyingModel(id: 0, name: 'Loading'),

          haveSystem: event.currentStage.id != 7,
          currentStage: event.currentStage));
      add(GetClassRoomGradeEvent(
          getClassRoomParameter:
              GetClassRoomParameter(
                  stageId: state.currentStage.id)));
    });

    on<ChangeClassRoomEvent>((event, emit) {
      emit(state.copyWith(
          changeStageState: GradeStates.changeStageState,
          getTermsState: RequestStates.initial,
          terms: [],
          paths: [],
          currentClassRoom: event.currentClassRoom));
      if(fromSubscription){
        if(state.currentClassRoom.paths!.isNotEmpty){
          add(
            GetPathEvent(
              GetPathParameters(
                systemId: state.currentSystem.id,
                stageId: state.currentStage.id,
                classRoomId: state.currentClassRoom.id,
                termId: state.currentTerm.id,
              ),
            ),
          );}

      }else {
        add(
          GetTermsEvent(
            GetTermsParameters(
              stageId: state.currentStage.id,
              classRoomId: state.currentClassRoom.id,
              systemId: state.currentSystem.id,
            ),
          ),
        );
      }
    });

    on<ChangeTermEvent>((event, emit) {
      emit(state.copyWith(
          changeStageState: GradeStates.changeStageState,
          paths: [],
          currentTerm: event.currentTerm));
      if (state.currentTerm.isPath ?? false) {
        add(
          GetPathEvent(
            GetPathParameters(
              systemId: state.currentSystem.id,
              stageId: state.currentStage.id,
              classRoomId: state.currentClassRoom.id,
              termId: state.currentTerm.id,
            ),
          ),
        );
      }
    });

    on<ChangePathEvent>((event, emit) {
      emit(state.copyWith(
          changePathState: GradeStates.changeStageState,
          currentPath: event.currentPath));
    });

    on<ChangeClassroomPathEvent>((event, emit) {
      emit(state.copyWith(
          changeClassroomPathState: GradeStates.changeStageState,
          currentClassroomPath: event.currentPath));
    });
  }
}

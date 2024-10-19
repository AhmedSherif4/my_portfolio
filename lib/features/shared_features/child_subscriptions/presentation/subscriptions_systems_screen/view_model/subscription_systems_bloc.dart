import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../../../core/enum/enum_generation.dart';
import '../../../../../../core/services/services_locator.dart';
import '../../../../../../core/shared_models/user/data/user_local_data_source/user_local_data_source.dart';
import '../../../../../../core/shared_models/user/user_entity/user_entity.dart';
import '../../../../../child_flow/questions/shared/data/go_to_question_parameter.dart';
import '../../../domain/child_subscriptions_base_repository/child_subscriptions_base_repository.dart';
import '../../../domain/child_subscriptions_usecases/get_child_subscription_systems_usecase.dart';
import '../../../domain/child_subscriptions_usecases/get_child_subscriptions_classrooms_use_case.dart';
import '../../../domain/child_subscriptions_usecases/get_child_subscriptions_paths_use_case.dart';
import '../../../domain/child_subscriptions_usecases/get_child_subscriptions_stages_use_case.dart';
import '../../../domain/child_subscriptions_usecases/get_child_subscriptions_subjects_use_case.dart';
import '../../../domain/child_subscriptions_usecases/get_child_subscriptions_terms_use_case.dart';
import '../../../domain/entity/child_subscriptions_studying_entity.dart';
import 'subscription_systems_event.dart';
import 'subscription_systems_state.dart';

@Injectable()
class SubscriptionSystemsBloc
    extends Bloc<SubscriptionSystemsEvent, SubscriptionSystemsState> {

  final GetChildSubscriptionsSystemsUseCase getChildSubscriptionsSystems;
  final GetChildSubscriptionsStagesUseCase getStagesUseCase;
  final GetChildSubscriptionsClassRoomUseCase getClassRoomUseCase;
  final GetChildSubscriptionsTermsUseCase getTermsUseCase;
  final GetChildSubscriptionsPathsUseCase getPathsUseCase;
  final GetChildSubscriptionsSubjectsUseCase
      getChildSubscriptionsSubjectsUseCase;
  SubscriptionSystemsBloc(
    this.getChildSubscriptionsSystems,
    this.getStagesUseCase,
    this.getClassRoomUseCase,
    this.getTermsUseCase,
    this.getPathsUseCase,
    this.getChildSubscriptionsSubjectsUseCase,
  ) : super(const SubscriptionSystemsState()) {
    on<GetSystemsEvent>(_getSystemsEvent);
    on<GetStageEvent>(_getStagesEvent);
    on<GetClassRoomEvent>(_getClassRoomsEvent);
    on<GetSubTermsEvent>(_getTermsEvent);
    on<GetSubPathEvent>(_getPathsEvent);
    on<GetSubscriptionsSubjectsEvent>(_getSubjectsEvent);
    on<ChangeSystemEvent>(_changeSystemEvent);
    on<ChangeStagesEvent>(_changeStageEvent);
    on<ChangeClassRoomEvent>(_changeClassRoomEvent);
    on<ChangeTermEvent>(_changeTermEvent);
    on<ChangePathEvent>(_changePathEvent);
  }

  UserEntity childData = const UserEntity(
      stageName: "stageName",
      classroomName: "classroomName",
      termName: "termName",
      lock: "lock",
      lockMessage: "lockMessage",
      stageId: 0,
      classroomId: 0,
      termId: 0,
      name: '',
      email: '',
      phone: '',
      type: '',
      imgPath: '',
      gender: '',
      username: '',
      userId: 0,
      socialId: '');
  List<ChildSubscriptionsStudyingEntity> systems=[];

  FutureOr<void> _getSystemsEvent(
      GetSystemsEvent event, Emitter<SubscriptionSystemsState> emit) async {
    emit(state.copyWith(
      getSystemState: RequestStates.loading,
      currentPath: const ChildSubscriptionsStudyingEntity(id: 0, name: 'Loading'),
    ));
    final result = await getChildSubscriptionsSystems(event.childId);
    result.fold((failure) {
      emit(state.copyWith(
        getSystemState: RequestStates.error,
      ));
    }, (success) {
      // final ChildSubscriptionsStudyingEntity userSystem = success.singleWhere(
      //         (element) => element.id == getIt<UserLocalDataSource>().getUserData()!.systemId,
      //     orElse: () => success.first);
      emit(state.copyWith(
        getSystemState: RequestStates.loaded,
        systems: success.isNotEmpty
            ? success
            : [],
        currentSystem: success.isNotEmpty
            ? success.first
            : const ChildSubscriptionsStudyingEntity(
                id: -1, name: 'No Terms Now'),
      ),
      );
      systems=success;
      add(GetStageEvent(
        systemIdAndChildData: GetChildSubscriptionsTermsOrPathsParameters(
          systemId: state.currentSystem.id,
          childData: childData,
        ),
      ));
    });
  }

  FutureOr<void> _getStagesEvent(
      GetStageEvent event, Emitter<SubscriptionSystemsState> emit) async {
    emit(
      state.copyWith(
        getStagesState: RequestStates.loading,
        currentPath: const ChildSubscriptionsStudyingEntity(id: 0, name: 'Loading'),

      ),
    );
    final result = await getStagesUseCase(event.systemIdAndChildData);
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            getStagesState: RequestStates.error,
          ),
        );
      },
      (success) {
        // final ChildSubscriptionsStudyingEntity userStage = success.singleWhere(
        //         (element) => element.id == getIt<UserLocalDataSource>().getUserData()!.stageId,
        //     orElse: () => success.first);
        emit(
          state.copyWith(
            getStagesState: RequestStates.loaded,
            stages: success.isNotEmpty
                ? success
                : [
                    const ChildSubscriptionsStudyingEntity(
                        id: -1, name: 'No Terms Now')
                  ],
            currentStage: success.isNotEmpty
                ? success.first
                : const ChildSubscriptionsStudyingEntity(
                    id: -1, name: 'No Terms Now'),
            haveSystem: success.isNotEmpty?state.currentStage.id!=7:false,

          ),
        );
        add(GetClassRoomEvent(
            getClassRoomParameters: GetChildSubscriptionsTermsOrPathsParameters(
          systemId: state.currentSystem.id,
          stageId: state.currentStage.id,
          classRoomId: state.currentClassRoom.id,
              childData: childData,
        )));
      },
    );
  }

  FutureOr<void> _getClassRoomsEvent(
      GetClassRoomEvent event, Emitter<SubscriptionSystemsState> emit) async {
    emit(
      state.copyWith(
        getClassRoomsState: RequestStates.loading,
      ),
    );
    final result = await getClassRoomUseCase(event.getClassRoomParameters);
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            getClassRoomsState: RequestStates.error,
          ),
        );
      },
      (success) {
        // final ChildSubscriptionsStudyingEntity userClassroom = success.singleWhere(
        //         (element) => element.id == getIt<UserLocalDataSource>().getUserData()!.classroomId,
        //     orElse: () => success.first);
        emit(
          state.copyWith(
            getClassRoomsState: RequestStates.loaded,
            classRooms: success.isNotEmpty
                ? success
                : [
                    const ChildSubscriptionsStudyingEntity(
                        id: -1, name: 'No Class Room Now')
                  ],
            currentClassRoom: success.isNotEmpty
                ? success.first
                : const ChildSubscriptionsStudyingEntity(
                    id: -1, name: 'No Class Room Now'),
          ),
        );
        add(GetSubTermsEvent(
            GetChildSubscriptionsTermsOrPathsParameters(
            systemId: state.currentSystem.id,
            stageId: state.currentStage.id,
            childData: childData,
            classRoomId: state.currentClassRoom.id)));
      },
    );
  }

  FutureOr<void> _getTermsEvent(
      GetSubTermsEvent event, Emitter<SubscriptionSystemsState> emit) async {
    emit(
      state.copyWith(
        getTermsState: RequestStates.loading,
      ),
    );
    final result = await getTermsUseCase(event.parameters);
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            getTermsState: RequestStates.error,
          ),
        );
      },
      (success) {
        // final ChildSubscriptionsStudyingEntity userTerm = success.singleWhere(
        //         (element) => element.id == getIt<UserLocalDataSource>().getUserData()!.classroomId,
        //     orElse: () => success.first);
        emit(
          state.copyWith(
            getTermsState: RequestStates.loaded,
            terms: success.isNotEmpty
                ? success
                : [
                    const ChildSubscriptionsStudyingEntity(
                        id: -1, name: 'No Terms Now')
                  ],
            currentTerm: success.isNotEmpty
                ? success.first
                : const ChildSubscriptionsStudyingEntity(
                    id: -1, name: 'No Terms Now'),
          ),
        );
      },
    );
    if (state.terms.isNotEmpty && (state.terms[0].termHavePathOrNot )) {
      add(GetSubPathEvent(GetChildSubscriptionsTermsOrPathsParameters(
          systemId: state.currentSystem.id,
          stageId: state.currentStage.id,
          classRoomId: state.currentClassRoom.id,
          childData: childData,
          termId: state.currentTerm.id)));
    }
  }

  FutureOr<void> _getPathsEvent(
      GetSubPathEvent event, Emitter<SubscriptionSystemsState> emit) async {
    emit(state.copyWith(
      getPathsState: RequestStates.loading,
    ));
    final result = await getPathsUseCase(event.parameters);
    result.fold(
      (failure) {
        emit(state.copyWith(
          getPathsState: RequestStates.error,
        ));
      },
      (success) {
        // final ChildSubscriptionsStudyingEntity userPath = success.singleWhere(
        //         (element) => element.id == getIt<UserLocalDataSource>().getUserData()!.classroomId,
        //     orElse: () => success.first);
        emit(state.copyWith(
          getPathsState: RequestStates.loaded,
          paths: success.isNotEmpty
              ? success
              : [
                  const ChildSubscriptionsStudyingEntity(
                      id: -1, name: 'No Paths Now')
                ],
          currentPath: success.isNotEmpty
              ? success.first
              : const ChildSubscriptionsStudyingEntity(
                  id: -1, name: 'No Paths Now'),
        ));
        add(
          GetSubscriptionsSubjectsEvent(
            parameter: ParameterGoToQuestions(
                systemId: state.currentSystem.id,
                stageId: state.currentStage.id,
                pathId: state.currentPath.id,
                classRoomId: state.currentClassRoom.id,
                userId: childData.userId,
                termId: state.currentTerm.id),
          ),
        );
      },
    );
  }

  FutureOr<void> _getSubjectsEvent(GetSubscriptionsSubjectsEvent event,
      Emitter<SubscriptionSystemsState> emit) async {
    emit(state.copyWith(
      getSubjectsState: RequestStates.loading,
    ));
    final result = await getChildSubscriptionsSubjectsUseCase(
      ParameterGoToQuestions(
        systemId: event.parameter.systemId,
        stageId: event.parameter.stageId,
        classRoomId: event.parameter.classRoomId,
        userId: childData.userId,
        termId: event.parameter.termId,
        pathId: event.parameter.pathId,
      ),
    );
    result.fold(
      (failure) {
        emit(state.copyWith(
          getSubjectsState: RequestStates.error,
        ));
      },
      (success) {
        emit(state.copyWith(
          getSubjectsState: RequestStates.loaded,
          subjects: success,
        ));
      },
    );
  }

  FutureOr<void> _changeSystemEvent(
      ChangeSystemEvent event, Emitter<SubscriptionSystemsState> emit) {
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
      currentPath: const ChildSubscriptionsStudyingEntity(id: 0, name: 'Loading'),
    ));
    add(GetStageEvent(
      systemIdAndChildData: GetChildSubscriptionsTermsOrPathsParameters(
        systemId: state.currentSystem.id,
        childData: childData,
      ),
    ));
  }

  FutureOr<void> _changeStageEvent(
      ChangeStagesEvent event, Emitter<SubscriptionSystemsState> emit) {
    emit(state.copyWith(
      currentStage: event.currentStage,
      getClassRoomsState: RequestStates.initial,
      getTermsState: RequestStates.initial,
      getPathsState: RequestStates.initial,
      getSubjectsState: RequestStates.initial,
      classRooms: [],
      terms: [],
      paths: [],
      currentPath: const ChildSubscriptionsStudyingEntity(id: 0, name: 'Loading'),
      haveSystem: event.currentStage.id != 7,
    ));
    add(GetClassRoomEvent(
        getClassRoomParameters: GetChildSubscriptionsTermsOrPathsParameters(
      systemId: state.currentSystem.id,
      stageId: state.currentStage.id,
      classRoomId: state.currentClassRoom.id,
          childData: childData,
    )));
  }

  FutureOr<void> _changeClassRoomEvent(
      ChangeClassRoomEvent event, Emitter<SubscriptionSystemsState> emit) {
    emit(state.copyWith(
      currentClassRoom: event.currentClassRoom,
      getTermsState: RequestStates.initial,
      getPathsState: RequestStates.initial,
      getSubjectsState: RequestStates.initial,
      terms: [],
      paths: [],
    ));
    add(GetSubTermsEvent(GetChildSubscriptionsTermsOrPathsParameters(
        systemId: state.currentSystem.id,
        stageId: state.currentStage.id,
        childData: childData,
        classRoomId: state.currentClassRoom.id)));
  }

  FutureOr<void> _changeTermEvent(
      ChangeTermEvent event, Emitter<SubscriptionSystemsState> emit) {
    emit(state.copyWith(
      currentTerm: event.currentTerm,
      getPathsState: RequestStates.initial,
      getSubjectsState: RequestStates.initial,
      paths: [],
    ));
    if (state.terms[0].termHavePathOrNot) {
      add(GetSubPathEvent(GetChildSubscriptionsTermsOrPathsParameters(
        systemId: state.currentSystem.id,
        stageId: state.currentStage.id,
        classRoomId: state.currentClassRoom.id,
        childData: childData,
        termId: state.currentTerm.id,
      )));
    } else {
      add(
        GetSubscriptionsSubjectsEvent(
          parameter: ParameterGoToQuestions(
              systemId: state.currentSystem.id,
              stageId: state.currentStage.id,
              classRoomId: state.currentClassRoom.id,
              termId: state.currentTerm.id),
        ),
      );
    }
  }

  FutureOr<void> _changePathEvent(
      ChangePathEvent event, Emitter<SubscriptionSystemsState> emit) {
    emit(state.copyWith(
      currentPath: event.currentPath,
      getSubjectsState: RequestStates.initial,
    ));
    add(
      GetSubscriptionsSubjectsEvent(
        parameter: ParameterGoToQuestions(
            systemId: state.currentSystem.id,
            stageId: state.currentStage.id,
            pathId: state.currentPath.id,
            classRoomId: state.currentClassRoom.id,
            termId: state.currentTerm.id),
      ),
    );
  }
}

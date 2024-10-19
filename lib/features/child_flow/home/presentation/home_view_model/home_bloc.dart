part of '../../home.dart';

@Injectable()
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetPuzzleAndAdviceUseCase getPuzzleAndAdvice;

  final GetSubjectsUseCase getSubjects;
  final UserLocalDataSource userDataSource;

  HomeBloc(this.getPuzzleAndAdvice, this.getSubjects, this.userDataSource)
      : super(const HomeState()) {
    on<GotPuzzleAndAdviceEvent>(_onGotPuzzle);
    on<CheckPuzzleEvent>(_checkPuzzleEvent);
  }

  FutureOr<void> _onGotPuzzle(
      GotPuzzleAndAdviceEvent event, Emitter<HomeState> emit) async {
    emit(
      state.copyWith(
        getPuzzleAndAdviceState: RequestStates.loading,
      ),
    );
    final result = await getPuzzleAndAdvice(const NoParameter());

    result.fold((failure) {
      emit(
        state.copyWith(
          getPuzzleAndAdviceState: RequestStates.error,
          puzzleAndAdviceMessage: failure.message,
        ),
      );
    }, (puzzle) {
      emit(state.copyWith(
        getPuzzleAndAdviceState: RequestStates.loaded,
        puzzleAndAdviceEntity: puzzle,
      ));
    });
  }

  FutureOr<void> _checkPuzzleEvent(
      CheckPuzzleEvent event, Emitter<HomeState> emit) async {
    try {
      final result = await getIt<HomeLocalDataSource>().getSelectedAnswerOfPuzzle();
      emit(
        state.copyWith(
          puzzleAnswer: result,
        ),
      );
    } catch (e) {
      rethrow;
    }

  }

  // FutureOr<void> _onGotSubjects(
  //     GotSubjectsEvent event, Emitter<HomeState> emit) async {
  //   emit(
  //     state.copyWith(
  //       subjectsStates: RequestStates.loading,
  //     ),
  //   );
  //   final result = await getSubjects(event.subjectsParameters);
  //
  //   result.fold((failure) {
  //     emit(
  //       state.copyWith(
  //         subjectsStates: RequestStates.error,
  //         subjectsErrorMessage: failure.message,
  //       ),
  //     );
  //   }, (subjects) {
  //     emit(state.copyWith(
  //       subjectsStates: RequestStates.loaded,
  //       subjects: subjects,
  //     ));
  //   });
  // }



  void goToLessonScreen({
    required BuildContext context,
    required SubjectsEntity subject,
    required UserEntity user,
    required bool isPrimary,
  }) {
    RouteManager.rPushNamedAndRemoveUntil(
        context: context,
        rName: AppRoutesNames.rLessonScreen,
        arguments: DataToGoQuestions(
          subjectId: subject.subjectId,
          notHaveImage: subject.subjectImg.isEmpty,
          isGeneralQuestions: false,
          imgUrl: subject.subjectImg.isEmpty
              ? AppImagesAssets.sLogoWithoutName
              : subject.subjectImg,
          subjectName: subject.subjectName,
          isPrimary: isPrimary,
          subjectsHaveUnits: subject.isHaveUnit,
          stageId: user.stageId!,
          classRoomId: user.classroomId!,
          termId: user.termId!,
          systemId: user.systemId!,
          pathId: user.pathId!,
        ));
  }

  refreshHome() async {
    getIt<BaseLocalDataSource>()
        .deleteDataAt<PuzzleAndAdviceEntity>(AppKeys.puzzleAndAdviceKey)
        .then((value) {
      add(const GotPuzzleAndAdviceEvent());
    });
    getIt<SharedSubjectsBloc>().add(
      GetSharedSubjectsEvent(parameter:
      ParameterGoToQuestions(
        systemId: getIt<UserLocalDataSource>().getUserData()!.systemId!,
        stageId: getIt<UserLocalDataSource>().getUserData()!.stageId!,
        classRoomId: getIt<UserLocalDataSource>().getUserData()!.classroomId!,
        termId: getIt<UserLocalDataSource>().getUserData()!.termId!,
        subjectType: SubjectType.public
      ).copyWith(pathId: getIt<UserLocalDataSource>().getUserData()!.pathId!),
      )
    );
    // add(
    //   GotSubjectsEvent(
    //     ParameterGoToQuestions(
    //       systemId: getIt<UserLocalDataSource>().getUserData()!.systemId!,
    //       stageId: getIt<UserLocalDataSource>().getUserData()!.stageId!,
    //       classRoomId: getIt<UserLocalDataSource>().getUserData()!.classroomId!,
    //       termId: getIt<UserLocalDataSource>().getUserData()!.termId!,
    //     ).copyWith(pathId: getIt<UserLocalDataSource>().getUserData()!.pathId!),
    //   ),
    // );
  }
}

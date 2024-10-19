part of '../../rank.dart';

enum RankType {
  classroom,
  term,
  subject,
}

@Injectable()
class RankBloc extends Bloc<RankEvent, RankState> {
  final GetStageRankUseCase getStageRankUseCase;
  final GetClassroomRankUseCase getClassroomRankUseCase;
  final GetTermRankUseCase getTermRankUseCase;
  final GetSubjectRankUseCase getSubjectRankUseCase;
  final GetChildSubscriptionsSubjectsUseCase getUserSubjectsUseCase;

  RankBloc(
    this.getStageRankUseCase,
    this.getClassroomRankUseCase,
    this.getTermRankUseCase,
    this.getSubjectRankUseCase,
    this.getUserSubjectsUseCase,
  ) : super(const RankState()) {
    on<GotUserRankClassroom>(_onGotUserRankClassroom);
    on<GotUserRankTerm>(_onGotUserRankTerm);
    on<GotUserRankSubject>(_onGotUserRankSubject);
    on<GotSubjectsForRank>(_onGotSubjectsForRank);
  }

  int nextPage = 1;

  FutureOr<void> _onGotUserRankClassroom(
      GotUserRankClassroom event, Emitter<RankState> emit) async {
    emit(state.copyWith(
      rankStates: RequestStates.loading,
      rankType: RankType.classroom,
    ));

    final result = await getClassroomRankUseCase(
      RankParameters(
        systemID: event.systemID,
        stageID: event.stageID,
        classroomID: event.classroomID,
        pageNumber: event.pageNumber,
      ),
    );

    result.fold(
      (failure) {
        emit(state.copyWith(
          rankStates: RequestStates.error,
          rankMessage: failure.message,
        ));
      },
      (rank) {
        if(rank.pagination.lastPage!=1){
          nextPage = nextPage + 1;
        }
        emit(
          state.copyWith(
            rankStates: RequestStates.loaded,
            userID: rank.userID,
            paginationModel: rank.pagination,
            ranks: [...state.ranks, ...rank.childrenRank],
            isLastPage: nextPage == rank.pagination.lastPage,
          ),
        );
      },
    );
  }

  FutureOr<void> _onGotUserRankTerm(
      GotUserRankTerm event, Emitter<RankState> emit) async {
    emit(state.copyWith(
      rankStates: RequestStates.loading,
      rankType: RankType.term,
    ));

    final result = await getTermRankUseCase(
      RankParameters(
        systemID: event.systemID,
        stageID: event.stageID,
        classroomID: event.classroomID,
        termID: event.termID,
        pathID: event.pathID,
        pageNumber: event.pageNumber,
      ),
    );

    result.fold(
          (failure) {
        emit(state.copyWith(
          rankStates: RequestStates.error,
          rankMessage: failure.message,
        ));
      },
          (rank) {
        nextPage = nextPage + 1;
        emit(
          state.copyWith(
            rankStates: RequestStates.loaded,
            userID: rank.userID,
            paginationModel: rank.pagination,
            ranks: [...state.ranks, ...rank.childrenRank],
            isLastPage: nextPage == rank.pagination.lastPage,
          ),
        );
      },
    );

  }

  FutureOr<void> _onGotUserRankSubject(
      GotUserRankSubject event, Emitter<RankState> emit) async {
    emit(state.copyWith(
      rankStates: RequestStates.loading,
      rankType: RankType.subject,
    ));

    final result = await getSubjectRankUseCase(
      RankParameters(
        systemID: event.systemID,
        stageID: event.stageID,
        classroomID: event.classroomID,
        subjectID: event.subjectID,
        pathID: event.pathID,
        termID: event.termID,
        pageNumber: event.pageNumber,
      ),
    );

    result.fold(
          (failure) {
        emit(state.copyWith(
          rankStates: RequestStates.error,
          rankMessage: failure.message,
        ));
      },
          (rank) {
        nextPage = nextPage + 1;
        emit(
          state.copyWith(
              rankStates: RequestStates.loaded,
              userID: rank.userID,
              specificSubjectID: event.subjectID,
              ranks: [...state.ranks, ...rank.childrenRank],
              paginationModel: rank.pagination,
              isLastPage:
              nextPage == rank.pagination.lastPage),
        );
      },
    );


  }


  FutureOr<void> _onGotSubjectsForRank(
      GotSubjectsForRank event, Emitter<RankState> emit) async {
    emit(state.copyWith(
      userSubjectsState: RequestStates.loading,
    ));
    final value = await getUserSubjectsUseCase(event.subjectParameters);
    value.fold(
      (failure) {
        emit(state.copyWith(
          userSubjectsState: RequestStates.error,
          userSubjectsError: failure.toString(),
        ));
      },
      (subjects) {
        emit(state.copyWith(
          userSubjectsState: RequestStates.loaded,
          userSubjects: subjects,
        ));
      },
    );
  }
}

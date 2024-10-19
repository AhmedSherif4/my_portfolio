part of '../../rank.dart';

class RankState extends Equatable {
  final RequestStates rankStates;
  final String rankMessage;

  final int userID;

  final List<UserRankEntity> ranks;
  final PaginationEntity? paginationModel;
  final bool isLastPage;

  final RequestStates userSubjectsState;
  final List<SubjectsEntity>? userSubjects;
  final String userSubjectsError;
  final int specificSubjectID;

  final RankType? rankType;

  const RankState({
    this.rankStates = RequestStates.initial,
    this.rankMessage = '',
    this.userID = 0,
    this.ranks = const [],
    this.paginationModel,
    this.isLastPage = false,
    this.userSubjects,
    this.userSubjectsState = RequestStates.initial,
    this.userSubjectsError = '',
    this.rankType,
    this.specificSubjectID = 0,
  });

  RankState copyWith({
    RequestStates? rankStates,
    String? rankMessage,
    int? userID,
    List<UserRankEntity>? ranks,
    PaginationEntity? paginationModel,
    bool? isLastPage,
    List<SubjectsEntity>? userSubjects,
    RequestStates? userSubjectsState,
    String? userSubjectsError,
    RankType? rankType,
    int? specificSubjectID,
  }) {
    return RankState(
      rankStates: rankStates ?? this.rankStates,
      rankMessage: rankMessage ?? this.rankMessage,
      userID: userID ?? this.userID,
      ranks: ranks ?? this.ranks,
      paginationModel: paginationModel ?? this.paginationModel,
      isLastPage: isLastPage ?? this.isLastPage,
      userSubjects: userSubjects ?? this.userSubjects,
      userSubjectsState: userSubjectsState ?? this.userSubjectsState,
      userSubjectsError: userSubjectsError ?? this.userSubjectsError,
      rankType: rankType ?? this.rankType,
      specificSubjectID: specificSubjectID ?? this.specificSubjectID,
    );
  }

  @override
  List<Object?> get props => [
        rankStates,
        rankMessage,
        userID,
        ranks,
        paginationModel,
        isLastPage,
        userSubjects,
        userSubjectsState,
        userSubjectsError,
        rankType,
        specificSubjectID,
      ];
}

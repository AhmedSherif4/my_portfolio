part of '../../rank.dart';

class RankEntity extends Equatable {
  final int userID;
  final List<UserRankEntity> childrenRank;
  final PaginationModel pagination;

  const RankEntity({
    required this.userID,
    required this.childrenRank,
    required this.pagination,
  });

  @override
  List<Object> get props => [userID, childrenRank, pagination];
}

class UserRankEntity extends Equatable {
  final int id;
  final String name;
  final int points;

  const UserRankEntity({
    required this.id,
    required this.name,
    required this.points,
  });

  @override
  List<Object> get props => [id, name, points];
}

class PaginationEntity extends Equatable {
  final int currentPage;
  final int? from;
  final int lastPage;
  final int perPage;
  final int? to;
  final int total;
  final String firstPageUrl;
  final String lastPageUrl;
  final String? nextPageUrl;
  final String path;
  final String? prevPageUrl;

  const PaginationEntity({
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.total,
    required this.from,
    required this.to,
    required this.firstPageUrl,
    required this.lastPageUrl,
    this.nextPageUrl,
    required this.path,
    this.prevPageUrl,
  });

  factory PaginationEntity.empty() {
    return const PaginationEntity(
      currentPage: 0,
      lastPage: 0,
      perPage: 0,
      total: 0,
      from: null,
      to: null,
      firstPageUrl: '',
      lastPageUrl: '',
      nextPageUrl: null,
      path: '',
      prevPageUrl: null,
    );
  }

  @override
  List<Object?> get props => [
        currentPage,
        lastPage,
        perPage,
        total,
        from,
        to,
        firstPageUrl,
        lastPageUrl,
        nextPageUrl,
        path,
        prevPageUrl,
      ];
}

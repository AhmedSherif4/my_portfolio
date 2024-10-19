part of '../../rank.dart';

class RankModel extends RankEntity {
  const RankModel({
    required super.userID,
    required List<UserRankModel> super.childrenRank,
    required super.pagination,
  });

  factory RankModel.fromJson(Map<String, dynamic> json) {
    return RankModel(
      userID: json['current_child_login_id'] ?? 0,
      childrenRank: (json['children'] as List)
          .map((e) => UserRankModel.fromJson(e))
          .toList(),
      pagination: PaginationModel.fromJson(json['pagination']),
    );
  }
}

class UserRankModel extends UserRankEntity {
  const UserRankModel({
    required super.id,
    required super.name,
    required super.points,
  });

  factory UserRankModel.fromJson(Map<String, dynamic> json) {
    return UserRankModel(
      id: json['id'],
      name: json['name'],
      points: json['total_point'] ?? 0,
    );
  }
}

class PaginationModel extends PaginationEntity {
  const PaginationModel({
    required super.currentPage,
    super.from,
    required super.lastPage,
    required super.perPage,
    super.to,
    required super.total,
    required super.firstPageUrl,
    required super.lastPageUrl,
    super.nextPageUrl,
    required super.path,
    super.prevPageUrl,
  });

  factory PaginationModel.fromJson(Map<String, dynamic> json) {
    return PaginationModel(
      currentPage: json['current_page'],
      from: json['from'],
      lastPage: json['last_page'],
      perPage: json['per_page'],
      to: json['to'],
      total: json['total'],
      firstPageUrl: json['first_page_url'],
      lastPageUrl: json['last_page_url'],
      nextPageUrl: json['next_page_url'] ?? '',
      path: json['path'],
      prevPageUrl: json['prev_page_url'] ?? '',
    );
  }
}

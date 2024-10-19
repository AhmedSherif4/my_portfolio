part of '../../statics.dart';

class LevelStaticsModel extends Equatable {
  final List<GroupData> groupData;
  final int maxTime;
  final int maxAttempts;
  final int maxPoint;

  const LevelStaticsModel({
    required this.groupData,
    required this.maxTime,
    required this.maxAttempts,
    required this.maxPoint,
  });

  factory LevelStaticsModel.fromJson(Map<String, dynamic> json) {
    return LevelStaticsModel(
      groupData: (json['groups'] as List<dynamic>)
          .map((levelJson) => GroupData.fromJson(levelJson))
          .toList(),
      maxTime: json['MaxTime'] ?? 0,
      maxAttempts: json['MaxAttempts'] ?? 0,
      maxPoint: json['MaxPoint'] ?? 0,
    );
  }

  @override
  List<Object?> get props => [
        maxTime,
        maxAttempts,
        maxPoint,
      ];
}

class GroupData extends Equatable {
  final int point;
  final int answerTime;
  final int attempts;
  final int groupId;

  const GroupData(
      {required this.point,
      required this.answerTime,
      required this.attempts,
      required this.groupId});

  factory GroupData.fromJson(Map<String, dynamic> json) {
    return GroupData(
      groupId: json['group_id'] as int,
      point: json['point'] as int,
      answerTime: json['answer_time'] as int,
      attempts: json['attempts'] as int,
    );
  }

  @override
  List<Object?> get props => [
        point,
        answerTime,
        attempts,
      ];
}

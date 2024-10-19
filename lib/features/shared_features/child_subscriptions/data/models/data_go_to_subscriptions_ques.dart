import 'package:equatable/equatable.dart';

class DataGoToSubscriptionsQuestions extends Equatable {
  final int systemId;
  final int pathId;
  final int stageId;
  final int classRoomId;
  final int termId;
  final String? classRoomName;
  final String? points;

  const DataGoToSubscriptionsQuestions({
    this.stageId = 0,
    this.classRoomId = 0,
    this.termId = 0,
    this.pathId = 0,
    this.systemId = 0,
    this.classRoomName,
    this.points,
  });

  DataGoToSubscriptionsQuestions copyWith({
    int? stageId,
    int? classRoomId,
    int? termId,
    int? pathId,
    int? systemId,
    String? classRoomName,
    String? points,
  }) {
    return DataGoToSubscriptionsQuestions(
      termId: termId ?? this.termId,
      classRoomId: classRoomId ?? this.classRoomId,
      stageId: stageId ?? this.stageId,
      pathId: pathId ?? this.pathId,
      systemId: systemId ?? this.systemId,
      classRoomName: classRoomName ?? this.classRoomName,
      points: points ?? this.points,
    );
  }

  @override
  List<Object?> get props => [
        stageId,
        classRoomId,
        termId,
        systemId,
        pathId,
        classRoomName,
         points
      ];
}

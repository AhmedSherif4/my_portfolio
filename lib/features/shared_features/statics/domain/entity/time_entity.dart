part of '../../statics.dart';

class TimeInAppModel extends Equatable {
  final BaseCountTime total;
  final BaseCountTime inTimeRange;

  const TimeInAppModel({
    required this.total,
    required this.inTimeRange,
  });

  factory TimeInAppModel.fromJson(Map<String, dynamic> json) {
    return TimeInAppModel(
      total: json['total'] != null
          ? BaseCountTime.fromJson(json['total'])
          : BaseCountTime.empty(),
      inTimeRange: json['DateMinutes'] != null
          ? BaseCountTime.fromJson(json['DateMinutes'])
          : BaseCountTime.empty(),
    );
  }

  @override
  List<Object> get props => [
        total,
        inTimeRange,
      ];
}

class BaseCountTime extends Equatable {
  final int minutes;
  final int hours;

  const BaseCountTime({
    required this.minutes,
    required this.hours,
  });

  factory BaseCountTime.fromJson(Map<String, dynamic> json) {
    return BaseCountTime(
      minutes: json['minutes'],
      hours: json['hours'],
    );
  }

  factory BaseCountTime.empty() {
    return const BaseCountTime(
      minutes: 0,
      hours: 0,
    );
  }

  @override
  List<Object?> get props => [
        minutes,
        hours,
      ];
}


class TimeInAppInputs extends Equatable {
  final DateTime startDate;
  final DateTime endDate;
  final int? childId ;
  const TimeInAppInputs({
    required this.startDate,
    required this.endDate,
    this.childId
  });

  @override
  List<Object?> get props => [startDate, endDate,childId];

  TimeInAppInputs copyWith({
     DateTime? startDate,
     DateTime? endDate,
     int? childId,
  }) {
    return TimeInAppInputs(
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      childId: childId ?? this.childId,
    );
  }
}

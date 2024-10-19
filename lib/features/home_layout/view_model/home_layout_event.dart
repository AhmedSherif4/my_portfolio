part of '../home_layout.dart';

abstract class HomeLayoutEvent extends Equatable {}

class ChangeBottomNavBarIndexEvent extends HomeLayoutEvent {
  final int index;

  ChangeBottomNavBarIndexEvent(this.index);

  @override
  List<Object?> get props => [index];
}

class GetUserTypeEvent extends HomeLayoutEvent {
  final String userType;
  final bool inReview ;

  GetUserTypeEvent({required this.userType, required this.inReview});

  @override
  List<Object> get props => [
        userType,
    inReview,
      ];
}

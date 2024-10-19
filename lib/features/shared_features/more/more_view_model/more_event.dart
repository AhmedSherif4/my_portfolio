import 'package:equatable/equatable.dart';

abstract class MoreEvent extends Equatable {
  const MoreEvent();
}

class LogoutEvent extends MoreEvent {
  @override
  List<Object?> get props => [];
}

class ReOpenBoxesEvent extends MoreEvent {
  @override
  List<Object?> get props => [];
}

class GetScreens extends MoreEvent{
  @override
  List<Object?> get props => [];
}

class FormatAppEvent extends MoreEvent {
  @override
  List<Object?> get props => [];
}

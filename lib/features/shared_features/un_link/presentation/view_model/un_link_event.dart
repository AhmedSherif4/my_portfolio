part of '../../un_link.dart';

abstract class UnLinkEvent extends Equatable {
  const UnLinkEvent();
}

class UserUnLinkEvent extends UnLinkEvent {
  final int userId;

  const UserUnLinkEvent({required this.userId});

  @override
  List<Object> get props => [userId];
}

class ChildAddedNewParent extends UnLinkEvent {
  final String emailOrPhone;

  const ChildAddedNewParent({required this.emailOrPhone});

  @override
  List<Object> get props => [emailOrPhone];
}

class ChildAddedExistParent extends UnLinkEvent {
  final String username;
  const ChildAddedExistParent({required this.username});

  @override
  List<Object> get props => [username];
}

class ParentAddedNewChild extends UnLinkEvent {
  final String mailOrPhone;

  const ParentAddedNewChild({
    required this.mailOrPhone,
  });

  @override
  List<Object?> get props => [mailOrPhone];
}

class ParentAddedExistChild extends UnLinkEvent {
  final String username;

  const ParentAddedExistChild({required this.username});

  @override
  List<Object> get props => [username];
}
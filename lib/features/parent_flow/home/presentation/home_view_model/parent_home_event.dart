part of 'parent_home_bloc.dart';

abstract class ParentHomeEvent extends Equatable {
  const ParentHomeEvent();
}

class GetAllChildForParentEvent extends ParentHomeEvent {
  final int? parentId;

  const GetAllChildForParentEvent({this.parentId});

  @override
  List<Object?> get props => [parentId];
}

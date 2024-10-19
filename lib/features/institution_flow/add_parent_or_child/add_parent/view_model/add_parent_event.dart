part of 'add_parent_bloc.dart';

@immutable
abstract class AddParentEvent extends Equatable {}

class AddNewParentEvent extends AddParentEvent {
  final AddParentParameter addParentParameter;

  AddNewParentEvent({
    required this.addParentParameter,
  });

  @override
  List<Object> get props => [addParentParameter];
}

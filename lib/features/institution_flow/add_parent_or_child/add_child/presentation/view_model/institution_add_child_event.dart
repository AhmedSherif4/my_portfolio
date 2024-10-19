part of '../../add_child.dart';

abstract class InstitutionAddChildEvent extends Equatable {}

class InstitutionAddNewChildEvent extends InstitutionAddChildEvent {
  final InstitutionAddChildParameter addChildParameter;

  InstitutionAddNewChildEvent({required this.addChildParameter});

  @override
  List<Object> get props => [addChildParameter];
}

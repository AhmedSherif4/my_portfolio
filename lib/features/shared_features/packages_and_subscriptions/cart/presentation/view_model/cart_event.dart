import 'package:equatable/equatable.dart';

abstract class CartEvent extends Equatable {}

class ViewCartDataEvent extends CartEvent {
  final int childID;
  ViewCartDataEvent(this.childID);

  @override
  List<Object> get props => [childID];
}

class DeleteCartDataEvent extends CartEvent {
  final int childID;
  DeleteCartDataEvent(this.childID);

  @override
  List<Object> get props => [childID];
}

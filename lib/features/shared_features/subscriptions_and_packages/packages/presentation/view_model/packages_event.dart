import 'package:equatable/equatable.dart';

import '../../domain/repository/packages_repository.dart';

abstract class PackagesEvent extends Equatable{}

class AddClassroomToCartEvent extends PackagesEvent{
  final AddItemToCartParameters addItemToCartParameters;
  AddClassroomToCartEvent(this.addItemToCartParameters);
  @override
  List<Object> get props => [addItemToCartParameters];
}

class AddTermToCartEvent extends PackagesEvent{
  final AddItemToCartParameters addItemToCartParameters;
  AddTermToCartEvent(this.addItemToCartParameters);
  @override
  List<Object> get props => [addItemToCartParameters];
}

class AddSubjectToCartEvent extends PackagesEvent{
  final AddItemToCartParameters addItemToCartParameters;
  AddSubjectToCartEvent(this.addItemToCartParameters);
  @override
  List<Object> get props => [addItemToCartParameters];
}
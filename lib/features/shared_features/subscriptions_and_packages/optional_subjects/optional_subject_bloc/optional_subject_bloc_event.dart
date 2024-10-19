import 'package:equatable/equatable.dart';

import '../domain/repository/repository.dart';

abstract class OptionalSubjectBlocEvent extends Equatable{}

class AddOptionalSubjectEvent extends OptionalSubjectBlocEvent{

  final AddOptionalSubjectParameters addOptionalSubjectParameters;

  AddOptionalSubjectEvent({required this.addOptionalSubjectParameters,});

  @override
  List<Object> get props => [
    addOptionalSubjectParameters
  ];
}
enum OptionalSubjectType{
  toClassroom,
  toTerm,
}
import 'package:equatable/equatable.dart';
import 'package:my_portfolio/core/enum/enum_generation.dart';

class OptionalSubjectBlocState extends Equatable {
  final RequestStates addOptinalSubjectsForClassroomState;

  final String addOptinalSubjectsForClassroomMessage;

  const OptionalSubjectBlocState({
     this.addOptinalSubjectsForClassroomState = RequestStates.initial,
     this.addOptinalSubjectsForClassroomMessage= '',
  });

  OptionalSubjectBlocState copyWith({
     RequestStates? addOptinalSubjectsForClassroomState,

     String? addOptinalSubjectsForClassroomMessage,
}){
    return OptionalSubjectBlocState(
      addOptinalSubjectsForClassroomState: addOptinalSubjectsForClassroomState ?? this.addOptinalSubjectsForClassroomState,
      addOptinalSubjectsForClassroomMessage: addOptinalSubjectsForClassroomMessage ?? this.addOptinalSubjectsForClassroomMessage,
    );
  }

  @override
  List<Object> get props => [
    addOptinalSubjectsForClassroomState,
    addOptinalSubjectsForClassroomMessage,
  ];

}

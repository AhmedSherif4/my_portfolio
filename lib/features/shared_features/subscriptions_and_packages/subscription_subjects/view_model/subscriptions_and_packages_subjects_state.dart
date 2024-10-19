import 'package:equatable/equatable.dart';

import '../../../../../core/enum/enum_generation.dart';
import '../../../../child_flow/home/domain/home_entities/subjects_entity.dart';

class SubscriptionsAndPackagesSubjectsState extends Equatable {
  final RequestStates subjectsStates;
  final String subjectsErrorMessage;
  final List<SubjectsEntity> subjects;

  const SubscriptionsAndPackagesSubjectsState({
    this.subjectsStates = RequestStates.initial,
    this.subjectsErrorMessage = '',
    this.subjects = const <SubjectsEntity>[],
  });

  SubscriptionsAndPackagesSubjectsState copyWith({
    RequestStates? subjectsStates,
    String? subjectsErrorMessage,
    List<SubjectsEntity>? subjects,
  }) {
    return SubscriptionsAndPackagesSubjectsState(
      subjectsStates: subjectsStates ?? this.subjectsStates,
      subjectsErrorMessage: subjectsErrorMessage ?? this.subjectsErrorMessage,
      subjects: subjects ?? this.subjects,
    );
  }

  @override
  List<Object> get props => [
        subjectsStates,
        subjectsErrorMessage,
        subjects,
      ];
}

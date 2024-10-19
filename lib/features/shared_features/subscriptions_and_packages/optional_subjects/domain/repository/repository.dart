import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:my_portfolio/features/shared_features/subscriptions_and_packages/optional_subjects/optional_subject_bloc/optional_subject_bloc_event.dart';

import '../../../../../../core/failure/failure.dart';

abstract class AddOptionalSubjectRepository {
  Future<Either<Failure, String>> addOptionalSubject(
      {required AddOptionalSubjectParameters addOptionalSubjectParameters});
}

class AddOptionalSubjectParameters extends Equatable {
  final List<int> termIds;
  final List<int> subjectsIds;
  final OptionalSubjectType addTo;
  final int childId;
  const AddOptionalSubjectParameters({
    required this.termIds,
    required this.subjectsIds,
    required this.addTo,
    required this.childId,
  });

  @override
  List<Object> get props => [
        termIds,
        subjectsIds,
        addTo,
        childId,
      ];
}

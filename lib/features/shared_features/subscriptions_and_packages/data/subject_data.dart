import 'package:equatable/equatable.dart';

import '../../../../core/shared_models/user/user_entity/user_entity.dart';
import '../../../child_flow/questions/shared/data/go_to_question_parameter.dart';

class GoToSubjectData extends Equatable {
  final UserEntity? userData;
  final ParameterGoToQuestions getSubjectsParameters;

  const GoToSubjectData({
    this.userData,
    required this.getSubjectsParameters,
  });

  GoToSubjectData copyWith({
    UserEntity? userData,
    ParameterGoToQuestions? getSubjectsParameters,
  }) {
    return GoToSubjectData(
      userData: userData ?? this.userData,
      getSubjectsParameters:
          getSubjectsParameters ?? this.getSubjectsParameters,
    );
  }

  @override
  List<Object?> get props => [
        userData,
        getSubjectsParameters,
      ];
}

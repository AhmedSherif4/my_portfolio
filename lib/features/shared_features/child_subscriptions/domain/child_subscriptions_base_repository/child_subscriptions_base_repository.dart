import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:my_portfolio/core/shared_models/user/user_entity/user_entity.dart';

import '../../../../../../core/failure/failure.dart';
import '../../../../child_flow/home/domain/home_entities/subjects_entity.dart';
import '../../../../child_flow/questions/shared/data/go_to_question_parameter.dart';
import '../entity/child_subscriptions_studying_entity.dart';

abstract class ChildSubscriptionsBaseRepository {
  Future<Either<Failure, List<ChildSubscriptionsStudyingEntity>>> getChildSubscriptionsSystems({int? childId});

  Future<Either<Failure, List<ChildSubscriptionsStudyingEntity>>>
      getChildSubscriptionsStages({required GetChildSubscriptionsTermsOrPathsParameters systemIdAndChildData});

  Future<Either<Failure, List<ChildSubscriptionsStudyingEntity>>>
      getChildSubscriptionsClassRoom({
    required GetChildSubscriptionsTermsOrPathsParameters parameters,
  });

  Future<Either<Failure, List<ChildSubscriptionsStudyingEntity>>>
      getChildSubscriptionsTerms({
    required GetChildSubscriptionsTermsOrPathsParameters parameters,
  });

  Future<Either<Failure, List<ChildSubscriptionsStudyingEntity>>>
      getChildSubscriptionsPaths({
    required GetChildSubscriptionsTermsOrPathsParameters parameters,
  });

  Future<Either<Failure, List<SubjectsEntity>>> getChildSubscriptionsSubjects({
    required ParameterGoToQuestions subjectsParameters,
    int? childId,
  });
}

class GetChildSubscriptionsTermsOrPathsParameters extends Equatable {
  final int systemId;
  final int stageId;
  final int classRoomId;
  final int? termId;

  final UserEntity? childData;

  const GetChildSubscriptionsTermsOrPathsParameters({
    this.stageId =0,
    this.classRoomId = 0,
    this.childData,
    required this.systemId,
    this.termId
  });

  @override
  List<Object?> get props => [stageId, classRoomId, childData,systemId,termId];

  GetChildSubscriptionsTermsOrPathsParameters copyWith({
    int? stageId,
    int? classRoomId,
    UserEntity? childData,
    int? systemId,
    int? termId,
  }) {
    return GetChildSubscriptionsTermsOrPathsParameters(
      systemId: systemId?? this.systemId,
      stageId: stageId ?? this.stageId,
      classRoomId: classRoomId ?? this.classRoomId,
      termId: termId ?? this.termId,
      childData: childData ?? this.childData,
    );
  }
}

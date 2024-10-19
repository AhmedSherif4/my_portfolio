import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:my_portfolio/features/child_flow/home/domain/home_entities/subjects_entity.dart';
import 'package:my_portfolio/features/child_flow/questions/shared/data/go_to_question_parameter.dart';

import '../../../../../../config/base_repository/base_repository.dart';
import '../../../../../../core/failure/failure.dart';
import '../../domain/child_subscriptions_base_repository/child_subscriptions_base_repository.dart';
import '../../domain/entity/child_subscriptions_studying_entity.dart';
import '../child_subscriptions_data_source/child_subscriptions_remote_data_source.dart';

@LazySingleton(as: ChildSubscriptionsBaseRepository)
class ChildSubscriptionsRepository implements ChildSubscriptionsBaseRepository {
  final ChildSubscriptionsRemoteDataSource remoteDataSource;
  final BaseRepository baseRepository;
  // final ChildSubscriptionsLocalDataSource childSubscriptionsLocalDataSource;

  ChildSubscriptionsRepository({
    required this.remoteDataSource,
    required this.baseRepository,
  });

  @override
  Future<Either<Failure, List<ChildSubscriptionsStudyingEntity>>>
      getChildSubscriptionsClassRoom({
    required GetChildSubscriptionsTermsOrPathsParameters parameters,
  }) async {
    final jsonData = await baseRepository.checkExceptionForRemoteData(
      remoteDataSource.getChildSubscriptionsClassRoom(
        parameters: parameters,
      ),
    );
    return jsonData.fold(
      (failure) => left(failure),
      (data) async {
        return right(data);
      },
    );
  }

  @override
  Future<Either<Failure, List<ChildSubscriptionsStudyingEntity>>>
      getChildSubscriptionsStages({required GetChildSubscriptionsTermsOrPathsParameters systemIdAndChildData}) async {
    final jsonData = await baseRepository.checkExceptionForRemoteData(
      remoteDataSource.getChildSubscriptionsStages(systemIdAndChildData: systemIdAndChildData),
    );
    return jsonData.fold(
      (failure) => left(failure),
      (data) async {
        return right(data);
      },
    );
  }

  @override
  Future<Either<Failure, List<ChildSubscriptionsStudyingEntity>>>
      getChildSubscriptionsTerms({
    required GetChildSubscriptionsTermsOrPathsParameters parameters,
  }) async {
    final jsonData = await baseRepository.checkExceptionForRemoteData(
      remoteDataSource.getChildSubscriptionsTerms(parameters: parameters),
    );
    return jsonData.fold(
      (failure) => left(failure),
      (data) async {
        return right(data);
      },
    );
  }

  @override
  Future<Either<Failure, List<ChildSubscriptionsStudyingEntity>>>
      getChildSubscriptionsPaths({
    required GetChildSubscriptionsTermsOrPathsParameters parameters,
  }) async {
    // final termsLocal =
    //     await childSubscriptionsLocalDataSource.getChildSubscriptionsTerms(
    //   stageId: parameters.stageId,
    //   classRoomId: parameters.classRoomId,
    //   childId: parameters.childData!.userId,
    // );
    // if (termsLocal != null) {
    //   return Right(termsLocal);
    // }
    final jsonData = await baseRepository.checkExceptionForRemoteData(
      remoteDataSource.getChildSubscriptionsPaths(parameters: parameters),
    );
    return jsonData.fold(
      (failure) => left(failure),
      (data) async {
        // await childSubscriptionsLocalDataSource.saveChildSubscriptionsTerms(
        //   childSubscriptionsTerms: data,
        //   stageId: parameters.stageId,
        //   classRoomId: parameters.classRoomId,
        //   childId: parameters.childData!.userId,
        // );
        return right(data);
      },
    );
  }

  @override
  Future<Either<Failure, List<SubjectsEntity>>> getChildSubscriptionsSubjects(
      {required ParameterGoToQuestions subjectsParameters,
      int? childId}) async {
    // final subjectsLocal =
    //     await childSubscriptionsLocalDataSource.getChildSubscriptionsSubjects(
    //   stageId: subjectsParameters.stageId,
    //   classRoomId: subjectsParameters.classRoomId,
    //   termId: subjectsParameters.termId,
    //   childId: subjectsParameters.userId,
    // );
    // if (subjectsLocal != null) {
    //   return Right(subjectsLocal);
    // }
    final jsonData = await baseRepository.checkExceptionForRemoteData(
      remoteDataSource.getChildSubscriptionsSubjects(
          subjectsParameters: subjectsParameters),
    );
    return jsonData.fold(
      (failure) => left(failure),
      (data) async {
        // await childSubscriptionsLocalDataSource.saveChildSubscriptionsSubjects(
        //   childSubscriptionsSubjects: data,
        //   stageId: subjectsParameters.stageId,
        //   classRoomId: subjectsParameters.classRoomId,
        //   termId: subjectsParameters.termId,
        //   childId: subjectsParameters.userId,
        // );
        return Right(data);
      },
    );
  }

  @override
  Future<Either<Failure, List<ChildSubscriptionsStudyingEntity>>> getChildSubscriptionsSystems({int? childId}) async {
    // final stagesLocal =
    // await childSubscriptionsLocalDataSource.getChildSubscriptionsStages(
    //     childId:
    //     childId ?? getIt<UserLocalDataSource>().getUserData()!.userId);
    // if (stagesLocal != null) {
    //   return Right(stagesLocal);
    // }
    final jsonData = await baseRepository.checkExceptionForRemoteData(
      remoteDataSource.getChildSubscriptionsSystems(childID: childId),
    );
    return jsonData.fold(
          (failure) => left(failure),
          (data) async {
        // await childSubscriptionsLocalDataSource.saveChildSubscriptionsStages(
        //   childSubscriptionsStages: data,
        //   childId:
        //   childId ?? getIt<UserLocalDataSource>().getUserData()!.userId,
        // );
        return right(data);
      },
    );
  }
}

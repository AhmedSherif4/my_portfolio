import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:my_portfolio/config/base_repository/base_repository.dart';
import 'package:my_portfolio/core/failure/failure.dart';
import '../../domain/entity/add_delete_subject_entity.dart';
import '../../domain/entity/subject_subscriptions_entity.dart';
import '../../domain/repository/subject_subscriptions_repository.dart';
import '../remote_data_source/subject_subscription_remote_data_source.dart';

@LazySingleton(as:SubjectSubscriptionRepository )
class SubjectSubscriptionRepositoryImpl implements SubjectSubscriptionRepository {
  final BaseRepository _baseRepository;
  final SubjectSubscriptionRemoteDataSource _remoteDataSource;

  SubjectSubscriptionRepositoryImpl(this._baseRepository, this._remoteDataSource);

  @override
  Future<Either<Failure, AddAndDeleteSubjectEntity>> addSubject({required AddAndDeleteSubjectInputs addAndDeleteSubjectInputs}) async{
    final response =
    await _baseRepository
        .checkExceptionForRemoteData(_remoteDataSource.addSubjectData(addAndDeleteSubjectInputs: addAndDeleteSubjectInputs
    ));
    return response;
  }

  @override
  Future<Either<Failure, AddAndDeleteSubjectEntity>> deleteSubject({required AddAndDeleteSubjectInputs addAndDeleteSubjectInputs}) async{
    final response =
        await _baseRepository
        .checkExceptionForRemoteData(_remoteDataSource.deleteSubjectData(addAndDeleteSubjectInputs: addAndDeleteSubjectInputs));
    return response;
  }

  @override
  Future<Either<Failure, String>> addOptionalSubject({required AddAndDeleteSubjectInputs addAndDeleteSubjectInputs}) async{
    final response =
    await _baseRepository
        .checkExceptionForRemoteData(_remoteDataSource.addOptionalSubjectData(addAndDeleteSubjectInputs: addAndDeleteSubjectInputs));
    return response;
  }

  @override
  Future<Either<Failure, SubjectSubscriptionsEntity>> getSubjectSubscriptions(SubjectSubscriptionsInputs subjectSubscriptionsInputs) async {
    return await _baseRepository
        .checkExceptionForRemoteData(_remoteDataSource.getSubjectSubscriptions(subjectSubscriptionsInputs));
  }
}

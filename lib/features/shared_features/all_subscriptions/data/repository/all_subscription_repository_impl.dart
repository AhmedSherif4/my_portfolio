import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:my_portfolio/features/shared_features/all_subscriptions/domain/entity/all_subscription_entity.dart';

import '../../../../../config/base_repository/base_repository.dart';
import '../../../../../core/failure/failure.dart';
import '../../domain/repository/all_subbscription_repo.dart';
import '../remote_data_source/all_subbscription_rempte_data_source.dart';

@LazySingleton(as: AllSubscriptionRepository)
class AllSubscriptionRepositoryImpl implements AllSubscriptionRepository {
  final AllSubscriptionRemoteDataSource remoteDataSource;
  final BaseRepository baseRepository;

  const AllSubscriptionRepositoryImpl({
    required this.remoteDataSource,
    required this.baseRepository,
    //local data source if you want handle cached data.
  });

  @override
  Future<Either<Failure, List<AllSubscriptionModel>>> getAllSubscription(
      {required int? childId}) async {
    final jsonData = await baseRepository.checkExceptionForRemoteData(
      remoteDataSource.getAllSubscription(childId: childId),
    );
    return jsonData.fold(
      (failure) => left(failure),
      (allAllSubscription) async {
        return Right(allAllSubscription);
      },
    );
  }
}

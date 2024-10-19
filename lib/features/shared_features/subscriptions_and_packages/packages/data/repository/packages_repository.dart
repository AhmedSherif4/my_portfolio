import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:my_portfolio/core/failure/failure.dart';
import 'package:my_portfolio/features/shared_features/subscriptions_and_packages/packages/data/remote/packages_remote_data_source.dart';
import 'package:my_portfolio/features/shared_features/subscriptions_and_packages/packages/domain/repository/packages_repository.dart';

import '../../../../../../config/base_repository/base_repository.dart';
import '../model/add_classroom_model.dart';
@LazySingleton(as: PackagesRepository)
class PackagesRepositoryImpl implements PackagesRepository {
  final BaseRepository baseRepository;
  final PackagesRemoteDataSource packagesRemoteDataSource;

  PackagesRepositoryImpl(
    this.baseRepository,
    this.packagesRemoteDataSource,
  );
  @override
  Future<Either<Failure, AddClassroomModelHaveTermsAndOptionalSubjects>> addClassroomToCart({required AddItemToCartParameters addItemToCartParameters}) async {
    return await baseRepository.checkExceptionForRemoteData(
      packagesRemoteDataSource.addClassroomToCart(
        addItemToCartParameters: addItemToCartParameters,
      ),
    );
  }

  @override
  Future<Either<Failure, String>> addSubjectToCart({required AddItemToCartParameters addItemToCartParameters}) async {
    return await baseRepository.checkExceptionForRemoteData(
      packagesRemoteDataSource.addSubjectToCart(
        addItemToCartParameters: addItemToCartParameters,
      ),
    );
  }

  @override
  Future<Either<Failure, AddTermModelHaveOptionalSubjects>> addTermToCart({required AddItemToCartParameters addItemToCartParameters})async {
    return await baseRepository.checkExceptionForRemoteData(
      packagesRemoteDataSource.addTermToCart(
        addItemToCartParameters: addItemToCartParameters,
      ),
    );
  }
}

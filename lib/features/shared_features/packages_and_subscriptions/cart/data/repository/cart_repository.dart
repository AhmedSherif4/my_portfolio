import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:my_portfolio/config/base_repository/base_repository.dart';
import 'package:my_portfolio/core/failure/failure.dart';

import '../../domain/entity/cart_entity.dart';
import '../../domain/repository/cart_repository.dart';
import '../remote_data_source/cart_remote_data_source.dart';


@LazySingleton(as:CartRepository )
class CartRepositoryImpl implements CartRepository {
  final BaseRepository _baseRepository;
  final CartRemoteDataSource _cartRemote;

  CartRepositoryImpl(this._baseRepository, this._cartRemote);
  @override
  Future<Either<Failure, String>> deleteAllDataInCart(int childId) async {
    return await _baseRepository
        .checkExceptionForRemoteData(_cartRemote.deleteCartData(childId));
  }

  @override
  Future<Either<Failure, CartEntity>> viewCartData(int childId) async {
    return await _baseRepository
        .checkExceptionForRemoteData(_cartRemote.viewCartData(childId));
  }
}

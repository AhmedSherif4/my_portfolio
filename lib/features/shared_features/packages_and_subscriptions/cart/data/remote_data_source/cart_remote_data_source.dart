import 'package:injectable/injectable.dart';
import 'package:my_portfolio/core/api/end_points.dart';
import 'package:my_portfolio/my_app/app_reference.dart';
import '../../../../../../config/base_remote_data_source/base_remote_data_source.dart';
import '../../domain/entity/cart_entity.dart';
import '../model/cart_model.dart';

abstract class CartRemoteDataSource {
  Future<CartEntity> viewCartData(int childId);

  Future<String> deleteCartData(int childId);
}

@LazySingleton(as: CartRemoteDataSource)
class CartRemoteDataSourceImpl implements CartRemoteDataSource {
  final BaseRemoteDataSource _dataSource;

  CartRemoteDataSourceImpl(this._dataSource);

  @override
  Future<String> deleteCartData(int childId) async {
    final response = await _dataSource.postData(
        url: AppReference.userIsChild()?
        EndPoints.deleteCartPath:
        EndPoints.parentDeleteCartPath,
        body: AppReference.userIsChild()?{}:{
          "child_id": childId,
        });

    return response['data'];
  }

  @override
  Future<CartEntity> viewCartData(int childId) async {
    final response = await _dataSource.postData(
        url: AppReference.userIsChild()?
        EndPoints.viewCartPath:
        EndPoints.parentViewCartPath,
        body: AppReference.userIsChild()?{}:{
          "child_id": childId,
        });

    return CartModel.fromJson(response['data']);
  }
}

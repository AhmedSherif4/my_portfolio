import 'package:injectable/injectable.dart';
import 'package:my_portfolio/my_app/app_reference.dart';

import '../../../../../../config/base_remote_data_source/base_remote_data_source.dart';
import '../../../../../../core/api/end_points.dart';
import '../../domain/repository/packages_repository.dart';
import '../model/add_classroom_model.dart';

abstract class PackagesRemoteDataSource {
  Future<AddClassroomModelHaveTermsAndOptionalSubjects> addClassroomToCart({required AddItemToCartParameters addItemToCartParameters});
  Future<AddTermModelHaveOptionalSubjects> addTermToCart({required AddItemToCartParameters addItemToCartParameters});
  Future<String> addSubjectToCart({required AddItemToCartParameters addItemToCartParameters});
}

@LazySingleton(as: PackagesRemoteDataSource)
class PackagesRemoteDataSourceImpl implements PackagesRemoteDataSource {
  final BaseRemoteDataSource baseRemoteDataSource;

  PackagesRemoteDataSourceImpl({required this.baseRemoteDataSource});

  @override
  Future<AddClassroomModelHaveTermsAndOptionalSubjects> addClassroomToCart({required AddItemToCartParameters addItemToCartParameters}) async {
    final response = await baseRemoteDataSource.postData(
      url: AppReference.userIsChild() ? EndPoints.addClassroomToCartPath : EndPoints.parentAddClassroomToCartPath,
      body:  AppReference.userIsChild() ?{
        'classroom_id': addItemToCartParameters.id,
        'path_id': addItemToCartParameters.pathId,
      }:{
        'classroom_id': addItemToCartParameters.id,
        'path_id': addItemToCartParameters.pathId,
        'child_id': addItemToCartParameters.userID,
      },
    );
    return AddClassroomModelHaveTermsAndOptionalSubjects.fromJson(response);
  }

  @override
  Future<String> addSubjectToCart({required AddItemToCartParameters addItemToCartParameters})  async {
    final response = await baseRemoteDataSource.postData(
      url: AppReference.userIsChild()? EndPoints.addSubjectToCartPath: EndPoints.parentAddSubjectToCartPath,
      body:  AppReference.userIsChild() ? {
        'subject_id': addItemToCartParameters.id,
      }:{
        'subject_id': addItemToCartParameters.id,
        'child_id': addItemToCartParameters.userID,
      },
    );
    return response['message'];
  }

  @override
  Future<AddTermModelHaveOptionalSubjects> addTermToCart({required AddItemToCartParameters addItemToCartParameters})  async {
    final response = await baseRemoteDataSource.postData(
      url: AppReference.userIsChild() ? EndPoints.addTermToCartPath : EndPoints.parentAddTermToCartPath ,
      body: AppReference.userIsChild() ?{
        'term_id': addItemToCartParameters.id,
        'path_id': addItemToCartParameters.pathId,
      }:{
        'term_id': addItemToCartParameters.id,
        'path_id': addItemToCartParameters.pathId,
        'child_id': addItemToCartParameters.userID,
      },
    );
    return AddTermModelHaveOptionalSubjects.fromJson(response);
  }
}

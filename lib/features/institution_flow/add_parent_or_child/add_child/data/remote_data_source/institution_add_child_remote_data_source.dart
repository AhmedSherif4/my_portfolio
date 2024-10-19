part of '../../add_child.dart';

abstract class InstitutionAddChildRemoteDataSource {
  Future<String> institutionAddChild({
    required InstitutionAddChildParameter addChildParameter,
  });
}

@LazySingleton(
  as: InstitutionAddChildRemoteDataSource,
)
class InstitutionAddChildRemoteDataSourceImpl
    implements InstitutionAddChildRemoteDataSource {
  final BaseRemoteDataSource baseDataSource;
  final ApiConsumer apiConsumer;

  const InstitutionAddChildRemoteDataSourceImpl({
    required this.apiConsumer,
    required this.baseDataSource,
  });

  @override
  Future<String> institutionAddChild(
      {required InstitutionAddChildParameter addChildParameter}) async {
    final response = await baseDataSource.postData(
      url: AppReference.userIsParent()? EndPoints.parentAddNewChild
          :EndPoints.institutionAddNewChild,
      body: AppReference.userIsParent()?FormData.fromMap({
        "name": addChildParameter.name,
        "email": addChildParameter.emailOrPhone,
        "password": addChildParameter.password,
        "phone":  addChildParameter.phone,

        "gendar": addChildParameter.gendar,
        "img": addChildParameter.img.isNotEmpty
            ? await MultipartFile.fromFile(addChildParameter.img)
            : null,
        "system_id": addChildParameter.systemId,
        "path_id": addChildParameter.pathId==0?null:addChildParameter.pathId,
        "stage_id": addChildParameter.stageId,
        "classroom_id": addChildParameter.classroomId,
        "term_id": addChildParameter.termId,
      })
          :FormData.fromMap({
        "name": addChildParameter.name,
        "email":  addChildParameter.emailOrPhone,
        "password": addChildParameter.password,
        "phone": addChildParameter.phone,
        "gendar": addChildParameter.gendar,
        "img": addChildParameter.img.isNotEmpty
            ? await MultipartFile.fromFile(addChildParameter.img)
            : null,
        "parent_id": addChildParameter.parentId,
        "system_id": addChildParameter.systemId,
        "path_id": addChildParameter.pathId==0?null:addChildParameter.pathId,
        "stage_id": addChildParameter.stageId,
        "classroom_id": addChildParameter.classroomId,
        "term_id": addChildParameter.termId,
      }),
    );
    return response['message'];
  }
}

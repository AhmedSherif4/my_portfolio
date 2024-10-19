part of '../../parent_preview_for_child.dart';

abstract class ParentPreviewForChildRemoteDataSource {
  Future<List<ParentPreviewForChildEntity>> getAllParents();
}

@LazySingleton(as: ParentPreviewForChildRemoteDataSource)
class ParentPreviewForChildRemoteDataSourceImpl
    implements ParentPreviewForChildRemoteDataSource {
  final BaseRemoteDataSource baseRemoteDataSource;

  ParentPreviewForChildRemoteDataSourceImpl(
      {required this.baseRemoteDataSource});

  @override
  Future<List<ParentPreviewForChildEntity>> getAllParents() async {
    final response = await baseRemoteDataSource
        .postData(url: EndPoints.parentsForChild, body: {});
    final allParents = List<ParentPreviewForChildEntity>.from(
        (response['data'] as List)
            .map((element) => ParentPreviewForChildModel.fromJson(element)));

    return allParents;
  }
}

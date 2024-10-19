part of '../../parent_preview_for_child.dart';

abstract class ParentPreviewForChildLocalDataSource {
  Future<List<ParentPreviewForChildEntity>?> getAllParents();

  Future<void> saveAllParents(
      {required List<ParentPreviewForChildEntity> allParents});
}

@LazySingleton(as: ParentPreviewForChildLocalDataSource)
class ParentPreviewForChildLocalDataSourceImpl
    implements ParentPreviewForChildLocalDataSource {
  final BaseLocalDataSource baseLocalDataSource;

  ParentPreviewForChildLocalDataSourceImpl({required this.baseLocalDataSource});

  @override
  Future<List<ParentPreviewForChildEntity>?> getAllParents() async {
    await Hive.openBox<String>(
        AppKeys.getExpirationKey(AppKeys.parentsForChild));
    await Hive.openBox<ParentPreviewForChildEntity>(AppKeys.parentsForChild);

    final allParents = await baseLocalDataSource
        .getListOfDataFromLocal<ParentPreviewForChildEntity>(
      labelKey: AppKeys.parentsForChild,
    );
    if (allParents == null) {
      return null;
    } else {
      return allParents;
    }
  }

  @override
  Future<void> saveAllParents(
      {required List<ParentPreviewForChildEntity> allParents}) async {
    await baseLocalDataSource
        .saveListOfDataInLocal<ParentPreviewForChildEntity>(
      labelKey: AppKeys.parentsForChild,
      data: allParents,
    );
  }
}

// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:injectable/injectable.dart';
// import 'package:my_portfolio/features/child_flow/questions/shared/entity/levels_group_entity.dart';
// import '../../../../../../config/base_local_data_source/base_local_data_source.dart';
// import '../../../../../../config/storages/keys.dart';
//
// abstract class CollectionsLocalDataSource {
//   Future<void> saveCollectionInLocalData({
//     required List<LevelAndCollectionEntity> data,
//     required int levelID,
//   });
//
//   Future<List<LevelAndCollectionEntity>?> getCollectionInLocalData({
//     required int levelID,
//   });
//
//   Future<void> updateCollection({
//     required int levelID,
//     required int index,
//     required int updatedUserPoint,
//   });
// }
//
// @LazySingleton(as: CollectionsLocalDataSource)
// class CollectionsLocalDataSourceImpl implements CollectionsLocalDataSource {
//   final BaseLocalDataSource baseLocalDataSource;
//
//   const CollectionsLocalDataSourceImpl({required this.baseLocalDataSource});
//
//   @override
//   Future<List<LevelAndCollectionEntity>?> getCollectionInLocalData(
//       {required int levelID}) async {
//     await Hive.openBox<String>(AppKeys.getExpirationKey(AppKeys.collectionKey(levelID)));
//
//     await Hive.openBox<LevelAndCollectionEntity>(AppKeys.collectionKey(levelID));
//     final allCollection = await baseLocalDataSource
//         .getListOfDataFromLocal<LevelAndCollectionEntity>(
//             labelKey: AppKeys.collectionKey(levelID));
//     if (allCollection == null) {
//       return null;
//     } else {
//       return allCollection;
//     }
//   }
//
//   @override
//   Future<void> saveCollectionInLocalData(
//       {required List<LevelAndCollectionEntity> data,
//       required int levelID}) async {
//     await baseLocalDataSource.saveListOfDataInLocal<LevelAndCollectionEntity>(
//         labelKey: AppKeys.collectionKey(levelID), data: data);
//   }
//
//   @override
//   Future<void> updateCollection({
//     required int levelID,
//     required int index,
//     required int updatedUserPoint,
//   }) async{
//     return await baseLocalDataSource.updateListDataInLocal<int>(
//       index: index,
//       labelKey: AppKeys.collectionKey(levelID),
//       updatedData: updatedUserPoint,
//     );
//   }
// }

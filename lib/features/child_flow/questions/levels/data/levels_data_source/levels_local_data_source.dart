// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:injectable/injectable.dart';
// import 'package:my_portfolio/config/storages/keys.dart';
// import 'package:my_portfolio/features/child_flow/questions/shared/entity/levels_group_entity.dart';
//
// import '../../../../../../config/base_local_data_source/base_local_data_source.dart';
//
// abstract class LevelsLocalDataSource {
//   Future<void> saveLevelsInLocalData({
//     required List<LevelAndCollectionEntity> data,
//     required int subjectID,
//   });
//
//   Future<List<LevelAndCollectionEntity>?> getLevelsInLocalData({
//     required int subjectID,
//   });
// }
//
// @LazySingleton(as: LevelsLocalDataSource)
// class LevelsLocalDataSourceImpl implements LevelsLocalDataSource {
//   final BaseLocalDataSource baseLocalDataSource;
//
//   const LevelsLocalDataSourceImpl({required this.baseLocalDataSource});
//
//   @override
//   Future<List<LevelAndCollectionEntity>?> getLevelsInLocalData(
//       {required int subjectID}) async {
//     await Hive.openBox<String>(AppKeys.getExpirationKey(AppKeys.levelsKey(subjectID)));
//
//     await Hive.openBox<LevelAndCollectionEntity>(AppKeys.levelsKey(subjectID));
//     final allLevels = await baseLocalDataSource
//         .getListOfDataFromLocal<LevelAndCollectionEntity>(
//       labelKey: AppKeys.levelsKey(subjectID),
//     );
//     if (allLevels == null) {
//       return null;
//     } else {
//       return allLevels;
//     }
//   }
//
//   @override
//   Future<void> saveLevelsInLocalData(
//       {required List<LevelAndCollectionEntity> data,
//       required int subjectID}) async {
//     await baseLocalDataSource.saveListOfDataInLocal<LevelAndCollectionEntity>(
//       labelKey: AppKeys.levelsKey(subjectID),
//       data: data,
//     );
//   }
// }

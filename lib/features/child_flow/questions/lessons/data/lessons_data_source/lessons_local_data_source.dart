// import 'package:hive/hive.dart';
// import 'package:injectable/injectable.dart';
// import 'package:my_portfolio/config/extensions/color_extension.dart';
// import 'package:my_portfolio/features/child_flow/questions/lessons/domain/lessons_entities/lessons_with_units_entity.dart';
//
// import '../../../../../../config/base_local_data_source/base_local_data_source.dart';
// import '../../../../../../config/storages/keys.dart';
// import '../../domain/lessons_entities/lessons_entity.dart';
//
// abstract class LessonsLocalDataSource {
//   Future<void> saveLessonsInLocalData({
//     required List<LessonEntity> data,
//     required int subjectId,
//   });
//
//   Future<List<LessonEntity>?> getLessonsInLocalData({
//     required int subjectId,
//   });
//
//   Future<void> saveLessonsWithUnitsInLocalData({
//     required List<LessonWithUnitsEntity> data,
//     required int subjectId,
//   });
//
//   Future<List<LessonWithUnitsEntity>?> getLessonsWithUnitsInLocalData({
//     required int subjectId,
//   });
//   Future<void> updateLesson({
//     required int subjectId,
//     required int index,
//     required int updatedUserPoint,
//   });
//
//   Future<void> updateLessonsWithUnits({
//     required int subjectId,
//     required int index,
//     required int updatedUserPoint,
//   });
// }
//
// @LazySingleton(as: LessonsLocalDataSource)
// class LessonsLocalDataSourceImpl implements LessonsLocalDataSource {
//   final BaseLocalDataSource baseLocalDataSource;
//
//   const LessonsLocalDataSourceImpl(this.baseLocalDataSource);
//
//   @override
//   Future<List<LessonEntity>?> getLessonsInLocalData({
//     required int subjectId,
//   }) async {
//     await Hive.openBox<String>(AppKeys.getExpirationKey(AppKeys.lessonsKey(subjectId)));
//
//     await Hive.openBox<LessonEntity>(AppKeys.lessonsKey(subjectId));
//     final allLessons =
//         await baseLocalDataSource.getListOfDataFromLocal<LessonEntity>(
//             labelKey: AppKeys.lessonsKey(subjectId),
//
//         );
//     if (allLessons == null) {
//       return null;
//     } else {
//       AppKeys.getExpirationKey(AppKeys.lessonsKey(subjectId)).log();
//       AppKeys.lessonsKey(subjectId).log();
//       subjectId.log();
//       "$allLessons".log();
//       "user point${allLessons[0].lessonUserPoints}".log();
//       return allLessons;
//     }
//   }
//
//
//
//   @override
//   Future<void> saveLessonsInLocalData({
//     required List<LessonEntity> data,
//     required int subjectId,
//   }) async {
//     await baseLocalDataSource.saveListOfDataInLocal<LessonEntity>(
//         labelKey: AppKeys.lessonsKey(subjectId),
//         data: data,
//       // expirationDuration: const Duration(
//       //   minutes: 10,
//       // ),
//     );
//   }
//
//   @override
//   Future<List<LessonWithUnitsEntity>?> getLessonsWithUnitsInLocalData(
//       {required int subjectId}) async {
//     await Hive.openBox<String>(AppKeys.getExpirationKey(AppKeys.lessonsByUnitsKey(subjectId)));
//
//     await Hive.openBox<LessonWithUnitsEntity>(AppKeys.lessonsByUnitsKey(subjectId));
//     final allLessonsWithUnits =
//         await baseLocalDataSource.getListOfDataFromLocal<LessonWithUnitsEntity>(
//             labelKey: AppKeys.lessonsByUnitsKey(subjectId));
//     if (allLessonsWithUnits == null) {
//       return null;
//     } else {
//       AppKeys.getExpirationKey(AppKeys.lessonsKey(subjectId)).log();
//       AppKeys.lessonsKey(subjectId).log();
//       subjectId.log();
//       "$allLessonsWithUnits".log();
//       "user point${allLessonsWithUnits[0].unitLessons[0].lessonUserPoints}".log();
//       return allLessonsWithUnits;
//     }
//   }
//
//   @override
//   Future<void> saveLessonsWithUnitsInLocalData(
//       {required List<LessonWithUnitsEntity> data,
//       required int subjectId}) async {
//     await baseLocalDataSource.saveListOfDataInLocal<LessonWithUnitsEntity>(
//         labelKey: AppKeys.lessonsByUnitsKey(subjectId),
//         // expirationDuration: const Duration(
//         //   minutes: 10,
//         // ),
//         data: data);
//   }
//
//   @override
//   Future<void> updateLesson({
//     required int subjectId,
//     required int index,
//     required int updatedUserPoint,
//   }) async {
//     return await baseLocalDataSource.updateListDataInLocal<int>(
//       index: index,
//       labelKey: AppKeys.lessonsKey(subjectId),
//       updatedData: updatedUserPoint,
//     );
//   }
//
//
//   @override
//   Future<void> updateLessonsWithUnits({
//     required int subjectId,
//     required int index,
//     required int updatedUserPoint,
//   }) async{
//     return await baseLocalDataSource.updateListDataInLocal<int>(
//       index: index,
//       labelKey: AppKeys.lessonsKey(subjectId),
//       updatedData: updatedUserPoint,
//     );
//   }
// }

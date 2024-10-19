// part of '../../exams.dart';
//
// abstract class ExamsLocalDataSource {
//   Future<void> setExamsForSpecificSubject({
//     required int subjectId,
//     required List<ExamEntity> data,
//   });
//
//   Future<List<ExamEntity>?> getExamsForSpecificSubject({
//     required int subjectId,
//   });
//
//   Future<void> updateExam({
//     required int subjectId,
//     required int index,
//     required ExamEntity updatedExam,
//   });
// }
//
// @LazySingleton(as: ExamsLocalDataSource)
// class ExamsLocalDataSourceImpl implements ExamsLocalDataSource {
//   final BaseLocalDataSource baseLocalDataSource;
//
//   ExamsLocalDataSourceImpl({required this.baseLocalDataSource});
//
//   @override
//   Future<void> setExamsForSpecificSubject({
//     required int subjectId,
//     required List<ExamEntity> data,
//   }) async {
//     return await baseLocalDataSource.saveListOfDataInLocal<ExamEntity>(
//       labelKey: subjectId.toString(),
//       data: data,
//       expirationDuration: const Duration(
//         minutes: 3,
//       ),
//     );
//   }
//
//   @override
//   Future<List<ExamEntity>?> getExamsForSpecificSubject({
//     required int subjectId,
//   }) async {
//     await Hive.openBox<String>(AppKeys.getExpirationKey(subjectId.toString()));
//
//     await Hive.openBox<ExamEntity>(subjectId.toString());
//
//     return await baseLocalDataSource.getListOfDataFromLocal<ExamEntity>(
//       labelKey: subjectId.toString(),
//     );
//   }
//
//   @override
//   Future<void> updateExam({
//     required int subjectId,
//     required int index,
//     required ExamEntity updatedExam,
//   }) async {
//     return await baseLocalDataSource.updateListDataInLocal<ExamEntity>(
//       index: index,
//       labelKey: subjectId.toString(),
//       updatedData: updatedExam,
//       expirationDuration: const Duration(
//         minutes: 3,
//       ),
//     );
//   }
// }
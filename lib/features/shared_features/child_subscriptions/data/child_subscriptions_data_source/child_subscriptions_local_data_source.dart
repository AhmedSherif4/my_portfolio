// import 'package:hive/hive.dart';
// import 'package:injectable/injectable.dart';
// import 'package:my_portfolio/config/base_local_data_source/base_local_data_source.dart';
//
// import '../../../../../../config/storages/keys.dart';
// import '../../../../child_flow/home/domain/home_entities/subjects_entity.dart';
// import '../../domain/auth_entity/child_subscriptions_studying_entity.dart';
//
// abstract class ChildSubscriptionsLocalDataSource {
//   Future<void> saveChildSubscriptionsStages({
//     required List<ChildSubscriptionsStudyingEntity> childSubscriptionsStages,
//     required int childId,
//   });
//
//   Future<void> saveChildSubscriptionsClassRoom({
//     required List<ChildSubscriptionsStudyingEntity>
//         childSubscriptionsClassRooms,
//     required int stageId,
//     required int childId,
//   });
//
//   Future<void> saveChildSubscriptionsTerms({
//     required List<ChildSubscriptionsStudyingEntity> childSubscriptionsTerms,
//     required int stageId,
//     required int classRoomId,
//     required int childId,
//   });
//
//   Future<void> saveChildSubscriptionsSubjects({
//     required List<SubjectsEntity> childSubscriptionsSubjects,
//     required int stageId,
//     required int classRoomId,
//     required int termId,
//     required int childId,
//   });
//
//   Future<List<ChildSubscriptionsStudyingEntity>?> getChildSubscriptionsStages({
//     required int childId,
//   });
//
//   Future<List<ChildSubscriptionsStudyingEntity>?>
//       getChildSubscriptionsClassRoom({
//     required int stageId,
//     required int childId,
//   });
//
//   Future<List<ChildSubscriptionsStudyingEntity>?> getChildSubscriptionsTerms({
//     required int stageId,
//     required int classRoomId,
//     required int childId,
//   });
//
//   Future<List<SubjectsEntity>?> getChildSubscriptionsSubjects({
//     required int stageId,
//     required int classRoomId,
//     required int termId,
//     required int childId,
//   });
// }
//
// @LazySingleton(as: ChildSubscriptionsLocalDataSource)
// class ChildSubscriptionsLocalDataSourceImpl
//     implements ChildSubscriptionsLocalDataSource {
//   final BaseLocalDataSource baseLocalDataSource;
//
//   const ChildSubscriptionsLocalDataSourceImpl(
//       {required this.baseLocalDataSource});
//
//   @override
//   Future<void> saveChildSubscriptionsClassRoom({
//     required List<ChildSubscriptionsStudyingEntity>
//         childSubscriptionsClassRooms,
//     required int stageId,
//     required int childId,
//   }) async {
//     await baseLocalDataSource
//         .saveListOfDataInLocal<ChildSubscriptionsStudyingEntity>(
//       labelKey: AppKeys.childSubscriptionsClassRoomsKey(
//         stageId: stageId,
//         childId: childId,
//       ),
//       data: childSubscriptionsClassRooms,
//       expirationDuration: const Duration(days: 1),
//     );
//   }
//
//   @override
//   Future<void> saveChildSubscriptionsStages({
//     required List<ChildSubscriptionsStudyingEntity> childSubscriptionsStages,
//     required int childId,
//   }) async {
//     await baseLocalDataSource
//         .saveListOfDataInLocal<ChildSubscriptionsStudyingEntity>(
//       labelKey: AppKeys.childSubscriptionsStagesKey(childId: childId),
//       data: childSubscriptionsStages,
//       expirationDuration: const Duration(days: 1),
//     );
//   }
//
//   @override
//   Future<void> saveChildSubscriptionsTerms({
//     required List<ChildSubscriptionsStudyingEntity> childSubscriptionsTerms,
//     required int stageId,
//     required int classRoomId,
//     required int childId,
//   }) async {
//     await baseLocalDataSource
//         .saveListOfDataInLocal<ChildSubscriptionsStudyingEntity>(
//       labelKey: AppKeys.childSubscriptionsTermsKey(
//           stageId: stageId, classRoomId: classRoomId, childId: childId),
//       data: childSubscriptionsTerms,
//       expirationDuration: const Duration(days: 1),
//     );
//   }
//
//   @override
//   Future<void> saveChildSubscriptionsSubjects({
//     required List<SubjectsEntity> childSubscriptionsSubjects,
//     required int stageId,
//     required int classRoomId,
//     required int termId,
//     required int childId,
//   }) async {
//     await baseLocalDataSource.saveListOfDataInLocal<SubjectsEntity>(
//       labelKey: AppKeys.childSubscriptionSubjectsKey(
//         childId: childId,
//         stageId: stageId,
//         classRoomId: classRoomId,
//         termId: termId,
//       ),
//       data: childSubscriptionsSubjects,
//       expirationDuration: const Duration(days: 1),
//     );
//   }
//
//   @override
//   Future<List<ChildSubscriptionsStudyingEntity>?>
//       getChildSubscriptionsClassRoom({
//     required int stageId,
//     required int childId,
//   }) async {
//     await Hive.openBox<String>(
//       AppKeys.getExpirationKey(
//         AppKeys.childSubscriptionsClassRoomsKey(
//           childId: childId,
//           stageId: stageId,
//         ),
//       ),
//     );
//     await Hive.openBox<ChildSubscriptionsStudyingEntity>(
//       AppKeys.childSubscriptionsClassRoomsKey(
//         childId: childId,
//         stageId: stageId,
//       ),
//     );
//
//     final allClassRooms = await baseLocalDataSource
//         .getListOfDataFromLocal<ChildSubscriptionsStudyingEntity>(
//             labelKey: AppKeys.childSubscriptionsClassRoomsKey(
//                 childId: childId, stageId: stageId));
//     if (allClassRooms == null) {
//       return null;
//     } else {
//       return allClassRooms;
//     }
//   }
//
//   @override
//   Future<List<ChildSubscriptionsStudyingEntity>?> getChildSubscriptionsStages(
//       {required int childId}) async {
//     await Hive.openBox<String>(AppKeys.getExpirationKey(
//         AppKeys.childSubscriptionsStagesKey(childId: childId)));
//     await Hive.openBox<ChildSubscriptionsStudyingEntity>(
//         AppKeys.childSubscriptionsStagesKey(childId: childId));
//
//     final allStages = await baseLocalDataSource
//         .getListOfDataFromLocal<ChildSubscriptionsStudyingEntity>(
//             labelKey: AppKeys.childSubscriptionsStagesKey(childId: childId));
//     if (allStages == null) {
//       return null;
//     } else {
//       return allStages;
//     }
//   }
//
//   @override
//   Future<List<SubjectsEntity>?> getChildSubscriptionsSubjects({
//     required int stageId,
//     required int classRoomId,
//     required int termId,
//     required int childId,
//   }) async {
//     await Hive.openBox<String>(
//         AppKeys.getExpirationKey(AppKeys.childSubscriptionSubjectsKey(
//       childId: childId,
//       stageId: stageId,
//       classRoomId: classRoomId,
//       termId: termId,
//     )));
//     await Hive.openBox<SubjectsEntity>(AppKeys.childSubscriptionSubjectsKey(
//       childId: childId,
//       stageId: stageId,
//       classRoomId: classRoomId,
//       termId: termId,
//     ));
//
//     final allSubjects =
//         await baseLocalDataSource.getListOfDataFromLocal<SubjectsEntity>(
//       labelKey: AppKeys.childSubscriptionSubjectsKey(
//         childId: childId,
//         stageId: stageId,
//         classRoomId: classRoomId,
//         termId: termId,
//       ),
//     );
//     if (allSubjects == null) {
//       return null;
//     } else {
//       return allSubjects;
//     }
//   }
//
//   @override
//   Future<List<ChildSubscriptionsStudyingEntity>?> getChildSubscriptionsTerms({
//     required int stageId,
//     required int classRoomId,
//     required int childId,
//   }) async {
//     await Hive.openBox<String>(
//       AppKeys.getExpirationKey(
//         AppKeys.childSubscriptionsTermsKey(
//           childId: childId,
//           stageId: stageId,
//           classRoomId: classRoomId,
//         ),
//       ),
//     );
//     await Hive.openBox<ChildSubscriptionsStudyingEntity>(
//       AppKeys.childSubscriptionsTermsKey(
//         childId: childId,
//         stageId: stageId,
//         classRoomId: classRoomId,
//       ),
//     );
//     final allTerms = await baseLocalDataSource
//         .getListOfDataFromLocal<ChildSubscriptionsStudyingEntity>(
//       labelKey: AppKeys.childSubscriptionsTermsKey(
//         childId: childId,
//         stageId: stageId,
//         classRoomId: classRoomId,
//       ),
//     );
//     if (allTerms == null) {
//       return null;
//     } else {
//       return allTerms;
//     }
//   }
// }

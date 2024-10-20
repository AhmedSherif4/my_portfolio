import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:my_portfolio/my_app/app_analytics.dart';
import '../config/storages/keys.dart';
import '../core/shared_models/user/user_entity/user_entity.dart';
import 'app_reference.dart';

class AppRequirementSetup {
  AppRequirementSetup._();

  static final AppRequirementSetup _instance = AppRequirementSetup._();

  static AppRequirementSetup get instance => _instance;

  static Future<void> initialFutures() async {
    await Future.wait([
      // AppAnalytics.initAppsFlyer(),

    // if(!await AppReference.isHuaweiDevice())...[
    //   Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform),
    //   ],
      // Token
      Hive.openBox<String>(AppKeys.getExpirationKey(AppKeys.accessToken)),
      Hive.openBox<String>(AppKeys.accessToken),

      // UserData
      Hive.openBox<String>(AppKeys.getExpirationKey(AppKeys.userData)),
      Hive.openBox<UserEntity>(AppKeys.userData),

      Hive.openBox<String>(AppKeys.getExpirationKey(AppKeys.showcaseViewed)),
      Hive.openBox<bool>(AppKeys.showcaseViewed),

      Hive.openBox<String>(AppKeys.getExpirationKey(AppKeys.contactUs)),
      // Hive.openBox<ContactUsEntity>(AppKeys.contactUs),

      Hive.openBox<String>(AppKeys.getExpirationKey(AppKeys.cartItemsKey)),
    ]);
  }

  static void registerHiveAdapter() {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(UserEntityAdapter());
    }
    // if (!Hive.isAdapterRegistered(2)) {
    //   Hive.registerAdapter(SubjectsEntityAdapter());
    // }
    // if (!Hive.isAdapterRegistered(3)) {
    //   Hive.registerAdapter(LessonEntityAdapter());
    // }
    // if (!Hive.isAdapterRegistered(4)) {
    //   Hive.registerAdapter(LevelAndCollectionEntityAdapter());
    // }
    // if (!Hive.isAdapterRegistered(7)) {
    //   Hive.registerAdapter(LessonWithUnitsEntityAdapter());
    // }
    // if (!Hive.isAdapterRegistered(5)) {
    //   Hive.registerAdapter(ExamEntityAdapter());
    // }
    // if (!Hive.isAdapterRegistered(6)) {
    //   Hive.registerAdapter(ResultExamEntityAdapter());
    // }
    // if (!Hive.isAdapterRegistered(10)) {
    //   Hive.registerAdapter(ChildSubscriptionsStudyingEntityAdapter());
    // }
    // if (!Hive.isAdapterRegistered(9)) {
    //   Hive.registerAdapter(PuzzleAndAdviceEntityAdapter());
    // }
    // if (!Hive.isAdapterRegistered(11)) {
    //   Hive.registerAdapter(TermsAndConditionsEntityAdapter());
    // }
    // if (!Hive.isAdapterRegistered(12)) {
    //   Hive.registerAdapter(AyahsEntityAdapter());
    // }
    // if (!Hive.isAdapterRegistered(13)) {
    //   Hive.registerAdapter(ContactUsEntityAdapter());
    // }
    // if (!Hive.isAdapterRegistered(20)) {
    //   Hive.registerAdapter(ParentPreviewForChildEntityAdapter());
    // }
    // if (!Hive.isAdapterRegistered(19)) {
    //   Hive.registerAdapter(CommonQuestionEntityAdapter());
    // }
  }
}

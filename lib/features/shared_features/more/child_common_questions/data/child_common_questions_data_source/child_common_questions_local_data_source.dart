part of '../../child_common_questions.dart';

abstract class ChildCommonQuestionsLocalDataSource {
  Future<List<CommonQuestionEntity>?> getAllCommonQuestions();

  Future<void> saveAllCommonQuestions(
      {required List<CommonQuestionEntity> allQuestions});
}

@LazySingleton(as: ChildCommonQuestionsLocalDataSource)
class ChildCommonQuestionsLocalDataSourceImpl
    implements ChildCommonQuestionsLocalDataSource {
  final BaseLocalDataSource baseLocalDataSource;

  ChildCommonQuestionsLocalDataSourceImpl({required this.baseLocalDataSource});

  @override
  Future<List<CommonQuestionEntity>?> getAllCommonQuestions() async {
    await Hive.openBox<String>(
        AppKeys.getExpirationKey(AppKeys.commonQuestions));
    await Hive.openBox<CommonQuestionEntity>(AppKeys.commonQuestions);

    final allQuestions =
        await baseLocalDataSource.getListOfDataFromLocal<CommonQuestionEntity>(
      labelKey: AppKeys.commonQuestions,
    );
    if (allQuestions == null) {
      return null;
    } else {
      return allQuestions;
    }
  }

  @override
  Future<void> saveAllCommonQuestions(
      {required List<CommonQuestionEntity> allQuestions}) async {
    await baseLocalDataSource.saveListOfDataInLocal<CommonQuestionEntity>(
      labelKey: AppKeys.commonQuestions,
      data: allQuestions,
    );
  }
}

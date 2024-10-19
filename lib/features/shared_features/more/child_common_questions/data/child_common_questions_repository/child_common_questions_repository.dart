part of '../../child_common_questions.dart';

@LazySingleton(as: ChildCommonQuestionsBaseRepository)
class ChildCommonQuestionsRepository
    implements ChildCommonQuestionsBaseRepository {
  final ChildCommonQuestionsRemoteDataSource remoteDataSource;
  final BaseRepository baseRepository;
  final ChildCommonQuestionsLocalDataSource childCommonQuestionsLocalDataSource;

  ChildCommonQuestionsRepository({
    required this.childCommonQuestionsLocalDataSource,
    required this.remoteDataSource,
    required this.baseRepository,
  });

  @override
  Future<Either<Failure, List<CommonQuestionEntity>>>
      getAllCommonQuestions() async {
    final allQuestions =
        await childCommonQuestionsLocalDataSource.getAllCommonQuestions();
    if (allQuestions != null) {
      return Right(allQuestions);
    }
    final jsonData = await baseRepository.checkExceptionForRemoteData(
      remoteDataSource.getAllCommonQuestions(),
    );
    return jsonData.fold(
      (failure) => left(failure),
      (data) async {
        await childCommonQuestionsLocalDataSource.saveAllCommonQuestions(
            allQuestions: data);
        return Right(data);
      },
    );
  }
}

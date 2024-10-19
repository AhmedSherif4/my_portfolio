part of '../../statics.dart';


abstract class BaseStaticsRepository {
  Future<Either<Failure, TimeInAppModel>> getTimeInApp(TimeInAppInputs timeInAppInputs);

  Future<Either<Failure, List<SubjectsEntity>>> getSubjects({
    required GetStaticsParam subjectsParameters,
  });

  Future<Either<Failure, LessonsStaticsModel>> getLessonsStatics({
    required GetStaticsParam parameters,
  });

  Future<Either<Failure, LevelStaticsModel>> getLevelStatics({
    required GetStaticsParam parameters,
  });

  Future<Either<Failure, List<BestSubjectsModel>>> getBestSubjects({
    required GetStaticsParam parameters,
  });

  Future<Either<Failure, List<FailsSkillsForLessonsModel>>> getFailsSkills({
    required GetFailsSkillsWithQuestionsParameters parameters,
  });

  Future<Either<Failure, QuestionEntity>> getFailsSkillsQuestions({
    required int id,
  });


}

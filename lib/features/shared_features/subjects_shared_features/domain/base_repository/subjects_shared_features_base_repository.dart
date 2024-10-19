part of '../../subjects_shared_features.dart';


abstract class SubjectsSharedFeaturesBaseRepository {
  Future<Either<Failure, List<SubjectsEntity>>> getSharedSubjects({
    required ParameterGoToQuestions subjectsParameters,});
}
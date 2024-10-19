part of '../../statics.dart';


@LazySingleton()
class GetFailSkillsStaticsUseCase
    extends BaseUseCase<List<FailsSkillsForLessonsModel>, GetFailsSkillsWithQuestionsParameters> {
  final BaseStaticsRepository repository;

  GetFailSkillsStaticsUseCase({required this.repository});

  @override
  Future<Either<Failure, List<FailsSkillsForLessonsModel>>> call(
      GetFailsSkillsWithQuestionsParameters parameter) async {
    return await repository.getFailsSkills(parameters: parameter);
  }
}



class GetFailsSkillsWithQuestionsParameters extends Equatable{
  final int subjectId;
  final int? childId;
  final bool fromStatic;
  final List<SubjectsEntity>? subjects;
  final FailsSkillsForLessonsModel? failQuestions;


  const GetFailsSkillsWithQuestionsParameters({required this.subjectId,required this.fromStatic ,required this.childId,this.subjects,this.failQuestions, });


  @override
  List<Object?> get props => [subjectId, fromStatic,childId,subjectId,failQuestions];
}
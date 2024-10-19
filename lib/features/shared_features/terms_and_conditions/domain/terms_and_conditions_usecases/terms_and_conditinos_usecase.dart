
part of '../../terms_and_conditions.dart';

@LazySingleton()
class GetTermsAndConditionsUseCase
    extends BaseUseCase<TermsAndConditionsEntity, NoParameter> {
  final TermsAndConditionsBaseRepository repository;

  GetTermsAndConditionsUseCase({required this.repository});

  @override
  Future<Either<Failure, TermsAndConditionsEntity>> call(
      NoParameter parameter) async {
    return await repository.getTermAndCondition();
  }
}
